<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>
   
<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>

<style>
.bgc{
background-color:rgba(245,245,245,0.5);
}
.container {
       margin-top:30px;
}
</style>

</head>
<body class="row">
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
		
					<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand">网上药房</a>
				</div>
				
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li>
							 <a href="MainView.jsp">主页</a>
						</li>
						<li>
							 <a href="${APP_PATH}/ToSearch">搜索</a>
						</li>
					</ul>
					<form class="navbar-form navbar-left">
						<div class="form-group">
							<input type="text" class="form-control" name="keyword" id="keyword_input"/>
						</div> <button class="btn btn-default" id="DoSearch">搜索</button>
					</form>
					<ul class="nav navbar-nav navbar-right">
						<li>
							 <c:if test="${not empty sessionScope.LogInUsername}">
                                <a><c:out value="${sessionScope.LogInUsername}"/> 您好</a>
                                <li class="dropdown">
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">我的药房<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									 <a href="${APP_PATH}/ToCart">购物车</a>
								</li>
								<li>
									 <a href="${APP_PATH}/ToUserInfo">用户信息</a>
								</li>								
								<li class="divider">
								</li>
								<li>
									 <a href="${APP_PATH}/LogOut">注销</a>
								</li>
							</ul>
						</li>
                             </c:if>
                             <c:if test="${empty sessionScope.LogInUsername}">
                                 <a href="${APP_PATH}/ToLogIn"><c:out value="请登录  "/></a>
                             </c:if>
						</li>
					</ul>
				</div>	
			</nav>
			
			<h1 class="text-center page-header">
			<span class="glyphicon glyphicon-book"></span>
				欢迎来到网上药房
				
			</h1>
				<div class="col-md-4 column col-md-offset-4 bgc" >
				
				<!-- 选项卡控件 -->
				<ul class="nav nav-tabs" id="LogInTab">
					<li class="active"><a href="#UserLogIn">会员</a></li>
					<li><a href="#AdminLogIn">管理员</a></li>
				</ul>
				
				<div id="LogInTab-content" class="tab-content"> 
				
				<!-- 用户登录选项卡内容 -->
				<div class="tab-pane fade in active" id="UserLogIn">
					<form class="form-signin">
                            <h2 class="form-signin-heading text-center">请登录</h2>
                                  <label for="inputEmail">用户名</label>
                                  <input type="text" name="username" class="form-control" placeholder="用户名" required autofocus>
                                  <label for="inputPassword">密码</label>
                                  <input type="password" name="password" class="form-control" placeholder="密码" required>
                                  <a class="btn" href="${APP_PATH}/ToRegister">还没有账号？点击注册 »</a>
                                  <button class="btn btn-lg btn-block" id="user_login_btn">登录</button>
                                  <br>       
                     </form>
                     </div>
                     
                     <!-- 管理员登录选项卡内容 -->
                     <div class="tab-pane fade" id="AdminLogIn">
                     <form class="form-signin">
                            <h2 class="form-signin-heading text-center">请登录</h2>
                                  <label for="inputEmail">用户名</label>
                                  <input type="text" name="adminUsername"class="form-control" placeholder="用户名" required autofocus>
                                  <label for="inputPassword">密码</label>
                                  <input type="password" name="adminPassword"class="form-control" placeholder="密码" required>
                                  <br>
                                  <button class="btn btn-lg btn-block" id="admin_login_btn">登录</button>
                                  <br>       
                     </form>
                     </div>                 
                     </div>
                     
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
			//激活bootstrap选项卡
			$(function(){
				$('#LogInTab a').click(function(){
					$(this).tab('show')
				})
			})
			
			
			//发送ajax请求进行用户登录验证
			$("#user_login_btn").click(function(){
				event.preventDefault();//阻止按钮默认的表单提交动作
				//1.填写的表单数据提交给服务器
				$.ajax({
					url:"${APP_PATH}/UserLogIn",
					type:"post",
					data:$("#UserLogIn form").serialize(),
			    
					success:function(result){
						alert(result.msg);
						if(result.code == 200 ){
							location.href = 'MainView.jsp';
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert("error!");
					}
				});
				
			});
			
			//发送ajax请求进行管理员登录验证
			$("#admin_login_btn").click(function(){
				event.preventDefault();//阻止按钮默认的表单提交动作
				$.ajax({
					url:"${APP_PATH}/AdminLogIn",
					type:"post",
					data:$("#AdminLogIn form").serialize(),
					
					success:function(result){
						alert(result.msg);
						if(result.code == 200 ){
							location.href = '${APP_PATH}/ToAdminView';
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert("error");
					}
				});				
			});
			
			$("#DoSearch").click(function(){
				event.preventDefault();//阻止按钮默认的表单提交动作
				//发送ajax请求执行搜索操作
					var pn = 1;
					var keyword = $("#keyword_input").val();
					$.ajax({
						url:"${APP_PATH}/DoSearch",
						type:"post",
						data:{
							"keyword":keyword,
							"pn":pn
						},
						
						success:function(result){
							alert(result.msg);
							if(result.code == 200 ){
								location.href ="${APP_PATH}/ToShopView?keyword="+keyword+"&pn="+pn;
							}
							if(result.code == 100 ){
								alert("搜索失败！");
							}
						},
						
						error:function(){
							alert("error!");
						}
				});
			});
		</script>	
</html>