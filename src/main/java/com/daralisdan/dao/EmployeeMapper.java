package com.daralisdan.dao;

import com.daralisdan.bean.Employee;
import com.daralisdan.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
  long countByExample(EmployeeExample example);
  
  int deleteByExample(EmployeeExample example);

  /**
   * 
   * Title：deleteByPrimaryKey <br>
   * Description：根据员工id删除<br>
   * author：yaodan  <br>
   * date：2019年8月19日 下午7:07:32 <br>
   * @param empId
   * @return <br>
   */
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

  /**
   * 
   * Title：updateByprimaryKeySelective <br>
   * Description：根据id更新员工信息<br>
   * author：yaodan  <br>
   * date：2019年8月19日 上午11:48:33 <br>
   * @param record
   * @return <br>
   */
  int updateByprimaryKeySelective(@Param("record")Employee record);

  int updateByprimaryKey(@Param("record")Employee record);


}
