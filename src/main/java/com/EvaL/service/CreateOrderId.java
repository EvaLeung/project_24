package com.EvaL.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class CreateOrderId {
	
	public static String getOrder_Id()
	{
		String order_id;
		SimpleDateFormat sfDate = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String strDate = sfDate.format(new Date());
		String random = getRandom620(3);
		order_id = strDate+random; 
		return order_id;
	}
	
	/**
	 * 获取6-10 的随机位数数字
	 * @param length	想要生成的长度
	 * @return result
	 */
	public static String getRandom620(Integer length) {
		String result = "";
		Random rand = new Random();
		int n = 20;
		if (null != length && length > 0) {
			n = length;
		}
		int randInt = 0;
		for (int i = 0; i < n; i++) {
			randInt = rand.nextInt(10);
			result += randInt;
		}
		return result;
	}
}