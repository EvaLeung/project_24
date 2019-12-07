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
					<form class="navbar-form navbar-left" action="search.do" method="post">
						<div class="form-group">
							<input type="text" class="form-control" name="key_word"/>
						</div> <button type="submit" class="btn btn-default">搜索</button>
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
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand">共有${fn:length(requestScope.list)}个搜索结果</a>
				</div>			
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">排序<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									 <a href="resultsort.do?type=asc&key_word=${requestScope.key_word}">按价格升序</a>
								</li>
								<li class="divider">
								</li>
								<li>
									 <a href="resultsort.do?type=desc&key_word=${requestScope.key_word}">按价格降序</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				
			</nav>
			
			<div class="row" id = result_list>
			
			<c:forEach var="book" items="${requestScope.list}">
				<div class="col-md-3">
				<div class="thumbnail">
					<img alt="300x300" src="${book.img}"/>
					<div class="caption">
						<p>
						    <form action="showdetailed.do" method="post" name="${book.name}">
						    <input type='hidden' name='name' value='${book.name}'><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
							<a class="btn" href='javascript:document.${book.name}.submit();'><c:out value="${book.name}"/></a>
							</form> 
					</div>
				</div>
			</div>
            </c:forEach>
           
            <div class="row">
            <div class="col-md-12 column">
			<ul class="pagination">
				<li>
					 <a href="#">Prev</a>
				</li>
				<li>
					 <a href="#">1</a>
				</li>
				<li>
					 <a href="#">2</a>
				</li>
				<li>
					 <a href="#">3</a>
				</li>
				<li>
					 <a href="#">4</a>
				</li>
				<li>
					 <a href="#">5</a>
				</li>
				<li>
					 <a href="#">Next</a>
				</li>
			</ul>
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

	
	//加载搜索结果
	$(function(){
		$.ajax({
			url:"${APP_PATH}/DoSearch",
			data:{
				keyword:getParam("keyword"),
				pn:getParam("pn")
			},
			type:"post",
			
			
			success:function(result){
				//console.log(result);
				//解析搜索结果
				build_result_list(result);
			},
			
			error:function(){
				alert("error!");
			}
		});
	});
	
	//解析搜索结果并生成页面数据的函数
	function build_result_list(result){
		var items = result.extend.pageInfo.list;
		$.each(items,function(index,item){
			
			var img =$("<img></img>").attr("alt","300x300").attr("src",item.picUrl);
			
			var toItemURL =$("<a></a>").append(item.itemName);
			toItemURL.addClass("btn");
			toItemURL.attr('href','${APP_PATH}/ToItem?itemId='+item.itemId);
			
			var caption =$("<div></div").addClass("caption");
			caption.append("<p>").append(toItemURL);
			
			var thumbnail =$("<div></div").addClass("thumbnail").append(img).append(caption);
			
			var col = $("<div></div").addClass("col-md-3").append(thumbnail).appendTo("#result_list");
		});
	}
	
	function build_page_nav(result){
		
	}
</script>
</html>