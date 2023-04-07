<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>관리자 문의 페이지</title>

<!-- Bootstrap CSS CDN -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css">

<!-- Our Custom CSS -->
<link rel="stylesheet" href="/resources/style/manage.css">

<!-- Font Awesome JS -->
<script defer
	src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js"
	integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ"
	crossorigin="anonymous"></script>
<script defer
	src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js"
	integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY"
	crossorigin="anonymous"></script>




<!-- jQuery CDN - Slim version (=without AJAX) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper.JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
	integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
	crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
	integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
	crossorigin="anonymous"></script>

<script type="text/javascript">
    $(document).ready(function () {
        //탭 드랍다운 토글 처리
        $('.dropdown-toggle').on('click', function () {
            $('.dropdown-toggle').parent().removeClass('active');
            $(this).parent().addClass('active');
            $('.dropdown-toggle').not(this).removeClass('active').next().slideUp(500);
            $(this).toggleClass('active').next().slideToggle(500);
        });

        //해당 탭에 관련된 테이블만 표시 나머지는 히든처리
        $('.menu').on('click', function () {
            var menu = $(this).data('value');
            alert(menu);
            $('.content-menu').css('display', 'none');
            $('.' + menu).css('display', 'block');
            $('#menu-title').text(menu);
        });
       
        
    });

    function fn_view(bbsSeq)
    {
        document.bbsForm.qnaBbsSeq.value = bbsSeq;
        document.bbsForm.action = "/qna/view";
        document.bbsForm.submit();
    }

    $("#btnSearch").on("click", function() {
        document.bbsForm.qnaBbsSeq.value = "";
        document.bbsForm.searchType.value = $("#searchType").val();
        document.bbsForm.searchValue.value = $("#searchValue").val();
        document.bbsForm.curPage.value = "1";
        document.bbsForm.action = "/manage/adminQna";
        document.bbsForm.submit();
    });
    
    
</script>


</head>



<body>
<div class="wrapper">
<!-- Sidebar  -->
		<nav id="sidebar">
			<div class="sidebar-header">
				<h3>
					<a href="/index" style="text-decoration: none; color: inherit;"><img
						class="mainlogo" style="z-index: 700;"
						src="/resources/images/logo/logo_width.png" alt="logo"></a>
				</h3>
			</div>

			<ul class="list-unstyled components">
				<h4 class="sub-title">관리자페이지</h4>
				<div style="border-bottom: 1px solid #4f4f4f; margin-bottom: 15px;">
				</div>
				<li class="active"><a href="#homeSubmenu"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle">회원관리</a>
					<ul class="collapse list-unstyled" id="homeSubmenu">
						<li><a href="#" data-value="회원정보관리" class="menu">회원정보관리</a></li>
						<li><a href="#" data-value="아티스트등급관리" class="menu">아티스트등급관리</a>
						</li>
						<li><a href="#">Home 3</a></li>
					</ul></li>
				<li class="single-side"><a href="/manage/Qna" class="dropdown-toggle">문의관리</a>
				</li>
				<li><a href="#pageSubmenu" data-toggle="collapse"
					aria-expanded="false" class="dropdown-toggle">펀딩관리</a>
					<ul class="collapse list-unstyled" id="pageSubmenu">
						<li><a href="#" data-value="펀딩등록승인" class="menu">펀딩등록 승인</a>
						</li>
						<li><a href="#" data-value="공연등록승인" class="menu">공연등록 승인</a>
						</li>
						<li><a href="#">Page 3</a></li>
					</ul></li>
			</ul>

			
		</nav>
		
		<!-- Page Content  -->
		<div id="content">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div>
					<!-- 서브타이틀 -->
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<h2 id="menu-title">문의게시판</h2>
					</div>
				</div>
			</nav>
			<div class="content-container">
				<div class="content-nav"></div>

				<div class="content-main">
					<div class="content-menu 문의게시판" style="display: block;"
						data-value="문의게시판">
						
				<div class="search">
			      <select name="searchType" id="searchType" class="custom-select">
			        <option value="">조회</option>
			        <option value="1"<c:if test="${searchType eq '1'}">selected</c:if> >아이디</option>
			        <option value="2"<c:if test="${searchType eq '2'}">selected</c:if> >이름</option>
			        <option value="3"<c:if test="${searchType eq '3'}">selected</c:if> >제목</option>
			      </select>
			      <input type="text" placeholder="검색어를 입력하세요" class="search-bar" id="searchValue" value="${searchValue}"/>
			     <button class="search-btn" id="btnSearch"><i class="fas fa-search"></i></button>
			    </div>
			   
    
    
						<table class="my-table">
							<thead>
								<tr class="title">
									<th class="text-center">번호</th>
									<th class="text-center">아이디</th>
									<th class="text-center">제목</th>
									<th class="text-center">이름</th>
									<th class="text-center">등록일</th>
									<th class="text-center">답변상태</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${!empty list}">
									<c:forEach var="qna" items="${list}" varStatus="status">
									<tr>
								<c:if test="${qna.qnaBbsAnswerState ne 'Y'}">	
									<c:choose>
										<c:when test="${qna.qnaBbsIndent eq 0}">
										     <td class="text-center">${qna.qnaBbsSeq}</td>
										</c:when>
									    <c:otherwise>
										     <td class="text-center">
										</c:otherwise>
							    	</c:choose>	
							    	
							    	 <td class="text-center"><c:out value="${qna.userId}"/></td>
							    	
							    	<td>
							   
							    	<a href="javascript:void(0)" onclick="fn_view(${qna.qnaBbsSeq})">
							    	<div class="text-center my-class2"><c:out value="${qna.qnaBbsTitle}"/></div>				
		   							</a>
		   					   	
								    </td>
								    
								    
									<td class="text-center"><c:out value="${qna.userName}"/></td>
    								<td class="text-center">${qna.qnaRegDate}</td>
 									 <td class="text-center">답변 미완료</td>
									</c:if>
      								</tr>
								
						
								
									</c:forEach>
								</c:if>
							</tbody>
							
							
							<tfoot>
							<tr>
								<td colspan="6"></td>
							</tr>
							</tfoot>
								
						</table>
						
		
      
    <form name="bbsForm" id="bbsForm" method="post">
   	<input type="hidden" name="qnaBbsSeq" value="" />
   	<input type="hidden" name="searchType" value="${searchType}" />
   	<input type="hidden" name="searchValue" value="${searchValue}" />
   	<input type="hidden" name="curPage" value="${curPage}" />  	
   </form>
   
      
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>