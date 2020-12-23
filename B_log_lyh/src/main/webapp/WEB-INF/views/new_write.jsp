<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/new_write.css">
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
		f.method="post";
		f.submit();
		
	}
</script>
</head>
<body>
	<form name="f" enctype="multipart/form-data">
		<table class="table" align="center">
			<tr style="cursor:pointer;">
				<td>
					<img class="back_icon" src="${pageContext.request.contextPath }/resources/img/back2.GIF" title="뒤로가기" onclick="location.href='content.do'">
					<img class="file2" src="${pageContext.request.contextPath }/resources/img/file2.GIF" title="업로드">
					<input class="file1" type="file" name="file">
					<img class="insert_icon" src="${pageContext.request.contextPath }/resources/img/insert2.GIF" title="등록하기" onclick="send();">
				</td>
			</tr>
			
			<tr>
			
			
				<td><input name="subject" style="border: none" placeholder="스토리 제목을 적어주세요" style="width:250px" style="height:20px"></td>
			</tr>
			<tr>
				<td colspan="2">
				<hr>
					<textarea name="content" style="border: none" placeholder="무슨 생각을 하고 계신가요?" rows="15" cols="70"></textarea>
				</td>
			</tr>		
			<tr>
				
			</tr>
			

		</table>
	</form>
</body>
</html>