package com.EvaL.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.EvaL.bean.Address;
import com.EvaL.bean.Message;
import com.EvaL.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/ToOrderDetail")
	public String ToOrder() {
		return "OrderDetail";
	}
	
	@RequestMapping("/ShowOrderDetail")
	@ResponseBody
	public Message ShowOrderDetail(String OrderId) {
		return userService.ShowOrderDetail(OrderId);		
	}
	
	@RequestMapping("/ToUserInfo")
	public String ToUserInfo() {
		return "UserInfo";
	}
	
	@RequestMapping("/GetOrderList")
	@ResponseBody
	public Message GetOrderList(HttpServletRequest request) {
		return userService.GetOrderList(request);
	}
	
	@RequestMapping("/LogOut")
	public String LogOut(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		session.removeAttribute("LogInUsername");
		return "redirect:/MainView.jsp";
	}
	
	@RequestMapping("/ToAddrInfo")
	public String ToAddrInfo() {
		return "AddressInfo";
	}
	
	@RequestMapping("/ToOrderInfo")
	public String ToOrderInfo() {
		return "UserInfo";
	}

	@RequestMapping("/GetAddrList")
	@ResponseBody
	public Message GetAddrList(HttpServletRequest request) {
		return userService.GetAddrList(request);
	}
	
	@RequestMapping("/GetAddress")
	@ResponseBody
	public Message GetAddress(HttpServletRequest request) {
		return userService.GetAddress(request);
	}
	
	@RequestMapping("/ToSignInAddr")
	public String ToSignInAddr() {
		return "SignInAddr";
	}
	
	@RequestMapping("/SignInAddress")
	@ResponseBody
	public Message SignInAddress(HttpServletRequest request,String receiver,String cellphone,String province,String city,String area,String address) {
		return userService.SignInAddress(request,receiver,cellphone,province,city,area,address);
	}
	
	@RequestMapping("/ToUpdateAddr")
	public String ToUpdateAddr() {
		return "UpdateAddr";
	}
	
	@RequestMapping("/UpdateAddress")
	@ResponseBody
	public Message UpdateAddress(HttpServletRequest request,String receiver,String cellphone,String province,String city,String area,String address) {
		return userService.UpdateAddress(request,receiver,cellphone,province,city,area,address);
	}
}
