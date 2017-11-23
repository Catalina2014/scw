<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
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
</style>

</head>

<body>
	<%
		pageContext.setAttribute("title", "角色分配");
		pageContext.setAttribute("high_a", "user/list.html");
	%>
	<!-- 静态导入头部导航条 -->
	<%@include file="/WEB-INF/include/manager/top-nav.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!-- 静态导入侧边导航条 -->
			<%@include file="/WEB-INF/include/manager/side-bar.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="#">首页</a></li>
					<li><a href="#">数据列表</a></li>
					<li class="active">分配角色</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-body">
						<form role="form" class="form-inline">
							<div class="form-group">
								<label for="exampleInputPassword1">未分配角色列表</label><br> 
								<select id="select_allRoles" class="form-control" multiple size="10"
									style="width: 200px; overflow-y: auto;">
									<c:forEach items="${roles}" var="role">
										<option value="${role.id }">${role.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<ul>
									<li id="addRoles" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
									<br>
									<li id="deleteRoles" class="btn btn-default glyphicon glyphicon-chevron-left"
										style="margin-top: 20px;"></li>
								</ul>
							</div>
							<div class="form-group" style="margin-left: 40px;">
								<label for="exampleInputPassword1">已分配角色列表</label><br> 
								<select id="select_assignedRoles"	class="form-control" multiple size="10"
									style="width: 200px; overflow-y: auto;">
									<c:forEach items="${assignedRoles}" var="ar">
										<option value="${ar.id }">${ar.name }</option>
									</c:forEach>
								</select>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">帮助</h4>
				</div>
				<div class="modal-body">
					<div class="bs-callout bs-callout-info">
						<h4>测试标题1</h4>
						<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
					</div>
					<div class="bs-callout bs-callout-info">
						<h4>测试标题2</h4>
						<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
					</div>
				</div>
				<!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
			</div>
		</div>
	</div>
	
	<form id="assign_form" action="" method="post">
		<input type="hidden" name="_method" value=""/>
		<input type="hidden" name="uid" value="${param.uid}"/>
	</form>
	
	
	<!-- 静态包含bootstrap和jquery的js文件-->
	<%@include file="/WEB-INF/include/commons-js.jsp"%>
	<script type="text/javascript">
		$(function(){
			//移除已经分配的角色
			removeAssignedRoles();
		});
		
		//绑定单击事件，为指定用户分配角色
		$("#addRoles").click(function(){
			$("#assign_form input[name='_method']").val("put");
			var rids = "";
			$("#select_allRoles option:selected").each(function(){
				rids += "rid=" + this.value + "&";
			});
			$("#assign_form").attr("action","${ctp}/role/assignRole?"+rids).submit();
			
		});
		//绑定单击事件，为指定用户删除已分配的角色
		$("#deleteRoles").click(function(){
			$("#assign_form input[name='_method']").val("delete");
			var rids = "";
			$("#select_assignedRoles option:selected").each(function(){
				rids += "rid=" + this.value + "&";
			});
			$("#assign_form").attr("action","${ctp}/role/assignRole?"+rids).submit();
		});
		
		$("#select_allRoles option").each(function(){
			$(this).click(function(){
				$(this).attr({"selected":"true"});
			});
		});
		
		function removeAssignedRoles(){
			$("#select_assignedRoles option").val(function(){
				var assignedRoleId = this.value;
				$("#select_allRoles option[value='" + assignedRoleId + "']").remove();
				return assignedRoleId;
			});
		}
		
	</script>
</body>
</html>
