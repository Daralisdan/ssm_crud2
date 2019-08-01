package com.daralisdan.bean;

public class Deparment {
  private Integer deptId;

  private String deptName;

/**
 * 
 * Title：Deparment <br>
 * Description：有参构造器必须要有无参构造器<br>
 * author：yaodan <br>
 * date：2019年8月1日 下午1:20:35 <br> <br>
 */
  public Deparment() {
    super(); // TODO %CodeTemplates.constructorstub.tododesc
  }

  /**
   * 
   * Title：Deparment <br>
   * Description：添加有参构造器，有参构造器必须要有无参构造器 <br>
   * author：yaodan <br>
   * date：2019年8月1日 下午1:18:44 <br>
   * @param deptId
   * @param deptName <br>
   */
  public Deparment(Integer deptId, String deptName) {
    super();
    this.deptId = deptId;
    this.deptName = deptName;
  }

  public Integer getDeptId() {
    return deptId;
  }

  public void setDeptId(Integer deptId) {
    this.deptId = deptId;
  }

  public String getDeptName() {
    return deptName;
  }

  public void setDeptName(String deptName) {
    this.deptName = deptName == null ? null : deptName.trim();
  }
}
