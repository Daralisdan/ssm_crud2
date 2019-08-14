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
				<button class="btn btn-primary">新增</button>
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
			<div class="col-md-6">当前第 页，总共有 页,总共有 条记录</div>
			<!-- 分页条信息 -->
			<div class="col-md-6"></div>

		</div>
	</div>

	<!-- js代码-->

	<script type="text/javascript">
//1.页面加载完成后，直接发送一个ajax请求，获取到分页数据
$(function(){
	//页面加载完，然后发送ajax请求,获取分页数据
	$.ajax({
		url:"<%=request.getContextPath()%>/emps",
		//获取第一页
		data : "pn=1",
		type : "GET",
		//result 是服务器响应给浏览器的数据
		success : function(result) {
		//console.log(result);
		//1.在页面解析员工的json数据，显示在表格中
		bulid_emps_table(result);
		//2.解析并显示分页信息
				}
			});

		});

		//抽取方法，

		//1.构建员工的表格的方法 ,并解析相应结果result
		function bulid_emps_table(result) {
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
		function bulid_page_nav(result) {

		}
	</script>

</body>
</html>