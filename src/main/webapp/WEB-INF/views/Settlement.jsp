<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title>结算——确认订单</title>
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
			<div class="page-header">
				<h1>
					订单确认<small>请仔细确认订单信息</small>
				</h1>
			</div>
			<h3>
				收货地址
			</h3>
			<p>
			<div id="address">
			</div>

			<div class="page-header">
				<h2>
					订单详情
				</h2>
			</div>
			<table class="table table-hover" id="table">
				<thead>
					<tr>
						<th>商品预览</th>
						<th>单价</th>
						<th>数量</th>
						<th>小计</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			
			<nav class="navbar navbar-default" role="navigation">
				<ul class="nav navbar-nav">
						<li>
							 <a href="/ToCart">修改订单</a>
						</li>
					</ul>		
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right" id="sum_price">
					
					
					         <c:forEach var="cart" items="${sessionScope.cart}">
                             <c:set var="count" value="${count+cart.detail.price*cart.count}"></c:set>
                             </c:forEach>
                             
                             <li>
							  <a>总计：<fmt:formatNumber value="${count}" type="currency" pattern="￥.00"/></a>
							 </li>
							 
							 
					</ul>
				</div>
			</nav>
           
		    <button class="btn btn-lg btn-primary pull-right" id="do_order_btn">提交订单</button>
		    
		</div>
	</div>
</div>

</body>

<script type="text/javascript">

		//动态加载页面
	    $(function(){ 	
	    	$.ajax({
		        url:"${APP_PATH}/GetSession",
		        type:"GET",
		        withCredentials: true, //!跨域带cookies
		        success:function(result){
		        	console.log(result);
		            if(result.extend.cart != null){
		            	build_list(result.extend.cart);
		            }
		            
		            if(result.extend.cart == null){
		            	alert("非法操作！购物车为空！");
		            	location.href="MainView.jsp";
		            }
		        }
		    });
	    	
	    	$.ajax({
		        url:"${APP_PATH}/GetAddress",
		        type:"GET",
		        withCredentials: true, //!跨域带cookies
		        success:function(result){
		        	console.log(result);
		            if(result.extend.address != null){
		            	build_address(result.extend.address);
		            }
		            
		            if(result.extend.address == null){
		            	alert("非法操作！收货地址为空！");
		            	location.href="${APP_PATH}/ToSignInAddr";
		            }
		        }
		    });
	    });
		
		function build_list(cart){
			cart = eval(cart);
			address = eval(address);
			$.each(cart,function(index,item){
				var _pic = $("<img></img>").attr("src",item.detail.picUrl).attr("width","50px");
				var pic = $("<td></td>").append(_pic).append(item.detail.itemName);
				
				var price = $("<td></td>").append("￥"+formatCurrency(item.detail.price));
				
				var count = $("<td></td>").append(" x"+item.count);
				
				var sum = $("<td></td>").append("￥"+formatCurrency(item.detail.price*item.count));
				
				$("<tr></tr>").append(pic).append(price).append(count).append(sum).appendTo("#table tbody");
				
			});
			
		}	
		
		function build_address(address){
			var address = $("<div></div>").append(address.receiver)
		                                  .append("<br>").append(address.province+"省    ").append(address.city+"市    ").append(address.area+"区    ").append(address.address)
		                                  .append("<br>").append(address.cellphone);
		    address.appendTo("#address");
		}
	
    $("#do_order_btn").click(function(){
    	event.preventDefault();//阻止按钮默认的表单提交动作
	        	//发送ajax请求执行购买操作
	        	$.ajax({
	        	    url:"${APP_PATH}/DoOrder",
	        	    type:"post",
	        	    withCredentials: true, //!跨域带cookies
	        	    success:function(result){
	        	        console.log(result);
	        	        if(result.code == 200){
	        	            location.href="${APP_PATH}/ToOrderDone?OrderId="+result.extend.order_id;
	        	        }
	        	            
	        	        if(result.code == 100){
	        	            alert("购买失败！");
	        	        }
	        	    },
	        	    error:function(){
	        	        alert("error!");
	        	    }
	        	});
	        });
    
	 //价格格式化
	function formatCurrency(num) {  
	    num = num.toString().replace(/\$|\,/g,'');  
	    if(isNaN(num))  
	    num = "0";  
	    sign = (num == (num = Math.abs(num)));  
	    num = Math.floor(num*100+0.50000000001);  
	    cents = num%100;  
	    num = Math.floor(num/100).toString();  
	    if(cents<10)  
	    cents = "0" + cents;  
	    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
	    num = num.substring(0,num.length-(4*i+3))+','+  
	    num.substring(num.length-(4*i+3));  
	    return (((sign)?'':'-') + num + '.' + cents);  
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