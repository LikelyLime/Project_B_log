<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/new_write.css">
<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script type="text/javascript">
	function send(f) {
		
		var f = document.f;
		if (f.subject.value == '') {
			alert("제목을 입력하세요");
			return;
		}
		if (f.content.value == '') {
			alert("내용을 적어주세요");
			return;
		}
		
		var url = "modify.do";
		var param = "idx=" + f.idx.value + "&subject=" + f.subject.value
					+ "&content=" + encodeURIComponent(f.content.value)
					+ "&photo=" + f.file.value;
		sendRequest( url, param, resultFn, "post" );
		
	}
	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			alert(data)
			
			if (data == 'no') {
				alert("수정 실패");
				return;
			}
			alert("수정을 완료하였습니다.")
			location.href = "content.do";
			
		}
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
		<table class="table" align="center">
			<tr style="cursor:pointer;">
				<td>
					<input type="hidden" name="idx" value="${vo.idx}">
					<img class="back_icon" src="${pageContext.request.contextPath }/resources/img/back2.GIF" title="뒤로가기" onclick="back(this.form);">
					<img class="file2" src="${pageContext.request.contextPath }/resources/img/file2.GIF" title="업로드">
					<input class="file1" type="file" name="file">
					<img class="insert_icon" src="${pageContext.request.contextPath }/resources/img/insert2.GIF" title="수정하기" onclick="send();">
				</td>
			</tr>
			
			<tr>
			
			
				<td><input name="subject" style="border: none" style="width:250px" value="${ vo.subject }" style="height:20px"></td>
			</tr>
			<tr>
				<td colspan="2">
				<hr>
					<textarea name="content" style="border: none" placeholder="무슨 생각을 하고 계신가요?" rows="15" cols="70">${ vo.content }</textarea>
				</td>
			</tr>		
			<tr>
				
			</tr>
			

		</table>
	</form>
</body>
</html>