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
<c:set var="menu" value="search" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-4 col-xs-4">
			
			<div class="panel panel-info">
				<div class="panel-heading">아이디 찾기</div>
				<div class="panel panel-body">
					<form method="post" action="searchid.do">
						<div class="form-group">
							<label>이름</label>
							<input type="text" class="form-control" name="name" />
						</div>
						<div class="form-group">
							<label>연락처</label>
							<input type="text" class="form-control" name="tel" />
						</div>
						<div class="text-right">
							
							<a href="/ebook/user/registerform.do "class="btn btn-success" >회원가입</a>
							<input type="submit" class="btn btn-primary" value="아이디 찾기"/>
						</div>
					</form>
				</div>
			</div>
			<div class="panel panel-info">
				<div class="panel-heading">비밀번호 새로 만들기</div>
				<div class="panel panel-body">
					<form method="post" action="searchpwd.do">
						<div class="form-group">
							<label>이름</label>
							<input type="text" class="form-control" name="name" />
						</div>
						<div class="form-group">
							<label>아이디</label>
							<input type="text" class="form-control" name="id" />
						</div>
						<div class="form-group">
							<label>연락처</label>
							<input type="text" class="form-control" name="tel" />
						</div>
						<div class="text-right">
							
							<a href="/ebook/user/registerform.do "class="btn btn-success" >회원가입</a>
							<input type="submit" class="btn btn-primary" value="비밀번호 새로 만들기"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</div>

</body>
</html>