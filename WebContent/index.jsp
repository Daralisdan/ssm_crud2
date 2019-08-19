<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 引入标签库 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<!-- 以当前资源路径为基准 -->
<!-- 引入jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<!-- <script src="../static/js/jquery-3.4.1.min.js"></script> -->
<!-- 引入Bootstrap前端框架 -->
<!--<link href="../static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">-->
<!--引入 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<!--<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>-->


<!-- 
1.不以/开始的相对路径，找资源，以当前资源路径为基准，容易出错
2.推荐使用：以/开始的相对路径，找资源，以服务器的路径为基准（http://localhost:3306/需要加上项目名称
	例子：	http://localhost:3306/ssm_crud/文件路径
		<script src="http://localhost:3306/ssm_crud/static/js/jquery-3.4.1.min.js"></script> -->

<!-- 以服务器为基准 -->
<script
	src="<%=request.getContextPath()%>/static/js/jquery-3.4.1.min.js"></script>
<link
	href="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 点击编辑，弹出的模态框================================================================ -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<!-- 用户名 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
							<!-- 用户名静态显示 -->
							  <p class="form-control-static" id="empName_update_static"> </p>
							</div>
						</div>
						<!-- 邮箱 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_update_input" placeholder="email@qq.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<!-- 性别 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked">男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<!-- 部门-->
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!--部门提交，提交部门id即可  -->
								<select class="form-control" name="dId" id="dept_update_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>




<!--== 点击新增，弹出的新增模态框 =======================================================================================-->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工新增</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<!-- 用户名 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName">
								<!-- 添加span元素，显示检验提示的内容 -->
								<span class="help-block"></span>
							</div>
						</div>
						<!-- 邮箱 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_add_input" placeholder="email@qq.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<!-- 性别 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked">男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<!-- 部门-->
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!--部门提交，提交部门id即可  -->
								<select class="form-control" name="dId" id="dept_add_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

<!--== ============主页面显示=================================================================== -->
	<div class="container">
		<!--标题  -->
		<div class="row">
			<div class="col-md-12  ">
				<h1>SSM-CRUD</h1>
			</div>

		</div>
		<!--按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>

		</div>
		<!--显示表格数据  -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<!-- 表头 -->
					<thead>
						<tr>
						<th>
						<input type="checkbox" id="check_all"/>
						</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>


				</table>
			</div>
		</div>

		<!--显示分页信息  -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>

		</div>
	</div>

<!--============ js代码===================================================================-->
<script type="text/javascript">
//定义一个全局变量，保存总记录数,然后给变量赋值当前的总记录数。用户新增完成之后，让信息显示在数据的最后一条
var totalRecord;
//定义一个全局变量，保存当前页，然后给变量赋值当前页码。用于修改页面，修改完成之后回到当前页
var currentPage;

