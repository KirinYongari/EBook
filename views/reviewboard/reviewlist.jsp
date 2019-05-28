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
<title>Review :: Board</title>
<style>
	table {
		align="center";
	}
</style>
</head>
<body>
<c:set var="menu" value="reviewboard" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1" style="margin-top:20px;">
			<h1>리뷰 게시판( ͡° ͜ʖ ͡°)</h1>
			<div class="panel panel-default" style="margin-top:20px;">
				<table class="table table-striped">
					<colgroup>
						<col width="6%">
						<col width="*">
						<col width="10%">
						<col width="10%">
						<col width="8%">
						<col width="10%">
						<col width="7%">
					</colgroup>
					<thead>
						<tr style="color:black">
							<th class="text-center">번호</th>
							<th class="text-center" >제목</th>
							<th class="text-center" >책제목</th>
							<th class="text-center">글쓴이</th>
							<th class="text-center">조회수</th>
							<th class="text-center">등록일</th>
							<th class="text-center">추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reviewboards" items="${reviewBoards}">
							<tr>
								<td class="text-center">${reviewboards.no }</td>
								<td class="text-left"><a href="reviewdetail.do?no=${reviewboards.no }&cp=${param.cp }">${reviewboards.title }</a></td>
								<td class="text-center"><a href="../bookreader/bookdetail.do?bookNo=${reviewboards.book.no }">${reviewboards.book.title }</a></td>
								<td class="text-center">${reviewboards.user.name }</td>
								<td class="text-center">${reviewboards.hits}</td>
								<td class="text-center"><fmt:formatDate value="${reviewboards.createDate}"/></td>
								<td class="text-center"><span style="color:red; font-weight:bold;">${reviewboards.likes }</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-right" id="${fail eq 'deny' ? 'deny' : 'ok' }">	<!-- 리뷰글쓰기(구매한 책 없으면 리뷰못씀, 기능삭제)-->
				<a href="reviewform.do" class="btn btn-default"><img src="/ebook/images/pen.png"></a>
			</div>
			<!-- 페이징처리 -->
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pagination.currentBlock gt 1 }">
						<li><a href="reviewlist.do?cp=${pagination.prevBlock }">&laquo;</a></li>
					</c:if>
					<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
						<li class="${num eq pagination.cp ? 'active' : '' }"><a href="reviewlist.do?cp=${num }">${num }</a></li>
					</c:forEach>
					<c:if test="${pagination.currentBlock lt pagination.totalBlocks }" >
						<li><a href="reviewlist.do?cp=${pagination.nextBlock }">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	/*  구매한책 없으면 리뷰쓰기 눌렀을때 팝업뜨는 기능 
		=> 삭제(loginedUser 에러때문에 삭제 했습니다.)
	var reviewWrite = document.getElementById("deny");
	reviewWrite.onclick = function(event) {
		
		alert("책 구매후 리뷰 쓰기가 가능합니다.");
		return false;
	}
	*/
</script>
</html>