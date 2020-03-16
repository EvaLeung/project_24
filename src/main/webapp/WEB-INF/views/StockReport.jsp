<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath());%>

<!--引入bootstrap-->   
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css">
<script type="text/javascript" charset="UTF-8" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<style>
.container {
margin-top:15px;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理系统</title>
</head>
<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="page-header">
				<h1>
					 管理系统
				</h1>
			</div>
			<div class="row clearfix">
				<div class="col-md-2 column">
					<div class="list-group">
					<a href="${APP_PATH}/ToAddItem">
                    <button type="button" class="list-group-item">新增商品</button>
                    </a>
                    <a href="${APP_PATH}/ToUpdateItem">
                    <button class="list-group-item">修改商品信息</button>
                    </a>
                    <a href="${APP_PATH}/ToStockReport">
                    <button class="list-group-item">库存统计</button>
                    </a>
                    <a href="${APP_PATH}/ToSellReport">
                    <button class="list-group-item">销售统计</button>
                    </a>
                    <a href="${APP_PATH}/ToFinanceReport">
                    <button class="list-group-item">财务统计</button>
                    </a>
				</div>
				</div>
				<div class="col-md-10 column">	
						    					
					<table class="table table-hover" id="table">
						<thead>
							<tr>
								<th>商品ID</th>
								<th>商品名称</th>
								<th>数量</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
						
				</div>
				
				
			</div>		

		</div>
	</div>
</div>

</body>

<script type="text/javascript">

	//动态加载页面
	$(function(){ 	
		$.ajax({
	        url:"${APP_PATH}/GetStockReport",
	        type:"GET",
	        withCredentials: true, //!跨域带cookies
	        success:function(result){
	        	console.log(result);
	        	if(result.code==200){
	        		build_list(result.extend.report);
	        	}
	        	else{
	        		alert("非法操作！")
	        		location.href = "MainView.jsp";
	        	}
	        },
	         error:function(){
	        	 alert("error!");
	         }
	        });
	    });	
	
	function build_list(result){
		result = eval(result);
		$.each(result,function(index,item){
			
			var itemName = $("<td></td>").append(item.itemName);
			
			var itemCount = $("<td></td>").append(item.itemCount);
			
			var itemId = $("<td></td>").append(item.itemId);
			
			$("<tr></tr>").append(itemId).append(itemName).append(itemCount).appendTo("#table tbody");
			
		});
	}

</script>
</html>