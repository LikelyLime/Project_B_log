package com.korea.b_log;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.LoginDAO;
import vo.LoginVO;

@Controller
public class b_logController {
	LoginDAO login_dao;
	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = {"/"})
	public String login() {
		return "login_form.jsp";
	}//로그인 폼 이동
	
	@RequestMapping("/check.do")
	public String check(String id, String pwd) {
				
		LoginVO user = login_dao.selectOne(id);
		String db_id = user.getId();
		String db_pwd = user.getPwd();
		
		if (db_id == null) {
			
		}
		
		
		return "main_contest.jsp";
	}

}
