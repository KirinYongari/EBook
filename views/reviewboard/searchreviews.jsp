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
  	td, th {
  		vertical-align: middle !important;
  		text-align: center;
  	}
  </style>
</head>
<body>
<c:set var="menu" value="searchreviews"></c:set>
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
<ul class="nav nav-tabs">
	<li role="presentation" class="${menu eq 'searchbooks' ? 'active' : '' }"><a href="/ebook/bookreader/searchbooks.do?sort=date&opt=all">E Book 검색</a></li>
	<li role="presentation" class="${menu eq 'searchreviews' ? 'active' : '' }"><a href="/ebook/reviewboard/searchreviews.do?sort=date&opt=all">Review 검색</a></li>
</ul>
<br />
<form id="search-form" class="form-inline" method="get" action="searchreviews.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<div class="row">
		<div class="col-xs-2">
			<select onchange="searchHR();" id="sort-box" name="sort" class="form-control">
				<option value="date" ${param.sort eq 'date' ? 'selected' : '' }> 최신 순</option>
				<option value="hits" ${param.sort eq 'hits' ? 'selected' : '' }> 조회 순</option>
				<option value="title" ${param.sort eq 'title' ? 'selected' : '' }> 제목 순</option>
			</select>
		</div>
		<div class="col-xs-4 pull-right">
			<div class="form-group" >
				<select id="opt-box" class="form-control" name="opt">
					<option value="all" ${param.opt eq 'all' ? 'selected' : '' }>전체</option>
					<option value="review" ${param.opt eq 'review' ? 'selected' : '' }>제목</option>
					<option value="book" ${param.opt eq 'book' ? 'selected' : '' }>책 제목</option>
					<option value="contents" ${param.opt eq 'contents' ? 'selected' : '' }>내용</option>
					<option value="user" ${param.opt eq 'user' ? 'selected' : '' }>작성자</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" id="keyword-box" class="form-control" name="keyword" value="${param.keyword }"/>
			</div>
			<button type="button" class="btn btn-default btn-md" onclick="searchHR();">검색</button>
		</div>
	</div>
	<br />
	<div class="row">
		<div class="col-xs-12">
			<div class="panel panel-default">
				<table class="table">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
				</colgroup>
					<thead>
						<tr>
							<th class="text-center"> </th>
							<th class="text-center">제목</th>
							<th class="text-center">리뷰한 책</th>
							<th class="text-center">작성자</th>
							<th class="text-center">조회수</th>
							<th class="text-center">게시일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="reviewboard" items="${reviewboards }">
						<tr>
							<td>${reviewboard.rn }</td>
							<td><a href="reviewdetail.do?no=${reviewboard.no }&cp=${pagination.cp }&opt=${param.opt }&sort=${param.sort }&keyword=${param.keyword }&root=searchreview">${reviewboard.title }</a></td>
							<td><a href="../bookreader/bookdetail.do?bookNo=${reviewboard.book.no }">${reviewboard.book.title }</a></td>
							<td>${reviewboard.user.name }</td>
							<td>${reviewboard.hits }</td>
							<td><fmt:formatDate value="${reviewboard.createDate }" pattern="yyyy.MM.dd hh:mm"/></td>
						</tr>
					</c:forEach>
					</tbody>			
				</table>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-offset-3 col-xs-6 text-center">
			<ul class="pagination">
			
			<c:if test="${pagination.currentBlock gt 1 }">
				<li><a href="javascript:searchHR(${pagination.prevBlock })">&laquo;</a></li>
			</c:if>
			
			<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
				<li class="${num eq pagination.cp ? 'active' : '' }"><a href="javascript:searchHR(${num })">${num }</a></li>
			</c:forEach>
			
			<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
				<li><a href="javascript:searchHR(${pagination.nextBlock })">&raquo;</a></li>
			</c:if>
			
			</ul>
		</div>
		
	</div>
</form>
</div>
<script type="text/javascript">
	function searchHR(cp) {
		cp = cp || 1;
		document.getElementById("cp-box").value = cp;
		
		document.getElementById("search-form").submit();
	}
</script>
</body>
</html>