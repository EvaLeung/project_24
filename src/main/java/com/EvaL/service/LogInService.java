package com.EvaL.service;

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

}
