package com.korea.b_log;

import java.io.File;
import java.io.IOException;
import java.util.List;

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

import dao.ContentDAO;
import dao.LoginDAO;
import vo.ContentVO;
import vo.LoginVO;

@Controller
public class b_logController {

	@Autowired
	ServletContext applicaion;
	
	@Autowired
	LoginDAO log_dao;
	
	@Autowired
	ContentDAO con_dao;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	SqlSession sqlsession;
	
	//글 상세보기 창
	@RequestMapping("/show_content.do")
	public String show_content(Model model, int idx) {
		
		//로그인이 안되어 있다면 로그인 창으로
		String check_login = (String)session.getAttribute("check_login"); 
		if(check_login==null) {
			return "please_login.jsp";
		}
		
		//상세보기 글 가져오기
		ContentVO vo = con_dao.selectOne(idx);
		
		model.addAttribute("vo", vo);
		
		//상세보기창으로 이동
		return "content_view.jsp";
	}
	
	//블로그로 이동
	@RequestMapping(value = {"/content.do"})
	public String content(Model model, LoginVO l_vo) {
		
		//로그인이 안되어 있다면 로그인 창으로
		String check_login = (String)session.getAttribute("check_login");
		if(check_login==null) {
			return "please_login.jsp";
		}
		
		//이동하려는 블로그의 아이디를 가져온다
		String id = l_vo.getId();
		
		//이동하려는 아이디가 없다면 자기 자신의 아이디를 가져온다
		if(id==null) {
			id = check_login;
		}
		
		//이동하려는 블로그의 글들을 가져온다
		List<ContentVO> list = con_dao.selectList(id);
		model.addAttribute("list", list);
		
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
			return "please_login.jsp";
		}
		
		//----------------------vo에 ip,id 추가
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		vo.setId(check_login);
		
		//----------------------사진 업로드
		String webPath = "/resources/upload/"+check_login+"/";
		String savePath = applicaion.getRealPath(webPath);//절대경로
		System.out.println(savePath);
		
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
