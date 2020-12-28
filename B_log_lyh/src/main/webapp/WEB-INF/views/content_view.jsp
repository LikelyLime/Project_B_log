<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<html>
<head>
<title>Home</title>

</head>
<body>
   <title>상세보기</title>
   <script type="text/javascript">
   		function modify_form(f) {
			f.action = 'modify_form.do';
			f.submit();
		}
   </script>
</head>
<body>
   <form name="f" method="post">

      <table border="1" align="center">
         <caption>
            <font size=6 color="blue">상세보기창</font>
         </caption>

         <tr>
            <td width="120" heigth="25"><font size=4 color="blue">제목</font></td>
            <td width="250">${ vo.subject }</td>
         </tr>

         <tr>
            <td width="120" heigth="25"><font size=4 color="blue">작성일</font></td>
            <td width="250">${ vo.regdate }</td>
         </tr>

         <tr>
            <td width="120" heigth="25"><font size=4 color="blue">아이디</font></td>
            <td width="250">${ vo.id }</td>
         </tr>

         <tr>
            <td width="120" heigth="25"><font size=4 color="blue">작성내용</font></td>
            <td width="250" height="200"><pre>${vo.content}</pre></td>
         </tr>

		<tr>
            <td width="120" heigth="25"><font size=4 color="blue">태그 또는 이미지</font></td>
            <td width="250" height="150"><pre>연결된 태그나 이미지, 비디오가 있으면 연결~~</pre></td>
         </tr>

         <tr>
            <td colspan="2" align="center">
               <div style="margin-top: 20px">
               <input type="hidden" name="idx" value="${vo.idx}">
                  <button type="button" class="btn btn-sm btn-primary"
                     id="btnUpdate" onclick="modify_form(this.form)">수정</button>
                  <button type="button" class="btn btn-sm btn-primary"
                     id="btnDelete">삭제</button>
                  <button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
               </div>
            </td>
         </tr>

      </table>

   </form>

</body>
</html>