<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>E BOOK HOME</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
div.bhoechie-tab-container{
  z-index: 10;
  background-color: #ffffff;
  padding: 0 !important;
  border-radius: 4px;
  -moz-border-radius: 4px;
  border:1px solid #ddd;
  margin-top: 20px;
  margin-left: 50px;
  -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
  box-shadow: 0 6px 12px rgba(0,0,0,.175);
  -moz-box-shadow: 0 6px 12px rgba(0,0,0,.175);
  background-clip: padding-box;
  opacity: 0.97;
  filter: alpha(opacity=97);
}
div.bhoechie-tab-menu{
  padding-right: 0;
  padding-left: 0;
  padding-bottom: 0;
}
div.bhoechie-tab-menu div.list-group{
  margin-bottom: 0;
}
div.bhoechie-tab-menu div.list-group>a{
  margin-bottom: 0;
}
div.bhoechie-tab-menu div.list-group>a .glyphicon,
div.bhoechie-tab-menu div.list-group>a .fa {
  color: #000;
}
div.bhoechie-tab-menu div.list-group>a:first-child{
  border-top-right-radius: 0;
  -moz-border-top-right-radius: 0;
}
div.bhoechie-tab-menu div.list-group>a:last-child{
  border-bottom-right-radius: 0;
  -moz-border-bottom-right-radius: 0;
}
div.bhoechie-tab-menu div.list-group>a.active,
div.bhoechie-tab-menu div.list-group>a.active .glyphicon,
div.bhoechie-tab-menu div.list-group>a.active .fa{
  background-color: #000;
  background-image: #000;
  color: #ffffff;
}
div.bhoechie-tab-menu div.list-group>a.active:after{
  content: '';
  position: absolute;
  left: 100%;
  top: 50%;
  margin-top: -13px;
  border-left: 0;
  border-bottom: 13px solid transparent;
  border-top: 13px solid transparent;
  border-left: 10px solid #000;
}

div.bhoechie-tab-content{
  background-color: #ffffff;
  /* border: 1px solid #eeeeee; */
  padding-left: 20px;
  padding-top: 10px;
}

