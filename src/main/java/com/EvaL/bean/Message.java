package com.EvaL.bean;

import java.util.HashMap;
import java.util.Map;

public class Message {
	
	//状态码
	private int code;
	private String msg;
	
	//用户要返回给浏览器的数据
	private Map<String,Object> extend = new HashMap<String,Object>();
	
	public static Message success() {
		Message result = new Message();
		result.setCode(200);
		result.setMsg("处理成功！");
		return result;
	}
	
	public static Message fail() {
		Message result = new Message();
		result.setCode(100);
		result.setMsg("处理失败！");
		return result;
	}
	
	public Message add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	
}
