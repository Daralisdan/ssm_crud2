package com.daralisdan.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.daralisdan.bean.Deparment;
import com.daralisdan.dao.DeparmentMapper;

@Service // 业务逻辑组件
public class DepartmentService {

  @Autowired
  private DeparmentMapper departmentMapper;

  /**
   * 
   * Title：getDepts <br>
   * Description：查询返回部门信息 <br>
   * author：yaodan  <br>
   * date：2019年8月15日 下午7:45:46 <br>
   * @return <br>
   */
  public List<Deparment> getDepts() {
    List<Deparment> list = departmentMapper.selectByExample(null);
    return list;
  }

}
