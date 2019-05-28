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
</head>
<body>
<c:set var="menu" value="boardmanagement" />
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
						<col width="*">
						<col width="20%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="20%">			
					</colgroup>
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">제목</th>
							<th class="text-center">도서명</th>
							<th class="text-center">아이디</th>
							<th class="text-center">조회수</th>
							<th class="text-center">사용여부</th>
							<th class="text-center">등록일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="board" items="${boards }">
						<tr>
							<td class="text-center">${board.no }</td>
							<td><a href="../reviewboard/reviewdetail.do?no=${board.no }&cp=${pagination.cp}&root=boardmanagement">${board.title }</a></td>
							<td class="text-center">${board.book.title }</td>
							<td class="text-center">${board.user.id }</td>
							<td class="text-center">${board.hits }</td>
							<td class="text-center">${board.available }</td>
							<td class="text-center"><fmt:formatDate value="${board.createDate }" pattern="yyyy.MM.dd HH:mm:ss" /></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pagination.currentBlock gt 1 }">
						<li><a href="boardmanagement.do?cp=${pagination.prevBlock }">&laquo;</a></li>
					</c:if>
					<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
						<li class="${num eq pagination.cp ? 'active' : '' }"><a href="boardmanagement.do?cp=${num }">${num }</a></li>
					</c:forEach>
						
					<c:if test="${pagination.currentBlock lt pagination.totalBlocks }" >
						<li><a href="boardmanagement.do?cp=${pagination.nextBlock }">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>