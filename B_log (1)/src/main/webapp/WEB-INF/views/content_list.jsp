<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${list[0].id }님의 블로그</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/content_list.css">
		<script src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
		<script type="text/javascript">
		
			function show_content(idx) {
				location.href='show_content.do?idx='+idx;
			}
			
			function logout() {
				location.href='logout.do';
			}
			
			function search() {
				var id = document.getElementById('search_id').value;
				var url = 'check_id.do';
				var param = 'id='+id;
				sendRequest(url, param, resFn, 'post');
			}
			
			function resFn() {
				if(xhr.readyState==4&&xhr.status==200) {
					
					var id = document.getElementById('search_id').value;
					
					var data = xhr.responseText;
					
					if(data=='yes') {
						location.href='content.do?id='+id;
					}else {
						alert('존재하지 않는 아이디 입니다.');
					}
				}
			}
		</script>
	</head>
	<body>
		
		<div id="main_box">
			<h1 align="center">:::${list[0].id }의 스토리:::</h1>
			<div align="center">
				<input id="search_id">
				<input type="button" value="찾기" onclick="search();">
				<input type="button" value="새글쓰기" onclick="location.href='insert_form.do'">
				<input type="button" value="로그아웃" onclick="logout();">
			</div>
			<c:forEach var="vo" items="${list }">
				<div class="b_log_box" style="cursor: pointer;" onclick="show_content(${vo.idx})">
					<div class="type_name">${vo.id }(${vo.regdate })</div>
					<div class="type_regdate">작성일 : ${vo.regdate }</div>
					<div class="type_content"> 
						<pre>${vo.content }</pre> <br>
						
						<c:if test="${vo.photo != null}">
							<img src="resources/upload/${vo.photo }" width="100">
						</c:if>
					<div class="type_subject">
						제목 : ${vo.subject }
					</div>
					</div>
					<div align="center">
						<form>
							<input type="hidden" name="idx" value="${vo.idx }">
							<input type="button" value="댓글" onclick="show(${vo.idx})">
						</form>
					</div>
				</div>
			</c:forEach>
		</div>
	</body>
</html>