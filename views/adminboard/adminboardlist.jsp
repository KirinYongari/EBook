<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>E BOOK</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<c:set var="menu" value="adminboards" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<c:choose>
		<c:when test="${param.fail eq 'deny' }">
			<div class="alert alert-danger text-center">
				<strong><span class="glyphicon glyphicon-exclamation-sign"></span> 관리자가 아닙니다!</strong>
				<br />
				해당 서비스는 관리자만 사용가능한 서비스입니다.
			</div>				
		</c:when>
	</c:choose>
<form id="search-form" class="form-inline" method="get" action="adminboardlist.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
	<div class="row">
		<div class="col-xs-2">
			<select onchange="searchHR();" id="sort-box" name="sort" class="form-control">
				<option value="date" ${param.sort eq 'date' ? 'selected' : '' }>최신 순</option>
				<option value="title" ${param.sort eq 'title' ? 'selected' : '' }>제목 순</option>
				<option value="hits" ${param.sort eq 'hits' ? 'selected' : '' }>조회수 순</option>
			</select>
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
					<col width="20%">
				</colgroup>
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">제목</th>
							<th class="text-center">작성자</th>
							<th class="text-center">조회수</th>
							<th class="text-center">등록일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="adminboard" items="${adminboards }">
							<tr>
								<td class="text-center">${adminboard.rn }</td>
								<td class="text-center"><a href="adminboarddetail.do?no=${adminboard.no }">${adminboard.title }</a></td>
								<td class="text-center">${adminboard.user.name }</td>
								<td class="text-center">${adminboard.hits }</td>
								<td class="text-center"><fmt:formatDate value="${adminboard.createDate }" pattern="yyyy.MM.dd hh:mm"/></td>
							</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${LOGIN_USER_INFO.role eq 'Admin' }">
				<div class="text-right">
					<a href="adminboardform.do" class="btn btn-primary">등록</a>
				</div>					
			</c:if>
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