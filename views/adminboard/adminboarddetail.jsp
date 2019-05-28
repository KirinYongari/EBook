<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지사항</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<c:set var="menu" value="adminboard" />
<%@ include file="../include/mainnav.jsp" %>
<%
	pageContext.setAttribute("cn", "\n");
%>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<div class="panel panel-default">
				<div class="panel-body">
					<table class="table">
							<tr>
								<th>제목</th>
								<td colspan="3">${adminboard.title }</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>${adminboard.user.name }</td>
								<th>조회수</th>
								<td>${adminboard.hits }</td>
							</tr>
							<tr>
								<th>등록일</th>
								<td colspan="3"><fmt:formatDate value="${adminboard.createDate }" pattern="yyyy.MM.dd hh:mm"/></td>
							</tr>
							<tr>
								<th class="text-center" colspan="4">내용</th>
							</tr>
							<tr>
								<td colspan="4" class="text-center">${fn:replace(adminboard.contents, cn, '<br/>') }</td>
							</tr>
					</table>
					<div class="text-right">
					<c:if test="${LOGIN_USER_INFO.role eq 'Admin' }">
						<a href="adminboardmodifyform.do?no=${adminboard.no }" class="btn btn-warning">수정</a>
						<a href="adminboarddelete.do?no=${adminboard.no }" class="btn btn-danger">삭제</a>
					</c:if>
					
					<a href="adminboardlist.do" class="btn btn-primary">목록</a>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>