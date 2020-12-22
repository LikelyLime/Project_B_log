<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function send() {
		
		var f = document.f;
		if (f.subject.value == '') {
			alert("제목을 입력하세요");
			return;
		}
		if (f.content.value == '') {
			alert("내용을 적어주세요");
			return;
		}
		
		f.action="insert.do";
		f.method="get";
		f.submit();
		
	}
</script>
</head>
<body>
	<form name="f" enctype="multipart/form-data">
		<table border="1" align="center">
			
			<tr>
				<th>제목</th>
				<td><input name="subject" style="width: 250px"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" rows="15" cols="70"></textarea>
				</td>
			</tr>		
			<tr>
				<th>사진 첨부</th>
				<td><input type="file" name="file"></td>
			</tr>
			
			<tr>
				<td align="center" colspan="3">
					<input type="hidden" name="id" value="${ check_login }">
					<input type="button" value="등록" onclick="send();">
					<input type="button" value="돌아가기" onclick="location.href='content.do'">
					
				</td>
				
			
			</tr>
		</table>
	</form>
</body>
</html>