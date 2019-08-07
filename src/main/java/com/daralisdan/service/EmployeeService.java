package com.daralisdan.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.daralisdan.bean.Employee;
import com.daralisdan.dao.EmployeeMapper;

@Service // 业务逻辑组件
public class EmployeeService {

  // 调用，mapper,也就是dao层
  @Autowired
  EmployeeMapper employeeMapper;

  /**
   * 
   * Title：getAll <br>
   * Description：查询所有员工信息并且带有部门<br>
   * author：yaodan  <br>
   * date：2019年8月1日 下午11:21:38 <br>
   * @return <br>
   */
  public List<Employee> getAll() {

    return employeeMapper.selectByExampleWithdept(null);
  }

}
