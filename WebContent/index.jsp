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
<!-- 点击新增，弹出的新增模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工新增</h4>
      </div>
      <div class="modal-body">
        
        <form class="form-horizontal">
       			 <!-- 用户名 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			    </div>
			  </div>
			   <!-- 邮箱 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
			    </div>
			  </div>
			  <!-- 性别 -->
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
				    <label class="radio-inline">
						 <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
					</label>
					<label class="radio-inline">
						  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
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








<!-- ============主页面显示======================================================== -->
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
				<button class="btn btn-danger">删除</button>
			</div>

		</div>
		<!--显示表格数据  -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<!-- 表头 -->
					<thead>
						<tr>
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















<!--============ js代码==============================================-->
<script type="text/javascript">
//定义一个全局变量，保存总记录数
var totalRecord;

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
					var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
					
					//删除按钮
					/**
						<button class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
									</button>
					*/
					var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
					
					//把按钮放在一个单元格中
					var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn)
					
					
					//append方法执行完成以后还是返回原来的元素,appendTo意思是把这些元素添加到哪里去
					$("<tr></tr>").append(empIdTd).append(empNameTd)
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
//===================主页面的介绍代码==================================
	
	//============新增模态框的代码=========================
		//1.点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//1.2弹出模态框之前发送ajax请求，获取部门信息，显示在下拉列表中
			getDepts();
		   //1.1弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"//背景删除，设置为背景不删除
			});
		});
		
		//1.3提取方法，查询出所有的部门信息并显示在下拉列表中
		function getDepts(){
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
					 optionEle.appendTo("#dept_add_select");
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
				alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			};
			//2.校验邮箱，如果用户名检验成功，进行这一步
			//获取到邮箱的值
			var email=$("#email_add_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				alert("邮箱格式不正确");
				return false;
			}
			return true; //都校验成功返回true
		}
		
		//3.保存按钮绑定单机事件
		//点击保存按钮，保存员工
		$("#emp_save_btn").click(function(){
			//1.模态框中填写的表单数据点击保存，然后提交给服务器进行保存
			//4.先对提交给服务器的数据进行校验
			if (!validate_add_form()) {
				return false;
			}
			
			
			//2.发送ajax请求保存员工
			//表单序列化，快捷操作
			//alert($("#empAddModal form").serialize());
			$.ajax({
				url:"<%=request.getContextPath()%>/emp",
				type:"POST",
				//发送请求的数据
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//员工保存，1、员工保存之后关闭模态框，2.来到最后一页并显示保存的数据
					//3.1 员工保存之后关闭模态框
					$("#empAddModal").modal('hide')
					
					//3.2.来到最后一页并显示保存的数据
					//3.2.1发送ajax请求显示最后一页数据即可
					//总记录数当做页码
					to_page(totalRecord);
				}
			});
			
		});
	</script>

</body>
</html>