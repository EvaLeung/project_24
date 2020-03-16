<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>
   
<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<style>
.container {
margin-top:75px;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购买成功</title>
</head>
<body>

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
			
			<div class="panel panel-default">
                <div class="panel-body">
                <div class="col-md-4 col-md-offset-4" style="font-size:15px" id="text">
                <h2>			
                 <span class="glyphicon glyphicon-ok">购买成功!</span>
                 </h2 >
                  <p></p>
                 </div>
                <div class="col-md-4 col-md-offset-4" id="ToOrderDetail">	
                </div>	
                </div>	
			</div>
		</div>
	</div>
</div>

</body>
<script type="text/javascript">
//解析传入URL中的参数的方法
var getParam = function(name){  
    var search = document.location.search;  
    var pattern = new RegExp("[?&]"+name+"\=([^&]+)", "g");  
    var matcher = pattern.exec(search);  
    var items = null;  
    if(null != matcher){  
            try{  
                    items = decodeURIComponent(decodeURIComponent(matcher[1]));  
            }catch(e){  
                    try{  
                            items = decodeURIComponent(matcher[1]);  
                    }catch(e){  
                            items = matcher[1];  
                    }  
            }  
    }  
    return items;  
}; 

$(function(){
	$("#text p").append("订单号："+getParam("OrderId"));
	
	var a = $("<a></a>").addClass("btn").attr("href","${APP_PATH}/ToOrderDetail?OrderId="+getParam("OrderId")).append("查看订单详情");
	$("#ToOrderDetail").append(a);
});

$("#DoSearch").click(function(){
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