//1.页面加载完成后，直接发送一个ajax请求，获取到分页数据
$(function(){
		//页面加载完，然后发送ajax请求,获取分页数据
		//来到首页
		to_page(1);
		});

		//抽取方法，
		//7.抽取ajax方法，让它最开始来到页面第一页,之后点击跳转页码的方法
		function to_page(pn){
			//页面加载完，然后发送ajax请求,获取分页数据
			$.ajax({
				url:"<%=request.getContextPath()%>/emps",
				//获取第一页
				data : "pn="+pn,
				type : "GET",
				//result 是服务器响应给浏览器的数据
				success : function(result) {
				//console.log(result);
				//1.在页面解析员工的json数据，显示在表格中
				bulid_emps_table(result);
				//2.解析并显示分页信息
				bulid_page_info(result);
				//3.解析并显示分页条信息
				bulid_page_nav(result);
						}
					});
		}

		//1.构建员工的表格的方法 ,并解析相应结果result
		function bulid_emps_table(result) {
			//8.跳转之后表格没被清空，会有重复数据，所以在添加数据之前，所有的操作之前都需要被清空
			$("#emps_table tbody").empty();
				//1).首先取出员工数据
				var emps = result.extend.pageInfo.list;
				//2).然后遍历数据(遍历的方法是$.each)
				//emps是要遍历的元素，function是回调函数，index是索引，item是当前元素对象
				$.each(emps, function(index, item) {
					//alert(item.empName);
					//3).创建单元格
					var chechBox=$("<td><input type='checkbox' class='check_item'/></td>");
					var empIdTd=$("<td></td>").append(item.empId);
					var empNameTd=$("<td></td>").append(item.empName);
					//判断，并处理英文转为英文
					var gender =item.gender=='M'?"男":"女";
					var genderTd=$("<td></td>").append(gender);
					//var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
					
					var emailTd=$("<td></td>").append(item.email);
					var deparmentTd=$("<td></td>").append(item.deparment.deptName);
					
					//编辑按钮
					/**
					<button class="btn btn-primary btn-sm">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
										编辑
									</button>
					*/
					var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
					
					//为编辑按钮添加一个自定义属性，来表示当前员工id,item.empId表示员工id的值
					editBtn.attr("edit-id",item.empId);
					
					//删除按钮
					/**
						<button class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
									</button>
					*/
					var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
					
					//为删除按钮自定义添加一个属性，获取员工id
					delBtn.attr("del-id",item.empId);
					
					
					//把按钮放在一个单元格中
					var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn)
					
					
					//append方法执行完成以后还是返回原来的元素,appendTo意思是把这些元素添加到哪里去
					$("<tr></tr>").append(chechBox)
					.append(empIdTd).append(empNameTd)
					.append(genderTd).append(emailTd)
					.append(deparmentTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
				});
		}
		//2.构建分页导航信息的方法，并解析相应结果result
		//2.1构建解析显示分页信息的方法
		function bulid_page_info(result){
			//8.1跳转之后表格没被清空，会有重复数据，所以在添加数据之前，所有的操作之前都需要被清空
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前第 "+result.extend.pageInfo.pageNum+
					"  页，总共有 "+result.extend.pageInfo.pages
					+" 页,共有 "+result.extend.pageInfo.total+" 条记录");
		//全局总记录数赋值
			totalRecord=result.extend.pageInfo.total;
		//给全局变量赋值，当前页码
			currentPage=result.extend.pageInfo.pageNum;
		}
		
		//2.2构建解析显示分页条的方法,  2.3点击分页条要能跳转
		function bulid_page_nav(result) {
			//8.2跳转之后表格没被清空，会有重复数据，所以在添加数据之前，所有的操作之前都需要被清空
			$("#page_nav_area").empty();
			//3.构建ul
			var ul=$("<ul></ul>").addClass("pagination");
			
			//2.2.1.构建分页条显示<li>,构建元素
			//首页
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			//前一页
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			 
			//6.1如果没有前一页就不能再点击了
			if (result.extend.pageInfo.hasPreviousPage==false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//7.3.给元素绑定点击翻页事件
				//首页
				firstPageLi.click(function(){
					to_page(1)
				});
				//7.4上一页给元素绑定点击翻页事件
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			
			//下一页,构建元素
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			//尾页
			var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			
			//6.2如果没有下一页了就不能再点击了
			if (result.extend.pageInfo.hasNextPage==false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				//7.5给元素绑定点击翻页事件
				//下一页
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				//7.6尾页,给元素绑定点击翻页事件
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			//3.1把li添加到ul中，并且把首页，前一页添加到导航栏中
			ul.append(firstPageLi).append(prePageLi);
			
			//2.2.2构建普通页面1，2,3....
			//遍历页面
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi=$("<li></li>").append($("<a></a>").append(item));
				//6.显示的效果，高亮显示
				if (result.extend.pageInfo.pageNum==item) {
					numLi.addClass("active");
				}
				//7.1绑定单击事件，添加点击事件，点击之后能跳转
				numLi.click(function(){
					to_page(item);
				})
				//3.2把普通页码添加到导航栏ul中
				ul.append(numLi);
				
			});
			//3.3把下一页，尾页添加到ul中
			ul.append(nextPageLi).append(lastPageLi);
			
			//4.把ul添加到nav元素中
			var navEle=$("<nav></nav>").append(ul);
			//5.把导航条添加到要显示导航条的区域
			navEle.appendTo("#page_nav_area");
		}
//===================主页面的介绍代码==========================================================================
	
