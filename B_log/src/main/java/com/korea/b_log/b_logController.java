package com.korea.b_log;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.LoginDAO;
import vo.LoginVO;

@Controller
public class b_logController {
	
	@Autowired
	LoginDAO login_dao;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = {"/"})
	public String login() {
		return "login_form.jsp";
	}//로그인 폼 이동
	

	@RequestMapping("/check.do")
	@ResponseBody
	public String check( Model model, String id, String pwd ) {
		
		
		System.out.println("---확인---" + id);
		
		
		
		LoginVO user = login_dao.selectOne(id);
		System.out.println("--user--" + user);
		String param = "";
		String resultStr = "";
		
		if ( user == null) {
			param = "no_id";
			resultStr = String.format("[{'resultStr':'%s'}]", param);
			return resultStr;
		}
		if (!user.getPwd().equals(pwd)) {
		
			param = "no_pwd";
			resultStr = String.format("[{'resultStr':'%s'}]", param);
			
		}
		
		System.out.println("if문 통과" + param);
		
		return resultStr;
	}
	
	@RequestMapping("/clear.do")
	public String clear() {
		return "main_content.jsp";
	}

}
