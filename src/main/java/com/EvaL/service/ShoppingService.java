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
import com.EvaL.bean.Stock_report;
import com.EvaL.dao.ItemMapper;
import com.EvaL.dao.Order_itemMapper;
import com.EvaL.dao.OrdersMapper;
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
	
	public Message JoinCart(HttpServletRequest request ,Integer itemId,Integer count) {
		HttpSession session = request.getSession(false);
		List<Order_item> cart = new ArrayList<Order_item>();
		if((List<Order_item>) session.getAttribute("cart")!=null){
			cart = (List<Order_item>) session.getAttribute("cart");
		}
		
		boolean flag = false;		
		for(int i = 0 ; i < cart.size() ; i++)
		{
			if(Integer.parseInt(cart.get(i).getItem())==itemId)
			{
				cart.get(i).setCount(cart.get(i).getCount()+count);
				flag = true;
			}
		}
		
		if(flag==false){
			Order_item oi = new Order_item();
			oi.setItem(String.valueOf(itemId));
			oi.setDetail(itemMapper.selectByPrimaryKey(itemId));
			oi.setCount(count);
			cart.add(oi);
		}
		
        session.setAttribute("cart",cart);
		return Message.success();	
	}

	public Message DoOrder(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
	    List<Order_item> cart = (List<Order_item>)session.getAttribute("cart");
	    String username = (String)session.getAttribute("LogInUsername");
	    
	    List<Stock_report> order = new ArrayList<Stock_report>();
	    if(cart.size()!=0){
	    	 for(int i = 0;i<order.size();i++) {
	 	    	//创建库存对象列表
	 	    	order.get(i).setItemCount(cart.get(i).getCount());
	 	    	order.get(i).setItemId(Integer.parseInt(cart.get(i).getItem()));
	 	    	order.get(i).setUpdateTime(new Date());
	 	    }	    
	    
	    //执行库存更新操作
		Integer succ = 0;
		List<Stock_report> report = stockreportMapper.selectByExample(null);
		for(int i = 0;i<order.size();i++) {
			Integer flag = 0;
			Stock_report tmp = order.get(i);
			for(int n = 0;i<report.size();n++) {
				if(report.get(n).getItemId()==tmp.getItemId()) {
					int re = report.get(n).getItemCount();
					int or = tmp.getItemCount();
					System.out.print(tmp.getItemId());
                    report.get(n).setItemCount(re-or);
					flag = stockreportMapper.updateByPrimaryKeySelective(report.get(n));
					succ = succ+flag;
			}
				else {
					continue;
				}
		}
		}
		
		if(succ==cart.size())
		{
			Orders od = new Orders();
			od.setOrderId(CreateOrderId.getOrder_Id());
			od.setUsername(username);
			od.setOrderTime(new Date());
			ordersMapper.insert(od);
			session.removeAttribute("cart");
			return Message.success().add("order_id",od.getOrderId());
		}
	    
		
		else {
			return Message.fail();
		}
		
	    }
	    else {
		return Message.fail();
	    }
	}
	
	

}
