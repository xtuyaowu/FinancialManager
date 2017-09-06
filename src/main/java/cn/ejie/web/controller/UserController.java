package cn.ejie.web.controller;

import cn.ejie.exception.SimpleException;
import cn.ejie.po.VerifyMessage;
import cn.ejie.pocustom.UserCustom;
import cn.ejie.service.VertifyCodeService;
import cn.ejie.utils.SimpleBeanUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户类的控制器
 */
@Controller
public class UserController {
    @Resource(name="authenticationManagerw")
    private AuthenticationManager myAuthenticationManager;

    @Autowired
    private VertifyCodeService vertifyCodeService;

    @Autowired
    private ObjectMapper objectMapper;

    @RequestMapping(value = "/user/login")
    public void login(HttpServletRequest request,HttpSession session,HttpServletResponse response,UserCustom userCustom){

        Map<String,String> message = new HashMap<>();
        UserCustom user = SimpleBeanUtils.setMapPropertyToBean(UserCustom.class,request.getParameterMap());
        System.out.println("#########################################");
        System.out.println("提交POST时，IP地址为："+request.getRemoteAddr());
        System.out.println(userCustom.getUsername());
        System.out.println(userCustom.getPassword());
        System.out.println(session.getId()+"验证码："+userCustom.getVerifyCode());
        System.out.println(session.getId()+"正确验证码："+(String)session.getAttribute("verifyCode"));
        System.out.println("#########################################\n");
        if(userCustom.getVerifyCode()==null || !userCustom.getVerifyCode().equalsIgnoreCase(((String)session.getAttribute("verifyCode")))) {

            message.clear();
            message.put("code","0");
            message.put("msg","验证码错误！");

            SimpleException.sendMessage(response,message,objectMapper);

            return;
        }
        System.out.println(session.getAttribute("verifyCode"));
        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(userCustom.getUsername(), userCustom.getPassword());
        try {
            Authentication authentication = myAuthenticationManager.authenticate(authRequest); //调用loadUserByUsername
            SecurityContextHolder.getContext().setAuthentication(authentication);
            session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext()); // 这个非常重要，否则验证后将无法登陆

            message.clear();
            message.put("code","1");
            message.put("msg","登录成功！");

            SimpleException.sendMessage(response,message,objectMapper);
        } catch (AuthenticationException ex) {
            message.clear();
            message.put("code","0");
            message.put("msg","用户名或密码错误！");

            SimpleException.sendMessage(response,message,objectMapper);
        }
    }

    @RequestMapping("/user/virifyImage")
    public void getVerifyImage(HttpSession session,HttpServletResponse response,HttpServletRequest request){

        try {
            response.setHeader("Content-Type","image/gif");
            VerifyMessage verifyMessage = vertifyCodeService.getVerifyMessage();
            System.out.println(session.getId()+"调用了验证码图片方法，请求了图片："+verifyMessage.getVerifyCode());
            ImageIO.write(verifyMessage.getVerifyImage(),"gif",response.getOutputStream());
            session.setAttribute("verifyCode",verifyMessage.getVerifyCode());
            System.out.println(session.getId()+"调用了验证码图片方法="+session.getAttribute("verifyCode"));
            System.out.println("调用了验证码图片方法=IP为："+request.getRemoteAddr());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}