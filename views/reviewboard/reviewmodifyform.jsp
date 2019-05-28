<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>E Book Review ModifyForm</title>
</head>
<body>
<c:set var="menu" value="reviewboard" />
<%@ include file ="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<div class="panel panel-info">
				<div class="panel-heading">리뷰 수정하기</div>	
				<div class="panel-body">
					<form method="post" action="modify.do" id="review-write-form"> 
						<input type="hidden" name="no" value="${reviewBoard.no }">
						<div class="form-group">
							<label>제목</label>
							<input type="text" id="review-title" class="form-control" name="title" placeholder="제목을 입력해주세요." value="${reviewBoard.title }">	<!--기존에 내용을 가져온다  -->
						</div>	
						<div class="form-group">
							<label>내용</label>
							<textarea rows="10" id="review-content" class="form-control" name="contents" placeholder="내용을 입력해주세요.">${reviewBoard.contents }</textarea>	<!--기존에 내용을 가져온다  -->
						</div>
						<div class="text-right">
							<input type="submit" class="btn btn-primary" value="수정" />
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