//============新增模态框的代码============================================================================
		
		//12.提取表单重置的方法
		//参数ele表示要重置的哪个元素，不是固定的，动态参数
		function reset_form(ele){
		//清空表单数据	
		$(ele)[0].reset();
		//find("*")表示表单后的所有样式
		$(ele).find("*").removeClass("has-error has-success");
		//清空内容
		$(ele).find(".help-block").text("");
	}

		
		
		//1.点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//
			//11.清除表单之前提交的数据(应该是表单完整重置包括表单数据，表单样式)
			//$("#empAddModal form")[0].reset();
			//调用表单重置的方法
			reset_form("#empAddModal form");
			
			//1.2弹出模态框之前发送ajax请求，获取部门信息，显示在下拉列表中
			//getDepts();
			//动态传入参数，查询出来的信息放在哪里，放在dept_add_selec处
			getDepts("#dept_add_select");
		   //1.1弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"//背景删除，设置为背景不删除
			});
		});
		
		//1.3提取方法，查询出所有的部门信息并显示在下拉列表中
		//动态传入参数，ele表示需要显示的地方的参数
		function getDepts(ele){
			//清空下拉列表数据显示
			$(ele).empty();
			
			//向服务器（controller层路径）获取部门信息
			$.ajax({
				//controller层获取部门信息方法的路径
				url:"<%=request.getContextPath()%>/depts",
				type:"GET",
				success:function(result){
					// code: 100, msg: "处理成功！"
					//console.log(result) //部门信息
			//2.显示部门信息在下拉列表中
					//$("#dept_add_select")
			//2.1遍历部门信息
				 $.each(result.extend.depts,function(){
					 //构建元素option
					 var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
					 //optionEle.appendTo("#dept_add_select");
					 optionEle.appendTo(ele);
				 });
				}
			});
		}
		
		//5.validate_add_form 抽取校验方法，校验表单数据
		function validate_add_form(){
			//1.获取要检验的数据，使用正则表达式
			//1.1首先校验姓名
			
			//首先获取到姓名的值
			var empName=$("#empName_add_input").val();
			//正则表达式检验员工姓名, (^[\u2E80-\u9FFF]{2,5}) 表示允许中文，并且要求2-5个中文字符
			var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//alert(regName.test(empName));
			//return false; //返回false，表示不进行下面的ajax提交
			if (!regName.test(empName)) {
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				
				//6.优化检验显示信息
			/* 	$("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合"); */
				
				//8.优化检验显示信息的校验方法 调用抽取的方法
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				//6.1优化检验显示信息
				/* $("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text(""); */
				
				//8.1优化检验显示信息的校验方法 调用抽取的方法
				show_validate_msg("#empName_add_input","success","");
			};
			
			
			//2.校验邮箱，如果用户名检验成功，进行这一步
			
			//获取到邮箱的值
			var email=$("#email_add_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				//6.2优化检验显示信息
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
			
				//8.3优化检验显示信息的校验方法 调用抽取的方法
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				//6.3优化检验显示信息
				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
				
				//8.4优化检验显示信息的校验方法 调用抽取的方法
				show_validate_msg("#email_add_input","success","");
			}
			return true; //都校验成功返回true
		}
		 
		//7.抽取验证的方法，验证之前要清空样式,元素传入，ele代表#email_add_input等选择器，然后在传入状态（成功与失败），然后还有提示信息
		//显示校验的结果的提示信息
		function show_validate_msg(ele,status,msg){
			//7.2因为样式会记录缓存，所以在校验之前需要清除样式
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text(""); 
			//7.1校验逻辑
			if ("success"==status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg); 
			}else if ("error"==status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//9.检验用户名是否可用，绑定用户名改变检查是否可用发送ajax请求的方法
		//给用户名绑定一个change事件，表示当用户名改变时发送ajax请求验证用户名是否可用
		 $("#empName_add_input").change(function(){
			 //9.2取出输入框的值然后让ajax携带该值发送给服务器
			 var empName=this.value;//this.value表示empName_add_input输入框中的值
			 
			 //9.1发送ajax请求验证用户名是否可用,先在controller写业务逻辑
			 $.ajax({
				url:"<%=request.getContextPath()%>/checkuser",
				type:"POST",
				//9.3发送请求时要携带的数据就是员工姓名
				data:"empName="+empName,
				//9.4服务器响应成功之后，服务器会传过来一个result结果集
				success:function(result){
					//result有两种结果，因为返回的是msg对象，所以msg里边的code属性有两种状态
				if (result.code==100) {
					show_validate_msg("#empName_add_input","success","用户名可用");
			//如果保存成功
			$("#emp_save_btn").attr("ajax-va","success");
				}else{
					//va-msg 是校验数据库用户名是否有重复的提示信息Controller传过来的提示信息
					show_validate_msg("#empName_add_input","error",result.extend.va_msg);
					//如果保存失败了，
					$("#emp_save_btn").attr("ajax-va","error");
				}
				}
			 });
			 
		 });
		
		
//==============按钮点击事件========================================================================
		
	//3.保存按钮绑定单机事件
		//点击保存按钮，保存员工
		$("#emp_save_btn").click(function(){
			//1.模态框中填写的表单数据点击保存，然后提交给服务器进行保存
			//4.先对提交给服务器的数据进行校验
			//前端校验
			/*  if (!validate_add_form()) {
				return false;
			}   */
			//10.在点击按钮发送按钮ajax之前需要判断之前发送的ajax请求校验的用户名，邮箱是否成功。如果成功，
			// $(this).attr("ajax-va")=="error"表示按钮保存失败时，直接返回false，不进行下面的ajax请求
			if ($(this).attr("ajax-va")=="error") {
				return false;
			}
			
			//2.发送ajax请求保存员工
			//表单序列化，快捷操作
			//alert($("#empAddModal form").serialize());
			$.ajax({
				url:"<%=request.getContextPath()%>/emp",
				type : "POST",
				//发送请求的数据
				data : $("#empAddModal form").serialize(),
				success : function(result) {
					//alert(result.msg);

					//JSR303校验 先进行判断
					//如果状态码是正确的，验证成功了，才关闭保存模态框，否则用户校验失败，显示失败信息
					if (result.code == 100) {

						//员工保存，1、员工保存之后关闭模态框，2.来到最后一页并显示保存的数据
						//3.1 员工保存之后关闭模态框
						$("#empAddModal").modal('hide');

						//3.2.来到最后一页并显示保存的数据
						//3.2.1发送ajax请求显示最后一页数据即可
						//总记录数当做页码
						to_page(totalRecord);

					} else {
						//否则用户校验失败，显示失败信息
						//显示失败信息(集中在用户名，邮箱)，有哪个字段的错误信息就显示哪个
						//console.log(result);
						//undefind表示未定义，如果有邮箱不是未定义就显示邮箱的错误信息，下面同理
						if (undefined !=result.extend.errorFileds.email) {
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFileds.email);
						}
						if (undefined !=result.extend.errorFileds.empName) {
							//显示名字错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFileds.empName);
						}
					}

				}
			});
		});
		
