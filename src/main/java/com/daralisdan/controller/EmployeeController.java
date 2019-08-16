package com.daralisdan.controller;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.daralisdan.bean.Employee;
import com.daralisdan.bean.Msg;
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
  // @RequestMapping("/emps")
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

  /**
   * 
   * Title：getEmps <br>
   * Description：返回json数据的方式 <br>
   * 分页数据以json格式返回
   * author：yaodan  <br>
   * date：2019年8月14日 下午4:38:05 <br>
   * @return <br>
   */
  @RequestMapping("/emps")
  @ResponseBody
  public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
    // 1.引入分页插件，在查询之前只需要调用，传入页码，以及每页的大小
    PageHelper.startPage(pn, 5);
    // 2. startPage后面紧跟的这个查询就是一个分页查询
    List<Employee> emps = employeeService.getAll();
    // 3.使用pageinfo包装结果集，只需要将pageinfo交给页面
    // pageInfo封装了详细信息，包括查询出来的数据,连续传入5页，连续显示5页
    PageInfo page = new PageInfo(emps, 5);
    return Msg.success().add("pageInfo", page);

  }

  /**
   * 
   * Title：saveEmp <br>
   * Description：新增员工，员工的保存<br>
   * author：yaodan  <br>
   * date：2019年8月15日 下午9:22:08 <br>
   * @return <br>
   */
  @RequestMapping(value = "/emp", method = RequestMethod.POST)
  @ResponseBody
  public Msg saveEmp(Employee employee) {
    employeeService.saveEmp(employee);
    return Msg.success();

  }

  /**
   * 
   * Title：checkUser <br>
   * Description：校验用户名是否可用 <br>
   * 传入用户名的参数
   * author：yaodan  <br>
   * date：2019年8月16日 下午5:05:19 <br>
   * @return <br>
   */
  @ResponseBody
  @RequestMapping("/checkuser")
  //加上@RequestParam("empName")注解之后就是明确告诉springmvc要取出empName的值给前端（ajax请求的数据值）
  public Msg checkUser(@RequestParam("empName")String empName) {
    boolean b = employeeService.checkUser(empName);
    if (b) {
      // 如果可用,返回成功
      return Msg.success();
    } else {
      return Msg.fail();
    }
  }


}
