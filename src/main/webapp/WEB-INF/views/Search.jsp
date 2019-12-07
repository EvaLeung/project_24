<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>
   
<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<style>

.bg {
       background:url(source/img/search.jpg) no-repeat center center scroll;
       width:100%;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}
.bgc{

background-color:rgba(245,245,245,0.5);
}

.container {
       margin-top:90px;
}
.fix{
       margin-top:60px;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网上书城-搜索</title>
</head>
<body class="bg">
<div class="container">
	<div class="row clearfix">
	<h1 class="text-center page-header" style="color:white;">
			<span class="glyphicon glyphicon-book"></span>
				网上书城
			</h1>
    <form class="bs-example bs-example-form fix">
            <div class="col-md-6 col-md-offset-3 ">
                <div class="input-group">
                    <input type="text" class="form-control" name="keyword" id="keyword_input">
                    <span class="input-group-btn">
                        <button class="btn btn-default" id="search_btn">搜索</button>
                    </span>
                </div>
            </div>
    </form>
    </div>
</div>

            <nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand">网上书城</a>
				</div>
				
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="active">
							 <a href="MainView.jsp">主页</a>
						</li>
						<li>
							 <a href="${APP_PATH}/ToSearch">搜索</a>
						</li>
					</ul>
					<form class="navbar-form navbar-left">
						<div class="form-group">
							<input type="text" class="form-control" id="keyword_input"/>
						</div> <button class="btn btn-default">搜索</button>
					</form>
					<ul class="nav navbar-nav navbar-right">
						<li>
							 <c:if test="${not empty sessionScope.LogInUsername}">
                                <a><c:out value="${sessionScope.LogInUsername}"/> 您好</a>
                                <li class="dropdown">
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">我的书城<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									 <a href="ShoppingCart.jsp">购物车</a>
								</li>
								<li>
									 <a href="previeworder.do">用户信息</a>
								</li>								
								<li class="divider">
								</li>
								<li>
									 <a href="logout.do">注销</a>
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
</body>

<script type="text/javascript">

		//发送ajax请求执行搜索操作
		$("#search_btn").click(function(){
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
				},
				
				error:function(){
					alert("error!");
				}
				
				
			});
		});

</script>
</html>