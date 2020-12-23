<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<html>
	<head>
	<meta charset="UTF-8">
	<title>http://www.blueb.co.kr</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/login_form.css">
	<script src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
		
		//아이디와 비밀번호의 유효성을 검사하고 DB에 넣는다
		function send( f ){
			var id = f.id.value;
			var pwd = f.pwd.value;
			
			if(id==''){
				alert("아이디를 입력해주세요.");
				return;
			}
			
			if(pwd==''){
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			var url = "join.do";
			var param = "id=" + id + "&pwd=" + pwd;
			sendRequest(url, param, resultFn, "post");
			
		}
		
		//이미 존재하던 아이디면 경고창을 띄우고 회원가입이 성공하면 로그인창으로 이동한다
		function resultFn() {
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				
				if( data == 'no' ){
					alert("중복된 아이디가 존재합니다");
					return;
				}
				
				alert("회원가입 성공!");
				location.href = 'login.do';
				
			}
		} 
		
	</script>
</head>
<body>

<form class="signUp" id="signupForm">
   <h1 class="signUpTitle">회원가입 창</h1>
   <input type="text" name="id" class="signUpInput" placeholder="아이디를 입력해 주세요" autofocus required>
   <input type="password" name="pwd" class="signUpInput" placeholder="비밀번호를 입력해 주세요" required>
   <input type="button" onclick="send(this.form);" value="회원가입" class="signUpButton">
   <a href="login.do">돌아가기</a>
</form>

</body>
</html>