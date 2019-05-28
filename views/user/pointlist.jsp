<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>EBook</title>
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
<form id="search-form" class="form-inline" method="get" action="pointlist.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<div class="row">
		<div class="col-xs-12">
			<h1>포인트변동내역 게시판</h1>
			
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="30%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th class="text-center">no</th>
						<th class="text-center">전체포인트</th>						
						<th class="text-center">포인트 변동내역</th>
						<th class="text-center">포인트 변동</th>
						<th class="text-center">포인트날짜</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="pointlist" items="${pointLists }">
					<tr>
						<td>${pointlist.no }</td>
						<td>${pointlist.user.point }</td>
						<td>${pointlist.contents }</td>
						<td>${pointlist.point }</td>
						<td><fmt:formatDate value="${pointlist.createDate }" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
		<!-- 페이징처리 -->
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
	</div>
</form>
</div>
	

</body>
<script type="text/javascript">
	function searchHR(cp) {
		cp = cp || 1;
		document.getElementById("cp-box").value = cp;
		
		document.getElementById("search-form").submit();
	}
</script>
</body>
</html>