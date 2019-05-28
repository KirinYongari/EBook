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
<c:set var="menu" value="user"></c:set>
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-3 col-xs-6">
			<div class="panel panel-info">
				<div class="panel-heading">비밀번호수정</div>
				<div class="panel-body">
					<form id="password-form" class="form-horizontal" method="post" action="modipwd.do">
						<div class="form-group">
							<label class="control-label col-md-2">비밀번호</label>
							<div class="col-md-9">
								<input id="user-pwd1" class="form-control" type="password" name="password" placeholder="새로운 비밀번호 입력"/>
							</div>
							
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">비밀번호 재확인</label>
							<div class="col-md-9">
								<input id="user-pwd2" class="form-control" type="password" name="password2" placeholder="위의 비밀번호와 같이 입력해주세요"/>
								
							</div>
						</div>
						<div class="text-right">
							<input type="reset" class="btn btn-default"  value="취소"/>
							<input type="submit" class="btn btn-default" value="수정"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	// 비밀번호 확인
	document.getElementById("password-form").onsubmit = function() {
		
		var pass1 = document.getElementById("user-pwd1").value;
		var pass2 = document.getElementById("user-pwd2").value;
		
		if (pass1 != pass2) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		return true;
	}
	
</script>
</html>