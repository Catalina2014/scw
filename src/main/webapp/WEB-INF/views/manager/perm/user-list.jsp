<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- 静态引入样式文件 -->
<%@include file="/WEB-INF/include/commons-css.jsp"%>

<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>

<body>
	<%
		pageContext.setAttribute("title", "用户维护");
		pageContext.setAttribute("high_a", "user/list.html");
	
	%>
	<!-- 静态导入头部导航条 -->
	<%@include file="/WEB-INF/include/manager/top-nav.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!-- 静态导入侧边导航条 -->
			<%@include file="/WEB-INF/include/manager/side-bar.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;" id="deleteItems">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='add.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input id="checkALLBtn" type="checkbox"></th>
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pageInfo.list }" var="user">
										<tr>
											<td>${user.id }</td>
											<td><input type="checkbox" class="checkOneBtn" u_id="${user.id}"></td>
											<td>${user.loginacct }</td>
											<td>${user.username }</td>
											<td>${user.email }</td>
											<td>
												<button type="button" u_id="${user.id}" class="btn btn-success btn-xs">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" u_id="${user.id}" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button>
												<button type="button" u_id="${user.id}" class="btn btn-danger btn-xs">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								
								<tfoot>
									<!-- 分页条的导入 -->
									<%@include file="/WEB-INF/include/manager/page-bar.jsp" %>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form action="" method="post" id="delete_form">
		<input type="hidden" name="_method" value="delete">
		<input type="hidden" name="pn" value="${pageInfo.pageNum}">
	</form>

	<!-- 静态包含bootstrap和jquery的js文件-->
    <%@include file="/WEB-INF/include/commons-js.jsp"%>
	<script type="text/javascript">
		sessionStorage.pn="${pageInfo.pageNum}";
	
		$("tbody .btn-success").click(function() {
			var u_id = $(this).attr("u_id");
			window.location.href = "${ctp}/role/assignRole.html?uid=" + u_id;
		});
		$("tbody .btn-primary").click(function() {
			var u_id = $(this).attr("u_id");
			window.location.href = "${ctp}/user/edit.html?id=" + u_id;
		});
		//删除单个用户
		$("tbody .btn-danger").click(function() {
			var u_id = $(this).attr("u_id");
			$("#delete_form").attr("action","${ctp}/user/delete/" + u_id).submit();
		});
		//删除多个
		$("#deleteItems").click(function(){
			var ids = "";
			$(".checkOneBtn:checked").each(function(){
				ids += $(this).attr("u_id") + ",";
			});
			if(ids!=""){
				$("#delete_form").attr("action","${ctp}/user/delete/" + ids).submit();
			}else{
				alert("没选中任何要删除的数据");
			}
			
		});
		//全选全不选		
		$("#checkALLBtn").click(function(){
			$(".checkOneBtn").prop("checked",$(this).prop("checked"));
		});
		//点满，点不满效果
		$(".checkOneBtn").click(function(){
			var flag = $(".checkOneBtn").length==$(".checkOneBtn:checked").length
				$("#checkALLBtn").prop("checked",flag);
		});
	</script>
</body>
</html>
