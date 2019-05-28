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
	<style type="text/css">
		th, td {
			text-align: center;
			vertical-align: middle !important;
		}
	</style>
</head>
<body>
<c:set var="menu" value="user" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
<form id="search-form" class="form-inline" method="get" action="buylist.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<div class="row">
		<div class="col-xs-offset-8 col-xs-2">
			
		</div>
		<div class="col-xs-2">
			<select onchange="searchHR();" id="sort-box" name="sort" class="form-control" >
				<option value="date" ${param.sort eq 'date' ? 'selected' : '' }>최신순</option>
				<option value="title" ${param.sort eq 'title' ? 'selected' : '' }>도서제목순 </option>
				<option value="author" ${param.sort eq 'author' ? 'selected' : '' }>저자순 </option>
				<option value="point" ${param.sort eq 'point' ? 'selected' : '' }>포인트순</option>
			</select>
		</div>
		<div class="col-xs-12">
			<h1>구매내역 게시판</h1>
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="20%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th class="text-center">no</th>
						<th class="text-center">상품</th>
						<th class="text-center">도서제목</th>
						<th class="text-center">포인트</th>
						<th class="text-center">저자</th>
						<th class="text-center">구매날짜</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="buylist" items="${buyLists }">
					<tr>
						<td>${buylist.no }</td>
						<td><img src="/ebook/bookimg/${buylist.book.no }/${buylist.book.front }" class="img-rounded" height="80"></td>
						<td><a href="../bookreader/bookdetail.do?bookNo=${buylist.book.no }">${buylist.book.title }</a></td>
						<td>${buylist.book.point }</td>
						<td>${buylist.book.author }</td>
						<td><fmt:formatDate value="${buylist.createDate }" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
			<!-- 페이징처리 -->
		<div class="row">
			<div class="text-center">
				<ul class="pagination">
				<c:if test="${pagination.currentBlock gt 1 }">
					<li><a href="javascript:searchHR(${pagination.prevBlock })">&laquo;</a></li>
				</c:if>
					
				<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					<li class="${num eq pagination.cp ? 'active' : '' }"><a href="javascript:searchHR(${num })">${num }</a></li>
				</c:forEach>
					
				<c:if test="${pagination.currentBlock lt pagination.totalBlocks }" >
					<li><a href="javascript:searchHR(${pagination.nextBlock })">&raquo;</a></li>
				</c:if>
				</ul>
			</div>
			<div class="col-xs-6">
			<div class="form-group">
				<select id="opt-box" class="form-control" name="opt">
					<option value="title" ${param.opt eq 'title' ? 'selected' : '' }> 제목</option>
					<option value="author" ${param.opt eq 'author' ? 'selected' : '' }> 저자</option>
					
				</select>
			</div>
			<div class="form-group">
				<input type="text" id="keyword-box" class="form-control" name="keyword" value="${param.keyword }"/>
			</div>
			<button type="button" class="btn btn-default btn-md" onclick="searchHR();">검색</button>
			
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