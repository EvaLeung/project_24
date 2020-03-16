<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>用户信息</title>
</head>
<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="page-header">
				<h1>
					用户信息 <small>详细信息</small>
				</h1>
			</div>
			<div class="row clearfix">
				<div class="col-md-2 column">
					<div class="list-group">
					<a href="${APP_PATH}/ToOrderInfo">
                    <button type="button" class="list-group-item">订单信息</button>
                    </a>
                    <a href="${APP_PATH}/ToAddrInfo">
                    <button class="list-group-item">地址管理</button>
                    </a>
				</div>
				</div>
				<div class="col-md-10 column">
					<div class="page-header">
						<h3>
							订单信息 <small>预览</small>
						</h3>
			    	</div>
			    
					<table class="table table-hover" id="table">
						<thead></thead>
						<tbody></tbody>
					</table>
					
				<div class="container">
					<div class="row clearfix">
				    	<div class="col-md-12 column">
							<div class="row clearfix">
								<div class="col-md-6 column col-md-offset-1" id="tips">
								</div>
							</div>
						</div>
					</div>
				</div>
			
				</div>
			</div>
			
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
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">我的书城<strong class="caret"></strong></a>
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
		</div>
	</div>
</div>

</body>

<script type="text/javascript">

	//动态加载页面
	$(function(){ 	
		$.ajax({
	        url:"${APP_PATH}/GetOrderList",
	        type:"GET",
	        withCredentials: true, //!跨域带cookies
	        success:function(result){
	        	console.log(result);
	            if(result.extend.orders != null){
	            	build_order_list(result.extend.orders);
	            }
	            
	            if(result.extend.orders == null){
	            	build_tips();
	            }
	        },
	         error:function(){
	        	 alert("error!");
	         }
	        });
	    });
	
	//构建订单列表
	function build_order_list(re){
    	var td1 = $("<td></td>").append("订单号");
    	var td2 = $("<td></td>").append("交易时间");
    	var td3 = $("<td></td>").append("状态");
    	
    	$("<tr></tr>").append(td1).append(td2).append(td3).appendTo("#table thead");
    	
    	var re = eval(re);
    	$.each(re,function(index,item){	
    		var _orderId = $("<a></a>").addClass("btn").attr("href","${APP_PATH}/ToOrderDetail?OrderId="+item.orderId+"&User="+item.username+"&OrderTime="+item.orderTime).append(item.orderId);
    		var orderId = $("<td></td>").append(_orderId);
    		var orderTime = $("<td></td>").append(new Date(parseInt(item.orderTime)).toLocaleString());
    		var condition = $("<td></td>").append("订单已处理");
    		
    		$("<tr></tr>").append(orderId).append(orderTime).append(condition).appendTo("#table tbody");
    	});  	   	
    }
	
	//构建提示
	function build_tips(){
		var _toMain = $("<a></a>").addClass("btn").attr("href","MainView.jsp").append("去购物»");
		var toMain = $("<p></p>").append(_toMain);
		
		var p = $("<p></p>").append("您还没有订单，去看看心仪的商品吧~");
		var jum = $("<div></div>").addClass("jumbotron").append(p).append(toMain).appendTo("#tips");
	}
	
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