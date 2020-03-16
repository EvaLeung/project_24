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
					
					<div class="container-fluid">
						<div class="row-fluid">
							<div class="span12">
								<form id="ItemInfo">
								 	<legend>修改商品的信息</legend>
									<div class="form-group">
    									<label>商品名称</label>
    									<input class="form-control" placeholder="商品名称" name="itemName" id="itemName">
  									</div>
  									<div class="form-group">
    									<label for="exampleInputFile">商品图片</label>
    									<input type="file" name="pic">
    									<p class="help-block">图片大小尺寸为200x200,文件大小在5MB以下</p>
  									</div>
  									<div class="form-group">
    									<label>价格</label>
    									<input class="form-control" placeholder="价格" name="price" id="price">
  									</div>
  									<div class="form-group">
    									<label>数量</label>
    									<input class="form-control" placeholder="数量" name="count" id="count">
  									</div>
  									<div class="form-group">
    									<label>分类</label>
    									<input class="form-control" placeholder="分类" name="itemTag" id="itemTag">
  									</div>
  									<div class="form-group">
    									<label>制造商</label>
    									<input class="form-control" placeholder="制造商" name="producer" id="producer">
  									</div>
  									<div class="form-group">
    									<label>批次号</label>
    									<input class="form-control" placeholder="批次号" name="batchNumber" id="batchNumber">
  									</div>
  									<div class="form-group">
    									<label>详细描述</label>
    									<textarea class="form-control" rows="4" name="detail" id="detail"></textarea>
  									</div>
  									<button class="btn btn-default btn-lg" id="DoSubmit">提交</button>
								</form>
							</div>
						</div>
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

	//动态加载页面
	$(function(){ 	
		$.ajax({
	        url:"${APP_PATH}/ItemDetail",
	        type:"POST",
	        withCredentials: true, //!跨域带cookies
			 data:{
				  itemId:getParam("ItemId")
			  },
	        success:function(result){
	        	console.log(result);
	        	if(result.code==200){
	        		var item = result.extend.Item;
	        		build_form(item);
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
	//构建回显查询信息
	function build_form(item){
		$("#itemName").val(item.itemName);
		$("#price").val(item.price);
		$("#count").val(item.itemCount);
		$("#itemTag").val(item.itemTag);
		$("#producer").val(item.producer);
		$("#batchNumber").val(item.batchNumber);
		$("#detail").val(item.detail);
	}
	
	$("#DoSubmit").click(function(){
		event.preventDefault();//阻止按钮默认的表单提交动作
		var sendData = new FormData($('#ItemInfo')[0]);
		$.ajax({
			url:"${APP_PATH}/UpdateItemInfo?ItemId="+getParam("ItemId"),
	        type:"post",
	        data:sendData,
	        withCredentials: true, //!跨域带cookies
	        cache:false,//文件不设置缓存
            processData: false,//数据不被转换为字符串
            contentType: false,//上传文件时使用，避免 JQuery 对其操作
	        success:function(result){
	        	if(result.code==200){
	        		alert("更新成功");
	        	}
	        	else{
	        		alert("更新失败");
	        	}
	        }
		});
	});
</script>