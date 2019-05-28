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
	<style type="text/css">
		th, td {
			vertical-align: middle !important;
		}
	</style>
</head>
<body>
<c:set var="menu" value="bookmanagement" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
<ul class="nav nav-tabs">
		<li role="presentation" class="${menu eq 'bookform' ? 'active' : '' }"><a href="/ebook/admin/bookform.do">책 등록</a></li>
		<li role="presentation" class="${menu eq 'bookmanagement' ? 'active' : '' }"><a href="/ebook/admin/bookmanagement.do">책 목록</a></li>
		<li role="presentation" class="${menu eq 'userlist' ? 'active' : '' }"><a href="/ebook/admin/userlist.do">유저 목록</a></li>
		<li role="presentation" class="${menu eq 'boardmanagement' ? 'active' : '' }"><a href="/ebook/admin/boardmanagement.do">리뷰 게시판 목록</a></li>
	</ul>
	<br />
	<div class="row">
		<div class="col-xs-12">
			<div class="panel panel-default">
				<table class="table table-striped">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="20%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">			
						<col width="10%">			
					</colgroup>
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">표지</th>
							<th class="text-center">제목</th>
							<th class="text-center">저자</th>
							<th class="text-center">출판사</th>
							<th class="text-center">포인트</th>
							<th class="text-center">등록일</th>
							<th class="text-center">사용여부</th>
							<th class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="book" items="${books }">
						<tr>
							<td class="text-center">${book.no }</td>
							<td class="text-center"><img src="/ebook/bookimg/${book.no }/${book.front }" class="img-rounded" height="80" width="100"></td>
							<td class="text-center"><a href="../bookreader/bookdetail.do?bookNo=${book.no }&root=bookmanagement&cp=${param.cp}">${book.title }</a></td>
							<td class="text-center">${book.author }</td>
							<td class="text-center">${book.publisher }</td>
							<td class="text-center"><fmt:formatNumber value="${book.point }" /></td>
							<td class="text-center"><fmt:formatDate value="${book.createDate }" /></td>
							<td class="text-center">${book.available }</td>
							<td class="text-center"><a href="bookrecovery.do?bno=${book.no }" class="btn btn-primary btn-xs">복구</a>
								<a style="inline-block" href="bookdelete.do?bno=${book.no }" class="btn btn-danger btn-xs" id="btn delete-btn-${book.no }">삭제</a>
								<a style="inline-block" href="bookmodifyform.do?bookNo=${book.no }" class="btn btn-warning btn-xs">수정</a>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-right">
				<a href="bookform.do" class="btn btn-default">등록하기</a>		
			</div>
			<div class="text-center">
				<ul class="pagination">
				<c:if test="${pagination.currentBlock gt 1 }">
					<li><a href="bookmanagement.do?cp=${pagination.prevBlock }">&laquo;</a></li>
				</c:if>
					
				<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					<li class="${num eq pagination.cp ? 'active' : '' }"><a href="bookmanagement.do?cp=${num }">${num }</a></li>
				</c:forEach>
					
				<c:if test="${pagination.currentBlock lt pagination.totalBlocks }" >
					<li><a href="bookmanagement.do?cp=${pagination.nextBlock }">&raquo;</a></li>
				</c:if>
				</ul>
			</div>
		</div>
	</div>	
</div>
<script type="text/javascript">
document.querySelectorAll(".btn-danger").forEach(function(btn, index) {
	btn.onclick = function() {
		var message = confirm("정말 삭제하시겠습니까?");
		if (message == true) {
			alert("삭제되었습니다")
		} else {
			return false;
		}
	}	
});
</script>
</body>
</html>