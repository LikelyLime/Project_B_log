package com.korea.b_log;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.LoginDAO;
import dao.ReplyDAO;
import vo.LoginVO;
import vo.ReplyVO;

@Controller
public class ReplyController {
	

	@Autowired
	ServletContext applicaion;

	@Autowired
	LoginDAO log_dao;

	@Autowired
	ReplyDAO rep_dao;

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	@Autowired
	SqlSession sqlsession;
	
	//대댓글 작성
	@RequestMapping("/rep_rep.do")
	public String rep_rep(ReplyVO vo) {
			
		// 접속자의 ip
		String ip = request.getRemoteAddr();

		// DAO로 전달할 파라미터들을 vo에 포장
		vo.setIp(ip);
			
		ReplyVO baseVO = rep_dao.selectOne(vo.getRef()); 
		int res = rep_dao.update_step( baseVO );
			
		//댓글일시 step+1
		vo.setStep(baseVO.getStep()+1);
		vo.setRef(baseVO.getIdx());
			
		rep_dao.rep_insert(vo);
			
		return "redirect:show_content.do?idx=" + vo.getIdx();
	}
		 
	// 댓글작성
	@RequestMapping("/rep_insert.do")
	public String insert(ReplyVO vo) {
			
		// 접속자의 ip
		String ip = request.getRemoteAddr();
		
		// DAO로 전달할 파라미터들을 vo에 포장
		vo.setIp(ip);
		vo.setRef(vo.getIdx());
			
		rep_dao.insert(vo);

		return "redirect:show_content.do?idx=" + vo.getIdx();
	}

	// 댓글삭제
	@RequestMapping("/rep_delete.do")
	public String delete_reply(int idx) {

		ReplyVO vo = rep_dao.selectOne(idx);

		rep_dao.delete(idx);

		return "redirect:show_content.do?idx=" + vo.getPerIdx();
	}
	
	
	
}
