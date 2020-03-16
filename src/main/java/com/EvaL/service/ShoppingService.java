package com.EvaL.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.EvaL.bean.Message;
import com.EvaL.bean.Order_item;
import com.EvaL.bean.Orders;
import com.EvaL.bean.Sell_report;
import com.EvaL.bean.Stock_report;
import com.EvaL.dao.ItemMapper;
import com.EvaL.dao.Order_itemMapper;
import com.EvaL.dao.OrdersMapper;
import com.EvaL.dao.Sell_reportMapper;
import com.EvaL.dao.Stock_reportMapper;


@Service
public class ShoppingService {
	
	@Autowired
	ItemMapper itemMapper;
	
	@Autowired 
	Order_itemMapper order_itemMapper;
	
	@Autowired 
	OrdersMapper ordersMapper;
	
	@Autowired
	Stock_reportMapper stockreportMapper;
	
	@Autowired
	Sell_reportMapper sellreportMapper;
	
	public Message JoinCart(HttpServletRequest request ,Integer itemId,Integer count) {
		HttpSession session = request.getSession(false);
		List<Order_item> cart = new ArrayList<Order_item>();
		if((List<Order_item>) session.getAttribute("cart")!=null){
			cart = (List<Order_item>) session.getAttribute("cart");
		}
		
		boolean flag = false;		
		for(int i = 0 ; i < cart.size() ; i++)
		{
			if(cart.get(i).getItemId()==itemId)
			{
				cart.get(i).setCount(cart.get(i).getCount()+count);
				flag = true;
			}
		}
		
		if(flag==false){
			Order_item oi = new Order_item();
			oi.setItemId(itemId);
			oi.setDetail(itemMapper.selectByPrimaryKey(itemId));
			oi.setCount(count);
			cart.add(oi);
		}
		
        session.setAttribute("cart",cart);
		return Message.success();	
	}

	public Message DoOrder(HttpServletRequest request){
		try {
		HttpSession session = request.getSession(false);
	    List<Order_item> cart = (List<Order_item>)session.getAttribute("cart");
	    String username = (String)session.getAttribute("LogInUsername");
	    
	    List<Stock_report> order = new ArrayList<Stock_report>();
	    if(cart.size()!=0){
	    	 for(int i = 0;i<cart.size();i++) {
	 	    	//创建库存对象列表
	    		 Stock_report tmp = new Stock_report();
	    		 tmp.setItemCount(cart.get(i).getCount());
	    		 tmp.setItemId(cart.get(i).getItemId());
	    		 tmp.setUpdateTime(new Date());
	    		 order.add(tmp);
	 	    }
	    
		    //遍历订单执行库存更新操作
			List<Stock_report> report = stockreportMapper.selectByExample(null);
			for(Stock_report i:report) {
				Stock_report tmp = i;
				for(Stock_report n: order) {					
					if(n.getItemId()==tmp.getItemId()) {
						Stock_report t = new Stock_report();
						t.setItemId(n.getItemId());
						t.setItemCount(n.getItemCount());
						t.setUpdateTime(n.getUpdateTime());
	                    t.setItemCount(tmp.getItemCount()-t.getItemCount());
						stockreportMapper.updateByPrimaryKey(t);
						
				        }
					else {
						continue;
					}
			    }			
			}
			
			//遍历订单执行销售统计更新
			List<Sell_report> sell = sellreportMapper.selectByExample(null);
			for(Sell_report i:sell) {
				Sell_report tmp = i;
				for(Stock_report n: order) {					
					if(n.getItemId()==tmp.getItemId()) {
						int or = n.getItemCount();
						int sc = i.getSellCount();
	                    tmp.setSellCount(sc+or);
	                    tmp.setUpdateTime(n.getUpdateTime());
	                    sellreportMapper.updateByPrimaryKey(tmp);
				        }
					else {
						continue;
					}
			    }			
			}
			
			//添加订单
			Orders od = new Orders();
			String or_id = CreateOrderId.getOrder_Id();
			od.setOrderId(or_id);
			od.setUsername(username);
			od.setOrderTime(new Date());
			ordersMapper.insert(od);
			
			//插入订单物品
			for(Order_item i:cart) {
				i.setDetail(null);
				i.setOrderId(or_id);
				order_itemMapper.insert(i);
			}
		
		    //清空购物车
			session.removeAttribute("cart");
			return Message.success().add("order_id",od.getOrderId());
		
	    }
	    
	    else {
		return Message.fail();
	    }
		}catch(Exception e){
			throw e;
		}
	 
	}

}
