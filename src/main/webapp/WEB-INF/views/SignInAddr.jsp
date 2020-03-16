<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>

<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<style>
.bg {
       background:url(source/img/r-bg.jpg) no-repeat center center scroll;
       width:100%;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}
.bgc{

background-color:rgba(245,245,245,1);
}
.btn{
   margin-top:30px;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收货地址登记</title>
</head>
<body class="row bg">
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<h1 class="text-center page-header" style="color:white;">
			<span class="glyphicon glyphicon-user"></span>
				收货地址登记
			</h1>
				<div class="col-md-8 column col-md-offset-2 bgc">
					<form class="form-signin" id="address_form">
                            <h3 class="form-signin-heading text-center">请填写收货地址信息</h3>
                                  <label>收货人</label>
                                  <input type="text" id="receiver" name="receiver" class="form-control" placeholder="收货人">                                  
                                  <label>所在地区</label>
                                  <div class="row">
                                  <div class="col-md-3">
                                  <input type="text" id="province" name="province" class="form-control" placeholder="省">
                                  </div>
                                  <div class="col-md-3">
                                  <input type="text" id="city" name="city" class="form-control" placeholder="市">
                                  </div>
                                  <div class="col-md-3">
                                  <input type="text" id="area" name="area" class="form-control" placeholder="区（县）">
                                  </div>
                                  </div>
                                  
                                  <label>详细地址</label>
                                  <input type="text" id="address" name="address"class="form-control" placeholder="详细地址">
                                  
                                  <label>手机号码</label>
                                  <input type="text" id="cellphone" name="cellphone"class="form-control" placeholder="手机号码">
                                                                                         
                                  
                                  <button class="btn btn-lg btn-info btn-block" id="SignInAddress">确定提交</button>
                                  </form>
                                  </div>
                                  
				</div>
			</div>
		</div>

</body>

<script type="text/javascript">
	$("#SignInAddress").click(function(){
		event.preventDefault();//阻止按钮默认的表单提交动作
		$.ajax({
			url:"${APP_PATH}/SignInAddress",
			type:"post",
    	    withCredentials: true, //!跨域带cookies
    	    data:{
    	    	receiver:$("#receiver").val(),
    	    	province:$("#province").val(),
    	    	city:$("#city").val(),
    	    	area:$("#area").val(),
    	    	address:$("#address").val(),
    	    	cellphone:$("#cellphone").val()
    	    },
    	    success:function(result){
    	    	if(result.code==200){
    	    		alert("提交成功！");
    	    		location.href="${APP_PATH}/ToAddrInfo";
    	    	}
    	    	else{
    	    		alert("提交失败！");
    	    	}
    	    },
    	    error:function(){
    	    	alert("error");
    	    }
		});
	});
</script>

</html>