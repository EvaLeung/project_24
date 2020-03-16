<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>收货地址信息</title>
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
                    <button class="list-group-item" id="ToAddrInfo">地址管理</button>
                    </a>
                    </div>
				</div>
				<div class="col-md-10 column">
				<div class="page-header">
				<h3>
					收货地址信息 <small>信息管理</small>
				</h3>
			    </div>
			    			    
				<div class="row clearfix">
					<div class="col-md-12 column">
						<div class="row clearfix">
							<div class="col-md-6 column col-md-offset-1" id="tips">
							</div>
						</div>
					</div>
				</div>

					<p></p>
					<br>			
					<div class="panel panel-default" id="addrInfo"></div>
				
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
		</div>
	</div>
</div>
</div>
</body>
<script type="text/javascript">
	//动态加载页面
	$(function(){ 	
		$.ajax({
	        url:"${APP_PATH}/GetAddrList",
	        type:"GET",
	        withCredentials: true, //!跨域带cookies
	        success:function(result){
	        	console.log(result);
	            if(result.extend.addr != null){
	            	build_addr_list(result.extend.addr);
	            }
	            
	            if(result.extend.addr == null){
	            	build_tips();
	            }
	        },
	         error:function(){
	        	 alert("error!");
	         }
	        });
	    });
	function build_addr_list(result){
		$.each(result,function(index,item){
			var dt1 = $("<dt></dt>").append("收件人");
			var receiver = $("<dd></dd>").append(item.receiver);
			var dt2 = $("<dt></dt>").append("所在地区");
			var area = $("<dd></dd>").append(item.province+"省"+item.city+"市"+item.area+"区");
			var dt3 = $("<dt></dt>").append("地址");
			var addr = $("<dd></dd>").append(item.address);
			var dt4 = $("<dt></dt>").append("手机");
			var cellphone = $("<dd></dd>").append(item.cellphone);
			
			var dl = $("<dl></dl>").addClass("dl-horizontal").append(dt1).append(receiver).append(dt2).append(area)
								   .append(dt3).append(addr).append(dt4).append(cellphone);
			var div_10 = $("<div></div>").addClass("col-md-10 column").append(dl);
			
			var btn = $("<button></button").addClass("btn btn-default btn-sm edit_Btn pull-right edit_btn").append("编辑");
			var div_2 = $("<div></div>").addClass("col-md-2 column").append(btn);
			
			var div = $("<div></div>").addClass("panel-body").append(div_10).append(div_2).appendTo("#addrInfo");
		});
	}
	
	
	function build_tips(){
		var _toSign = $("<a></a>").addClass("btn").attr("href","${APP_PATH}/ToSignInAddr").append("添加收货地址»");
		var toSign = $("<p></p>").append(_toSign);
		
		var p = $("<p></p>").append("您还没有填写您的收货地址");
		var jum = $("<div></div>").addClass("jumbotron").append(p).append(toSign).appendTo("#tips");
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
	
	$(document).on("click",".edit_Btn",function(){
		window.location.href ="${APP_PATH}/ToUpdateAddr";
	});
	
</script>
</html>