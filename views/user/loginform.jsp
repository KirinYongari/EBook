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
<c:set var="menu" value="login" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-4 col-xs-4">
			<c:choose>
				<c:when test="${param.fail eq 'login' }">
					<div class="alert alert-danger">
						<strong>로그인 실패</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
					</div>
				</c:when>
				<c:when test="${param.fail eq 'deny' }">
					<div class="alert alert-danger">
						<strong>로그인 필수</strong> 해당 서비스는 로그인 완료 후 사용가능한 서비스입니다.
					</div>
				</c:when>
				<c:when test="${param.fail eq 'admin' }">
					<div class="alert alert-danger">
						<strong>로그인 필수</strong> 해당 서비스는 관리자만 사용가능한 서비스입니다.
					</div>	
				</c:when>
			</c:choose>
			<div class="panel panel-info">
				<div class="panel-heading">로그인</div>
				<div class="panel panel-body">
					<form method="post" action="login.do">
						<div class="form-group">
							<label>아이디</label>
							<input type="text" class="form-control" name="id" />
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" class="form-control" name="password" />
						</div>
						<div class="text-right">
							<a href="/ebook/user/registerform.do "class="btn btn-success" >회원가입</a>
							<input type="submit" class="btn btn-primary" value="로그인"/>
						</div>
					</form><br/>
					
					<div class="text-right">
						<p><a href="/ebook/user/searchidpwdform.do" class="btn btn-default">아이디 및 비밀번호 찾기</a></p>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>