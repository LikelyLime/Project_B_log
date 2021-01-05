<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/new_write.css">
<script type="text/javascript">
	function send(f) {
		var f = document.f;
		if (f.subject.value == '') {
			alert("제목을 입력하세요");
			return;
		}
		
		if (f.subject.value.length > 100 ) {
	         alert("제목의 글자수는 100자로 제한됩니다.");
	         return;
	      }
		
		if (f.content.value == '') {
			alert("내용을 적어주세요");
			return;
		}
		
		f.action="modify.do";
		f.method="post";
		f.submit();
	}
	
	function back() {
		f.action = 'show_content.do';
		f.method = 'get';
		f.submit();
	}
</script>
</head>
<body>
	<form name="f" enctype="multipart/form-data">
		<table class="table_icon">
			<tr style="cursor:pointer;">
				<td>
					<div class="icon">
						<input type="hidden" name="idx" value="${ vo.idx }">
						<div><img class="back_icon" src="${pageContext.request.contextPath }/resources/img/back2.GIF" title="뒤로가기" onclick="location.href='show_content.do?idx=${vo.idx}'"></div>
						<div class="details1"><p>뒤로가기</p></div>
					</div>
				</td>
				<td>
					<div class="icon">
						<img class="file2" src="${pageContext.request.contextPath }/resources/img/file2.GIF" title="업로드">
						<input class="file1" type="file" name="file">
						<div class="details2"><p>업로드</p></div>
					</div>
				</td>
				<td>
					<div class="icon">
						<img class="insert_icon" src="${pageContext.request.contextPath }/resources/img/insert2.GIF" title="등록하기" onclick="send();">
						<div class="details3"><p>등록하기</p></div>
					</div>	
				</td>
			</tr>
		</table>
		<table class="table">	
			
			<tr>
				<td><input name="subject" style="border: none" value="${ vo.subject }"  size="148"></td>
			</tr>
			<tr>
				<td colspan="2">
				<hr>
					<textarea name="content" style="border: none" placeholder="무슨 생각을 하고 계신가요?" rows="30" cols="150">${ vo.content }</textarea>
				</td>
			</tr>		
			<tr>
				
			</tr>
			

		</table>
	</form>
</body>
</html>