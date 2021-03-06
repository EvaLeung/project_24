<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    
<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<style>

.bg {
       background:url(source/img/r-bg.jpg) no-repeat center center scroll;
       width:100%;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}
.bgc{

background-color:rgba(245,245,245,1);
}

.btn{
   margin-top:30px;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
</head>

<body class="row bg">
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<h1 class="text-center page-header" style="color:white;">
			<span class="glyphicon glyphicon-user"></span>
				用户注册
			</h1>
				<div class="col-md-6 column col-md-offset-3 bgc" id="RegisterForm">
					<form class="form-signin" name="register">
                            <h2 class="form-signin-heading text-center">请填写注册信息</h2>
                                  <label for="inputEmail">用户名</label>
                                  <input type="text" id="username" name="username"class="form-control" placeholder="用户名" required autofocus>
                                  <span id="helpBlock_username" class="help-block">注册用户名大于2字符小于12字符</span>
                                  
                                  <label for="inputPassword">密码</label>
                                  <input type="password" id="password" name="password"class="form-control" placeholder="密码" required>
                                  <span id="helpBlock_password" class="help-block">密码在6~16字符之间</span>
                                  
                                  <label for="inputPassword">确认密码</label>
                                  <input type="password" id="cpwd" class="form-control" placeholder="确认密码" required>
                                  <span id="helpBlock_cpwd" class="help-block">请再输入一次密码以确认</span>
                                                                
                                  <button class="btn btn-lg btn-info btn-block" id="DoRegister">注册</button>
                                   </form>
                                  </div>                                 
                 
				</div>
			</div>
		</div>
</body>
<script type="text/javascript">
	//发送ajax请求进行用户注册
	$("#DoRegister").click(function(){
		event.preventDefault();//阻止按钮默认的表单提交动作
		//1.填写的表单数据提交给服务器
		$.ajax({
			url:"${APP_PATH}/DoRegister",
			type:"post",
			data:{
				"username":$("#username").val(),
				"password":$("#password").val(),
				"cPassword":$("#cpwd").val()
			},
	    
			success:function(result){
				if(result.code == 200 ){
					alert(result.msg);
					location.href = '${APP_PATH}/ToLogIn';
				}
				else{
					alert(result.msg);
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert("error!");
			}
		});
		
	});

</script>
</html>
