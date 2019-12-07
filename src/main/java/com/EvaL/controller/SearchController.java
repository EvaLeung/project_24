package com.EvaL.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.EvaL.bean.Message;
import com.EvaL.service.SearchService;

@Controller
public class SearchController {
	
	@Autowired
	SearchService searchService;

	@RequestMapping("/ToSearch")
	public String ToSearch() {
		return "Search";
	}
	
	//关键词模糊搜索
	@RequestMapping(value="/DoSearch",method=RequestMethod.POST)
	@ResponseBody
	public Message DoSearch(@RequestParam(value="pn",defaultValue="1")Integer pn,@RequestParam(value="keyword")String keyword) {
		
		//System.out.print(searchService.SearchByKeyword(pn,keyword).getMsg());
		
		return searchService.SearchByKeyword(pn,keyword);
	}
	
	
	@RequestMapping("/ToShopView")
	public String ToShopView() {
		return "ShopView";
	}
	
	@RequestMapping("/ToItem")
	public String ToItem() {
		return "ItemDetail";
	}
	
	@RequestMapping(value="/ItemDetail",method=RequestMethod.POST)
	@ResponseBody
	public Message ItemDetail(Integer itemId) {	
		return searchService.ItemDetail(itemId);
	}
}
