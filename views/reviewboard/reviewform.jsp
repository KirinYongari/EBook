<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>E Book Review Write</title>
<style type="text/css">

</style>
</head>
<body>
<c:set var="menu" value="reviewboard" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<h1>리뷰 작성하기</h1>
			<div class="panel panel-info"></div>
				<div class="panel-body">
					<div class="panel-body">
					<form method="post" action="add.do" id="review-write-form">
						<div class="form-group">
							<label>제목</label>
							<input type="text" id="review-title" class="form-control" name="title" placeholder="제목을 입력해 주세요."/>
						</div>
						<div class="form-group">
							<label>구매한 책 선택</label><label class="pull-right">별점 주기</label><br />
							<select name="bookNo" id="review-buybook">
								<option>==선택해주세요==</option>	<!-- 자기가 구매한 책 목록 -->
									<c:forEach var="buyBook" items="${buyLists }">
										<c:if test="${LOGIN_USER_INFO.no eq buyBook.user.no }">
											<option value="${buyBook.book.no }">	<!-- book_no를 가져와야 돼서 여기에 담음 -->
												${buyBook.book.title }
											</option>
										</c:if>
									</c:forEach>
							</select>		
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="10" id="review-content" class="form-control" name="contents" placeholder="내용을 입력해 주세요."></textarea>
						</div>
						<div class="text-right">
							<input type="reset" class="btn pull-left btn-warning" value="전부 지우기" />
							<input type="submit" class="btn btn-primary" value="저장" />
							<a href="reviewlist.do" class="btn btn-danger">취소</a>
						</div>
					</form>
				</div>	
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	var reviewform = document.getElementById("review-write-form");
	reviewform.onsubmit = function(event) {
		
		var titleField = document.getElementById("review-title");
		if (titleField.value.length < 1) {
			alert("제목을 입력해주세요.");
			titleField.focus();
			return false;
		}

		var selectField = document.getElementById("review-buybook");
		if (selectField.value == "==선택해주세요==") {
			alert("구매한 책을 선택해주세요. 또는 책 구매후 이용해주세요.");
			titleField.focus();
			return false;
		}
		
		var contentField = document.getElementById("review-content");
		if (contentField.value.length < 1) {
			alert("내용을 입력해주세요.");
			titleField.focus();
			return false;
		}
		
		return true;
	}
</script>
</html>