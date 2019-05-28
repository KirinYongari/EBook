<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<c:set var="menu" value="bookform" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
<ul class="nav nav-tabs">
		<li role="presentation" class="${menu eq 'bookform' ? 'active' : '' }"><a href="/ebook/admin/bookform.do">책 등록</a></li>
		<li role="presentation" class="${menu eq 'bookmanagement' ? 'active' : '' }"><a href="/ebook/admin/bookmanagement.do">책 목록</a></li>
		<li role="presentation" class="${menu eq 'userlist' ? 'active' : '' }"><a href="/ebook/admin/userlist.do">유저 목록</a></li>
		<li role="presentation" class="${menu eq 'boardmanagement' ? 'active' : '' }"><a href="/ebook/admin/boardmanagement.do">리뷰 게시판 목록</a></li>
	</ul>
	<br />
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<div class="panel panel-default">
				<div class="panel-heading">책 등록</div>
				<div class="panel-body">
					<form id="register-form" method="post" action="add.do" enctype="multipart/form-data">
						<div class=form-group>
							<label>제목</label>
							<input type="text" class="form-control" name="title">
						</div>
						<div class=form-group>
							<label>저자</label>
							<input type="text" class="form-control" name="author">
						</div>
						<div class=form-group>
							<label>출판사</label>
							<input type="text" class="form-control" name="publisher">
						</div>
						<div class=form-group>
							<label>포인트</label>
							<input type="number" class="form-control" name="point">
						</div>
						<div class=form-group>
							<label>표지</label>
							<input type="file" class="form-control" name="front">
						</div>
						<div class=form-group>
							<label>페이지 <button id="add-btn"> + </button></label>
							<input type="file" class="form-control" name="upfile">
						</div>
						<div id="button-box" class=form-group>
							<label>마지막장</label>
							<input type="file" class="form-control" name="back">
						</div>
						<div class="text-right">
							<input type="submit" class="btn btn-success" value="등록" />
							<a href="bookmanagement.do" class="btn btn-primary" id="return-btn">목록</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var index = 1;
	document.getElementById("add-btn").onclick = function() {
		var content = '<div class="form-group">';
		content += '<label>페이지</label>';
		content += '<input type="file" class="form-control" name="upfile'+ index++ +'">';
		content += '</div>';
		
		$("#button-box").before(content);
		return false;
	}
	
	document.getElementById("return-btn").onclick = function() {
		var message = confirm("목록으로 돌아가시겠습니까?");
		if (message == true) {
		}
		else {
			return false;
		}
	}
</script>
</body>
</html>