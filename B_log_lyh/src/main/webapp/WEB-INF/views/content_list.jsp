<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${check_login }님의 블로그</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/content_list.css?ver2">
		<script src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
		<script type="text/javascript">
			
			//글 상세보기창으로 이동
			function show_content(idx) {
				location.href='show_content.do?idx='+idx;
			}
			
			//로그아웃
			function logout() {
				location.href='logout.do';
			}
			
			//아이디 검색
			function search() {
				var id = document.getElementById('search_id').value;
				var url = 'check_id.do';
				var param = 'id='+id;
				sendRequest(url, param, resFn, 'post');
			}
			
			//아이디 검색의 콜백 메서드
			//아이디가 존재하면 해당 아이디 블로그로 이동
			//존재하지 않는다면 경고창 생성
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
			
			<div class="title">
				<h1>
					<img class="blog_icon" src="${pageContext.request.contextPath }/resources/img/blog.png" onclick="location.href='content.do(${vo.idx})'">
				</h1>
				<h1>
					${check_login }님의 뉴스피드
				</h1>
			</div>
			<div align="left">
				<input id="search_id" placeholder="B_log 검색">
				<img class="search_icon" src="${pageContext.request.contextPath }/resources/img/search.GIF" onclick="search();">
			</div>
			<div align="right">
				<img class="new_icon" src="${pageContext.request.contextPath }/resources/img/new.GIF" onclick="location.href='insert_form.do'">
				<img class="myblog_icon" src="${pageContext.request.contextPath }/resources/img/myblog.GIF" onclick="">
				<img class="logout_icon" src="${pageContext.request.contextPath }/resources/img/logout.GIF" onclick="logout();">
			</div>
			<!-- 글이 존재하면 글을 출력한다 -->
			
			<div class="total_box">
			<c:if test="${list[0]!=null }">
				<c:forEach var="vo" items="${list }">
					<div class="b_log_box" style="cursor:pointer" onclick="show_content(${vo.idx})">
						<div class="type_name">${vo.id }</div>
						<div class="type_regdate">${vo.regdate }</div>
						<hr>
						<div class="type_subject">
							제목 : ${vo.subject }
						</div>
						<div class="type_content">
							<div class="type_content_write">
								<pre>${vo.content }</pre> <br>
							</div>
							<div class="type_content_photo"> 
								
								<c:if test="${vo.photo != null}">
									<img src="resources/upload/${check_login }/${vo.photo }" width="200">
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
			</div>
			<!-- 글입 존재하지 않으면 출력한다 -->
			<c:if test="${list[0]==null }">
				<div class="b_log_box" style="cursor: pointer;">
					<div class="type_subject"></div>
					<div class="type_content">작성된 글이 없습니다. 게시글을 눌러서 새로운 글을 작성해보세요</div>
					<div class="type_name"></div>
					<div class="type_regdate"></div>
				</div>
			</c:if>
		</div>
	</body>
</html>