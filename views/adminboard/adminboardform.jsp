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
<c:set var="menu" value="adminboard" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<div class="panel panel-default">
				<div class="panel-heading text-center">게시글 등록폼</div>
				<div class="panel-body">
					<form method="post" action="adminboardadd.do">
						<div class="form-group">
							<label>제목</label>
							<input type="text" class="form-control" name="title" />
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="10" class="form-control" name="contents" ></textarea>
						</div>
						<div class="text-right">
							<a href="/ebook/adminboard/adminboardlist.do" class="btn btn-danger">취소</a>
							<input type="submit" class="btn btn-primary" value="저장" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>