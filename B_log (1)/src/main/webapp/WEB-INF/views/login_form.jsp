<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home</title>
		<style type="text/css">
			h1 {
				text-align: center;
			}
			
			table {
				margin: auto;
			}
		</style>
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
	<br><br><br><br><br><br><br>
   <h1>Hello world!</h1>

   <form action="login.jsp" method="post">
      <table border="0" width="200" height="100">
         <tr bgcolor="#025059">
            <td align="center"><font size=2 color="white">아이디</font></td>
            <td><input type="text" name="id" size="14"></td>
         </tr>
         
         <tr bgcolor="#025059">
            <td align="center"><font size=2 color="white">비밀번호</font></td>
            <td><input type="password" name="pwd" size="14"></td>
         </tr>
         <tr>
            <td colspan="2" align="center">
            <input type="button" value="로그인" onclick="login(this.form);">
			<input type="reset" value="취소">
         </tr>
      </table>
   </form>
</body>
</html>