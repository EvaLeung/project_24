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
.dl-horizontal{
margin-top:15px;
}
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${requestScope.book.name}</title>
</head>
<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">		
		
			<div class="row clearfix" id="showDetail"></div>						
			
			<div class="row clearfix" id="detailText"></div>
			
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
							 <c:if test="${not empty sessionScope.username}">
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
                             <c:if test="${empty sessionScope.username}">
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
</html>

<script type="text/jscript">
function add(max){
    var number=document.getElementById("count");
    var num=number.value;
    num=parseInt(num);
    max=parseInt(max);
    if (num>=max) {
        //如果文本框的值大于库存,则设置值为库存数量
        number.value=max;
    }
    else {
        num++;
        number.value=num;
    }
}

function subtraction(){
    //获取文本框
    var number = document.getElementById("count");
    var num = number.value;
    
    if (num<=1) {
        //如果文本框的值小于1,则设置值为1
        number.value=1;
    }else {
        num--;
        number.value=num;
    }
}

function addcart(count) {
	     count=parseInt(count);
    	 if(count==0){
        //修改按钮属性
        $("#buy").attr("disabled","true");     
    	 }
     };
     
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
		
		//解析商品详细内容
		  $(function(){
			  $.ajax({
				  url:"${APP_PATH}/ItemDetail",
				  data:{
					  itemId:getParam("itemId")
				  },
				  type:"post",
				  success:function(result){
					  //console.log(result)
					  var item = result.extend.Item;
					  build_buy(item);
					  build_detail_text(item);
					  window.onload = addcart(item.itemCount);
					  
				  }
			  });
		  });   
     
		//购买内容的构造方法
		function build_buy(item){	
			var img = $("<img></img>").attr("alt","200x200").attr("src",item.picUrl);
			var pic = $("<div></div>").addClass("col-md-4 column").append(img);
			
			var header = $("<div></div>").addClass("page-header");
			
			var producer = $("<small></small>").append(item.producer+" 制造");
			var In = $("<h2></h2>").append(item.itemName).append("<br>").append(producer);
			
			var price = $("<h2></h2>").addClass("text-error").append("￥"+formatCurrency(item.price));
			
			var stock = $("<h5></h5>").append("库存："+item.itemCount);
			
			var subBtn = $("<button></button>").addClass("btn btn-default").attr("type","button").attr("onclick","subtraction()").append("-");
			var span1 = $("<span></span>").addClass("input-group-btn").append(subBtn); 
			
			var input = $("<input></input>").addClass("form-control").attr("type","text")
											.attr("id","count").attr("name","count").attr("size",1)
											.attr("value",1).attr("readonly","readonly");
			
			var addBtn = $("<button></button>").addClass("btn btn-default").attr("type","button")
										   .attr("onclick","add("+item.itemCount+")").append("+");
			var span2 = $("<span></span>").addClass("input-group-btn").append(addBtn); 
			
			var ip = $("<div></div>").addClass("input-group").append(span1).append(input).append(span2);
			var addCart = $("<button></button>").addClass("btn btn-default btn-large").attr("id","buy").append("加入购物车");
			//绑定加入购物车按钮的点击事件
			addCart.click(function(){
				var count = $("#count").val();
				 $.ajax({
					  url:"${APP_PATH}/JoinCart",
					  data:{
						  itemId:item.itemId,
						  count:count
					  },
					  type:"post",
					  success:function(result){
						  alert("加入购物车成功！");
						  location.href = "${APP_PATH}/ToItem?itemId="+item.itemId;
						  }
					  });
			});
			
			var countgroup = $("<div></div>").addClass("form-group").append(ip);
			var form = $("<form></form>").addClass("form-inline").append(countgroup).append("<br>").append("<br>").append(addCart);
			
			
			var sum = $("<div></div>").addClass("col-md-8 column");
			sum.append(header).append(In).append(price).append("<br>").append(stock).append("<br>").append(form);
			
			pic.appendTo("#showDetail");
			sum.appendTo("#showDetail");		
		}
		
		function build_detail_text(item){
			var header = $("<div></div>").addClass("page-header");
			var detail = $("<h3></h3>").append("商品详情");
			header.append(detail);
			
			var name = $("<dt></dt>").append("商品名称");
			var _name = $("<dd></dd>").append(item.itemName);
			
			var producer = $("<dt></dt>").append("制造商");
			var _producer = $("<dd></dd>").append(item.producer);
			
			var tag = $("<dt></dt>").append("种类");
			var _tag = $("<dd></dd>").append(item.itemTag);
			
			var batch = $("<dt></dt>").append("批次号");
			var _batch = $("<dd></dd>").append(item.batchNumber);
			
			var detail = $("<dt></dt>").append("适应症");
			var _detail = $("<dd></dd>").append(item.detail);
			
			var dl = $("<dl></dl>").addClass("dl-horizontal").append(name).append(_name)
			                                                 .append(producer).append(_producer)
			                                                 .append(tag).append(_tag)
															 .append(batch).append(_batch)
															 .append(detail).append(_detail);
			
			var sum = $("<div></div>").append(header).append(dl).appendTo("#detailText");
		}
		
</script>