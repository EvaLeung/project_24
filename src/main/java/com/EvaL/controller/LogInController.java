package com.EvaL.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.EvaL.bean.Administrator;
import com.EvaL.bean.Message;
import com.EvaL.bean.User;
import com.EvaL.service.LogInService;

@Controller
public class LogInController {
	
	@Autowired
	LogInService loginService;

	@RequestMapping("/ToLogIn")
	public String ToSearch() {
		return "LogIn";
	}
	
	//用户登录验证
	@RequestMapping(value="/UserLogIn", method=RequestMethod.POST)
	@ResponseBody
	public Message checkUser(HttpSession session,User user) {
		
		//System.out.print(loginService.cheackUser(user).getMsg());
		
		if(loginService.cheackUser(user).getCode()==200) {
			session.setAttribute("LogInUsername",user.getUsername());
		}
		return loginService.cheackUser(user);
	}
	
	//管理员登录验证
	@RequestMapping(value="/AdminLogIn", method=RequestMethod.POST)
	@ResponseBody
	public Message checkAdmin(HttpSession session,Administrator admin) {
		
		//System.out.print(admin.getAdminUsername());
		
		if(loginService.cheackAdmin(admin).getCode()==200) {
			session.setAttribute("AdminUsername",admin.getAdminUsername());
		}
		return loginService.cheackAdmin(admin);
	}
	
	
	@RequestMapping("/ToRegister")
	public String ToRsgister() {
		return "Register";
	}
	
	//用户注册
	@RequestMapping("/DoRegister")
	@ResponseBody
	public Message DoRegister(String username,String password,String cPassword) {
		System.out.println(cPassword);
		return loginService.DoRegister(username,password,cPassword);
	}
	
	
}