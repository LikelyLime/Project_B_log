<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<html>
	<head>
	<meta charset="UTF-8">
	<title>http://www.blueb.co.kr</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/login_form.css">
	<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
			function login(f) {
				/* 값 받기 */
				var id = f.id.value;
				var pwd = f.pwd.value;
				//alert(id);
				/* 유효성 체크 */
				if (id == '') {
					alert("아이디를 입력하세요.");
					return;
				}
				if (pwd == '') {
					alert("비밀번호 입력은 필수 입니다.");
					return;
				}
				
				/* 값 보내기 */
				var url = "check_login.do";
				var param = "id=" + id + "&pwd=" + pwd;
				sendRequest(url, param, result, "get");
				 }
			
			function result() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					
					var data = xhr.responseText;
					
					if (data == 'no_id') {
						alert("아이디가 존재하지 않습니다.");
						
					}else if(data == 'no_pwd'){
						alert("비밀번호가 다릅니다.");
						
					}else{
						location.href = 'content.do';
					}
					
					
				}
			}
			
		</script>
</head>
<body>

<form class="signUp" id="signupForm">
   <h1 class="signUpTitle">B_log</h1>
   <input type="text" name="id" class="signUpInput" placeholder="아이디를 입력해 주세요" autofocus required>
   <input type="password" name="pwd" class="signUpInput" placeholder="비밀번호를 입력해 주세요" required>
   <input type="button" onclick="login(this.form);" value="Sign me up!" class="signUpButton">
   <a href="write.do">회원가입</a>
</form>

</body>
</html>
