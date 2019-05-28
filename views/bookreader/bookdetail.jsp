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
<%@ include file="../include/mainnav.jsp" %>
<style type="text/css">
	#read-possible {
		color: dodgerblue;
	}
</style>
<body>
<div class="container">
	<div class="row">
	    <div class="col-xs-4 item-photo">
	    	<img style="max-width:100%;" src="../bookimg/${book.no }/${book.front}" />
	    </div>
	    <div class="col-xs-5" style="border:0px solid gray">
	        <h3 style="margin-top:30px;">제목 : ${book.title } </h3>    
	        <h3 style="margin-top:30px;">출판사 :${book.publisher } </h3>    
	        <h3 style="margin-top:30px;">저자 : ${book.author } </h3>    
	        <h3 style="margin-top:30px;">포인트 : ${book.point }</h3>
	        	<c:if test="${empty LOGIN_USER_INFO}">
	        		<a style="margin-top:30px;" href="/ebook/user/loginform.do?fail=deny" class="btn btn-primary btn-lg">구매하시려면 로그인 하세요.</a>
	        	</c:if>
	        	<c:if test="${empty buyBook && LOGIN_USER_INFO.role eq 'User' }">
	        		<a id="buy-select-book" style="margin-top:30px;" href="buy.do?bookNo=${book.no }" class="btn btn-primary btn-lg">구매
	        		</a>
				</c:if>
<%-- 				<c:if test="${book.available eq 'N' }">
					<a style="margin-top:30px;" class="btn btn-primary btn-lg disabled" >더이상 구매가 불가능한 책입니다.</a>
				</c:if> --%>
				<c:if test="${(not empty LOGIN_USER_INFO && LOGIN_USER_INFO.no eq buyBook.user.no) || LOGIN_USER_INFO.role eq 'Admin'}">
					<p style="margin-top:30px; font-size:40px" id="read-possible">읽기 가능</p>
	        		<a href="firstpage.do?bookNo=${book.no }" class="btn btn-primary btn-lg">Ebook Read</a>
					<c:if test="${LOGIN_USER_INFO.role eq 'Admin' }">
						<a href="../admin/bookmodifyform.do?bookNo=${book.no }" class="btn btn-warning btn-lg">수정</a>
					</c:if>
				</c:if>
	    </div>                              	
	</div>
</div>
<%@ include file="bookpreview2.jsp" %>
<%@ include file="selectbookreview.jsp" %>
</body>
<script type="text/javascript">
document.getElementById("buy-select-book").onclick = function() {
	var message = confirm("구매 하시겠습니까?");
	var failBuy = document.getElementById("buy-select-book");
	if (message == true) {
		if (failBuy != null) {
			alert("보유 포인트가 부족합니다!");
		}
	}
	else {
		return false;
	}
}
</script>
</html>