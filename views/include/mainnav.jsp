<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.bs-dark.navbar-inverse {
  background-color: #222;
  border-color: #080808;
}
.bs-dark .navbar-img {padding:5px 6px !important;}
.bs-dark .navbar-img img {width:40px;}
.bs-dark .dropdown-menu {
  min-width: 200px;
  padding: 5px 0;
  margin: 2px 0 0;
  background-color: #000;
  border: 1px solid rgba(0, 0, 0, 0.7);
  border: 1px solid rgba(0, 0, 0, .15);
  -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
          box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
}

.bs-dark .dropdown-menu .divider {
  border: 1px solid rgba(0, 0, 0, 0.8);
}
.bs-dark .dropdown-menu > li > a {
  padding: 6px 20px;
  color: rgba(255,255,255,0.80);
}
.bs-dark .dropdown-menu > li > a:hover,
.bs-dark .dropdown-menu > li > a:focus {
  color: rgba(255,255,255,0.70);
  text-decoration: none;
  background-color: transparent;
}
.bs-dark .dropdown-menu > .active > a,
.bs-dark .dropdown-menu > .active > a:hover,
.bs-dark .dropdown-menu > .active > a:focus {
  color: rgba(255,255,255,0.70);
  text-decoration: none;
  background-color: transparent;
  outline: 0;
}

.bs-dark .navbar-form {
  margin:0;
  margin-top: 5px;
  padding:8px 0px;
}
 
.bs-dark .navbar-form .search-box {
  border:0px;
  height:35px;
  outline: none;
  width:320px;
  padding-right: 3px;
  padding-left: 15px;
  margin:4px;
  -webkit-border-radius: 22px;
  -moz-border-radius: 22px;
  border-radius: 22px;
}
 
.bs-dark .navbar-form a {
  border: 0;
  background: none;
  padding: 2px 5px;
  margin-top: 2px;
  position: relative;
  left: -34px;
  margin-bottom: 0;
  -webkit-border-radius: 3px;
  -moz-border-radius: 3px;
  border-radius: 3px;
}
 
.bs-dark .search-box:focus + a {
  z-index: 3;   
}

@media (min-width: 768px) {
    .bs-dark .dropdown:hover {background-color: #000;}
	.bs-dark .dropdown:hover .dropdown-menu {
	  display: block;
	}
	.bs-dark .navbar-form {
	  padding:0px;
	}	
	.bs-dark .navbar-form .search-box {
	  width:260px;
	  height:32px;
	}
	

}
@import url('https://fonts.googleapis.com/css?family=Roboto+Condensed');


body
{
    margin: 0;
    padding: 0;
    font-family: 'Roboto Condensed', sans-serif;
}

section
{
    padding: 120px 0 0;
    
}

.box
{
    position: relative;
    width: 100%;
    height: 300px;
    overflow: hidden;
    border-radius: 30px;
    background: #000;
    box-shadow: 0 5px 15px rgba(0,0,0,.5);
    transition: .5s;
    margin-bottom: 30px;
}

.box:hover
{
    transform: translateY(-20px);
    box-shadow: 0 50px 50x rgba(0,0,0,.5);
}

.box .imgbox
{
    position: relative;
}

.box .imgbox img
{
    transition: .4s;
}

.box:hover .imgbox img
{
   opacity: .5;
    transform: translateY(0px);
}

.box .content
{
    position: absolute;
    bottom: -10px;
    left: 0;
    padding: 30px;
    box-sizing: border-box;
    transition: .5s;
    opacity: 0;
    
}

.box:hover .content
{
    opacity: 1;
    bottom: 0;
}

.box .content h3
{
    font-size: 30px;
    color: #fff;
    font-weight: 700;
}

.box .content p
{
    font-size: 18px;
    color: #fff;
    font-weight: 600;
}

.box .content .btnD
{
    border: none;
    background: #176ceb;
    color: #fff;
    font-size: 18px;
    padding: 10px 20px;
    font-weight: 800;
    transition: .5s;
}

.box .content .btnD:hover
{
    background: #3a80e8;
    
}
</style>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<div class="container">
    <nav class="navbar navbar-inverse bs-dark">
        <div class="navbar-header">
          <ul class="nav navbar-nav">
          	<li class="${menu eq 'home' ? 'active' : '' }"><a class="navbar-brand" href="/ebook/home.do">E Book <span class="glyphicon glyphicon-book"></span></a></li>
          </ul>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <form class="navbar-form navbar-left form-horizontal" role="search" id="nav-form" method="get" action="/ebook/bookreader/searchbooks.do" >
              <div class="input-group">
                 <input type="text" id="keyword-box" class="search-box" name="keyword" placeholder="search E Book"/>
                 <a type="submit" class="btn btn-default" onclick="searchHR();"><span class="glyphicon glyphicon-search"></span></a>
              </div>
          </form>
          <ul class="nav navbar-nav navbar-right">
		
		  <c:if test="${empty LOGIN_USER_INFO }">
              <li><a href="/ebook/user/loginform.do">로그인</a></li>
			  <li><a href="/ebook/user/registerform.do">회원가입</a></li>
		  </c:if>              
            
            <!--로그인 여부 작성 부분 (로그인 o) -->
          <c:if test="${LOGIN_USER_INFO.role eq 'User' }">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle navbar-img" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
              MyPage 
              <img src="/ebook/images/User.png" class="img-circle" alt="Profile Image" />
              </a>
              <ul class="dropdown-menu">
                <li><a href="/ebook/user/buylist.do"><span class="glyphicon glyphicon-shopping-cart"></span> 구매 목록</a></li>
                <li><a href="/ebook/user/pointlist.do"><span class="glyphicon glyphicon-credit-card"></span> 포인트 내역</a></li>
                <li><a href="/ebook/user/myreviewlist.do"><span class="glyphicon glyphicon-list"></span> 나의 게시글</a></li>
                <li><a href="/ebook/user/modifyform.do"><span class="glyphicon glyphicon-cog"></span> 계정 정보 수정</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="/ebook/user/logout.do"><span class="glyphicon glyphicon-off"></span> 로그아웃</a></li>
              </ul>
            </li>
          </c:if>
            <!--로그인 여부 작성 부분 (로그인 o) -->
            
            <!--관리자 여부 작성 부분 -->
          <c:if test="${LOGIN_USER_INFO.role eq 'Admin' }">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle navbar-img" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
              Admin
              <img src="/ebook/images/Admin.png" class="img-circle" alt="Profile Image" />
              </a>
              <ul class="dropdown-menu">
                <li><a href="/ebook/adminboard/adminboardform.do"><span class="glyphicon glyphicon-send"></span> 공지사항 등록</a></li>
                <li><a href="/ebook/admin/bookform.do"><span class="glyphicon glyphicon-book"></span> E Book 등록</a></li>
                <li><a href="/ebook/admin/userlist.do"><span class="glyphicon glyphicon-user"></span> 회원 리스트</a></li>
                <li><a href="/ebook/admin/boardmanagement.do"><span class="glyphicon glyphicon-list"></span> 게시판 관리</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="/ebook/user/logout.do"><span class="glyphicon glyphicon-off"></span> 로그아웃</a></li>
              </ul>
            </li>
          </c:if>
            <!--관리자 여부 작성 부분 -->
          </ul>
        </div>
    </nav>
</div>
<script type="text/javascript">
	function searchHR(cp) {
		cp = cp || 1;
		document.getElementById("cp-box").value = cp;
		
		document.getElementById("nav-form").submit();
	}
</script>