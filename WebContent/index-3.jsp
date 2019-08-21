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
		&nbsp;&nbsp;&nbsp;2.8 spring单元测试的jar <br> &nbsp;&nbsp;&nbsp;2.9
		json数据支持的jar jackson-databind 引入pageHelper分页jar包 pagehelper
		3.引入bootstrap前端框架(boobootstrap,js和jquery中) <br>
		&nbsp;&nbsp;&nbsp;4.引入JSR校验的jar包：Hibernate-validatorhibernate-validator的jar支持(tomcat7以上版本支持，以下的服务器,el表达式不是新的标准，需要额外的给服务器的lib包中替换新的标准el)
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
	</p>

	<h1>第四步：ajax_查询部分</h1>
	<p>
	<h3>分页查询——返回json数据</h3>
	<h5>查询页面的逻辑</h5>
	<p>
		<br>&nbsp;&nbsp;1.index.jsp页面直接发送ajax请求进行员工分页数据的查询 <br>&nbsp;&nbsp;2.服务器将查询出的数据，以json字符串的形式返回给浏览器
		<br>&nbsp;&nbsp;3.浏览器收到js字符串，可以使用js对json进行解析，使用js通过dom增删改，改变页面 <br>&nbsp;&nbsp;4.返回json，实现客户端的无关性
	</p>
	<p>
	<h3>查询步骤：</h3>
	<br>&nbsp;&nbsp;&nbsp;1.首先引入json字符串支持的jar jackson-databind
	<br>&nbsp;&nbsp;&nbsp;2.在Controller层写返回json数据字符串的方法
	<br>&nbsp;&nbsp;&nbsp;3.设计一个通用的返回信息，包括状态通知给浏览器，在bean实体类中创建一个通用的返回信息的类Msg.java(通用个返回类)
	<br>&nbsp;&nbsp;&nbsp;4.修改jsp页面，写js代码，ajax获取后台数据，并解析json数据展示在前台
	<br>&nbsp;&nbsp;&nbsp;5.解析分页条信息，并且能跳转（需要判断）
	<br>&nbsp;&nbsp;&nbsp;6.实现跳转之后，会有重复信息，所有在所有操作之前需要清空
	<br>&nbsp;&nbsp;&nbsp;7.完成之后需要合理化分页，所以在mybatis配置中添加合理化分页的配置reasonable设置为true
	<br>&nbsp;&nbsp;&nbsp;8.修改点击事件的逻辑，禁用之后就不在点击，否则就点击
	<br>&nbsp;&nbsp;&nbsp;9.查询部分完成了。
	</p>
	</p>

	<h1>第五步：ajax_新增部分</h1>
	<p>
	<h5>新增页面的逻辑</h5>
	<br>&nbsp;&nbsp;1.在index.jsp页面点击"新增"
	<br>&nbsp;&nbsp;2.弹出新增对话框
	<br>&nbsp;&nbsp;3.去数据库查询部门列表，显示在对话框中
	<br>&nbsp;&nbsp;4.用户输入数据，
	<br>&nbsp;&nbsp;5.进行校验（前端jquery校验，ajaxy用户名校验，重要数据（JSR303后端校验）
	唯一约束）
	<br>&nbsp;&nbsp;6.完成保存
	<br>&nbsp;规定url:1./emp/{id} GET查询员工
	<br>&nbsp;2. /emp POST保存员工
	<br>&nbsp;3. /emp/{id} PUT修改员工
	<br>&nbsp;3. /emp/{id} DELETE删除员工
	<br>&nbsp;


	</p>
	<p>
		<br>&nbsp;&nbsp;&nbsp;1.创建员工模态框，弹出的新增对话框 <br>&nbsp;&nbsp;&nbsp;2.弹出模态框之前，数据库给服务器发送一个ajax请求，获取到部门信息，并显示到下拉列表中
		<br>&nbsp;&nbsp;&nbsp;3.完成保存，添加员工的方法 <br>&nbsp;&nbsp;&nbsp;4.保存按钮的点击事件，发送ajax请求，关闭模态框，回到最后页面
		<br>&nbsp;&nbsp;&nbsp;5.新增部分基本完成
	<h3>jquery前端校验，用户名等等</h3>
	<br>&nbsp;&nbsp;&nbsp;1.抽取校验方法，然后单独调用
	<br>&nbsp;&nbsp;&nbsp;2.美化校验显示信息。添加类样式CSS样式，添加span元素显示检验提示信息
	<br>&nbsp;&nbsp;&nbsp;3.添加样式之后，验证的时候会重复显示，所以在添加之前要先清除样式
	<h3>服务器端的校验，验证提交的数据是否有重复，即用户名是否重复</h3>
	<br>&nbsp;&nbsp;&nbsp;1.前端：用户名id绑定change改变事件(编写change方法)，表示当用户名改变时发送ajax请求到Controller服务器端检查用户名是否可用
	<br>&nbsp;&nbsp;&nbsp;1.1在按钮点击事件之前绑定change方法
	<br>&nbsp;&nbsp;&nbsp;2.编写controller逻辑代码，检查用户名是否可用
	<br>&nbsp;&nbsp;&nbsp;3.写好逻辑之后，回到前端页面，发送ajax请求验证用户名是否可用
	<br>&nbsp;&nbsp;&nbsp;4.在按钮点击处，点击之前需要判断之前ajax请求用户名，邮箱校验是否成功，如果没有则不进行按钮ajax请求
	<br>&nbsp;&nbsp;&nbsp;5.表单提交之前清除内容，这样就避免了提交成功的内容再次提交不进行校验
	<h3>处理校验的细节，前后端正则表达式统一等</h3>
	<br>&nbsp;&nbsp;&nbsp;1.找到服务器端Controller层校验的方法，编写前后端一致的正则表达式
	<br>&nbsp;&nbsp;&nbsp;2.修改前端页面校验的提示信息，从服务器端传过来的
	<br>&nbsp;&nbsp;&nbsp;3.清空表单的数据与样式（抽取清空的方法，然后在模态框处直接调用）
	<h3>JSR303校验</h3>
	<br>&nbsp;&nbsp;&nbsp;1.支持JSR303校验需要导入Hibernate-validator的jar包hibernate-validator的jar支持(tomcat7以上版本支持，以下的服务器,el表达式不是新的标准，需要额外的给服务器的lib包中替换新的标准el)
	<br>&nbsp;&nbsp;&nbsp;2.然后在实体类中对应字段上加上验证的正则表达式注解（可以统一，也可以用它自带的验证）
	<br>&nbsp;&nbsp;&nbsp;3.在Controller层验证时：对应方法的对象上面加上验证的注解，然后绑定校验的结果，然后校验成功，校验失败的逻辑返回给浏览器
	<br>&nbsp;&nbsp;&nbsp;4.修改完善jquery验证代码,在点击保存按钮处写错误验证的提示代码逻辑
	</p>


	<h1>第六步：ajax_修改部分</h1>
	<p>
	<h3>修改更新部分的逻辑</h3>
	<br>&nbsp;&nbsp;&nbsp;1.点击编辑按钮
	<br>&nbsp;&nbsp;&nbsp;2.弹出用户修改的模态框
	<br>&nbsp;&nbsp;&nbsp;3.然后点击更新按钮，完成用户修改
	</p>
	<p>
		<br>&nbsp;&nbsp;&nbsp;1.首先创建点击编辑的时候弹出的模态框 <br>&nbsp;&nbsp;&nbsp;2.点击编辑按钮弹出模态框，在创建编辑删除按钮的class样式中给编辑，删除按钮添加标识edit_btn,del_btn
		<br>&nbsp;&nbsp;&nbsp;3.然后给编辑按钮绑定点击事件 <br>&nbsp;&nbsp;&nbsp;3.1弹出模态框
		<br>&nbsp;&nbsp;&nbsp;3.1.1首先在点击弹出模态框之前要查处员工与部门信息并显示 <br>&nbsp;&nbsp;&nbsp;4.修改查出部门信息的方法，js代码（getDepts(ele)处修改），传入元素使需要查询显示部门信息的地方动态传入参数
		<br>&nbsp;&nbsp;&nbsp;5.调用查询方法显示信息在下拉列表之后，由于多次点击，则会多次查询显示，所以在调用方法之前需要清空下拉列表数据显示
		<br>&nbsp;&nbsp;&nbsp;5.1清空下拉列表数据显示($(ele).empty();) <br>&nbsp;&nbsp;&nbsp;6.点击编辑，模态框显示员工信息（发送ajax请求去服务器查询到当前需要修改的员工信息）然后显示在模态框中
		<br>&nbsp;&nbsp;&nbsp; 6.1先修改模态框，参照bootStrap Css样式静态控件 <br>&nbsp;&nbsp;&nbsp;
		7.发送查询员工信息的ajax前需要在服务器端写查询方法（controller层） <br>&nbsp;&nbsp;&nbsp;8.为员工编辑按钮添加一个自定义属性，来表示当前员工的id（在创建编辑按钮处添加），然后在调用查询员工信息方法的时候，定义被点击的按钮，然后获取按钮员工的id
		<br>&nbsp;&nbsp;&nbsp;9.运行测试时报错，显示没有找到主键查询的方法，这时就要自己写select
		查询语句，这是因为逆向生成的时候没有，需要不同的查询方法，则可以自己定义 <br>&nbsp;&nbsp;&nbsp;
		10.在服务器返回的数据中拿到员工数据 <br>&nbsp;&nbsp;&nbsp;11.在对话框指定位置显示对应数据 <br>&nbsp;&nbsp;&nbsp;12.给更新按钮绑定点击事件，点击更新按钮，完成保存
		<br>&nbsp;&nbsp;&nbsp;12.1验证邮箱 <br>&nbsp;&nbsp;&nbsp;12.2发送ajax请求保存员工更新的数据，在发送ajax请求之前需要在服务器层（controller层写保存更新员工的信息的方法），即请求处理的方法
		<br>&nbsp;&nbsp;&nbsp;13.处理ajax请求的方法写好之后，然后就写ajax，发送ajax请求更新员工 <br>&nbsp;&nbsp;&nbsp;13.1测试报错时，没有在mapper中写修改的sql语句可以自定义添加上，还要在dao层接口中定义该方法
		<br>&nbsp;&nbsp;&nbsp;13.2服务器发送去请求时PUT，ajax发送的请求时POST，这时ajax中就要加上(&_method=PUT)的方法，还需要在web.xml中配置处理rest风格的请求的过滤器
		<br>&nbsp;&nbsp;&nbsp;14.修改保存测试成功后，关闭对话框，回到当前页面 <br>&nbsp;&nbsp;&nbsp;14.1定义一个全局变量，赋值当前页码数，然后调用回到当前页码的方法传入全局变量的参数
		<br>&nbsp;&nbsp;&nbsp;15.修改部分完成了

	</p>

	<h1>第七步：ajax_删除部分</h1>
	<p>
	<h3>单个员工的删除</h3>
		<br>&nbsp;&nbsp;&nbsp;1.首先在服务器端写删除员工的方法（处理ajax请求的删除逻辑）
		<br>&nbsp;&nbsp;&nbsp; 1.1需要在mapper中自定义sql语句
		<br>&nbsp;&nbsp;&nbsp;2.然后在js页面：1.获取到点击删除按钮位置的用户名和id，
	    <br>&nbsp;&nbsp;&nbsp;2.2然后写弹框是否确认删除该用户，如果是则发送ajax请求处理
		<br>&nbsp;&nbsp;&nbsp;3.回到当前页
	<h3>多个员工的删除</h3>
		<br>&nbsp;&nbsp;&nbsp;1.先创建全选或者全不选框。首先在jsp页面显示表格数据处添加checkbox,然后在js页面创建td,tr元素的地方创建出来，然后追加显示在表格中
		<br>&nbsp;&nbsp;&nbsp;2.做全选/全不选功能
		<br>&nbsp;&nbsp;&nbsp;3.完成删除功能。提示是否删除
		<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;
	</p>

