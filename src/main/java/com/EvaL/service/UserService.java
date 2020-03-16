package com.EvaL.service;

import static org.hamcrest.CoreMatchers.describedAs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.EvaL.bean.Address;
import com.EvaL.bean.AddressExample;
import com.EvaL.bean.Message;
import com.EvaL.bean.Order_item;
import com.EvaL.bean.Order_itemExample;
import com.EvaL.bean.Orders;
import com.EvaL.bean.OrdersExample;
import com.EvaL.bean.OrdersExample.Criteria;
import com.EvaL.dao.AddressMapper;
import com.EvaL.dao.ItemMapper;
import com.EvaL.dao.Order_itemMapper;
import com.EvaL.dao.OrdersMapper;

@Service
public class UserService {
	
	@Autowired
	OrdersMapper ordersMapper;
	
	@Autowired
	Order_itemMapper orderItemMapper;
	
	@Autowired
	ItemMapper itemMapper;
	
	@Autowired
	AddressMapper addressMapper;	

	public Message ShowOrderDetail(String orderId) {
		Order_itemExample orderItemExample = new Order_itemExample();
		com.EvaL.bean.Order_itemExample.Criteria criteria = orderItemExample.createCriteria();
		criteria.andOrderIdEqualTo(orderId);
		
		List<Order_item> order = orderItemMapper.selectByExample(orderItemExample);
		
		for(Order_item i:order) {
			i.setDetail(itemMapper.selectByPrimaryKey(i.getItemId()));			
		}
		
		return Message.success().add("order", order);
		
	}

	public Message GetOrderList(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		String username = (String) session.getAttribute("LogInUsername");
		
		OrdersExample orderExample = new OrdersExample();
		Criteria criteria = orderExample.createCriteria();
		criteria.andUsernameEqualTo(username);
		
		List<Orders> orders= ordersMapper.selectByExample(orderExample);
		
		if(orders.size()>0) {
			return Message.success().add("orders", orders);
		}
		else {
			return Message.success();
		}
		
	}

	public Message GetAddrList(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		String username = (String) session.getAttribute("LogInUsername");
		
		AddressExample addressExample = new AddressExample();
		com.EvaL.bean.AddressExample.Criteria criteria = addressExample.createCriteria();
		criteria.andUsernameEqualTo(username);
		List<Address> addr = addressMapper.selectByExample(addressExample);
		if(addr.size()>0) {
			return Message.success().add("addr", addr);
		}
		else {
			return Message.success();
		}
	}

	public Message GetAddress(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		String username = (String) session.getAttribute("LogInUsername");
		
		AddressExample addressExample = new AddressExample();
		com.EvaL.bean.AddressExample.Criteria criteria = addressExample.createCriteria();
		criteria.andUsernameEqualTo(username);
		List<Address> addr = addressMapper.selectByExample(addressExample);
		if(addr.size()>0) {
			Address address = addressMapper.selectByExample(addressExample).get(0);
			return Message.success().add("address", address);
		}
		else {
			return Message.success();
		}
	}

	public Message SignInAddress(HttpServletRequest request,String receiver,String cellphone,String province,String city,String area,String address) {
		//获取用户名
		HttpSession session =  request.getSession();
		String username = (String) session.getAttribute("LogInUsername");
		if(username!=null && receiver!=null && cellphone!=null && province!=null && city!=null && area!=null && address!=null) {
			Address addr = new Address();
			//设置插入的地址对象
			addr.setUsername(username);
			addr.setReceiver(receiver);
			addr.setCellphone(cellphone);
			addr.setProvince(province);
			addr.setCity(city);
			addr.setArea(area);
			addr.setAddr(address);				
			//把数据插入address表中
			addressMapper.insert(addr);
			return Message.success();
		}
		else {
			return Message.fail();
		}
	}

	public Message UpdateAddress(HttpServletRequest request, String receiver, String cellphone, String province,
			String city, String area, String address) {
		//获取用户名
		HttpSession session =  request.getSession();
		String username = (String) session.getAttribute("LogInUsername");
		if(username!=null && receiver!=null && cellphone!=null && province!=null && city!=null && area!=null && address!=null) {
			Address addr = new Address();
			//设置更新的地址对象
			addr.setUsername(username);
			addr.setReceiver(receiver);
			addr.setCellphone(cellphone);
			addr.setProvince(province);
			addr.setCity(city);
			addr.setArea(area);
			addr.setAddr(address);
			AddressExample addressExample = new AddressExample();
			com.EvaL.bean.AddressExample.Criteria criteria = addressExample.createCriteria();
			criteria.andUsernameEqualTo(username);
			addressMapper.updateByExample(addr, addressExample);
			return Message.success();
		}
		else {
			return Message.fail();
		}
	}
		
}
