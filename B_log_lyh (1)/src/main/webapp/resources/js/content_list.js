
//스크롤을 내리면 버튼이 따라가게 만들기
$(function() {
 $(window).scroll(function() {
  if($(this).scrollTop() != 0) {
   $('#backtotop').fadeIn(); 
  } else {
   $('#backtotop').fadeOut();
  }
 });
 
 //스크롤을 맨위로 올리기
 $('#backtotop').click(function() {
  $('body,html').animate({scrollTop:0},800);
 }); 
});

//친구요청 수락
function beMyFriend(id) {
	if(confirm('친구 요청을 수락하시겠습니까?')) {
		location.href='myFriend.do?friend='+id;
	} else{
		location.href='noFriend.do?will='+id;
	}
}

//친구요청
function willBeMyFriend(id) {
	url = 'willBeMyFriend.do';
	param = 'id='+id;
	sendRequest(url, param, willBeMyFriendResFn, 'post');
	
}

function willBeMyFriendResFn() {
	if(xhr.readyState==4&&xhr.status==200) {
		var data = xhr.responseText;
		
		if(data=='no') {
			alert('이미 친구 신청을 한 상태입니다.');
		}else {
			location.href='beMyFriend.do?will='+data;
		}
		
	}
}

//글 상세보기창으로 이동
function show_content(idx) {
	location.href='show_content.do?idx='+idx;
}

//로그아웃
function logout() {
	location.href='logout.do';
	alert('로그아웃 되었습니다.');
}

//아이디 검색
function search() {
	var id = document.getElementById('search_id').value;
	var url = 'search_id.do';
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
		alert(data)
		if(data=='yes') {
			location.href='content.do?id='+id;
		}else {
			alert('존재하지 않는 아이디 입니다.');
		}
	}
}