<h1>第八步：SSM项目总结</h1>
	<p>
		1该项目.首先与用户交互的是UI界面，使用bootstrap前端框架快速搭建，用户发送请求<br>
		2.请求来到Tomcat服务器，Tomcat作为serverNet容器进行处理请求;tomcat中有许多项目，当前项目只是其中一个小项目<br>
		3.逻辑：如果页面发送请求，tomcat找到当前项目，当前项目收到请求之后，用ssm组合处理。请求第一步会被springmvc的前端控制器接收拦截之后进行处理，然后找到判断能不能处理请求；
		如果可以处理就调用Controller控制器某一个处理请求的方法来处理请求，如果不能处理请求，springmvc配置文件中配置了默认处理器，不能处理的请求（静态资源）就交给Tomcat服务器处理
		<br>能处理的请求就调用service层的业务逻辑，service层如果要进行数据库的交互，就调用dao层的组件，（dao的组件是用mybatis逆向工程自动生成的	）mybatis生成的mapper直接与数据库（DB）交互
			mapper直接操作数据库的增删改查；（MBG生成Mapper接口，mapper文件，自动生成的有局限性，如果不够用的，复杂的查询，在基于mapper之上，定义一些新的方法)
			(mapper之所以能用是因为在项目启动的时候，在spring配置文件中整合了mybatis，spring容器启动的时候自动扫描mapper接口（dao层）)；组件与组件之间使用自动装配，可以使用该组件的逻辑<br>
			4.数据处理查询完成之后，就会交给用户，用户查看结果；使用ajax请求（没有让前端控制器直接返回跳转一个页面，只是页面列表显示的时候找到返回页面了，剩下的增删改查都使用的是ajax）之后相当于是处理的结果返回的是Json字符串，
			浏览器收到的是返回的json，返回的json就可以页面不刷新，使用js解析json在页面显示<br>
			5.使用spring做组件管理，springmvc收到请求来处理，每个组件用自动装配，到dao层使用mybatis<br>
			6.使用maven依赖管理和项目构建（依赖管理是：项目中使用的其他jar是用maven导入到服务器中；eclipse是一个镜像服务器）；用maven的好处是停掉eclipse镜像服务器，使用maven install把项目打包，会在项目中target中生成war包，可以在Tomcat中启动
	<br>然后复制war包到Tomcat服务器，Tomcat启动时这个项目就会自动部署，（在cmd启动start.up）
	<h3>项目注意点</h3>
	<p>1.新增，修改，引入数据校验（前端，后端）<br>
	2.删除，单个&批量
	<br>3.mybatis generator-xxxmapper
	<br>4.使用ajax 然后springmvc就使用注解responseBody就行了
	</p>
	</p>
	

</body>
</html>
