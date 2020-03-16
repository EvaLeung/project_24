package com.EvaL.service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.EvaL.bean.Administrator;
import com.EvaL.bean.AdministratorExample;
import com.EvaL.bean.AdministratorExample.Criteria;
import com.EvaL.bean.Item;
import com.EvaL.bean.ItemExample;
import com.EvaL.bean.Message;
import com.EvaL.bean.Sell_report;
import com.EvaL.bean.Stock_report;
import com.EvaL.dao.AdministratorMapper;
import com.EvaL.dao.ItemMapper;
import com.EvaL.dao.Sell_reportMapper;
import com.EvaL.dao.Stock_reportMapper;

@Service
public class AdminService {
	@Autowired
	AdministratorMapper adminMapper;
	
	@Autowired
	Stock_reportMapper stockreportMapper;
	
	@Autowired
	Sell_reportMapper sellreportMapper;
	
	@Autowired
	ItemMapper itemMapper;

	public Message GetAdminInfo(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
	    String username = (String)session.getAttribute("AdminUsername");
		
		AdministratorExample adminExample = new AdministratorExample();
		Criteria criteria =  adminExample.createCriteria();
		criteria.andAdminUsernameEqualTo(username);
		List<Administrator> result = adminMapper.selectByExample(adminExample);
		
		if(result.size()>0) {
			Administrator admin = result.get(0);	
			return Message.success().add("info", admin);
		}
		else {
			return Message.fail();
		}
	}

	public Message GetStockReport() {
		List<Stock_report> report = stockreportMapper.selectByExample(null);
		List<Item> items = itemMapper.selectByExample(null);
		
		if(report.size()>0) {
			for(int i = 0;i<items.size();i++) {
				items.get(i).setItemCount(report.get(i).getItemCount());
			}
			return Message.success().add("report", items);
		}
		else {
			return Message.fail();
		}
	}

	public Message GetSellReport() {
		List<Sell_report> report = sellreportMapper.selectByExample(null);
		List<Item> items = itemMapper.selectByExample(null);
		
		if(report.size()>0) {
			for(int i = 0;i<report.size();i++) {
				report.get(i).setDetail(items.get(i));
			}
			return Message.success().add("report", report);
		}
		else {
			return Message.fail();
		}
	}

	public Message GetFinanceReport() {
		List<Sell_report> report = sellreportMapper.selectByExample(null);
		List<Item> items = itemMapper.selectByExample(null);
		
		if(report.size()>0) {
			for(int i = 0;i<report.size();i++) {
				report.get(i).setDetail(items.get(i));
			}
			return Message.success().add("report", report);
		}
		else {
			return Message.fail();
		}
	}


	public Message DoSubmit(MultipartFile file,HttpServletRequest request,String itemName, String itemTag, String producer, String batchNumber,
			BigDecimal price, String detail,Integer count) throws Exception{
		try {
			Item newItem = new Item();
			//获取文件名
            String fileName = file.getOriginalFilename();
            //文件存入存放图片地址
            String path = "D:/Java_Workspace/project_24/src/main/webapp/source/item_img/";
            System.out.println(path);
            //判断接收的文件为不为空
            if(!file.isEmpty() && null != itemName&& null != itemTag&& null !=producer&& null !=batchNumber&& null !=price&& null !=detail){
                //获取新的文件名字
                String newName = UUID.randomUUID()+fileName.substring(fileName.lastIndexOf("."));
                File newFile = new File(path+newName);
                //将文件写入到存放的地址
                file.transferTo(newFile);
                //对数据库进行操作
                newItem.setItemName(itemName);
                newItem.setPicUrl("source/item_img/"+newName);
                newItem.setItemTag(itemTag);
                newItem.setProducer(producer);
                newItem.setBatchNumber(batchNumber);
                newItem.setPrice(price);
                newItem.setDetail(detail);
                itemMapper.insert(newItem);
                
                ItemExample itemExample = new ItemExample();
                com.EvaL.bean.ItemExample.Criteria criteria= itemExample.createCriteria();
                criteria.andItemNameEqualTo(itemName);
                Item result = itemMapper.selectByExample(itemExample).get(0);
                Stock_report stock = new Stock_report();
                stock.setItemCount(count);
                stock.setUpdateTime(new Date());
                stock.setItemId(result.getItemId());
                stockreportMapper.insert(stock);
                return Message.success();
            }else {
            	return Message.fail();
            }
			
		}catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public Message GetItemList() {
		List<Item> list = itemMapper.selectByExample(null);
		if(list.size()!=0) {
			return Message.success().add("list", list);
		}
		else {
			return Message.fail();
		}
	}

	public Message UpdateItemInfo(MultipartFile file, HttpServletRequest request,Integer itemId,String itemName, String itemTag,
			String producer, String batchNumber, BigDecimal price, String detail, Integer count){
		try {
		Item item = itemMapper.selectByPrimaryKey(itemId);
		Stock_report stock = stockreportMapper.selectByPrimaryKey(itemId);
		 if(!file.isEmpty()) {
	         //文件存入路径
	         String path = "D:/Java_Workspace/project_24/src/main/webapp";
	         //获取数据库中文件名
	         String name = item.getPicUrl();
	         File newFile = new File(path+"/"+name);
             //将文件写入到存放的地址
             file.transferTo(newFile);
		  }
		  item.setItemName(itemName);
		  item.setItemTag(itemTag);
		  item.setProducer(producer);
		  item.setBatchNumber(batchNumber);
		  item.setPrice(price);
		  item.setDetail(detail);
		  stock.setItemCount(count);
		  stock.setUpdateTime(new Date());
		  //更新数据库数据
		  itemMapper.updateByPrimaryKeySelective(item);
		  stockreportMapper.updateByPrimaryKeySelective(stock);
		  return Message.success();
		  }
		  catch (Exception e){
			 return Message.fail();
		  }

	}
}
