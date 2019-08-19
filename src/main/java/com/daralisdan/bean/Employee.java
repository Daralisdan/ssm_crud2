package com.daralisdan.bean;

import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.Email;

public class Employee {
  private Integer empId;

  /**
   * JSR303验证的注解，提交的数据进行服务器端的验证
   * @Pattern 该注解表示自定义规则
   */
  @Pattern(regexp="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
      message="用户名必须是2-5位中文或者6-16位英文和数字的组合")
  private String empName;

  private String gender;


  /**
   * JSR303验证的注解，提交的数据进行服务器端的验证
   * @Pattern 该注解表示自定义规则
   */
  //@Email //快捷的注解，邮箱验证，也可以自定义
  @Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
      message="邮箱格式不正确")
  private String email;

  private Integer dId;

  // 封装员工对应的部门信息,一个员工对应一个部门
  // 查询员工的同时，部门信息也是查询好的
  private Deparment deparment;

  /**
   * Title：Employee <br>
   * Description：无参构造器 <br>
   * author：yaodan <br>
   * date：2019年8月1日 下午1:53:28 <br> <br>
   */
  public Employee() {
    super(); // TODO %CodeTemplates.constructorstub.tododesc
  }

  /**
   * 
   * Title：Employee <br>
   * Description：有参构造器 <br>
   * author：yaodan <br>
   * date：2019年8月1日 下午1:52:49 <br>
   */
  public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
    super();
    this.empId = empId;
    this.empName = empName;
    this.gender = gender;
    this.email = email;
    this.dId = dId;

  }



  @Override
  public String toString() {
    return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email="
        + email + ", dId=" + dId +"]";
  }

  public Deparment getDeparment() {
    return deparment;
  }

  public void setDeparment(Deparment deparment) {
    this.deparment = deparment;
  }

  public Integer getEmpId() {
    return empId;
  }

  public void setEmpId(Integer empId) {
    this.empId = empId;
  }

  public String getEmpName() {
    return empName;
  }

  public void setEmpName(String empName) {
    this.empName = empName == null ? null : empName.trim();
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender == null ? null : gender.trim();
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email == null ? null : email.trim();
  }

  public Integer getdId() {
    return dId;
  }

  public void setdId(Integer dId) {
    this.dId = dId;
  }
}
