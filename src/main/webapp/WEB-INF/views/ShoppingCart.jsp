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
<title>购物车</title>
</head>
<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column" id="mainPage">
		    <table class="table table-hover" id="table">
		    	<thead></thead>
				<tbody></tbody>
		    </table>
		
		
			<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand">网上书城</a>
				</div>
				
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li>
							 <a href="MainView.jsp">主页</a>
						</li>
						<li class="active">
							 <a href="Search.jsp">搜索</a>
						</li>
					</ul>
					<form class="navbar-form navbar-left" action="search.do" method="post">
						<div class="form-group">
							<input type="text" class="form-control" name="key_word"/>
						</div> <button type="submit" class="btn btn-default">搜索</button>
					</form>
					<ul class="nav navbar-nav navbar-right">
						<li>
							 <c:if test="${not empty sessionScope.LogIned}">
                                <a><c:out value="${sessionScope.username}"/> 您好</a>
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
                             <c:if test="${empty sessionScope.LogIned}">
                                 <a href="LogIn.jsp"><c:out value="请登录"/></a>
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

    //删除单种商品按钮事件
	$("#del").click(function(){
		$.ajax({
			url:"${APP_PATH}/DelCart",
			data:$("#itemId").val(),
			type:"post",
			success:function(){
				location.href = "${APP_PATH}/ToCart";
			}
		})
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
    
    //动态加载页面
    $(function(){ 	
    	$.ajax({
	        url:"${APP_PATH}/GetSession",
	        type:"GET",
	        success:function(result){
	        	console.log(result);
	            if(result.extend.cart != null){
	            	build_cart(result.extend.cart);
	            }
	            
	            if(result.extend.cart == null){
	            	build_tips();
	            }
	        }
	    });
    });

    function build_cart(re){
    	var td1 = $("<td></td>").append("商品预览");
    	var td2 = $("<td></td>").append("单价");
    	var td3 = $("<td></td>").append("数量");
    	var td4 = $("<td></td>").append("小计");
    	var td5 = $("<td></td>").append("操作");
    	$("<tr></tr>").append(td1).append(td2).append(td3).append(td4).append(td5).appendTo("#table thead");
    	
    	var re = eval(re);
    	$.each(re,function(index,item){	
    		var pic = $("<img></img>").attr("src",item.detail.picUrl).attr("width","100px");
    		var itemName = $("<td></td>").append(pic).append("    "+item.detail.itemName);
    		var count = $("<td></td>").append("x").append(item.count);
    		var sum = $("<td></td>").append("￥"+formatCurrency(item.detail.price*item.count));
    		var price = $("<td></td>").append(item.detail.price);
    		var _btn = $("<a></a>").addClass("btn").attr("id","del").attr("value",item.Item).append("删除");
    		var btn = $("<td></td>").append(_btn);
    		
    		$("<tr></tr>").append(itemName).append(price).append(count).append(sum).append(btn).appendTo("#table tbody");
    	});  	
    	
    	var allClean = $("<a></a>").attr("href","${APP_PATH}/AllClean").append("清空购物车");
    	var pre_li = $("<li></li>").append(allClean);
    	var pre_ul = $("<ul></ul>").addClass("nav navbar-nav").append(pre_li);
    	
    	var sum = null;
    	$.each(re,function(index,item){
    		sum = sum+item.detail.price*item.count;
    	});
    	
    	var sum_a = $("<a></a>").append("总计：￥"+formatCurrency(sum));
    	var next_li = $("<li></li>").append(sum_a);
    	var a = $("<a></a>").attr("href","${APP_PATH}/ToSettlement").append("去结算");
    	var sum_li = $("<li></li>").append(a);
    	var next_ul = $("<ul></ul>").addClass("nav navbar-nav navbar-right").append(next_li).append(sum_li);
    	var next_div = $("<div></div>").addClass("collapse navbar-collapse").append(next_ul);
    	
    	var nav = $("<nav></nav>").addClass("navbar navbar-default").attr("role","navigation").append(pre_ul).append(next_div);
    	
    	var col = $("<div></div>").addClass("col-md-12 column").append(nav);
    	var row = $("<div></div>").addClass("row clearfix").append(col);
    	var mainCol = $("<div></div").addClass("col-md-12 column").append(table).append(row);
    	var mainRow = $("<div></div>").addClass("row clearfix").append(mainCol).appendTo("#mainPage");
    	
    }
    
    function build_tips(){ 	
    	var a = $("<a></a>").addClass("btn").attr("href","MainView.jsp").append("去购物»");
    	var p2 = $("<p></p>").append(a);
    	var p1 = $("<p></p>").append("购物车空空的哦~，去看看心仪的商品吧~");
    	var jum = $("<div></div>").addClass("jumbotron").append(p1).append(p2);
    	var col_6 = $("<div></div>").addClass("col-md-6 column col-md-offset-3").append(jum);
    	var row = $("<div></div>").addClass("row clearfix").append(col_6);
    	var col = $("<div></div").addClass("col-md-12 column").append(row);
    	var mainRow = $("<div></div>").addClass("row clearfix").append(col).appendTo("#mainPage");
    }
</script>

</html>