<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>E Book</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<c:set var="menu" value="adminboard" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<div class="panel panel-info">
				<div class="panel-heading text-center">공지사항 수정</div>
				<div class="panel-body">
					<form method="post" action="adminboardmodify.do">
						<input type="hidden" name="no" value="${adminboard.no }" />
						<div class="form-group">
							<label>제목</label>
							<input type="text" class="form-control" name="title" value="${adminboard.title }" />
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="10" class="form-control" name="contents" >${fn:replace(adminboard.contents, cn, '<br/>') }</textarea>
						</div>
						<div class="text-right">
							<a href="adminboarddetail.do?no=${adminboard.no }" class="btn btn-default">취소</a>
							<input type="submit" class="btn btn-primary" value="수정" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>