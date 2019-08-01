package com.daralisdan.dao;

import com.daralisdan.bean.Employee;
import com.daralisdan.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
  long countByExample(EmployeeExample example);

  int deleteByExample(EmployeeExample example);

  int deleteByPrimaryKey(Integer empId);

  int insert(Employee record);

  int insertSelective(Employee record);

  // 查询所有
  List<Employee> selectByExample(EmployeeExample example);

  // 查询单个
  Employee selectByPrimaryKey(Integer empId);

  // 查询所有，查询带有部门信息
  List<Employee> selectByExampleWithdept(EmployeeExample example);

  // 查询单个,查询带有部门信息
  Employee selectByPrimaryKeyWithdept(Integer empId);

  int updateByExampleSelective(@Param("record") Employee record,
      @Param("example") EmployeeExample example);

  int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

  int updateByprimaryKeySelective(Employee record);

  int updateByprimaryKey(Employee record);


}
