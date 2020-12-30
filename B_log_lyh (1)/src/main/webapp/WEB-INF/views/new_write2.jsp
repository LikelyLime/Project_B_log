<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>board</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<style type="text/css">
		body {
			padding-top: 70px;
			padding-bottom: 30px;
		}
	</style>
	<script type="text/javascript">
		function send() {
			
			var f = document.form;
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

	<article>

		<div class="container" role="main">

			<h2>새글 작성</h2>

			<form name="form" id="form" role="form" enctype="multipart/form-data">

				<div class="mb-3">

					<label for="title">제목</label>

					<input type="text" class="form-control" name="subject" id="title" placeholder="제목을 입력해 주세요">

				</div>

				<div class="mb-3">

					<label for="content">내용</label>

					<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>

				</div>

				

				<div class="mb-3">

					<input type="file" name="file">
					<!-- <input type="text" class="form-control" name="tag" id="tag" placeholder="태그를 입력해 주세요"> -->

				</div>

			

			</form>

			<div >

				<button type="button" class="btn btn-sm btn-primary" id="btnSave" onclick="send();">등록</button>

				<button type="button" class="btn btn-sm btn-primary" id="btnList" onclick="location.href='content.do'">목록</button>

			</div>

		</div>

	</article>

</body>

</html>