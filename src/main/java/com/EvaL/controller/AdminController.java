package com.EvaL.controller;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.EvaL.bean.Message;
import com.EvaL.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;

	@RequestMapping("/ToAdminView")
	public String ToAdminView() {
		return "AdminView";
	}
	
	@RequestMapping("/GetAdminInfo")
	@ResponseBody
	public Message GetAdminInfo(HttpServletRequest request) {
		return adminService.GetAdminInfo(request);
	}
	
	@RequestMapping("/ToStockReport")
	public String ToStockReport() {
		return "StockReport";
	}
	
	@RequestMapping("/GetStockReport")
	@ResponseBody
	public Message GetStockReport() {
		return adminService.GetStockReport();
	}
	
	@RequestMapping("/ToSellReport")
	public String ToSellReport() {
		return "SellReport";
	}
	
	@RequestMapping("/GetSellReport")
	@ResponseBody
	public Message GetSellReport() {
		return adminService.GetSellReport();
	}
	
	@RequestMapping("/ToFinanceReport")
	public String ToFinanceReport() {
		return "FinanceReport";
	}
	
	@RequestMapping("/GetFinanceReport")
	@ResponseBody
	public Message GetFinanceReport() {
		return adminService.GetFinanceReport();
	}
	
	@RequestMapping("/ToAddItem")
	public String ToAddItem() {
		return "AddItem";
	}
	
	@RequestMapping("/DoSubmit")
	@ResponseBody
	public Message DoSubmit(@RequestParam(value="pic",required = false)MultipartFile file,HttpServletRequest request,String itemName,String itemTag,String producer,String batchNumber,BigDecimal price,String detail,Integer count) throws Exception {
			return adminService.DoSubmit(file,request,itemName,itemTag,producer,batchNumber,price,detail,count);

	}
	
	@RequestMapping("/GetItemList")
	@ResponseBody
	public Message GetItemList() {
		return adminService.GetItemList();
	}
	
	@RequestMapping("/ToUpdateItem")
	public String ToUpdateItem() {
		return "UpdateItemList";
	}
	
	@RequestMapping("/UpdateItem")
	public String UpdateItem() {
		return "UpdateItem";
	}
	
	@RequestMapping("/UpdateItemInfo")
	@ResponseBody
	public Message UpdateItemInfo(@RequestParam(value="pic",required = false)MultipartFile file,HttpServletRequest request,Integer ItemId,String itemName,String itemTag,String producer,String batchNumber,BigDecimal price,String detail,Integer count) throws Exception {
			return adminService.UpdateItemInfo(file,request,ItemId,itemName,itemTag,producer,batchNumber,price,detail,count);

	}
	
	@RequestMapping("/AdminLogOut")
	public String LogOut(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		session.removeAttribute("AdminUsername");
		return "redirect:/MainView.jsp";
	}
}
