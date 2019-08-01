package com.daralisdan.bean;

public class Employee {
  private Integer empId;

  private String empName;

  private String gender;

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
