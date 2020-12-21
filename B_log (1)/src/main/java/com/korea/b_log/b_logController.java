package com.korea.b_log;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ContentDAO;
import vo.ContentVO;
import vo.LoginVO;

@Controller
public class b_logController {
	
	@Autowired
	ContentDAO con_dao;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	SqlSession sqlsession;
	
	@RequestMapping("/show_content.do")
	public String show_content(Model model, int idx) {
		
		ContentVO vo = con_dao.selectOne2(idx);
		model.addAttribute("vo", vo);
		
		return "content_view.jsp";
	}
	
	@RequestMapping(value = {"/", "/login.do"})
	public String login() {

		String check_login = (String)session.getAttribute("check_login");
		if(check_login!=null) {
			return "redirect:content.do";
		}
		
		return "login_form.jsp";
	}
	
	@RequestMapping("/check_login.do")
	@ResponseBody
	public String check_login( Model model, String id, String pwd ) {
		
		LoginVO user = con_dao.selectOne(id);
		String resultStr = "";
		
		if ( user == null) {
			resultStr = "no_id";
			return resultStr;
		}
		if (!user.getPwd().equals(pwd)) {
			resultStr = "no_pwd";
			return resultStr;
		}
		
		resultStr = "yes";
		session.setAttribute("check_login", user.getId());
		
		return resultStr;
	}

	@RequestMapping(value = {"/content.do"})
	public String content(Model model, LoginVO l_vo) {
		
		String check_login = (String)session.getAttribute("check_login"); 
		
		if(check_login==null) {
			return "please_login.jsp";
		}
		
		String id = l_vo.getId();
		
		if(id==null) {
			id = check_login;
		}
		
		List<ContentVO> list = con_dao.selectList(id);
		model.addAttribute("list", list);
		return "content_list.jsp";
	}
	
	@RequestMapping("/logout.do")
	public String logout() {
		session.removeAttribute("check_login");
		return "redirect:login.do";
	}
	
	@RequestMapping("/check_id.do")
	@ResponseBody
	public String check_id(String id) {
		LoginVO vo = con_dao.selectOne(id);
		
		String res = "yes";
		if(vo==null) {
			res = "no";
		}
		
		return res;
	}
	
}
