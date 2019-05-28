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
<title>E Book Review</title>
<style>
</style>
</head>
<body>
<c:set var="menu" value="reviewboard" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8">
			<div class="panel" style="margin-top:40px;">
				<div class="panel-body">
					<table class="table">
						<colgroup>
							<col width="9%">
							<col width="*">
							<col width="8%">
							<col width="8%">
						</colgroup>
						<tr class="well">
							<th>제목</th>
							<td colspan="7">${reviewBoard.title }</td>
							<th class="text-right">등록일</th>
							<td class="text-right"><fmt:formatDate value="${reviewBoard.createDate }" pattern="yyyy.MM.dd HH:mm:ss" /></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td class="" colspan="3">${reviewBoard.user.name } (${reviewBoard.user.id })</td>
							<td class="pull-right">번호</td>
							<td class="">${reviewBoard.no }</td>
							<td class="pull-right">조회수</td>
							<td class="" style="font-weight:bold"><fmt:formatNumber value="${reviewBoard.hits }"/></td>
							<td class="text-right">추천수</td>
							<td class="text-right"><span style="font-weight:bold">${reviewBoard.likes }</span></td>
						</tr>
						<tr>
							<th colspan="10" style="">내용</th>
						</tr>
						<tr>
							<td colspan="10">${reviewBoard.contents }</td>							
						</tr>						
					</table>
					<div class="text-center">
						<c:choose>	
							<c:when test="${enableLikes}"><a href="addlike.do?no=${reviewBoard.no }" class="btn btn-default"><img src="/ebook/images/upbutton.png">추천</a></c:when>
							<c:otherwise><a href="#" class="btn btn-default disabled"><img src="/ebook/images/upbutton.png">추천</a></c:otherwise>
						</c:choose>
					</div>
				</div>		
			</div>
			<div class="footer text-right">
			<!--로그인 한사람과 글쓴 유저가 같은 경우 수정,삭제기능 or 로그인한 사람 권한이 관리자일경우 -->
				<c:if test="${ LOGIN_USER_INFO.id eq reviewBoard.user.id or LOGIN_USER_INFO.role eq 'Admin' }">
					<a href="reviewmodifyform.do?no=${reviewBoard.no }" class="btn btn-warning">수정</a>
					<a href="delete.do?no=${reviewBoard.no }" class="btn btn-danger">삭제</a>
				</c:if>
					<!-- 관리자페이지/리뷰 게시판 목록/상세정보 누른후 목록 누르면 다시 관리자 리뷰게시판 목록으로 -->
				<c:choose>
					<c:when test="${param.root eq 'searchreview' }">
						<a href="searchreviews.do?cp=${param.cp }&opt=${param.opt }&sort=${param.sort }&keyword=${param.keyword }" class="btn btn-primary">목록</a>
					</c:when>
					<c:when test="${param.root eq 'ebookdetail' }">
						<a href="../bookreader/bookdetail.do?bookNo=${param.bookNo }" class="btn btn-info">이전</a>
					</c:when>
					<c:when test="${param.root eq 'boardmanagement' }">
						<a href="../admin/boardmanagement.do?cp=${param.cp }&root=${param.cp }" class="btn btn-primary">목록</a>
					</c:when>
					<c:otherwise>
						<a href="reviewlist.do?cp=${param.cp }" class="btn btn-primary">목록</a>
					</c:otherwise>
				</c:choose>
			</div>	
		</div>
	</div>
</div>
</body>
</html>