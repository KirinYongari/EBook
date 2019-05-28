package com.sample.controllers;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jhta.mvc.annotation.Controller;
import kr.co.jhta.mvc.annotation.RequestMapping;
import kr.co.jhta.mvc.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@RequestMapping("/home.do")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("home.jsp");
		
		return mav;
	}
}
