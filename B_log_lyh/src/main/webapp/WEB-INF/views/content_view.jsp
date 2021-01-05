<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${ vo.subject }</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/content_view.css">
		<script type="text/javascript">
			function del(idx) {
				if(confirm('정말 삭제 하시겠습니까?')) {
					location.href = 'delete.do?idx='+idx;
				}
				
			}
			
			//댓글 추가
			function send_rep( f ){
				var content = f.content.value.trim();
								
				if(content==''){
					alert("댓글 내용을 입력해주세요!");
					return;
				}
				
				if (content.length > 100 ) {
	                  alert("제목의 글자수는 100자로 제한됩니다.");
	                  return;
	             }
				
				f.action = "rep_insert.do";
				f.method = "post";
				f.submit();
			}
			//댓글 삭제
			function del_rep(idx){
				
				if(confirm('정말 삭제 하시겠습니까?')) {
					location.href = 'rep_delete.do?idx='+idx;
				}
				
			} 
			
			//대댓글 보이기
			function view(idx){
				
				b_show = 
					document.getElementById("rep_button_"+idx).type=='hidden'?true:false;
				//댓글 버튼
				document.getElementById("bt_show_"+idx).value = 
					b_show ? "취소" : "댓글"
				//댓글 텍스트 공간
				document.getElementById("rep_content_"+idx).type =
					b_show ? 'text' : 'hidden';
				//댓글등록 버튼
				document.getElementById("rep_button_"+idx).type =
					b_show ? 'button' : 'hidden';		
			}
			
			//대댓글 작성
			function rep_rep(f){
				
				var content = f.content.value.trim();
				
				if(content==''){
					alert("댓글 내용을 입력해주세요!");
					return;
				}
				if (content.length > 100 ) {
	                  alert("제목의 글자수는 100자로 제한됩니다.");
	                  return;
	             }
				
				f.action = "rep_rep.do";
				f.method = "post";
				f.submit();
			}
		</script>

	</head>
	<body>
	
	<div class="main_box">
		<div class="subject">
			<h1> ${ vo.subject } </h1>
		</div>
		<div class="head">
			<p>${ vo.id }</p>
			<p class="date">${ vo.regdate }</p>
			<p class="readhit">조회수 : ${vo.readhit }</p>			
		</div>
		<hr>
		<div class="content">
			<div class="content_photo"> 
				<c:if test="${vo.photo != 'no_file'}">
					<img class="img" src="${pageContext.request.contextPath }/resources/upload/${vo.id }/${vo.photo }">
				</c:if>
			</div>	
			<pre>${vo.content}</pre>
		</div>
		<div align="center">
			<c:if test="${check_login == vo.id }">							
		     	<input class="btn btn-sm btn-primary"  type="button" value="수정" onclick="location.href='modify_form.do?idx=${vo.idx}'">
		        <input class="btn btn-sm btn-primary"  type="button" value="삭제" onclick="del(${vo.idx});">
			</c:if>
	        <input class="btn btn-sm btn-primary"  type="button" value="목록" onclick="location.href='content.do?id=${vo.id}'">
        </div>
        
        
		
		<!-- 댓글 -->
	    <hr>
		<div class="reply_box">
			<form>
				<input type="hidden" name="idx" value="${ param.idx }">
				<input type="hidden" name="id" value="${check_login}">
				<div align="center">
					<input name="content" size="100%">
					<input type="button" value="댓글등록" onclick="send_rep(this.form);">
				</div>
			</form>
			<hr>
			<!-- 댓글이 없을시 -->
			<c:if test="${ empty list }">
				<div align="center">등록된 댓글이 없습니다.</div>	
			</c:if>

			<!-- 작성자 가져오기 -->
			<div align="left">
			<c:forEach var="v" items="${list}">
			
				
				<!-- 대댓글 기호추가 -->
				<div class="rep_top">
					<c:if test="${ v.step ne 0 }">
						&nbsp;ㄴ
					</c:if>
					${v.id}
				</div>
				<div class="rep_center">
					<c:if test="${ v.step ne 0 }">
						&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					${v.content}
				</div>	
				
				<div class="rep_last">
					<c:if test="${ v.step ne 0 }">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					${ v.regdate }		
					<!-- 대대댓글 방지 -->
					<c:if test="${v.step eq 0}">
						<input type="button" value="댓글" id="bt_show_${v.idx}" onclick="view(${v.idx});">
					</c:if>
					<c:if test="${check_login == v.id }">		
						<input type="button" value="삭제" onclick="del_rep(${v.idx});">
					</c:if>
				</div>
				<hr>
				<!-- 히든 댓글 -->
				<form>
					<input type="hidden" name="idx" value="${ param.idx }">
					<input type="hidden" name="id" value="${check_login}">
					<input type="hidden" name="ref" value="${v.idx}">
					<input type="hidden" name="step" value="${v.step}">
					<div align="center">
						<input type="hidden" id="rep_content_${v.idx}" name="content" size=100%">
						<input type="hidden" value="댓글등록" id="rep_button_${v.idx}" onclick="rep_rep(this.form);">
					</div>
				</form>
						
			</c:forEach>
			</div>
			
			<div align="center">${ pageMenu }</div>
			
			
		</div>
	</div>
	
	
	</body>
</html>