//================点击编辑按钮绑定事件，弹出模态框==================================================================================		
	//如果按钮创建之前就去绑定click，这时绑定不上
	//1.可以创建按钮的时候绑定，然后绑定点击 .live()(live点击事件也是不可行的，因为jquery新版没有live),所有使用On代替live;
	$(document).on("click",".edit_btn",function(){
		//alert("edit");
		
	   //1.2查出部门信息,并显示在部门下拉列表中
	   //1.2.1调用查询部门信息的方法，显示在编辑的模态框的下拉列表中(选择器可以写模态框中的下拉列表选择器，也可以写下拉列表元素中的id选择器)
	   getDepts("#empUpdateModal select");
	   
	 //1.1查出员工信息，显示员工信息，
	 //this表示当前被点击的按钮，然后找到点击被点击的id属性
	   getEmp($(this).attr("edit-id"));
	 
	//4.把员工id传递给模态框的更新按钮
	 $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
	 
	   //0.弹出模态框
		$("#empUpdateModal").modal({
			backdrop:"static"//背景删除，设置为背景不删除
		});
	});
	
	//2.查询员工信息，并显示的方法
	function getEmp(id){
		//2.1发送ajax请求之前需要在服务器端写一个请求的处理器即在controller层写处理请求的方法，然后在发送请求
		$.ajax({
			url:"<%=request.getContextPath()%>/emp/"+id,
			type:"GET",
			//ajax请求成功以后，服务器会返回一个员工的数据
			success:function(result){
				//console.log(result);
				//3.拿到员工数据进行显示
				var empData=result.extend.emp;
				//获取用户名
				$("#empName_update_static").text(empData.empName);
				//获取邮箱
				$("#email_update_input").val(empData.email);
				//获取性别
				$("#empUpdateModal input[name=gender]").val([empData.gender]);
			//部门下拉列表
			$("#empUpdateModal select").val([empData.dId]);
			}
		});
	}
	
	
