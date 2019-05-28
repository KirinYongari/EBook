<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>북 리더</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<%@ include file="../include/navbar.jsp" %>
<c:if test="${param.status eq 'none' }">
	<script type="text/javascript">
		var bookNo = ${param.bookNo };
		alert("해당 책에대한 구매정보가 없습니다.");
		location.href="http://localhost/ebook/bookreader/bookdetail.do?bookNo=" + bookNo;
	</script>
</c:if>
<body id="body" oncontextmenu='return false' onselectstart='return false' ondragstart='return false' style="background-color: white;">
<div class="container">
	<div class="row">
		<div class="col-xs-offset-1 col-xs-10">
			<img id="img-click" name="next-page" width="100%" src="../bookimg/${bookReader[0].nowBookNo }/${bookReader[0].bookImg.imageRoute }" />
		</div>
	</div>
</div>
</body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
		var pageNo = 0;
		var totalPage = 0;
		
		//JSTL로 BookController에서 받은 List<Book> 데이터를 자바스크립트의 배열에 담는 동작
		var imgList = [];
		<c:forEach items="${bookReader}" var="bookReader">
			imgList.push("${bookReader.bookImg.imageRoute}");
			bookNo = "${bookReader.nowBookNo}";
			totalPage = '${bookReader.totalPage}';
		</c:forEach>
		
		//야간모드 스위치 동작
		document.getElementById("nightmod-slide-switch").onclick = function(event) {
			var boxCheck = document.getElementById("nightmod-check");
			
			if(boxCheck.checked) {
				document.getElementById('div-navbar').className='navbar navbar-inverse';
				document.getElementById('body').style='background-color: black;';
				document.getElementById('total-page').style='color:lightgrey; pointer-events: none; cursor: default;';
			}
			if(!boxCheck.checked) {
				document.getElementById('div-navbar').className='navbar navbar-default';
				document.getElementById('body').style='background-color: white;';
				document.getElementById('total-page').style='color:black; pointer-events: none; cursor: default;';
			}
		}
		
		//인풋 넘버 박스의 '이동 버튼'을 눌러 value값을 받아 페이지를 변경하는 동작
		document.getElementById("page-number-button").onclick = function(event) {
			var inputPage = document.getElementById("page-number");
			var img = document.getElementById("img-click");
			
			if (!inputPage.value) {
				pageNo = (inputPage.placeholder - 1);
				inputPage.placeholder = inputPage.placeholder;
				img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
				return;
			}
			if (inputPage.value<1) {
				alert("1보다 작은 값을 입력할 수 없습니다");
				inputPage.value = '';
				return;
			}
			if (parseInt(inputPage.value)>parseInt(totalPage)) {
				alert("총 페이지보다 큰 값을 입력할 수 없습니다");
				inputPage.value = '';
				return;
			}
			
			pageNo = (inputPage.value - 1);
			inputPage.placeholder = inputPage.value;
			inputPage.value = '';
			img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
		}
		
		//인풋 넘버 박스에서 Enter 키를 눌러 value값을 받아 페이지를 변경하는 동작
		function pressEnter() {
			if (event.keyCode == 13) {
				var inputPage = document.getElementById("page-number");
				var img = document.getElementById("img-click");
				
				if (!inputPage.value) {
					pageNo = (inputPage.placeholder - 1);
					inputPage.placeholder = inputPage.placeholder;
					img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
					return;
				}
				if (inputPage.value<1) {
					alert("1보다 작은값을 입력할 수 없습니다");
					inputPage.value = '';
					return;
				}
				if (parseInt(inputPage.value)>parseInt(totalPage)) {
					alert("총 페이지보다 큰 값을 입력할 수 없습니다");
					inputPage.value = '';
					return;
				}
				
				pageNo = (inputPage.value - 1);
				inputPage.placeholder = inputPage.value;
				inputPage.value = '';
				img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
			}
		}
		
		//이미지 클릭시 다음장으로 넘어가는 동작
		document.getElementById("img-click").onclick = function(event) {
			var inputPage = document.getElementById("page-number");
			var img = document.getElementById("img-click");
			inputPage.value = '';
			pageNo++;
			
			if (pageNo > (totalPage - 1)) {
				pageNo = (totalPage - 1);
				inputPage.placeholder = (pageNo + 1);
				alert("마지막 페이지 입니다");
				return;
			}
			
			inputPage.placeholder = (pageNo + 1);
			img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
		}
		
		//다음 페이지 이동 클릭시 동작
		document.getElementById("next-page").onclick = function(event) {
			var inputPage = document.getElementById("page-number");
			var img = document.getElementById("img-click");
			inputPage.value = '';
			pageNo++;
			
			if (pageNo > (totalPage - 1)) {
				pageNo = (totalPage - 1);
				inputPage.placeholder = (pageNo + 1);
				alert("마지막 페이지 입니다");
				return;
			}			
			
			inputPage.placeholder = (pageNo + 1);
			img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
		}
		
		//이전 페이지 이동 클릭시 동작
		document.getElementById("prev-page").onclick = function(event) {
			var inputPage = document.getElementById("page-number");
			var img = document.getElementById("img-click");
			inputPage.value = '';
			pageNo--;
			
			if (pageNo < 0) {
				pageNo = 0;
				inputPage.placeholder = 1;
				alert("첫번째 페이지 입니다");
				return;
			}
			
			inputPage.placeholder = (pageNo + 1);
			img.src = "../bookimg/" + bookNo + "/" + imgList[pageNo];
		}
		
		//처음 페이지 이동 클릭시 동작
		document.getElementById("first-page").onclick = function(event) {
			var inputPage = document.getElementById("page-number");
			var img = document.getElementById("img-click");
			inputPage.value = '';
			
			pageNo = 0;
			inputPage.placeholder = 1;
			img.src = "../bookimg/" + bookNo + "/" + imgList[0];
		}
		
		//넘버 인풋 박스 길이 제한
		function checkControl(object) {
			if (object.value.length > object.maxLength) {
				object.value = object.value.slice(0, object.maxLength);
			}
		}
	</script>
</html>