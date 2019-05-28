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
				<div class="panel-heading">회원가입</div>
				
				<div class="panel-body">
					<form id="user-form" class="form-horizontal" method="post" action="register.do">
						<div class="form-group">
							<label class="control-label col-md-2">이름</label>
							<div class="col-md-9">
								<input id="user-name" class="form-control" type="text" name="name" placeholder="이름 입력"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">아이디</label>
							<div class="col-md-9">
								<input id="user-id" class="form-control" type="text" name="id" placeholder="아이디 입력"/>
							</div>
						</div>
						<div class="form-group">
						<div class="wrap_inp">
							<label class="control-label col-md-2">비밀번호</label>
							<div class="col-md-9">
								<input id="user-pwd1" class="form-control" type="password" name="password" placeholder="비밀번호 입력"/>
							</div>
						</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">비밀번호</label>
							<div class="col-md-9">
								<input id="user-pwd2" class="form-control" type="password"  placeholder="비밀번호 확인입력"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">휴대전화</label>
							<div class="col-md-3">
								<select id="user-tel-first" onchange="checkFirstTel()" class="form-control" name="telfirst">
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
									<option value="none">없음</option>
								</select>
							</div>
							<div class="col-md-3">
								<input id="user-tel-middle" class="form-control" type="tel" maxlength="4" name="telmiddle" placeholder="0000" />
							</div>
							<div class="col-md-3">
								<input id="user-tel-last" class="form-control" type="tel" maxlength="4" name="tellast" placeholder="0000" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">이메일</label>
							<div class="col-md-9">
								<input id="user-email" class="form-control" type="email" name="email" placeholder="이메일 입력"/>
							</div>
						</div>
						<div class="text-right">
							<a href="/ebook/home.do "class="btn btn-success" >메인</a>
							<input type="submit" class="btn btn-primary" value="가입"/>
							
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<c:if test="${result eq 'NO'}">
<script>
	alert("중복된 아이디입니다.");
</script>
</c:if>
<script type="text/javascript">
	//폼 유효성 검사
	var userform = document.getElementById("user-form");
	userform.onsubmit = function(event) {
		
		var nameField = document.getElementById("user-name");
		if (nameField.value.length < 2) {
			alert("이름을 2글자 이상 입력해주세요");
			nameField.focus();
			return false;
		}

		var idField = document.getElementById("user-id");
		if (idField.value.length < 6) {
			alert("아이디는 6글자 이상 입력해주세요");
			idField.focus();
			return false;
		}

		var pwdField = document.getElementById("user-pwd1");
		if (pwdField.value.length < 8) {
			alert("비밀번호를 8글자 이상 입력해주세요");
			pwdField.focus();
			return false;
		}
		
		var pass1 = document.getElementById("user-pwd1").value;
		var pass2 = document.getElementById("user-pwd2").value;
		
		if (pass1 != pass2) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		

		var telFirstField = document.getElementById("user-tel-first");
		if(telFirstField.value == '') {
		    alert('휴대전화 앞자리를 선택해 주세요 (없을경우' + " '없음' " + '선택)');
		    telFirstField.focus();
			return false;
		}
		
		var telMiddleField = document.getElementById("user-tel-middle");
		if(telMiddleField.value.length < 3 && telFirstField.value != 'none') {
		    alert('3자리 이상의 번호를 입력해주세요');
		    telMiddleField.focus();
			return false;
		}

		var telLastField = document.getElementById("user-tel-last");
		if(telLastField.value.length < 4 && telFirstField.value != 'none') {
		    alert('4자리 번호를 입력해 주세요');
		    telLastField.focus();
			return false;
		}
		
		var emailField = document.getElementById("user-email");
		if (!(emailField.value.length)) {
			alert("이메일은 필수항목 입니다");
			emailField.focus();
			return false;
		}
		return true
	}
	
	//휴대전화 '없음' 선택시 user-tel-middle, user-tel-last 비활성화
	var telFirstField = document.getElementById("user-tel-first");
	function checkFirstTel() {
		var telMiddleField = document.getElementById("user-tel-middle");
		var telLastField = document.getElementById("user-tel-last");
		
		if(telFirstField.value == 'none') {
			telMiddleField.disabled = true;
			telMiddleField.placeholder = '';
			telMiddleField.value = '';
			
			telLastField.disabled = true;
			telLastField.placeholder = '';
			telLastField.value = '';
			
			return;
			
		} else if(telFirstField.value != 'none') {
			telMiddleField.disabled = false;
			telMiddleField.placeholder = '0000';
			
			telLastField.disabled = false;
			telLastField.placeholder = '0000';
			
			return;
			
		}
	}
	

	
</script>
</html>