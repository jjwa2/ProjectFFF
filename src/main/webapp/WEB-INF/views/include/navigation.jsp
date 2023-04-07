<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<link rel="stylesheet" href="/resources/style/navigation.css">


<%
	if(com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
    <div class="nav-main">
      <div style="flex-grow: 1.5;"></div>
      <div class="nav-logo" style="flex-grow: 0.1;">
        <a href="/index" style="text-decoration: none; color: inherit;"><img class="mainlogo" style="z-index: 700;" src="/resources/images/logo/logo_width.png" alt="logo"></a>
      </div>
      <div class="nav-main-item" style="flex-grow: 4;">
        <div class="nav-main-items">
          	<a href="/mypage" style="text-decoration: none; color: inherit;"><i class="fa-solid fa-user nav-menu1" role="button"></i></a>
        </div>
        <div class="nav-main-items nav-menu1">
      	    <a class="nav-link" role="button" id=btnLogout href="/user/loginOut" style="text-decoration: none; color: inherit;">
          	로그아웃
        	</a>
        </div>
      </div>
      <div style="flex-grow: 2;"></div>
    </div>
<%
	}
	else
	{
%>
    <div class="nav-main">
      <div style="flex-grow: 1.5;"></div>
      <div class="nav-logo" style="flex-grow: 0.1;">
        <a href="/index" style="text-decoration: none; color: inherit;"><img class="mainlogo" style="z-index: 700;" src="/resources/images/logo/logo_width.png" alt="logo"></a>
      </div>
      <div class="nav-main-item" style="flex-grow: 4;">
        <div class="nav-main-items nav-menu1">
        	<a class="nav-link" role="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
          	로그인
          	</a>
        </div>        
        <div class="nav-main-items nav-menu1">
         	<a href="/user/regForm_prac" style="text-decoration: none; color: inherit;">회원가입</a>
         	
        </div>
      </div>
      <div style="flex-grow: 2;"></div>
    </div>
<%
	}
%>
    <div class="nav-bar">
      <div class="nav-bar1" style="flex-grow: 1;"></div>
      <div class="nav-item nav-menu">
        <a href="/ntboard/ntlist" style="text-decoration: none; color: inherit;">NOTICE</a>
      </div>
      <div class="nav-item nav-menu">
        <a  class="nav-link" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">PLAY</a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/funding/fundingList">펀딩하기</a></li>
          <li><a class="dropdown-item" href="/ctBoard/ctlist">공연예매</a></li>
        </ul>
        
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        	ARTIST
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/snsboard/snsmain">아티스트 SNS</a></li>
          
          
<c:if test="${sessionScope.userLevel == 2 or sessionScope.userLevel == 3}">
	<li><a class="dropdown-item" href="/snsboard/artistMypage">아티스트 관리페이지</a></li>
</c:if>


        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a href="/rvBoard/rvList" style="text-decoration: none; color: inherit;">REVIEW</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">
       		CONTECT US
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/qna/inquiry">문의사항</a></li>
          <li><a class="dropdown-item" href="/qna">자주묻는질문</a></li>
        </ul>
      </div>
      <div style="flex-grow: 1;"></div>
    </div>
    
    
    
    
    
    
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<link rel="stylesheet" href="/resources/style/navigation.css">


<%
	if(com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
    <div class="nav-main">
      <div style="flex-grow: 1.5;"></div>
      <div class="nav-logo" style="flex-grow: 0.1;">
        <a href="/index" style="text-decoration: none; color: inherit;"><img class="mainlogo" style="z-index: 700;" src="/resources/images/logo/logo_width.png" alt="logo"></a>
      </div>
      <div class="nav-main-item" style="flex-grow: 4;">
        <div class="nav-main-items">
          	<a href="/mypage" style="text-decoration: none; color: inherit;"><i class="fa-solid fa-user nav-menu1" role="button"></i></a>
        </div>
        <div class="nav-main-items nav-menu1">
      	    <a class="nav-link" role="button" id=btnLogout href="/user/loginOut" style="text-decoration: none; color: inherit;">
          	로그아웃
        	</a>
        </div>
      </div>
      <div style="flex-grow: 2;"></div>
    </div>
<%
	}
	else
	{
%>
    <div class="nav-main">
      <div style="flex-grow: 1.5;"></div>
      <div class="nav-logo" style="flex-grow: 0.1;">
        <a href="/index" style="text-decoration: none; color: inherit;"><img class="mainlogo" style="z-index: 700;" src="/resources/images/logo/logo_width.png" alt="logo"></a>
      </div>
      <div class="nav-main-item" style="flex-grow: 4;">
        <div class="nav-main-items nav-menu1">
        	<a class="nav-link" role="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
          	로그인
          	</a>
        </div>        
        <div class="nav-main-items nav-menu1">
         	<a href="/user/regForm_prac" style="text-decoration: none; color: inherit;">회원가입</a>
         	
        </div>
      </div>
      <div style="flex-grow: 2;"></div>
    </div>
<%
	}
%>
    <div class="nav-bar">
      <div class="nav-bar1" style="flex-grow: 1;"></div>
      <div class="nav-item nav-menu">
        <a href="/ntboard/ntlist" style="text-decoration: none; color: inherit;">NOTICE</a>
      </div>
      <div class="nav-item nav-menu">
        <a  class="nav-link" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">PLAY</a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/funding/fundingList">펀딩하기</a></li>
          <li><a class="dropdown-item" href="/ctBoard/ctlist">공연예매</a></li>
        </ul>
        
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        	ARTIST
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/snsboard/snsmain">아티스트 SNS</a></li>
          
          
<c:if test="${sessionScope.userLevel == 2 or sessionScope.userLevel == 3}">
	<li><a class="dropdown-item" href="/snsboard/artistMypage">아티스트 관리페이지</a></li>
</c:if>


        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a href="/rvBoard/rvList" style="text-decoration: none; color: inherit;">REVIEW</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">
       		CONTECT US
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/qna/inquiry">문의게시판입니다22.</a></li>
          <li><a class="dropdown-item" href="/qna">자주묻는질문</a></li>
        </ul>
      </div>
      <div style="flex-grow: 1;"></div>
    </div>
    
    
    
    
    
    
>>>>>>> branch '동준' of https://github.com/jjwa2/ProjectFFF.git
    