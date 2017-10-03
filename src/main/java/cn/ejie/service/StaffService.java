package cn.ejie.service;

import cn.ejie.dao.CityMapper;
import cn.ejie.dao.DepartmentMapper;
import cn.ejie.dao.StaffMapper;
import cn.ejie.exception.SimpleException;
import cn.ejie.exception.StaffException;
import cn.ejie.pocustom.StaffCustom;
import cn.ejie.utils.BeanPropertyValidateUtils;
import cn.ejie.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StaffService {
    @Autowired
    private StaffMapper staffMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private CityService cityService;

    private String errorType="staffError";

    /**
     * 添加员工
     * @param staffCustom
     * @throws Exception
     */
    public void addSingleStaff(StaffCustom staffCustom) throws Exception{
        BeanPropertyValidateUtils.validateIsEmptyProperty(staffCustom);//验证前台传输过来的关键字段属性是否为空。
        String tel = staffCustom.getTel();
        if(tel.length()!=11){
            throw new StaffException(errorType,"电话号码必须为11位！");
        }
        System.out.println(staffCustom);

        String cityID = cityService.findCityIDByCity(staffCustom.getCity());
        staffCustom.setCity(cityID);

        Map<String,String> params = new HashMap<>();
        params.put("city",staffCustom.getCity());
        params.put("dep",staffCustom.getDep());
        String depId = departmentMapper.findDepartmentIDByDepNameAndCity(params);

        if(depId==null){
            throw new StaffException(errorType,staffCustom.getDep()+" 部门不存在！");
        }
        staffCustom.setDep(depId);
        System.out.println(staffCustom);
        Integer staffCount = staffMapper.findStaffCountByDepAndNameAndTel(staffCustom);
        if(staffCount>0){
            throw new StaffException(errorType,"该员工已经存在，你可以通过 员工所属部门、姓名、电话号码 判断该员工是否存在！");
        }

        String cityId = departmentMapper.findCityIdByDepartmentId(depId);
        staffCustom.setCity(cityId);

        staffCustom.setEntryTime(StringUtils.zhDateStrToENDateStr(staffCustom.getEntryTime()));
        try {
            System.out.println(staffCustom);
            staffMapper.insert(staffCustom);
        }catch (Exception e){
            throw new SimpleException(errorType,"数据库发生错误！");
        }

    }

    public List<StaffCustom> findAll() throws Exception{
        List<StaffCustom> staffList = new ArrayList<StaffCustom>();
        try {
            staffList = staffMapper.findAll();
        }catch (Exception e){
            e.printStackTrace();
            throw new SimpleException(errorType,"数据库发生错误！");
        }
        return staffList;
    }

    public List<StaffCustom> findBySql(String sql) throws Exception{
        List<StaffCustom> staffList = new ArrayList<StaffCustom>();
        try {
            staffList = staffMapper.findBySql(sql);
        }catch (Exception e){
            e.printStackTrace();
            throw new SimpleException(errorType,"数据库发生错误！");
        }
        return staffList;
    }

    public StaffCustom findStaffById(String id) throws Exception{
        StaffCustom staffCustom = new StaffCustom();
        try {
            staffCustom = staffMapper.findStaffById(id);
        }catch (Exception e){
            e.printStackTrace();
            throw new SimpleException(errorType,"数据库发生错误！");
        }
        return staffCustom;
    }

    public Integer countStaffByCity(String city) throws Exception{
        if(city==null || city.equals("")){
            throw new SimpleException(errorType,"查询公司员工时，城市不能为空！");
        }
        Integer count = staffMapper.countStaffByCity(city);
        if(count==null){
            throw new SimpleException(errorType,"查询员工时，系统发生故障！");
        }
        return count;
    }

    public Integer countStaffByDepart(String department) throws Exception{
        if(department == null || department.equals("")){
            throw new SimpleException(errorType,"查询公司员工时，部门不能为空！");
        }
        Integer count = staffMapper.countStaffByDepart(department);
        if(count==null){
            throw new SimpleException(errorType,"查询员工时，系统发生故障！");
        }
        return count;
    }

    public void uploadFile(MultipartFile file) throws Exception {
        //获取文件类型
        String contentType = file.getContentType();

        System.out.println("contentType="+contentType);

        if(!contentType.equals("")) {
            //可以对文件类型进行检查
        }
        //获取input域的name属性
        String name = file.getName();
        System.out.println("name="+name);
        //获取文件名，带扩展名
        String originFileName = file.getOriginalFilename();
        System.out.println("originFileName"+originFileName);
        //获取文件扩展名
        String extension = originFileName.substring(originFileName.lastIndexOf("."));
        System.out.println(extension);
        //获取文件大小，单位字节
        long site = file.getSize();
        System.out.println("size="+site);
        if(site > EquipmentService.MAX_FILE_SISE) {
            //可以对文件大小进行检查
        }
        //构造文件上传后的文件绝对路径，这里取系统时间戳＋文件名作为文件名
        //不推荐这么写，这里只是举例子，这么写会有并发问题
        //应该采用一定的算法生成独一无二的的文件名
        String fileName = EquipmentService.UPLOAD_DIR + originFileName+"-"+String.valueOf(System.currentTimeMillis()) + extension;
        try {
            file.transferTo(new File(fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("fileName--------->"+fileName);
    }
}
