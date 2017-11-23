<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	 <!-- 静态引入样式文件 -->
    <%@include file="/WEB-INF/include/commons-css.jsp" %>
	<link rel="stylesheet" href="${ctp}/static/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form class="form-signin" action="${ctp}/userLogin" method="post" role="form" id="login_form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        	<span style="color:red">${msg}</span>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" name="loginacct" id="loginacct_input" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" name="userpswd" id="userpswd_input" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>

        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
   <!-- 静态包含bootstrap和jquery的js文件-->
    <%@include file="/WEB-INF/include/commons-js.jsp"%>
    <script>
    function dologin() {
    	$("#login_form").submit();
    	

    }
    </script>
  </body>
</html>