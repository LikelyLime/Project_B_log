<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		var url = "check.do";
		var param = "id=" + id + "&pwd=" + pwd;
		sendRequest(url, param, result, "get");
		 }
	
	function result() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = eval(data);
			
			if (json[0].param == 'no_id') {
				alert("아이디가 존재하지 않습니다.");
				return;
			}else if(json[0].param == 'no_pwd'){
				alert("비밀번호가 다릅니다.");
				return;
			}else{
				
			}
			
		}
	}
	
</script>
</head>
<body>
	<form name="f" method="get"><!-- 이따가 post로 진행 -->
		<table border="1" align="center">
			<caption>:::로그인 페이지:::</caption>
			<tr>
				<th>아이디</th>
				<td><input name="id"></td>
			</tr>
			
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd"></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="로그인" onclick="login(this.form);">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>