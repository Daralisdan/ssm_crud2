package com.daralisdan.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.daralisdan.bean.Employee;
import com.daralisdan.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


/**
 * 
 * Description：这个处理器类的作用是：处理员工的增删改查的请求 <br>
 * @author yaodan  <br>
 * date 2019年8月1日 下午10:52:53 <br>
 */
@Controller
public class EmployeeController {

  // 3.需要查询的前提条件是调用service层
  @Autowired // 自动装配service层的业务逻辑组件
  EmployeeService employeeService;


  // 1.处理员工的方法，获取所有员工的信息
  /**
   * 
   * Title：getEmps <br>
   * Description：查询所有员工信息（分页查询） <br>
   * author：yaodan  <br>
   * date：2019年8月1日 下午11:05:45 <br>
   * @return <br>
   */
  @RequestMapping("/emps")
  public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

    // 4.service可以帮助查出所有数据，然后返回一个List类型的
    // 会查出很多。这不是一个分页查询
    // List<Employee> emps = employeeService.getAll();

    // 5.分页查询，需要引入PageHelper分页插件,传入页码及每页多少条数据
    PageHelper.startPage(pn, 5);
    // 5.2 startPage后面紧跟的这个查询就是一个分页查询
    List<Employee> emps = employeeService.getAll();
    // 5.3 使用pageinfo包装结果集，只需要将pageinfo交给页面
    // pageInfo封装了详细信息，包括查询出来的数据,连续传入5页，连续显示5页
    PageInfo page = new PageInfo(emps, 5);
    System.out.println();
    // pageInfo包括查询出来的数据
    model.addAttribute("pageInfo", page);
    // 2.返回到list页面进行展示
    return "list";

  }
}
