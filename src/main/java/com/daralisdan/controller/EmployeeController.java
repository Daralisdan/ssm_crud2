package com.daralisdan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import javax.websocket.server.PathParam;
import org.apache.catalina.Contained;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
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
      * 进行JSR校验：1.要支持JSR303校验
   * 2.首先导入Hibernate-validate的jar包
   * author：yaodan  <br>
   * date：2019年8月15日 下午9:22:08 <br>
   * @Valid 该注解表示对封装的员工数据进行验证
   * @return <br>
   */
  @RequestMapping(value = "/emp", method = RequestMethod.POST)
  @ResponseBody
  // @Valid 该注解表示对封装的员工数据进行验证,BindingResult绑定校验的结果
  public Msg saveEmp(@Valid Employee employee, BindingResult result) {
    if (result.hasErrors()) {
      // 4.封装一个Map，返回错误信息给浏览器
      Map<String, Object> map = new HashMap<String, Object>();
      // 1.如果校验失败，不能保存员工，并且返回失败，在模态框中显示校验失败的信息
      // 2.显示错误信息的逻辑，在result结果中提取错误信息
      List<FieldError> errors = result.getFieldErrors();
      // 3.遍历错误信息
      for (FieldError fieldError : errors) {
        System.out.println("错误字段名：" + fieldError.getField());
        System.out.println("错误信息：" + fieldError.getDefaultMessage());
        // 6.把错误信息写入Map中
        map.put(fieldError.getField(), fieldError.getDefaultMessage());
      }
      // 7.然后把map交给浏览器显示
      return Msg.fail().add("errorFileds", map);
    } else {
      // 校验成功，保存信息
      employeeService.saveEmp(employee);
      return Msg.success();
    }

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
  // 加上@RequestParam("empName")注解之后就是明确告诉springmvc要取出empName的值给前端（ajax请求的数据值）
  public Msg checkUser(@RequestParam("empName") String empName) {
    // 先判断用户名表达式是否正确合法，正确之后在判断数据库中是否有重复的用户名，该用户名是否可用，把结果返回到前台

    // 声明正则表达式，与前台校验的正则表达式一致
    String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
    // 查看用户名是否匹配这个正则表达式，String里面有个matches
    if (!empName.matches(regx)) {
      // 如果用户名表达式与正则表达式不匹配,返回fail
      return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者是2-5位的中文");
    }
    // 如果用户名表达式与正则表达式匹配校验成功，则进行下面的数据库校验，用户名是否重复
    boolean b = employeeService.checkUser(empName);
    if (b) {
      // 如果可用,返回成功
      return Msg.success();
    } else {
      return Msg.fail().add("va_msg", "用户名不可用");
    }
  }

  /**
   * 
   * Title：getEmp <br>
   * Description：根据员工id查询员工信息 <br>
   * author：yaodan  <br>
   * date：2019年8月18日 下午9:13:38 <br>
   * @return <br>
   */
  @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
  @ResponseBody
  // Integer id 员工id的值来源于请求地址中的变量，使用@PathVariable该注解指定从路径中取出的id值
  // 表示从前台获取到的员工id(传过来的id),Msg表示返回的数据都放在Msg中
  public Msg getEmpId(@PathVariable("id") Integer id) {
    // 然后根据id查询，返回employee对象
    Employee employee = employeeService.getEmpId(id);
    // 把返回的employee对象的内容放在emp中，返回出去
    return Msg.success().add("emp", employee);
  }

  /**
   * 
   * Title：updateEmpId <br>
   * Description：员工更新
      * 保存更新员工的数据<br>
   * author：yaodan  <br>
   * date：2019年8月19日 上午11:07:50 <br>
   * @param employee
   * @return <br>
   */
  @ResponseBody
  //empId 员工id
  @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
  public Msg updateEmpId(Employee employee) {
    //想要打印信息在控制台，就需要在实体类中加上toString方法
  System.out.println("将要更新的员工数据"+employee);
    employeeService.updateEmpId(employee);
    return Msg.success();

  }
  
  /**
   * 
   * Title：deleteEmpById <br>
   * Description：根据员工id删除 <br>
   * author：yaodan  <br>
   * date：2019年8月19日 下午4:26:13 <br>
   * @param id
   * @return <br>
   *//*
  @ResponseBody
  @RequestMapping(value="/emp/{id}",method=RequestMethod.POST)
  public Msg deleteEmpById(@PathVariable("id")Integer id) {
    employeeService.deleteEmpById(id);
    return Msg.success();
    
  }*/
  
  /**
   * 
   * Title：deleteEmpById <br>
   * Description：单个删除与多个删除二合一 <br>
   * 批量删除：1-2-3
   * 单个删除：1
   * author：yaodan  <br>
   * date：2019年8月19日 下午4:26:13 <br>
   * @param id
   * @return <br>
   */
  @ResponseBody
  @RequestMapping(value="/emp/{ids}",method=RequestMethod.POST)
  public Msg deleteEmpById(@PathVariable("ids")String ids) {
    if (ids.contains("-")) {
      //批量删除
      //3.id集合
      List<Integer> del_ids=new ArrayList<>();
      //1.分割id
      String[] str_ids=ids.split("-");
      //4.组装id的集合
      for (String string : str_ids) {
        del_ids.add(Integer.parseInt(string));
      }
     //2.
      employeeService.deleteBatch(del_ids);
    }else {
      //直接转换
      Integer id=Integer.parseInt(ids);
      employeeService.deleteEmpById(id);
    }
    return Msg.success();
    
  }
  

}
