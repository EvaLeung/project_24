<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    
<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<style>
.container {
       margin-top:30px;
}
.bg {
    background:url(source/img/title_background.jpg) no-repeat center center scroll;
    width:100%;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网上书城</title>
</head>
<body>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="jumbotron bg">
                <div class="container">
                    <h2>欢迎来到网上药房</h2>
                </div>
            </div>
			<div class="page-header">
				<h1>
					推荐 <small>部分热门分类</small>
				</h1>
			</div>
			<div class="carousel slide" id="carousel-507969" data-ride="carousel" data-interval="5000">
				<ol class="carousel-indicators">
					<li class="active" data-slide-to="0" data-target="#carousel-507969">
					</li>
					<li data-slide-to="1" data-target="#carousel-507969">
					</li>
					<li data-slide-to="2" data-target="#carousel-507969">
					</li>
				</ol>
				<div class="carousel-inner">
					<div class="item active">
						<img alt="" src="source/img/edu-l.jpg" />
						<div class="carousel-caption">
							<h4>
								教育
							</h4>
							<p>
								中小学教育/素质培养/语言培训/职业培训
							</p>
						</div>
					</div>
					<div class="item">
						<img alt="" src="source/img/tec-l.jpg" />
						<div class="carousel-caption">
							<h4>
								科技
							</h4>
							<p>
								计算机与互联网/科普/工业技术/医学
							</p>
						</div>
					</div>
					<div class="item">
						<img alt="" src="source/img/mus-l.jpg" />
						<div class="carousel-caption">
							<h4>
								音乐
							</h4>
							<p>
								钢琴/吉他/小提琴/歌谱曲谱/音乐理论
							</p>
						</div>
					</div>
				</div> <a class="left carousel-control" href="#carousel-507969" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="right carousel-control" href="#carousel-507969" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
			<div class="page-header">
				<h1>
					全部分类 <small>书城所有书籍分类</small>
				</h1>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x300" src="source/img/edu.jpg" />
						<div class="caption">
							<h3>
								教育
							</h3>
							<p>
								 <form action="sumview.do" method="post" name="form1">
						         <input type='hidden' name='tag' value='教育'><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
								 <a class="btn btn-primary" href='javascript:document.form1.submit();'>点击前往</a>
								 </form>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x300" src="source/img/tec.jpg" />
						<div class="caption">
							<h3>
								科技
							</h3>
							<p>
								 <form action="sumview.do" method="post" name="form2">
						         <input type='hidden' name='tag' value="科技"><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
								 <a class="btn btn-primary" href='javascript:document.form2.submit();'>点击前往</a>
								 </form>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x300" src="source/img/mus.jpg" />
						<div class="caption">
							<h3>
								音乐
							</h3>
							<p>
								 <form action="sumview.do" method="post" name="form3">
						         <input type='hidden' name='tag' value="音乐"><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
								 <a class="btn btn-primary" href='javascript:document.form3.submit();'>点击前往</a>
								 </form>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x300" src="source/img/nov.jpg" />
						<div class="caption">
							<h3>
								文学
							</h3>
							<p>
								 <form action="sumview.do" method="post" name="form4">
						         <input type='hidden' name='tag' value="文学"><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
								 <a class="btn btn-primary" href='javascript:document.form4.submit();'>点击前往</a>
								 </form>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x300" src="source/img/li.jpg" />
						<div class="caption">
							<h3>
								生活
							</h3>
							<p>
								 <form action="sumview.do" method="post" name="form5">
						         <input type='hidden' name='tag' value="生活"><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
								 <a class="btn btn-primary" href='javascript:document.form5.submit();'>点击前往</a>
								 </form>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x300" src="source/img/his.jpg" />
						<div class="caption">
							<h3>
								人文社科
							</h3>
							<p>
							     <form action="sumview.do" method="post" name="form6">
						         <input type='hidden' name='tag' value="人文社科"><!-- 创建隐藏域通过表单使用post方法传递EL表达式中的参数 -->
								 <a class="btn btn-primary" href='javascript:document.form6.submit();'>点击前往</a>
								 </form>
							</p>
						</div>
					</div>
				</div>
			</div>
			
	<div class="row clearfix">
		<div class="col-md-12 column">
		
			<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand">网上药房</a>
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
									 <a href="${APP_PATH}/ToCart">购物车</a>
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
			
			
		</div>
	</div>
</div>
			
			
		</div>
	</div>
</body>

<script>
</script>

</html>