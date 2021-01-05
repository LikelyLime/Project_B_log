package com.korea.b_log;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.LoginDAO;
import vo.LoginVO;

@Controller
public class LoginController {
	

	@Autowired
	LoginDAO log_dao;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	SqlSession sqlsession;
	
	//로그인 창으로 이동
	@RequestMapping(value = {"/", "/login.do"})
	public String login() {
		
		//로그인이 되어 있다면 블로그 창으로 이동
		String check_login = (String)session.getAttribute("check_login");
		if(check_login!=null) {
			return "redirect:content.do";
		}
		
		//로그인 창으로 이동
		return "login/login_form.jsp";
	}
	
	//로그인
	@RequestMapping("/check_login.do")
	@ResponseBody
	public String check_login( Model model, String id, String pwd ) {
		
		//아이디로 DB에 저장되어 있는 정보를 가지고 온다.
		LoginVO user = log_dao.selectOne(id);
		
		String resultStr = "";
		
		//저장된 아이디가 없는 경우
		if ( user == null) {
			resultStr = "no_id";
			return resultStr;
		}
		//가지고 온 비밀번호가 입력된 비밀번호가 틀린 경우 
		if (!user.getPwd().equals(pwd)) {
			resultStr = "no_pwd";
			return resultStr;
		}
		
		//아이디와 비밀번호가 일치하는 경우
		resultStr = "yes";
		
		//로그인 확인과 추후에 사용하기 위해 세션에 아이디를 저장해 둔다.
		session.setAttribute("check_login", user.getId());
		
		return resultStr;
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public String logout() {
		session.removeAttribute("check_login");
		return "redirect:login.do";
	}
	
	//회원가입창으로 이동
	@RequestMapping("/write.do")
	public String write() {
		return "login/join_form.jsp";
	}
	
	//회원 추가
	@RequestMapping("/join.do")
	@ResponseBody
	public String join(LoginVO vo) {
		
		//아이디로 DB에 저장되어 있는 정보를 가지고 온다.
		LoginVO user = log_dao.selectOne(vo.getId());
		
		String result="no";
		
		//입력된 정보가 없으면 정보를 저장한다.
		if (user == null) {
			result="yes";
			log_dao.insert(vo);
		}
		
		return result;
	}
	
}
