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
		pageContext.setAttribute("title", "角色维护");
		pageContext.setAttribute("high_a", "role/list.html");
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
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='form.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${roles}" var="role">
										<tr>
											<td>${role.id }</td>
											<td><input type="checkbox"></td>
											<td>${role.name }</td>
											<td>
												<button type="button" rid="${role.id }" class="btn btn-success btn-xs">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button>
												<button type="button" class="btn btn-danger btn-xs">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>


								</tbody>
								<tfoot>
									<!-- 分页条的导入 -->
									<%@include file="/WEB-INF/include/manager/page-bar.jsp"%>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配权限</h4>
				</div>
				<div class="modal-body">
					<ul id="myPermissionTree" class="ztree"></ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="sava_btn" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

</body>

<!-- 静态包含bootstrap和jquery的js文件-->
<%@include file="/WEB-INF/include/commons-js.jsp"%>

<script type="text/javascript">
	

	var zNodes;
	var zTreeObj;
	$("tbody .btn-success").click(function() {
		var ele = this;
		//1.发Ajax请求，到数据库获取节点数据zNodes
		$.get("${ctp}/perm/list.json",function(result){
			zNodes = result;
			//2.拿到节点数据后，初始化ztree
			initMyPermissionTree();
			//回显数据
			showMyPermission($(ele).attr("rid"));
		});
		//特别注意：Ajax请求是异步执行的，也就是说：第一步发请求去获取节点数据的过程中，第二步初始化ztree的
		//步骤也在执行。有时候，第二步先执行完，这时候还没有节点数据，那么ztree自然为空 。有时候第一步先执行
		//完，先有了节点数据，再去初始化ztree自然，模态框就有显示
		//一定保证先获取到节点数据，再去初始化ztree
		//3.开启模块框
		$("#myModal").modal({show:true});
	});

	function initMyPermissionTree() {
		var setting = {
			view: {
				addDiyDom: addDiyDom
			},
			check: {
				enable: true
			},
			data : {
				key: {
					url:"xurl"
				},
				simpleData : {
					enable : true,
					pIdKey:"pid"
				}
			}
		};

		$(document).ready(function() {
			zTreeObj = $.fn.zTree.init($("#myPermissionTree"), setting, zNodes);
		});
	}
	
	function addDiyDom(treeId, treeNode){
		var iconId = treeNode.tId + "_ico";
		$("#"+iconId).removeClass();
		$("#"+iconId).before("<span class='" + treeNode.icon + "'></span>");
		
// 		console.log(treeId);
// 		console.log(treeNode);
	}
	
	function showMyPermission(rid){
		//1.查出当前角色所拥有的所有权限,将所拥有的权限选中
		$.get("${ctp}/perm/role/" + rid, function(result){
			$.each(result,function(){
				zTreeObj.checkNode(zTreeObj.getNodeByParam("id", this.id, null), true, false);
				
			});
		});
	}
</script>
</html>
