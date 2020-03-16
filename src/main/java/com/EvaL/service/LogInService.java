package com.EvaL.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.EvaL.bean.Administrator;
import com.EvaL.bean.AdministratorExample;
import com.EvaL.bean.Message;
import com.EvaL.bean.User;
import com.EvaL.bean.UserExample;
import com.EvaL.bean.UserExample.Criteria;
import com.EvaL.dao.AdministratorMapper;
import com.EvaL.dao.UserMapper;

@Service
public class LogInService {
	
	@Autowired
	UserMapper userMapper;

	@Autowired
	AdministratorMapper adminMapper;

	//验证用户登录信息
	public Message cheackUser(User user) {
		UserExample userExample = new UserExample();
		Criteria criteria = userExample.createCriteria();
		
		criteria.andUsernameEqualTo(user.getUsername()).andPasswordEqualTo(user.getPassword());
			if(userMapper.selectByExample(userExample).size() != 0 ){
				return Message.success();
			}
			else {
				return Message.fail();
			}
		
	}


	public Message cheackAdmin(Administrator admin) {
		AdministratorExample adminExample = new AdministratorExample();
		com.EvaL.bean.AdministratorExample.Criteria criteria = adminExample.createCriteria();
		
		criteria.andAdminUsernameEqualTo(admin.getAdminUsername()).andAdminPasswordEqualTo(admin.getAdminPassword());
			if(adminMapper.selectByExample(adminExample).size() != 0 ){
				return Message.success();
			}
			else {
				return Message.fail();
			}
	}


	public Message DoRegister(String username,String password,String cp) {
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		//用户名密码格式校验
		if(user.getUsername().length()<=2||user.getUsername().length()>12)
		{	
			Message result = Message.fail();
			result.setMsg("用户名不合法！请重新输入。");
			return result;
		}
		
		if(user.getPassword().length()<6||user.getPassword().length()>16)
		{
			Message result = Message.fail();
			result.setMsg("密码不合法！请重新输入。");
			return result;
		}
		
		if(user.getPassword().equals(cp)==false)
		{
			Message result = Message.fail();
			result.setMsg("两次密码输入不一致！请重新输入。");
			return result;
		}
		
		//用户注册
		else {
		UserExample userExample = new UserExample();
		Criteria criteria = userExample.createCriteria();
		criteria.andUsernameEqualTo(user.getUsername());
		List<User> check = userMapper.selectByExample(userExample);
		
		//检查用户名是否重复
        if(check.size()==0) {
        	userMapper.insertSelective(user);
        	Message result = Message.success();
			result.setMsg("注册成功！");
			return result;
        	}
		else
		{
			Message result = Message.fail();
			result.setMsg("用户名已存在！请重新输入。");
			return result;
			}
		
		}		
	}

}
