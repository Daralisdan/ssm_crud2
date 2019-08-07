<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>创建ssm整合的项目，crud</title>
</head>
<body>
	<h1>第一步：创建maven项目,引入jar包</h1>
	<p>
		1.在pom.xml中指定JDK版本<br>
		2.引入所需jar包：spring，springmvc,mybatis,数据库连接池驱动包，其他<br>
		&nbsp;&nbsp;&nbsp; 2.1 springMVCjar包（AOP,IOC容器）<br>
		&nbsp;&nbsp;&nbsp; 2.2 spring的jar包，（事物控制的）： jabc包， 面向切面包，<br>
		&nbsp;&nbsp;&nbsp; 2.3 mybatis的包<br> &nbsp;&nbsp;&nbsp; 2.4
		mybatis与spring整合的包<br> &nbsp;&nbsp;&nbsp; 2.5数据库连接池与驱动类jar<br>
		&nbsp;&nbsp;&nbsp; 2.7 mybatis逆向工程的jar<br> &nbsp;&nbsp;&nbsp;
		2.6其他标配jar（jstl,servlet-api因为服务器中有api，所以需要添加scope包告诉它被提供,junit）<br>
		&nbsp;&nbsp;&nbsp;2.8 spring单元测试的jar<br> &nbsp;&nbsp;&nbsp;2.9
		引入pageHelper分页jar包 pagehelper
		3.引入bootstrap前端框架(boobootstrap,js和jquery中)
	</p>
	<h1>第二步：编写整合的配置文件，web.xml,spring,springmvc,mybatis的配置文件，使用mybatis的逆向工程生成对应的bean，以及mapper</h1>
	<p>
	<h3>web.xml,启动spring的容器</h3>

	1.配置启动spring容器的监听器，然后指定spring配置文件的路径，然后创建spring的配置文件
	<br>
	2.配置springmvc的前端控制器，DispatcherServlet（不写init指定的话，必须在web.xml同级目录下创建同名的配置文件，（servlet的名称-servlet）的命名方式）
	<br>3.配置字符编码过滤器
	<br>4.rest风格的url:作用将普通的get，post请求转为我们指定的delete，put等请求
	<br>
	<h3>在多个过滤器的情况下，必须要将字符编码过滤器放在所有过滤器最前面</h3>
	<br>
	<h3>springmvc.xml,前端控制器，包含网站页面跳转逻辑的控制</h3>
	<br>1.配置扫描controller包的控制器
	<br>2.配置视图InternalResourceViewResolver
	<br>3.两个标配
	<!--作用：springmvc不能处理的请求交给Tomcat，实现了动态资源，静态资源都能访问成功  -->
	<br>
	<mvc:default-servlet-handler />
	<br>
	<!-- 支持springmvc更加高级的功能，比如：jsr303校验，快捷的ajax..最重要的是映射动态请求 -->
	<br>
	<mvc:annotation-driven />
	<br>


	<h3>配置spring的配置文件applicationContext.xml</h3>

	<br>1.spring配置的作用：spring里面与业务逻辑有关的数据源 ，事物控制等重要属性控制
	<br>&nbsp;&nbsp;1.1配置数据源,然后创建与数据源相关配置的配置文件db.properties
	<br>&nbsp;&nbsp;1.2在db.properties中添加与数据源相关的配置文件
	<br>&nbsp;&nbsp;1.3在spring配置文件中需要引入外部文件db.properties中的配置则需要添加配置
	<br>&nbsp;&nbsp;1.4业务逻辑组件需要扫描进来，添加在最前面（不能与springmvc扫面的组件合并，这里除了controller包不扫描，其他都要扫描）
	<br>&nbsp;&nbsp;1.5配置与mybatis整合的配置文件 ,然后创建mybatis的配置文件
	<br>&nbsp;&nbsp;1.6配置扫描器，将mybatis接口的实现加入到IOC容器中，mybatis接口的实现是一个代理对象
	<br>&nbsp;&nbsp;1.5，1.6的配置步骤：是与mybatis的整合的配置文件
	<br>&nbsp;&nbsp;1.7事物控制的配置（控制数据源）
	<br>&nbsp;&nbsp;1.8开启基于注解的事物 2.使用xml配置形式的事物（一般重要的配置推荐使用配置式）
	<br>&nbsp;&nbsp;1.9配置事物增强，事物表达式如何切入方法
	<br>
	<h1>spring配置文件的核心点（数据源，与mybatis的整合，事物控制...）</h1>

	<h3>配置mybatis的配置文件mybatis-config.xml</h3>

	<br>1.mybatis的官方文档，www.mybatis.org
	<br>2.创建数据库表结构
	<br>3.使用mybatis的逆向工程生成对应的bean，以及mapper
	<br>&nbsp;&nbsp;3.1搜索mybatis generator,首先引入jar包
	<br>&nbsp;&nbsp;3.2创建逆向工程mbg的配置文件，然后复制文档中的配置,然后修改相应配置
	<br>&nbsp;&nbsp;3.3修改完成之后，新建测试包，运行Test测试类中main方法，逆向生成代码
	<br>&nbsp;&nbsp;3.4修改生成的代码，1.首先在dao的mapper.xml中添加查询方法
	<br> 2.在实体类中添加封装的信息
	<br>3.在mappers文件中添加查询语句
	<br>4.测试mapper,是否连通
	<br>5.测通之后，添加查询方法测试（在实体类添加有参构造器，就必须添加无参构造器）
	<br>6.添加插入的方式测试与数据库的连通情况


	<h1>第三步：开始写项目逻辑，前端页面</h1>
	<p>
	<h3>
		项目逻辑：1.首先访问index.jsp页面<br>
		&nbsp;&nbsp;&nbsp;2.index.jsp页面发送出查询员工请求 <br>&nbsp;&nbsp;&nbsp;3.EmployeeController来接受请求，然后处理逻辑，返回数据到前台页面
		<br>&nbsp;&nbsp;&nbsp;4.然后来到list.jsp页面进行展示 <br>
	</h3>
	&nbsp;&nbsp;&nbsp;1.前端页面规定url访问路径
	<br>&nbsp;&nbsp;&nbsp;2.写一个处理器，首先
	写一个查询所有的方法。然后返回到前端页面展示，然后新建一个对应的前端页面
	<br>&nbsp;&nbsp;&nbsp;Controller层 @Autower注解自动装配；Service层：@Service
	// 业务逻辑组件注解
	<br>&nbsp;&nbsp;&nbsp;3.分页查询，在controller引入分页插件，先引入jar
	<br>&nbsp;&nbsp;&nbsp;3.1引入jar之后，在mybatis-config全局配置中添加配置
	<br>&nbsp;&nbsp;&nbsp;3.3在方法中添加分页相关语句
	<br>&nbsp;&nbsp;&nbsp;4.测试。方法测试，请求测试，首先创建测试类（使用spring测试模块提供的测试请求功能，测试crud请求正确）
	<br>&nbsp;&nbsp;&nbsp;4.1 ctrl+2 补全
	</p>
	<p>
	<h3>搭建bootstrap前端页面</h3>
	<br>&nbsp;&nbsp;&nbsp;1.在list查询页面引入bootstrap框架，全局css中的样式，组件中的样式引入
	<br>&nbsp;&nbsp;&nbsp;2.框架搭好之后引入标签库
	<br>&nbsp;&nbsp;&nbsp;3.写页面布局，然后传入数据
	<br>&nbsp;&nbsp;&nbsp;
	<br>&nbsp;&nbsp;&nbsp;
	<br>&nbsp;&nbsp;&nbsp;
	<br>&nbsp;&nbsp;&nbsp;
	<br>&nbsp;&nbsp;&nbsp;







	</p>












	<h1>第四步：</h1>
	<p></p>
</body>
</html>
