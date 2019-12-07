package com.EvaL.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.EvaL.bean.Item;
import com.EvaL.bean.ItemExample;
import com.EvaL.bean.ItemExample.Criteria;
import com.EvaL.bean.Message;
import com.EvaL.bean.Stock_report;
import com.EvaL.dao.ItemMapper;
import com.EvaL.dao.Stock_reportMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class SearchService {
	
	@Autowired
	ItemMapper itemMapper;

	@Autowired
	Stock_reportMapper stockReportMapper;
	
	public Message SearchByKeyword(Integer pn,String keyword) {
		ItemExample itemExample = new ItemExample();
		Criteria criteria = itemExample.createCriteria();
		
		keyword = "%"+keyword+"%";
		criteria.andItemNameLike(keyword);
		//在查询之前只需要调用，传入页码，以及分页大小
		PageHelper.startPage(pn,16);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Item> items = itemMapper.selectByExample(itemExample);
		if(items.size() != 0) {
			//使用PageInfo包装查询后的结果
			//可以传入连续显示的页数
			PageInfo page = new PageInfo(items,5);
			return Message.success().add("pageInfo", page);
		}
		else {
			return Message.fail();
		}
	}

	public Message ItemDetail(Integer itemId) {	
		Item item = itemMapper.selectByPrimaryKey(itemId);
		Stock_report count = stockReportMapper.selectByPrimaryKey(itemId);
		
		Integer num = count.getItemCount();
		if(num!=null) {
			item.setItemCount(num);
		}
		
		return Message.success().add("Item", item);
	}

}
