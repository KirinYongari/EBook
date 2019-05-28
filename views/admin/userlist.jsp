<%@page import="org.reflections.util.FilterBuilder.Include"%>
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
		th, td {
			text-align: center;
			vertical-align: middle !important;
		}
	</style>
</head>
<body>
<c:set var="menu" value="userlist" />
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
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">아이디</th>
							<th class="text-center">이름</th>
							<th class="text-center">이메일</th>
							<th class="text-center">전화번호</th>
							<th class="text-center">포인트</th> 
							<th class="text-center">역할</th>
							<th class="text-center">생성일</th>
							<th class="text-center">사용여부</th>
							<th class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="user" items="${users }">
						<tr>
							<td class="text-center">${user.no }</td>
							<td class="text-center"><span style="cursor: pointer;" id="user-span-${user.no }">${user.id }</span></td>
							<td class="text-center">${user.name }</td>
							<td class="text-center">${user.email }</td>
							<td class="text-center">${user.tel }</td>
							<td class="text-center"><fmt:formatNumber value="${user.point }" /></td>
							<td class="text-center">${user.role }</td>
							<td class="text-center"><fmt:formatDate value="${user.createDate }"  /></td>				
							<td class="text-center">${user.available }</td>			
							<td class="text-center"><a href="userrecovery.do?uno=${user.no }" class="btn btn-primary btn-xs">복구</a>
								<a href="userdelete.do?uno=${user.no }" class="btn btn-danger btn-xs" id="delete-btn-${user.no }">삭제</a>
							</td>
						</tr>
					 </c:forEach>
					</tbody>
				</table>
			</div>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pagination.currentBlock gt 1 }">
						<li><a href="userlist.do?cp=${pagination.prevBlock }">&laquo;</a></li>
					</c:if>
						
					<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
						<li class="${num eq pagination.cp ? 'active' : '' }"><a href="userlist.do?cp=${num }">${num }</a></li>
					</c:forEach>
						
					<c:if test="${pagination.currentBlock lt pagination.totalBlocks }" >
						<li><a href="userlist.do?cp=${pagination.nextBlock }">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">구매 내역</h4>
	      		</div>
	      		<div class="modal-body">
		      		<div class="row">
			        	<div class="col-xs-12">
							<table class="table">
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="*">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th class="text-center">no</th>
										<th class="text-center">상품</th>
										<th class="text-center">제목</th>
										<th class="text-center">포인트</th>
										<th class="text-center">구매날짜</th>
									</tr>
								</thead>
								<tbody id="userBuyList-body">
									<tr>
										<td colspan="5" class="text-center"> 구매 내역이 없습니다. </td>
									</tr>
								</tbody>
							</table>
						</div>
		      		</div>
		      		<div class="modal-footer">
		        		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      		</div>
	    		</div>
	  		</div>
		</div>
	</div>	
</div>
<script type="text/javascript">
document.querySelectorAll('span[id^=user-span]').forEach(function(span, index) {
	span.onclick = function() {
		
		var userno = span.getAttribute("id").replace("user-span-", "");
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(event) {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				var text = xhr.responseText;
				var buyLists = JSON.parse(text)
				
				var rows = "";
				if (buyLists.length > 0) {
					buyLists.forEach(function(item, index){ 
						var book = item.book
						rows += "<tr>";
						rows += "<td>"+book.no+"</td>";
						rows += "<td><img src='/ebook/bookimg/" + book.no+ '/' +book.front+"' class='thumbnail' style='width:100px; height:100px;'/></td>";
						rows += "<td>"+book.title+"</td>";
						rows += "<td>"+book.point+"</td>";
						rows += "<td>"+item.createDate+"</td>";
						rows += "</tr>"
					}); 
				} else {
					rows += "<tr>"
					rows += "<td colspan='5' class='text-center'> 구매 내역이 없습니다. </td>";
					rows += "<tr>";
				}
				
				document.getElementById("userBuyList-body").innerHTML = rows;
				
				$("#myModal").modal('show');
			}
		}
		xhr.open("GET", "buyList.do?userno=" + userno)
		xhr.send();
		
	}
})

function getUserBuyList(no) {
	
	
}

document.querySelectorAll(".btn-danger").forEach(function(btn, index) {
	btn.onclick = function() {
		var message = confirm("정말 삭제하시겠습니까?");
		if (message == true) {
			alert("삭제되었습니다")
		} else {
			return false;
		}		
	}
});


</script>
</body>
</html>