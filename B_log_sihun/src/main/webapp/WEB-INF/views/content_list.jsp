<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${id }님의 블로그</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/content_list.css?f">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/content_list.js?b"></script>
	</head>
	<body>
		<div id="head_box">
			<h1>:::${id }님의 게시글:::</h1>
			<div align="center">
				<input id="search_id">
				<input type="button" value="찾기" onclick="search();">
				<input type="button" value="새글쓰기" onclick="location.href='insert_form.do'">
				<input type="button" value="내 글 보기" onclick="location.href='content.do?id=${check_login}'">
				<c:if test="${!myFriend }">
					<input type="button" value="친구 요청" onclick="willBeMyFriend('${id }');">
				</c:if>
				<input type="button" value="로그아웃" onclick="logout();">
			</div>
			<!-- 친구 창 -->
			<div class="friends_box" align="center">
				<div class="friends1">
					<ul>
						<li>친구 요청창</li>
						<c:if test="${will_friend_list!=null }">
							<c:forEach var="vo" items="${will_friend_list }">
								<li> <a onclick="beMyFriend('${vo.will}');">${vo.will }</a> </li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
				<div class="friends2">
					<ul>
						<li>친구 선택창</li>
						<c:if test="${friend_list!=null }">
							<c:forEach var="vo" items="${friend_list }">
								<li> <a href="content.do?id=${vo.friend }">${vo.friend }</a> </li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div id="main_box">
			<!-- 글이 존재하면 글을 출력한다 -->
			<c:if test="${list[0]!=null }">
				<c:forEach var="vo" items="${list }">
					<div class="b_log_box" style="cursor: pointer;" onclick="show_content(${vo.idx})">
						<div class="type_name">${vo.id }</div>
						<div class="type_regdate">${vo.regdate }</div>
						<hr>
						<div class="type_subject">
							<pre>제목 : ${vo.subject }</pre>
						</div>
						<div class="type_content">
							<div class="type_content_write">
								<pre>${vo.content }</pre>
							</div>
							<div class="type_content_photo"> 
								<c:if test="${vo.photo != 'no_file'}">
									<img src="${pageContext.request.contextPath }/resources/upload/${vo.id }/${vo.photo }" width="200">
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${list[0]==null }">
			<!-- 글이 존재하지 않고 자신의 블로그이면 출력한다 -->
				<c:if test="${check_login==id }">
					<div class="b_log_box" style="cursor: pointer;" onclick="location.href='insert_form.do'">
						<div class="type_subject"></div>
						<div class="type_content">작성된 글이 없습니다. 게시글을 눌러서 새로운 글을 작성해보세요</div>
						<div class="type_name"></div>
						<div class="type_regdate"></div>
					</div>
				</c:if>
			<!-- 글이 존재하지 않고 자시의 블로그가 아니면 출력한다 -->
				<c:if test="${check_login!=id }">
					<div class="b_log_box">
						<div class="type_subject"></div>
						<div class="type_content">작성된 글이 없습니다. 게시글을 눌러서 새로운 글을 작성해보세요</div>
						<div class="type_name"></div>
						<div class="type_regdate"></div>
					</div>
				</c:if>
			</c:if>
		</div>
		<div id="backtotop">
			go to top
		</div>
	</body>
</html>