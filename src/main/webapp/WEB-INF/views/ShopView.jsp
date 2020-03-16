<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>
   
<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<style>
.container {
margin-top:75px;
}
.btn{
white-space: normal;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品搜索</title>
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
			
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
					 <a class="navbar-brand"></a>
				</div>			
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">排序<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									 <a href="#">按价格升序</a>
								</li>
								<li class="divider">
								</li>
								<li>
									 <a href="#">按价格降序</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				
			</nav>
			
		<div class="row" id = result_list>			  
            <div class="row"></div>
		</div>
		<div class="col-md-12 column">
            <div class="col-md-6"></div>
            <div class="col-md-6" id="page_nav_area"></div>
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

	
	//加载搜索结果
	$(function(pn){
		to_page(1);
	});
	
	//分页加载函数
	function to_page(pn){
		$.ajax({
			url:"${APP_PATH}/DoSearch",
			data:{
				keyword:getParam("keyword"),
				pn:pn
			},
			type:"post",
			
			
			success:function(result){
				//console.log(result);
				//解析搜索结果
				build_result_list(result);
				build_page_nav(result);
			},
			
			error:function(){
				alert("error!");
			}
		});
	}
	
	//解析搜索结果并生成页面数据的函数
	function build_result_list(result){
		//清空页面元素表格
		$("#result_list").empty();
		var items = result.extend.pageInfo.list;
		$.each(items,function(index,item){
			
			var img =$("<img></img>").attr("alt","300x300").attr("src",item.picUrl);
			
			var toItemURL =$("<a></a>").append(item.itemName);
			toItemURL.addClass("btn");
			toItemURL.attr('href','${APP_PATH}/ToItem?itemId='+item.itemId);
			
			var caption =$("<div></div").addClass("caption");
			caption.append(toItemURL);
			
			
			var thumbnail =$("<div></div").addClass("thumbnail").append(img).append(caption);
			
			var col = $("<div></div").addClass("col-md-3").append(thumbnail).appendTo("#result_list");
		});
	}
	
	//构建分页导航条
	function build_page_nav(result){
		$("#page_nav_area").empty();
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("«").attr("href","#"));		
		
		if(result.extend.pageInfo.hasPreviousPage==false){
			firstPageLi.addClass("disabled").attr("disabled","disabled");
			prePageLi.addClass("disabled").attr("disabled","disabled");
		}
		else{
			//为元素添加点击事件
			firstPageLi.click(function(){
				toPage(1);
			});
			prePageLi.click(function(){
				toPage(result.extend.pageInfo.pageNum - 1);
			});
		}
		var ul = $("<ul></ul>").addClass("pagination").append(firstPageLi).append(prePageLi);
		
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
			var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
			if(result.extend.pageInfo.pageNum==item){
				numLi.addClass("active");
			}
			numLi.click(function(){
					to_page(item);
			});
			ul.append(numLi);
		});
		
		var nextPageLi = $("<li></li>").append($("<a></a>").append("»").attr("href","#"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
		if(result.extend.pageInfo.hasNextPage==false){
			nextPageLi.addClass("disabled").attr("disabled","disabled");
			lastPageLi.addClass("disabled").attr("disabled","disabled");
		}
		else{
			//为元素添加点击事件
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum + 1);
			});
			lastPageLi.click(function(){
				toPage(result.extend.pageInfo.pages);
			});
		}
		ul.append(nextPageLi).append(lastPageLi);
		
		var bavEle = $("<nav></nav>").addClass("nav nav-pills pull-right").append(ul).appendTo("#page_nav_area");
	}
	
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