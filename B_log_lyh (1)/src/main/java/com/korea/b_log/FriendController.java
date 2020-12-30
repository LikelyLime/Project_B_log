package com.korea.b_log;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.FriendDAO;
import vo.FriendVO;

@Controller
public class FriendController {
	
	@Autowired
	FriendDAO friend_dao;

	@Autowired
	HttpSession session;
	
	//친구 요청 거절
	@RequestMapping("/noFriend.do")
	public String noFriend(FriendVO vo) {
		String check_login = (String)session.getAttribute("check_login"); 
		vo.setI(check_login);
		friend_dao.del_friend(vo);
		return "redirect:content.do";
	}
	
	//친구 요청 수락시 친구 추가
	@RequestMapping("/myFriend.do")
	public String myFriend(FriendVO vo) {
		String check_login = (String)session.getAttribute("check_login"); 
		vo.setI(check_login);
		friend_dao.myFriend(vo);
		return "redirect:content.do";
	}
	
	@RequestMapping("/willBeMyFriend.do")
	@ResponseBody
	public String willBeMyFriend(String id) {
		
		String check_login = (String)session.getAttribute("check_login"); 
		String res = id;
		
		List<FriendVO> list = friend_dao.iWantFriend(check_login);
		for(int i=0; i<list.size(); i++) {
			if(id.equals(list.get(i).getI())) {
				res = "no";
				break;
			}
		}
		return res;
	}
	
	//친구 요청
	@RequestMapping("/beMyFriend.do")
	public String beMyFriend(FriendVO vo) {
		String check_login = (String)session.getAttribute("check_login"); 
		vo.setI(check_login);
		friend_dao.beMyFriend(vo);
		return "redirect:content.do?id="+vo.getWill();
	}

}
