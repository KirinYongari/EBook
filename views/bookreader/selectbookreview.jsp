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
<div class="container">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<div class="row">
		<div class="col-xs-12">
			<h1>${book.title }의 리뷰</h1>
			<div class="panel panel-info">
				<table class="table table-striped">
					<colgroup>
						<col width="10%">
						<col width="*">
						<col width="10%">
						<col width="10%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">제목</th>
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
							<td><a href="/ebook/reviewboard/reviewdetail.do?no=${reviewboards.no }&bookNo=${reviewboards.book.no }&root=ebookdetail">${reviewboards.title }</a></td>
							<td class="text-center">${reviewboards.user.id}</td>
							<td class="text-center">${reviewboards.hits}</td>
							<td class="text-center"><fmt:formatDate value="${reviewboards.createDate}"/></td>
							<td class="text-center"><span style="color:red; font-weight:bold;"></span></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-right">
				<a href="/ebook/reviewboard/reviewform.do" class="btn btn-default">리뷰 쓰기</a>
			</div>
			<div class="text-center">
				<ul class="pagination">
				<c:if test="${pagination.currentBlock gt 1 }">
					<li><a href="bookdetail.do?bookNo=${book.no }&cp=${pagination.prevBlock }">&laquo;</a></li>
				</c:if>
					
				<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					<li class="${num eq pagination.cp ? 'active' : '' }"><a href="bookdetail.do?bookNo=${book.no }&cp=${num }">${num }</a></li>
				</c:forEach>
					
				<c:if test="${pagination.currentBlock lt pagination.totalBlocks }" >
					<li><a href="bookdetail.do?bookNo=${book.no }&cp=${pagination.nextBlock }">&raquo;</a></li>
				</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function searchHR(cp) {
	cp = cp || 1;
	document.getElementById("cp-box").value = cp;
	
	document.getElementById("search-form").submit();
}
</script>