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
    <%@include file="/WEB-INF/include/commons-css.jsp" %>
s	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
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
   		<%@include file="/WEB-INF/include/manager/side-bar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" action="${ctp }/user/update" method="post" id="edit_form">
					<input type="hidden" name="_method" value="put"/>
					<input type="hidden" name="pn" value="" id="input_pn"/>
				  <div class="form-group">
					<label for="exampleInputPassword1">登陆账号</label><br>
					${user.loginacct }
				  </div>
				  <input type="hidden" name="id" value="${user.id }"/>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户名称</label>
					<input type="text" class="form-control" id="input_username" name="username" value="${user.username }">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" id="input_email" name="email" value="${user.email }">
					<!-- <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p> -->
				  </div>
				  <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 修改</button>
				  <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
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
    <!-- 静态包含bootstrap和jquery的js文件-->
    <%@include file="/WEB-INF/include/commons-js.jsp"%>
        <script type="text/javascript">
	       /*  function highLight(){
				//1.显示ul标签
				$("a[href='${ctp}/user/list.html']").parent().parent().show();
				//2.变红a标签
				$("a[href='${ctp}/user/list.html']").css("color","red");
			}
			highLight(); */
        
        
            $(function () {
            	$("#input_pn").val(sessionStorage.pn);
            	
			   /*  $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				}); */
			    
					//给校验器设置默认规则
					$.validator.setDefaults({
						showErrors: function(errors) {
							show_errors(this);
							
						}
					});
					//1.校验表单数据
					$("#edit_form").validate({
						//自定义校验规则
						rules:{
							username: {
								required:true,
								minlength:5,
								maxlength:18
							},
							email: {
								required: true,
								email: true
							},
						},
						//自定义错误提示
						messages:{
							username: {
								required:"请输入您的用户名",
								minlength:"用户名最小长度为5个字符",
								maxlength:"用户名最大长度为18个字符"
							},
							
							email: {
								required: "请输入您的邮箱",
								email: "请输入有效的邮箱地址"
							},
						},
						
					});
					//校验的业务逻辑:无论成功或失败，都要把之前有的提示信息删除，然后重新添加
					function show_errors(ele){
						var tipEle = $("<p class='help-block label label-warning'></p>");
						//所有经校验成功的dom元素
						var suc = ele.successList;
						$.each(suc,function(){
							//将校验成功元素后面的错误提示信息删除
							//$(this).parent(".form-group").find(".help-block").remove();
							$(this).nextAll(".help-block").remove();
						});
						
						//所有校验失败的错误信息：包括经校验错误的dom元素以及错误的自定义提示信息
						var el = ele.errorList;
						$.each(el,function(){
							var msg = this.message;
							var ele = this.element;
							//首先将之前的错误信息提示删除
							//$(ele).parent(".form-group").find(".help-block").remove();
							$(ele).nextAll(".help-block").remove();
							//其次添加最新的错误提示信息,以保证只有一条错误提示 
							//$(ele).parent(".form-group").append("<p class='help-block label label-warning'>" + msg + "</p>");
							tipEle.text(msg);
							$(ele).after(tipEle);
						}); 
					}
            });
        </script>
  </body>
</html>
