package com.EvaL.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.spi.http.HttpContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.EvaL.bean.Message;
import com.EvaL.bean.Order_item;
import com.EvaL.service.ShoppingService;

@Controller
public class ShopingController {
	
	@Autowired
	ShoppingService shoppingService;

	@RequestMapping("/JoinCart")
	public String JoinCart(HttpServletRequest request ,@RequestParam(value="itemId")Integer itemId,@RequestParam(value="count")Integer count) {
		shoppingService.JoinCart(request,itemId,count);
		return "ItemDetail";
	}
	
	@RequestMapping("/ToCart")
	public String ToCart() {
		return "ShoppingCart";
	}
	
	@RequestMapping("/GetSession")
	@ResponseBody
	public Message GetSession(HttpSession session) {
		List<Order_item> cart = (List<Order_item>) session.getAttribute("cart");
		String username = (String)session.getAttribute("LogInUsername");
		return Message.success().add("cart",cart).add("LogInUsername",username);
	}
	
	@RequestMapping("/ToSettlement")
	public String ToSettlement() {
		return "Settlement";
	}
	
	@RequestMapping("/DoOrder")
	@ResponseBody
	public Message DoOrder(HttpServletRequest request) {
		return shoppingService.DoOrder(request);
	}
	
	@RequestMapping("/ToOrderDone")
	public String ToOrderDone() {
		return "OrderSuccess";
	}
}
