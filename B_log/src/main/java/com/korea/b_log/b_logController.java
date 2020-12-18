package com.korea.b_log;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class b_logController {
	
	@RequestMapping(value = {"/"})
	public String login() {
		
		return "home.jsp";
	}

}
