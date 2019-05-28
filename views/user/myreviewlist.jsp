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
<c:set var="menu" value="myreviewboard" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
<form id="search-form" class="form-inline" method="get" action="myreviewlist.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<div class="row">
		<div class="col-xs-12">
			<h1>내가 쓴 리뷰 게시판</h1>
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
					<c:forEach var="myreviewlists" items="${myreviewlists}">
						<tr>
							<td class="text-center">${myreviewlists.no }</td>
							<td><a href="../reviewboard/reviewdetail.do?no=${myreviewlists.no }">${myreviewlists.title }</a></td>
							<td class="text-center">${myreviewlists.user.id }</td>
							<td class="text-center">${myreviewlists.hits}</td>
							<td class="text-center"><fmt:formatDate value="${myreviewlists.createDate}"/></td>
							<td class="text-center"><span style="color:red; font-weight:bold;">${myreviewlists.likes }</span></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- 페이징처리 -->
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
</html>