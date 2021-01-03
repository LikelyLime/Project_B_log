package com.korea.b_log;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import common.Paging;
import dao.ContentDAO;
import dao.FriendDAO;
import dao.LoginDAO;
import dao.ReplyDAO;
import vo.ContentVO;
import vo.FriendVO;
import vo.LoginVO;
import vo.ReplyVO;

@Controller
public class b_logController {

	@Autowired
	ServletContext applicaion;
	
	@Autowired
	LoginDAO log_dao;
	
	@Autowired
	ContentDAO con_dao;

	@Autowired
	ReplyDAO rep_dao;
	
	@Autowired
	FriendDAO friend_dao;

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	SqlSession sqlsession;
	
	//수정창으로 이동
	@RequestMapping("/modify_form.do")
	public String modify_form( Model model, int idx ) {
		ContentVO vo = con_dao.selectOne(idx);
		if (vo != null) {
			model.addAttribute("vo", vo);
		}
		
		return "modify_form.jsp";
	}
	
	//수정하기
	@RequestMapping("/modify.do")
	public String modify( ContentVO vo, int idx ){
		ContentVO before = con_dao.selectOne(idx);
		
		if(!before.getPhoto().equals("no_file")) {

			String webPath = "/resources/upload/"+before.getId()+"/"+before.getPhoto();
			String savePath = applicaion.getRealPath(webPath);
			
			File file = new File(savePath);
			if (file.exists()) {
				file.delete();
			}
		}
		
		MultipartFile file = vo.getFile();
		String photo = "no_file";
		
		String webPath = "/resources/upload/"+before.getId()+"/";
		String savePath = applicaion.getRealPath(webPath);
		
		if (!file.isEmpty()) {
			photo = file.getOriginalFilename();//filename에 본 사진이름을 넣음
			
			File saveFile = new File(savePath, photo);
			
			if (!saveFile.exists()) {
				saveFile.mkdirs();//만약 폴더가 없으면 생성
			}else {
				long time = System.currentTimeMillis();
				photo = String.format("%d_%s", time, photo);
				saveFile = new File(savePath, photo);
			}
			//파일을 원래 저장형식으로 변환
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		vo.setPhoto(photo);
		
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		int res = con_dao.update(vo);
		
		return "redirect:content.do";
		
	}
	
	//게시글을 삭제한다
	@RequestMapping("/delete.do")
	public String delete(int idx) {
		
		ContentVO vo = con_dao.selectOne(idx);
		
		//파일명이 no_file이 아니면 저장된 이미지도 삭제한다
		if(!vo.getPhoto().equals("no_file")) {
			
			//이미지를 삭제하기 위해 경로를 구한다
			String webPath = "/resources/upload/"+vo.getId()+"/"+vo.getPhoto();
			String savePath = applicaion.getRealPath(webPath);
			
			//구한 경로에 있는 이미지를 삭제한다
			File file = new File(savePath);
			if(file.exists()){

				file.delete();

			}
			
		}
		
		//게시글 삭제시 게시글에 있는 댓글도 삭제
		rep_dao.delete_reply_all(idx);
		
		con_dao.delete(idx);
		
		return "redirect:content.do";
	}
	
	//글 상세보기 창
	@RequestMapping("/show_content.do")
	public String show_content(Model model, int idx, Integer page) {
		
		//로그인이 안되어 있다면 로그인 창으로
		String check_login = (String)session.getAttribute("check_login"); 
		if(check_login==null) {
			return "login/please_login.jsp";
		}
		
		//조회수 변경
		String readhit = (String)session.getAttribute("show_content");
		
		if(readhit==null) {
			session.setAttribute("show_content", "yes");
			con_dao.update_readhit(idx);
		}

		// 댓글 가져오기
		//List<ReplyVO> list = rep_dao.selectList(idx);

		//상세보기 글 가져오기
		ContentVO vo = con_dao.selectOne(idx);
		
		//페이지 처리
		int nowPage = 1; //기본페이지는 1페이지로!!
		
		if( page != null) {
			nowPage = page;
		}
		
		//한 페이지에 표시될 게시물의 시작과 끝번호를 계산
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST -1;
		
		//start와 end를 map에 저장
		Map<String , Integer> map = new HashMap<String, Integer>();
		map.put("idx", idx);
		map.put("start", start);
		map.put("end", end);
		
		List<ReplyVO> list = rep_dao.selectList( map );
		
		//전체 게시물의 갯수
		int row_total = rep_dao.getRowTotal(idx);
		
		//페이지 하단 메뉴 생성하기
		String pageMenu = Paging.getPaging("show_content.do", idx, nowPage, row_total, 
											Common.Board.BLOCKLIST, 
											Common.Board.BLOCKPAGE);

		model.addAttribute("vo", vo);
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		//상세보기창으로 이동
		return "content_view.jsp";
	}
	
	//블로그로 이동
	@RequestMapping(value = {"/content.do"})
	public String content(Model model, LoginVO l_vo) {
		
		//로그인이 안되어 있다면 로그인 창으로
		String check_login = (String)session.getAttribute("check_login");
		if(check_login==null) {
			return "login/please_login.jsp";
		}
		
		//조회수 증가를 위해 세션 수정
		session.removeAttribute("show_content");
		
		//이동하려는 블로그의 아이디를 가져온다
		String id = l_vo.getId();
		
		//이동하려는 아이디가 없다면 자기 자신의 아이디를 가져온다
		if(id==null) {
			id = check_login;
		}
		
		//친구 요청 목록을 가져온다
		List<FriendVO> will_friend_list = friend_dao.will_friend_list(check_login);
		
		//친구 목록을 가져온다
		List<FriendVO> friend_list = friend_dao.friend_list(check_login);
		
		//친구일때는 친구요청 창을 지운다
		boolean myFriend = false;
		
		for(int i=0; i<friend_list.size(); i++) {
			if(id.equals(friend_list.get(i).getFriend())) {
				myFriend = true;
				break;
			}
		}
		
		for(int i=0; i<will_friend_list.size(); i++) {
			if(id.equals(will_friend_list.get(i).getWill())) {
				myFriend = true;
				break;
			}
		}
		
		if(id.equals(check_login)) {
			myFriend = true;
		}
		
		//이동하려는 블로그의 글들을 가져온다
		List<ContentVO> list = con_dao.selectList(id);
		model.addAttribute("will_friend_list", will_friend_list);
		model.addAttribute("friend_list", friend_list);
		model.addAttribute("list", list);
		model.addAttribute("id", id);
		model.addAttribute("myFriend", myFriend);
		
		//블로그 창으로 이동
		return "content_list.jsp";
	}
	
	//아이디가 존재하는지 확인
	@RequestMapping("/check_id.do")
	@ResponseBody
	public String check_id(String id) {
		
		//확인하려는 아이디를 가지고 온다
		LoginVO vo = log_dao.selectOne(id);
		
		String res = "yes";
		
		//아이디가 없으면 no를 보낸다
		if(vo==null) {
			res = "no";
		}
		
		return res;
	}

	//새글 작성 페이지로 이동
	@RequestMapping("/insert_form.do")
	public String insert_form() {
		return "new_write.jsp";
	}
	
	//새글 넣기
	@RequestMapping("/insert.do")
	public String insert( ContentVO vo ) {
		
		//로그인이 안되어 있다면 로그인 창으로
		String check_login = (String)session.getAttribute("check_login");
		if(check_login==null) {
			return "login/please_login.jsp";
		}
		
		//----------------------vo에 ip,id 추가
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		vo.setId(check_login);
		
		//----------------------사진 업로드
		String webPath = "/resources/upload/"+check_login+"/";
		String savePath = applicaion.getRealPath(webPath);//절대경로
		//System.out.println(savePath);
		
		MultipartFile file = vo.getFile();
		String photo = "no_file";
		
		if (!file.isEmpty()) {
			photo = file.getOriginalFilename();//filename에 본 사진이름을 넣음
			
			File saveFile = new File(savePath, photo);
			
			if (!saveFile.exists()) {
				saveFile.mkdirs();//만약 폴더가 없으면 생성
			}else {
				long time = System.currentTimeMillis();
				photo = String.format("%d_%s", time, photo);
				saveFile = new File(savePath, photo);
			}
			//파일을 원래 저장형식으로 변환
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		vo.setPhoto(photo);
		
		con_dao.insert(vo);
		return "redirect:content.do";
	}
	
}
