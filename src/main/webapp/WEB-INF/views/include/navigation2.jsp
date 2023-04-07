<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
	if(com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
<!--  <nav class="navbar navbar-expand-sm bg-secondary navbar-dark mb-3">

    <div class="nav-bar">
      <div class="nav-item" style="flex-grow: 2;">
        F. F. F
      </div>
      <div class="nav-item nav-menu">
        HOME
      </div>
      <div class="nav-item nav-menu">
        NOTICE
      </div>
      <div class="nav-item nav-menu">
        FUNDING
      </div>
      <div class="nav-item nav-menu">
        ARTIST
      </div>
      <div class="nav-item nav-menu">
        CONTACT US
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" role="button" id=btnMypage>
          MY PAGE
        </a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" role="button" id=btnLogout>
          LOGOUT
        </a>
      </div>
    </div>

</nav>-->


       <div class="nav-bar">
      <div class="nav-item" style="flex-grow: 2;">
        F. F. F
      </div>
      <div class="nav-item nav-menu">
        <a href="/index" style="text-decoration: none; color: inherit;">HOME</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button"
        data-bs-toggle="dropdown" aria-expanded="false">
        NOTICE
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/ntboard/ntlist">공지사항</a></li>
          <li><a class="dropdown-item" href="/ctboard/ctlist">공연일정</a></li>
        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a href="/funding/fdView" style="text-decoration: none; color: inherit;">FUNDING</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button"
        data-bs-toggle="dropdown" aria-expanded="false">
        ARTIST
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/snsboard/snsmain">아티스트 게시판</a></li>
          <li><a class="dropdown-item" href="/snsboard/artistMypage">아티스트 관리페이지</a></li>
        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a href="/rvBoard/rvList" style="text-decoration: none; color: inherit;">REVIEW</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button"
        data-bs-toggle="dropdown" aria-expanded="false">
        CONTECT US
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/qna">Q&A</a></li>
          <li><a class="dropdown-item" href="/qna/inquiry">문의</a></li>
        </ul>
      </div>
      <div class="nav-item nav-menu">
      	<a href="/mypage" style="text-decoration: none; color: inherit;"><i class="fa-solid fa-user" role="button"></i></a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" role="button" id=btnLogout href="/user/loginOut" style="text-decoration: none; color: inherit;">
          LOGOUT
        </a>
      </div>
    </div>
<%
	}
	else
	{
%>

    <div class="nav-bar">
      <div class="nav-item" style="flex-grow: 2;">
        F. F. F
      </div>
      <div class="nav-item nav-menu">
        <a href="/index" style="text-decoration: none; color: inherit;">HOME</a>
      </div>
      <div class="nav-item nav-menu">
      <a class="nav-link" id="MenuLink4" role="button"
        data-bs-toggle="dropdown" aria-expanded="false">
        NOTICE
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/ntboard/ntlist">공지사항</a></li>
         <li><a class="dropdown-item" href="/ctboard/ctlist">공연일정</a></li>
        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a href="/funding/fdView" style="text-decoration: none; color: inherit;">FUNDING</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button"
        data-bs-toggle="dropdown" aria-expanded="false">
        ARTIST
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="/snsboard/snsmain">아티스트 게시판</a></li>
          <li><a class="dropdown-item" href="/snsboard/artistMypage">아티스트 관리페이지</a></li>
        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a href="/rvBoard/rvList" style="text-decoration: none; color: inherit;">REVIEW</a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" id="MenuLink4" role="button"
        data-bs-toggle="dropdown" aria-expanded="false">
        CONTECT US
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
          <li><a class="dropdown-item" href="#">Q&A</a></li>
          <li><a class="dropdown-item" href="/qna/inquiry">문의</a></li>
        </ul>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" role="button" data-bs-toggle="modal"
        data-bs-target="#exampleModal">
       LOGIN
      </a>
      </div>
      <div class="nav-item nav-menu">
        <a class="nav-link" role="button" id=btnReg>
          JOIN
        </a>
      </div>
    </div>

<%
	}
%>
