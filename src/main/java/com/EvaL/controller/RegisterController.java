package com.EvaL.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RegisterController {
	
	@RequestMapping("/ToRegister")
	public String ToRsgister() {
		return "Register";
	}

}
