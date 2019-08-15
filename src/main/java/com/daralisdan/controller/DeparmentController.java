package com.daralisdan.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.daralisdan.bean.Deparment;
import com.daralisdan.bean.Msg;
import com.daralisdan.service.DepartmentService;

/**
 * 
 * Description：处理与部门相关的请求 <br>
 * @author yaodan  <br>
 * date 2019年8月15日 下午7:13:31 <br>
 */
@Controller
public class DeparmentController {

  @Autowired // 自动装配service层到Controller层
  private DepartmentService departmentService;

  /**
   * 
   * Title：getDepts <br>
   * Description：查询所有部门信息，返回所有部门信息<br>
   * author：yaodan  <br>
   * date：2019年8月15日 下午7:40:15 <br>
   * @return <br>
   */
  @ResponseBody
  @RequestMapping("/depts")
  public Msg getDepts() {
    //查出的所有部门信息
    List<Deparment> list = departmentService.getDepts();
    return Msg.success().add("depts", list);

  }


}
