<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Bootstrap Example</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style type="text/css">
		th, td {
			text-align: center;
			vertical-align: middle !important;
		}
	</style>
</head>
<body>
<c:set var="menu" value="search" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-9">
			<h1></h1>
			<table class="table">
				<thead>
					<tr>
						<th>입력하신 이메일로 임시비밀번호를 발송했습니다.</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${existedPassword.password }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>