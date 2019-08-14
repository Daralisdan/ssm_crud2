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
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<!-- 遍历查询出来的数据，然后取封装在pageInfo中的数据 -->
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.deparment.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

		<!--显示分页信息  -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">当前第${pageInfo.pageNum }页，总共有${pageInfo.pages }页,总共有${pageInfo.total }条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">

				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="<%=request.getContextPath()%>/emps?pn=1">首页</a></li>
						<!-- 上一页 -->
						<c:if test="${pageInfo.hasPreviousPage}">
							<li>
								<!-- 连接上一页，当前页减1 --> <a
								href="<%=request.getContextPath()%>/emps?pn=${pageInfo.pageNum-1 }"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a>
							</li>
						</c:if>
						<!-- 连续显示页数 -->
						<!--在pageInfo中拿取封装的页数 遍历页数 -->

						<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
							<!-- 判断当前页码是哪页，高亮显示 -->
							<c:if test="${page_num==pageInfo.pageNum }">
								<li class="active"><a href="#">${page_num }</a></li>
							</c:if>
							<c:if test="${page_num!=pageInfo.pageNum }">
								<li>
									<!-- 跳转到当前页 -->
									 <a href="<%=request.getContextPath()%>/emps?pn=${page_num }">${page_num }</a>
								</li>
							</c:if>
						</c:forEach>

						<!-- 下一页 -->
						<c:if test="${pageInfo.hasNextPage }">
							<li>
							<a href="<%=request.getContextPath()%>/emps?pn=${pageInfo.pageNum+1}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
							</li>
						</c:if>
						<li>
						<a href="<%=request.getContextPath()%>/emps?pn=${pageInfo.pages }">尾页</a>
						</li>
					</ul>
				</nav>
			</div>

		</div>
	</div>


</body>
</html>