//================点击更新按钮，绑定点击事件，完成更新保存=================================================
	//点击更新，更新员工信息
	$("#emp_update_btn").click(function(){
		//1.因为有一个邮箱输入框，验证邮箱是否合法
		//1.1校验邮箱是否合法
			//获取到邮箱的值
			var email=$("#email_update_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//检验显示信息的校验方法 调用抽取的方法
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				//8.4优化检验显示信息的校验方法 调用抽取的方法
				show_validate_msg("#email_update_input","success","");
				}
			
			//2.邮箱验证成功之后，发送ajax请求保存更新员工的数据
			$.ajax({
				url:"<%=request.getContextPath()%>/emp/"+$(this).attr("edit-id"),
				type:"POST",
				//ajax发送请求携带的数据，模态框更新的数据提交给后台保存
				//$("#empUpdateModal form").serialize()表示表单提交后的数据
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				success:function(result){
					//alert(result.msg);
					
					//3.关闭模态框
					$("#empUpdateModal").modal("hide");
					
					//4.回到本页面,全局变量currentPage
					to_page(currentPage);
				}
			});
	});
	
//==========删除按钮点击事件，删除单个============================================================================================================
		$(document).on("click",".delete_btn",function(){
				//1.获取到员工名字,弹出确认弹框
				
				//$(this).parents("tr").find("td:eq(1)").text();这句话意思是，this表示当前点击的按钮，parents表示找到祖先节点tr，然后td:eq(1)表示第二个td
				//意思是当前按钮下祖先父节点是tr，然后找到tr下的第二个td下的文本就是用户名的名字
				//alert($(this).parents("tr").find("td:eq(1)").text());
		       
				//1.1获取到员工名字
				var empName=$(this).parents("tr").find("td:eq(2)").text();
		       //1.2获取删除按钮的员工id
				var empId=$(this).attr("del-id");
		       //confirm是确认框
		 if (confirm("确认删除【"+empName+"】吗？")) {
			//2.如果是确认删除，然后发送ajax请求
			$.ajax({
				url:"<%=request.getContextPath()%>/emp/"+empId,
				type:"POST",
				success:function(result){
					alert(result.msg);
					//3.删除成功之后，回到本页面,全局变量currentPage
					to_page(currentPage);
				}
			});
		}
		});
	
//==================删除多个，全选/全不选功能=========================================================================	
	//1.完成全选/全不选功能
	//1.1给复选框绑定点击事件
	$("#check_all").click(function(){
		//1.1.1 attr获取checked是undefind;
		//1.1.2原生的dom属性，可以用attr获取自定义属性的值
		
		//1.1.3 prop修改和读取dom原生属性的值
		//2.获取勾选上当前的复选框
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	
	//3.check_item 这是每个复选框，给他们绑定点击事件
	$(document).on("click",".check_item",function(){
	//全选时，取消一个全选按钮也要跟着取消
		//4.判断当前选择中的元素是否有当前页显示的总个数（即是否有五个）
		var flag=$(".check_item:checked").length==$(".check_item").length;
	 //5.然后修改复选框按钮事件属性
	    $("#check_all").prop("checked",flag);
	});
	
//========完成删除功能=======================================================
	//点击全不删除时，就就批量删除
    $("#emp_delete_all_btn").click(function(){
    	//定义用户名变量
    	var empName="";
    	//定义id变量
    	var del_idstr="";
    	
    	//遍历用户名
    	$.each($(".check_item:checked"),function(){
    		//组装员工名字的字符串
    		empName +=$(this).parents("tr").find("td:eq(2)").text()+",";
    		//组装id名字的字符串
    		del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
    	});
    	//去除empName多余的","
    	empName=empName.substring(0,empName.length-1);
    	//去除多余的-
    	del_idstr=del_idstr.substring(0,del_idstr.length-1);
    	 if (confirm("确认删除【"+empName+"】吗？")) {
 			//如果是确认删除，然后发送ajax请求
 			$.ajax({
 				url:"<%=request.getContextPath()%>/emp/"+del_idstr,
 				type:"POST",
 				success:function(result){
 					alert(result.msg);
 					//3.删除成功之后，回到本页面,全局变量currentPage
 					to_page(currentPage);
 				}
 			});
 		}
    });
	
	
	
	
</script>

</body>
</html>