<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>E BOOK LIST</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"  src="js/jquery-3.1.1.min.js"></script>
</head>
<body>
<c:set var="menu" value="books" />
<%@ include file="../include/mainnav.jsp" %>
<div class="container">
<form id="search-form" class="form-inline" method="get" action="booklist.do">
	<input type="hidden" id="cp-box" name="cp" value="1" />
		<c:if test="${param.fail eq 'search' }">
			<div class="alert alert-danger text-center">
				<strong><span class="glyphicon glyphicon-exclamation-sign"></span> 찾을수 없는 책입니다.</strong>
			</div>				
		</c:if>
	<div class="row">
		<div class="col-xs-12">
			<div class="panel panel-defailt">
				<div class="panel-body">
					<div class="row">
						<c:forEach var="book" items="${books }">
							<div class="col-xs-3">
		                  		<div class="box">
		                  			<div class="imgbox">
		                      			<img src="/ebook/bookimg/${book.no }/${book.front }" style="width: 100%; height:300px;" class="img-responsive">
		                      		</div>
		                      		<div class="content">
		                      			<h3>${book.title }</h3>
		                          		<p>${book.author }</p>
		                          		<p>${book.publisher }</p>
		                          		<a href="/ebook/bookreader/bookdetail.do?bookNo=${book.no }" class="btn btn-default btnD">E Book 상세 정보</a>
		                      		</div>
		                 		</div>
		                  	</div>
						</c:forEach>
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