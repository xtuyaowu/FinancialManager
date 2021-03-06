package cn.ejie.po;

import cn.ejie.annotations.BeanPropertyErrorType;

/**
 * 员工类
 */
public class Staff {
    private String staffId;//员工ID
    @BeanPropertyErrorType(propertyName = "员工姓名",value = "staffError")
    private String name;//员工姓名
    @BeanPropertyErrorType(propertyName = "员工部门",value = "staffError")
    private String dep;//员工部门
    @BeanPropertyErrorType(propertyName = "员工职位",value = "staffError")
    private String position;//员工职位
    @BeanPropertyErrorType(propertyName = "员工电话号码",value = "staffError")
    private String tel;//员工电话号码
    @BeanPropertyErrorType(propertyName = "员工入职时间",value = "staffError")
    private String entryTime;//入职时间
    private String customMessages;//自定义字段
    private String city;//城市ID

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDep() {
        return dep;
    }

    public void setDep(String dep) {
        this.dep = dep;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(String entryTime) {
        this.entryTime = entryTime;
    }

    public String getCustomMessages() {
        return customMessages;
    }

    public void setCustomMessages(String customMessages) {
        this.customMessages = customMessages;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Override
    public String toString() {
        return "Staff{" +
                "staffId='" + staffId + '\'' +
                ", name='" + name + '\'' +
                ", dep='" + dep + '\'' +
                ", position='" + position + '\'' +
                ", tel='" + tel + '\'' +
                ", entryTime='" + entryTime + '\'' +
                ", customMessages='" + customMessages + '\'' +
                ", city='" + city + '\'' +
                '}';
    }
}
