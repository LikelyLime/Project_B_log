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
import vo.ContentVO;
import vo.LoginVO;

@Controller
public class b_logController {
	
	@Autowired
	ContentDAO con_dao;
	
	@Autowired
	ServletContext applicaion;//사진 등록
	
	@Autowired
	HttpSession session;
	
	@Autowired
	SqlSession sqlsession;
	
	@Autowired
	HttpServletRequest request;
	
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
	
	@RequestMapping("/insert_form.do")
	public String insert_form( LoginVO vo ) {
		
		return "new_write.jsp";
	}
	
	@RequestMapping("/insert.do")
	public String insert( ContentVO vo ) {
		
		//----------------------vo에 ip 추가
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		//----------------------사진 업로드
		String webPath = "/resources/upload/";
		String savePath = applicaion.getRealPath(webPath);//절대경로
		System.out.println(savePath);//경로 확인
		
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
