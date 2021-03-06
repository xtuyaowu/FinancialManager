package cn.ejie.web.filter;

import cn.ejie.po.RequestWrapper;
import cn.ejie.service.EquipmentService;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Administrator on 2017/8/21.
 */
public class EncordingFilter implements Filter {

    /**
     * Default constructor.
     */
    public EncordingFilter() {
        // TODO Auto-generated constructor stub
    }

    /**
     * @see Filter#destroy()
     */
    public void destroy() {
        // TODO Auto-generated method stub
    }

    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        {
            //修改文件上传路径和文件生成路径
            HttpServletRequest req = (HttpServletRequest)request;
            String rootPath = req.getSession().getServletContext().getRealPath("/");
            EquipmentService.BASE_PATH = rootPath +"UploadSource\\";
            EquipmentService.UPLOAD_DIR = EquipmentService.BASE_PATH;
            EquipmentService.EQ_MODEL_FILE = EquipmentService.BASE_PATH+"设备模板.xlsx";
        }
        RequestWrapper requestWrapper=new RequestWrapper((HttpServletRequest)request, "UTF-8");
        chain.doFilter(requestWrapper, response);
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig fConfig) throws ServletException {
    }

}
