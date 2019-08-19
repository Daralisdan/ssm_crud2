package com.daralisdan.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.daralisdan.bean.Employee;
import com.daralisdan.bean.EmployeeExample;
import com.daralisdan.bean.EmployeeExample.Criteria;
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

  /**
  * 
  * Title：saveEmp <br>
  * Description：新增员工信息保存 <br>
  * author：yaodan  <br>
  * date：2019年8月15日 下午9:31:58 <br>
  * @param employee <br>
  */
  public void saveEmp(Employee employee) {
    employeeMapper.insertSelective(employee);
  }

  /**
   * 
   * Title：checkUser <br>
   * Description：校验用户名是否可用 <br>
   * author：yaodan  <br>
   * date：2019年8月16日 下午5:54:04 <br>
   * @param empNamer
   * 如果等于则返回true,代表当前姓名可用。如果大于0则返回false 不可用，
   * 然后在controller写判断逻辑
   * @return <br>
   */
  public boolean checkUser(String empName) {
    EmployeeExample example = new EmployeeExample();
    Criteria criteria = example.createCriteria();
    // 拼装员工的名字andEmpNameEqualTo必须等于传入的empName
    criteria.andEmpNameEqualTo(empName);
    long count = employeeMapper.countByExample(example);
    return count == 0;

  }

  /**
   * 
   * Title：getEmpId <br>
   * Description：根据员工Id查询员工信息<br>
   * author：yaodan  <br>
   * date：2019年8月19日 上午11:12:16 <br>
   * @param id
   * @return <br>
   */
  public Employee getEmpId(Integer id) {
    Employee employee = employeeMapper.selectByPrimaryKey(id);
    return employee;
  }

  /**
   * 
   * Title：updateEmpId <br>
   * Description：员工更新 <br>
   * author：yaodan  <br>
   * date：2019年8月19日 上午11:11:50 <br>
   * @param employee <br>
   */
  public void updateEmpId(Employee employee) {
    employeeMapper.updateByprimaryKeySelective(employee);
  }

  public void deleteEmpById(Integer id) {
    employeeMapper.deleteByPrimaryKey(id);
  }

  public void deleteBatch(List<Integer> ids) {
    EmployeeExample example = new EmployeeExample();
    Criteria criteria = example.createCriteria();
//    delete from xxx where emp_id in(1,2,3)
    criteria.andEmpIdIn(ids);
    employeeMapper.deleteByExample(example);

  }


}
