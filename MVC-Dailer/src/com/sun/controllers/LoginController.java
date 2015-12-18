package com.sun.controllers;


import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sun.commons.Tools;
import com.sun.service.LoginService;

@Controller
@RequestMapping("/login.do")
public class LoginController{
	
	 @Autowired  
	 @Qualifier("loginService") //注释指定注入 Bean 
	 private LoginService loginService;
	 	
	
		
	@RequestMapping(params = "method=login") 
    public String login(@RequestParam("loginName") String loginName

           ,@RequestParam("password") String password,HttpServletRequest request,ModelMap model) {

		String msg = "";
		Map map = new HashMap();
		Map rsMap = null;
		map.put("loginName", loginName);
		map.put("password", password);
        
		try {
			rsMap = loginService.checkLogin(map);
			
			if("false".equals(rsMap.get("flag"))){
				model.addAttribute("message", "登陆信息有误，请核对后登陆！"); 
				return "login";
			}
			
		Map userInfoMap = new HashMap();
 
				userInfoMap.put("operatorname", rsMap.get("operatorname"));
				userInfoMap.put("loginName", loginName);
				userInfoMap.put("password", password);
				userInfoMap.put("state", "" + rsMap.get("state"));
				userInfoMap.put("operatortype", "" + rsMap.get("operatortype"));
				userInfoMap.put("citycode", "" + rsMap.get("citycode"));
				userInfoMap.put("citycode2", "0");

				// 获取session和 application对象
				HttpSession session = request.getSession();
				ServletContext application = session.getServletContext();

				boolean first = (application.getAttribute("first") == null);
				String serverID = (String) application.getAttribute("serverid");
				if (serverID == null) {
					serverID = Tools.getProperty("serverid", "adsl");
					application.setAttribute("serverid", serverID);
				}
				session.setAttribute("userInfo", userInfoMap);

				application.setAttribute("first", first);


		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "登陆信息有误，请核对后登陆！"); 
			return "login";
		}
      

       return "menu";

    }



}
