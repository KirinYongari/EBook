<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.navbar-nav li {
		float: none;
		display: inline-block;
	}
	/*넘버 인풋 박스 버튼 삭제 CSS*/
	input[type="number"] {
		width: 40px;
	}
	input[type=number]::-webkit-inner-spin-button, 
	input[type=number]::-webkit-outer-spin-button { 
 		 -webkit-appearance: none; 
  		 margin: 0; 
	}
	/*슬라이드 스위치 CSS*/
	.switch {
	  position: relative;
	  display: inline-block;
	  width: 60px;
	  height: 34px;
	}
	
	.switch input { 
	  opacity: 0;
	  width: 0;
	  height: 0;
	}
	
	.slider {
	  position: absolute;
	  cursor: pointer;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background-color: #ccc;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	.slider:before {
	  position: absolute;
	  content: "";
	  height: 26px;
	  width: 26px;
	  left: 4px;
	  bottom: 4px;
	  background-color: white;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	input:checked + .slider {
	  background-color: #2196F3;
	}
	
	input:focus + .slider {
	  box-shadow: 0 0 1px #2196F3;
	}
	
	input:checked + .slider:before {
	  -webkit-transform: translateX(26px);
	  -ms-transform: translateX(26px);
	  transform: translateX(26px);
	}
	
	/* Rounded sliders */
	.slider.round {
	  border-radius: 34px;
	}
	
	.slider.round:before {
	  border-radius: 50%;
	}
</style>
<div id="div-navbar" class="navbar navbar-default">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="javascript:void(0);"></a>
		</div>
		<ul class="nav navbar-nav">
			<label id="nightmod-slide-switch" class="switch" style="vertical-align:middle; text-align:center;">
				<input id="nightmod-check" type="checkbox">
				<span class="slider round"></span>
			</label>
			<li><a href="javascript:void(0);" style="pointer-events: none; cursor: default;">야간모드</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li id="first-page"><a href="javascript:void(0);"><span class="glyphicon glyphicon-triangle-left"></span><span class="glyphicon glyphicon-triangle-left"></span></a></li>
			<li id="prev-page"><a href="javascript:void(0);"><span class="glyphicon glyphicon-triangle-left"></span></a></li>
			<li></li>
			<li>
				<form action="javascript:void(0);">
					<input id="page-number" type="number" maxlength="4" oninput="checkControl(this);" onKeyPress="pressEnter();" placeholder="${bookReader[0].nowPageNo }" value="">	
					<a id="total-page" style="color:black; pointer-events: none; cursor: default;" > &nbsp; / &nbsp; ${bookReader[0].totalPage } &nbsp; </a>
					<input id="page-number-button" type="button" value="이동" />
				</form>
			</li>
			<li></li>
		 	<li id="next-page"><a href="javascript:void(0);"><span class="glyphicon glyphicon-triangle-right"></span></a></li>
		</ul>
	</div>
</div>