div.bhoechie-tab div.bhoechie-tab-content:not(.active){
  display: none;
}
</style>
<body>
<c:set var="menu" value="home" />
<%@ include file="include/mainnav.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-xs-offset-1 col-xs-9">
		<div class="row">
        <div class="col-xs-12 bhoechie-tab-container">
            <div class="col-lg-2 bhoechie-tab-menu">
              <div class="list-group">
                <a href="#" class="list-group-item active text-center">
                  <h4 class="glyphicon glyphicon-home" style="font-size:1.6em;"></h4><br/>Home
                </a>
                <a href="#" class="list-group-item text-center">
                  <h4 class="glyphicon glyphicon-send" style="font-size:1.6em;"></h4><br/>공지사항
                </a>
                <a href="#" class="list-group-item text-center">
                  <h4 class="glyphicon glyphicon-book" style="font-size:1.6em;"></h4><br/>E Book
                </a>
                <a href="#" class="list-group-item text-center">
                  <h4 class="glyphicon glyphicon-pencil" style="font-size:1.6em;"></h4><br/>Review
                </a>
                <a href="#" class="list-group-item text-center">
                  <h4 class="glyphicon glyphicon-cog" style="font-size:1.6em;"></h4><br/>
                  <c:choose>
                  	<c:when test="${LOGIN_USER_INFO.role eq 'Admin' }">
	                  회원 정보 관리
                  	</c:when>
                  	<c:otherwise>
	                  계정 정보 관리
                  	</c:otherwise>
                  </c:choose>
                </a>
              </div>
            </div>
            <div class="col-xs-offset-1 col-xs-8 bhoechie-tab">
                <!-- flight section -->
                <div class="bhoechie-tab-content active">
                    <center>
                      <h1 class="glyphicon glyphicon-home" style="font-size:10em;color:#000"></h1><br />
                      <c:choose>
                      	<c:when test="${LOGIN_USER_INFO.role eq 'User' }">
                      	  <h2 style="margin-top: 0;color:#000"><strong>${LOGIN_USER_INFO.name } 님 환영합니다.</strong></h2><br />
	                      <h3 style="margin-top: 0;color:#000">E Book 페이지를 찾아주셔서 감사합니다.</h3><br />
	                      <a href="user/logout.do" class="btn btn-primary btn-lg"><strong>로그아웃</strong></a>
                      	</c:when>
                      	<c:when test="${LOGIN_USER_INFO.role eq 'Admin' }">
                      	  <h2 style="margin-top: 0;color:#000"><strong>${LOGIN_USER_INFO.name } 계정입니다.</strong></h2><br />
	                      <h3 style="margin-top: 0;color:#000">E Book 페이지를 관리해 보세요.</h3><br />
	                      <a href="user/logout.do" class="btn btn-primary btn-lg"><strong>로그아웃</strong></a>
                      	</c:when>
                      	<c:otherwise>
	                      <h2 style="margin-top: 0;color:#000"><strong>환영합니다.</strong></h2><br />
	                      <h3 style="margin-top: 0;color:#000">로그인 후 이용해 주세요.</h3>
	                      <h3 style="margin-top: 0;color:#000">회원이 아니시라면 회원가입을 진행해 주세요.</h3><br />
	                      <a href="user/registerform.do" class="btn btn-default btn-lg"><strong>회원가입</strong></a>
	                      <a href="user/loginform.do" class="btn btn-primary btn-lg"><strong>로그인</strong></a>
                      	</c:otherwise>
                      </c:choose>
                    </center>
                </div>
                <!-- train section -->
                <div class="bhoechie-tab-content">
                    <center>
                      <h1 class="glyphicon glyphicon-send" style="font-size:10em;color:#000"></h1><br />
		              <h2 style="margin-top: 0;color:#000"><strong>공지사항</strong></h2><br />
	                    <c:choose>
	                    	<c:when test="${LOGIN_USER_INFO.role eq 'Admin' }">
		                      <h3 style="margin-top: 0;color:#000">공지사항을 등록하세요.</h3><br />
		                      <a href="adminboard/adminboardlist.do" class="btn btn-default btn-lg"><strong>공지사항 목록</strong></a>
		                      <a href="adminboard/adminboardform.do" class="btn btn-primary btn-lg"><strong>공지사항 등록</strong></a>
	                    	</c:when>
	                    	<c:otherwise>
		                      <h3 style="margin-top: 0;color:#000">공지사항을 꼭 읽어주세요!</h3><br />
		                      <a href="adminboard/adminboardlist.do" class="btn btn-default btn-lg"><strong>공지사항</strong></a>
	                    	</c:otherwise>
	                    </c:choose>
                    </center>
                </div>
    
                <!-- hotel search -->
                <div class="bhoechie-tab-content">
                    <center>
                      <h1 class="glyphicon glyphicon-book" style="font-size:10em;color:#000"></h1><br />
	                  <h2 style="margin-top: 0;color:#000"><strong>E Book</strong></h2><br />
					  <c:choose>
						<c:when test="${LOGIN_USER_INFO.role eq 'Admin' }">
	                      <h3 style="margin-top: 0;color:#000">새로운 E Book을 등록해보세요.</h3><br />
	                      <a href="bookreader/booklist.do" class="btn btn-default btn-lg"><strong>E Book 목록</strong></a>
	                      <a href="admin/bookform.do" class="btn btn-primary btn-lg"><strong>E Book 등록</strong></a>
						</c:when>
						<c:when test="${LOGIN_USER_INFO.role eq 'User' }">
	                      <h3 style="margin-top: 0;color:#000">나만의 E Book 책장을 만들어보세요.</h3><br />
	                      <a href="bookreader/booklist.do" class="btn btn-default btn-lg"><strong>E Book</strong></a>
						</c:when>
						<c:otherwise>
	                      <h3 style="margin-top: 0;color:#000">E Book을 구경해보세요.</h3><br />
	                      <a href="bookreader/booklist.do" class="btn btn-default btn-lg"><strong>E Book</strong></a>
						</c:otherwise>
					  </c:choose>
                    </center>
                </div>
                <div class="bhoechie-tab-content">
                    <center>
                      <h1 class="glyphicon glyphicon-pencil" style="font-size:10em;color:#000"></h1><br />
	                  <h2 style="margin-top: 0;color:#000"><strong>Review</strong></h2><br />
                      <c:choose>
                      	<c:when test="${LOGIN_USER_INFO.role eq 'Admin' }">
	                      <h3 style="margin-top: 0;color:#000">리뷰 게시판을 관리해보세요.</h3><br />
	                      <a href="admin/boardmanagement.do" class="btn btn-default btn-lg"><strong>리뷰 목록</strong></a>
                      	</c:when>
                      	<c:when test="${LOGIN_USER_INFO.role eq 'User' }">
	                      <h3 style="margin-top: 0;color:#000">E Book이 맘에 드셨다면 리뷰를 작성해 보세요.</h3><br />
	                      <a href="reviewboard/reviewlist.do" class="btn btn-default btn-lg"><strong>리뷰 목록</strong></a>
	                      <a href="reviewboard/reviewform.do" class="btn btn-primary btn-lg"><strong>리뷰 작성</strong></a>
                      	</c:when>
                      	<c:otherwise>
	                      <h3 style="margin-top: 0;color:#000">리뷰 게시판을 구경해보세요.</h3><br />
	                      <a href="reviewboard/reviewlist.do" class="btn btn-default btn-lg"><strong>리뷰 목록</strong></a>
                      	</c:otherwise>
                      </c:choose>
                    </center>
                </div>
                <div class="bhoechie-tab-content">
                    <center>
                      <h1 class="glyphicon glyphicon-cog" style="font-size:10em;color:#000"></h1><br />
                      <c:choose>
                      	<c:when test="${LOGIN_USER_INFO.role eq 'Admin' }">
	                      <h2 style="margin-top: 0;color:#000"><strong>회원 정보 관리</strong></h2><br />
	                      <h3 style="margin-top: 0;color:#000">회원 정보를 관리하세요.</h3><br />
	                      <a href="admin/userlist.do" class="btn btn-default btn-lg"><strong>회원 정보 관리</strong></a>
                      	</c:when>
                      	<c:when test="${LOGIN_USER_INFO.role eq 'User' }">
	                      <h2 style="margin-top: 0;color:#000"><strong>계정 정보 관리</strong></h2><br />
	                      <h3 style="margin-top: 0;color:#000">변경하실 정보를 수정하세요.</h3><br />
	                      <a href="user/modifyform.do" class="btn btn-default btn-lg"><strong>계정 정보 변경</strong></a>
	                      <a href="user/withdrawal.do" class="btn btn-danger btn-lg"><strong>회원 탈퇴</strong></a>
                      	</c:when>
                      	<c:otherwise>
	                      <h2 style="margin-top: 0;color:#000"><strong>계정 정보 관리</strong></h2><br />
	                      <h3 style="margin-top: 0;color:#000">로그인하세요.</h3><br />
	                      <a href="user/loginform.do" class="btn btn-default btn-lg"><strong>로그인</strong></a>
                      	</c:otherwise>
                      </c:choose>                      
                    </center>
                </div>
            </div>
        </div>
 	 </div>
	</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
});
</script>
</body>
</html>