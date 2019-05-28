<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>수정 폼</title>
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
				<div class="panel-heading">정보수정 폼</div>
				<div class="panel-body">
					<form class="form-horizontal" method="post" action="modify.do">
						<div class="form-group">
							<label class="control-label col-md-2">비밀번호</label>
							<div class="col-md-9">
								<input id="user-pwd" class="form-control" type="password" name="password" placeholder="비밀번호를 변경하려면 새로운 비밀번호 입력"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">휴대전화</label>
							<div class="col-md-3">
								<select id="user-tel-first" onchange="checkFirstTel()" class="form-control" name="telfirst">
									<option value="010" ${fn:substring(user.tel, 0, 3) eq '010' ? 'selected' : '' }>010</option>
									<option value="011" ${fn:substring(user.tel, 0, 3) eq '011' ? 'selected' : '' }>011</option>
									<option value="016" ${fn:substring(user.tel, 0, 3) eq '016' ? 'selected' : '' }>016</option>
									<option value="017" ${fn:substring(user.tel, 0, 3) eq '017' ? 'selected' : '' }>017</option>
									<option value="018" ${fn:substring(user.tel, 0, 3) eq '018' ? 'selected' : '' }>018</option>
									<option value="019" ${fn:substring(user.tel, 0, 3) eq '019' ? 'selected' : '' }>019</option>
									<option value="none" ${user.tel eq 'none' ? 'selected' : '' }>없음</option>
								</select>
							</div>
							<div class="col-md-3">
								<c:set var="tel" value="${user.tel }" />
								<c:if test="${fn:length(tel) == 11 }">
									<c:set var="telmiddle" value="${fn:substring(tel, 3, 7) }" />
									<c:set var="tellast" value="${fn:substring(tel, 7, 11) }" />
								</c:if>
								<c:if test="${fn:length(tel) == 10 }">
									<c:set var="telmiddle" value="${fn:substring(tel, 3, 6) }" />
									<c:set var="tellast" value="${fn:substring(tel, 6, 10) }" />
								</c:if>
									<input id="user-tel-middle" class="form-control" type="tel" maxlength="4" name="telmiddle" placeholder="${telmiddle }" ${tel eq 'none' ? 'disabled' : '' } />
							</div>
							<div class="col-md-3">
								<input id="user-tel-last" class="form-control" type="tel" maxlength="4" name="tellast" placeholder="${tellast }" ${tel eq 'none' ? 'disabled' : '' } />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">이메일</label>
							<div class="col-md-9">
								<input id="user-email" class="form-control" type="email" name="email" placeholder="${user.email }"/>
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