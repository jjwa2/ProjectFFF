<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>관리자 페이지</title>

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


//펀딩등록승인 눌렀을때 펀딩승인 탭으로 다시 오게 하는 함수
function fn_fdApproveTap()
{
    $('.dropdown-toggle').parent().removeClass('active');
    $('.menu-funding').parent().addClass('active');
    $('.dropdown-toggle').not('.menu-funding').removeClass('active').next().slideUp(500);
    $('.menu-funding').toggleClass('active').next().slideToggle(500);
    
     $('.content-menu').css('display', 'none');
     $('.펀딩등록승인').css('display', 'block');
     $('#menu-title').text('펀딩등록승인');
}
//공연등록승인 눌렀을때 공연승인 탭으로 다시 오게 하는 함수
function fn_ctApproveTap()
{
    $('.dropdown-toggle').parent().removeClass('active');
    $('.menu-funding').parent().addClass('active');
    $('.dropdown-toggle').not('.menu-funding').removeClass('active').next().slideUp(500);
    $('.menu-funding').toggleClass('active').next().slideToggle(500);
    
     $('.content-menu').css('display', 'none');
     $('.공연등록승인').css('display', 'block');
     $('#menu-title').text('공연등록승인');
}

//공연등록승인 눌렀을때 공연승인 탭으로 다시 오게 하는 함수
function fn_artistLevelApprove()
{
    $('.dropdown-toggle').parent().removeClass('active');
    $('.menu-funding').parent().addClass('active');
    $('.dropdown-toggle').not('.menu-funding').removeClass('active').next().slideUp(500);
    $('.menu-funding').toggleClass('active').next().slideToggle(500);
    
     $('.content-menu').css('display', 'none');
     $('.아티스트등급관리').css('display', 'block');
     $('#menu-title').text('아티스등급관리');
}




        $(document).ready(function () {

        	//아티스트등급관리  승인탭 드랍다운 토글 처리
        	<c:if test="${gubun eq 'artistLevelApprove'}">
        		fn_artistLevelApprove();
        	</c:if>
        	
        	
        	//펀딩게시글 승인탭 드랍다운 토글 처리
        	<c:if test="${gubun eq 'P'}">
        		fn_fdApproveTap();
        	</c:if>
        	
        	//공연게시글 승인탭 드랍다운 토글 처리
        	<c:if test="${gubun eq 'CtApprove'}">
        		fn_ctApproveTap();
        	</c:if>
        	
        	
        	
            $('.dropdown-toggle').on('click', function () {
                $('.dropdown-toggle').parent().removeClass('active');
                $(this).parent().addClass('active');
                $('.dropdown-toggle').not(this).removeClass('active').next().slideUp(500);
                $(this).toggleClass('active').next().slideToggle(500);
            });



			//해당 탭에 관련된 테이블만 표시 나머지는 히든처리
            $('.menu').on('click', function () {
                var menu = $(this).data('value');
                $('.content-menu').css('display', 'none');
                $('.' + menu).css('display', 'block');
                $('#menu-title').text(menu);
                
                
            });
			
			
            // 버튼 클릭 이벤트 리스너 등록 백종현
            $("table").on("click", "button[id^='userOut_']", function() {
              var userId = $(this).attr("id").split("_")[1]; // userId 추출
              if(confirm("회원 계정 정지 하시겠습니까?")){
                
                if($.trim($("#status").val()) == "N"){
                	alert("이미 정지된 계정입니다.");
                	location.href = "/manage/manage";
                }
             	// status 값이 "Y"라면 "N"으로 변경
                else if($.trim($("#status").val()) == "Y") {
                  $("#status").val("N");
                }
                $.ajax({
                  type: "POST",
                  url: "/userOut",
                  data: {
                    userId: userId, // userId 추가
                    status: $("#status").val()
                  },
                  dataType: "JSON",
                  beforeSend: function(xhr) {
                    xhr.setRequestHeader("AJAX", "true");
                  },
                  success: function(response) {
                    if(response.code == 0) {
                      alert("회원 계정 정지 완료되었습니다.");
                      location.href = "/manage/manage";
                    } else if(response.code == 400) {
                        alert("이미 정지된 회원입니다.");
                      location.href = "/manage/manage";
                    } else if(response.code == 404) {
                      alert("회원 정보 수정 중 오류가 발생하였습니다.");
                      location.href = "/manage/manage";
                    } else if(response.code == 500) {
                      alert("회원 정보 수정 중 오류가 발생하였습니다.");
                      location.href = "/manage/manage";
                    } else {
                      alert("회원 정보 수정 중 오류가 발생하였습니다.");
                      location.href = "/manage/manage";
                    }
                  },
                  error: function(xhr, status, error) {
                    icia.common.error(error);
                  }
                });
              } else {
                location.href = "/manage/manage";
              }
            });
			
			
			
			
			
			
			
			//배정현 펀딩등록 승인 처리
           	$('.fdApprove').on('click', function() {
           		var value = $(this).data('value');
           		//ajax
           		$.ajax({
           			type:"POST",
           			url: "/manage/fdApprove",
           			data:{
           				fdBbsSeq: value
           			},
           			dataTyoe: "JSON",
           			
           			beforeSend:function(xhr)
           			{
           				xhr.setRequestHeader("AJAX","ture");
           			},
           			success:function(response)
           			{
           				if(response.code ==0)
    					{
    						alert("승인이 되었습니다.");
    						document.bbsForm.gubun.value = "P";
    						document.bbsForm.action = "";
    						document.bbsForm.submit();
    					}
           				else
           				{
           					alert("오류가 났습니다.");	
           				}
           			},
           			error: function(xhr,status,error)
    				{
    					icia.common.error(error);
    				}
  
           		})
           	})
           	
           	
			//박재영 공연일정등록 승인 처리
           	$('.ctApprove').on('click', function() {
           		var value = $(this).data('value');
           		var gubun = 'CtApprove';
           		//ajax
           		$.ajax({
           			type:"POST",
           			url: "/manage/ctApprove",
           			data:{
           				fdBbsSeq: value,
           				gubun:gubun
           			},
           			dataTyoe: "JSON",
           			
           			beforeSend:function(xhr)
           			{
           				xhr.setRequestHeader("AJAX","ture");
           			},
           			success:function(response)
           			{
           				if(response.code ==0)
    					{
    						alert("승인이 되었습니다.");
    						document.bbsForm.gubun.value = "CtApprove";
    						document.bbsForm.action = "";
    						document.bbsForm.submit();
    					}
           				else
           				{
           					alert("오류가 났습니다.");	
           				}
           			},
           			error: function(xhr,status,error)
    				{
    					icia.common.error(error);
    				}
  
           		})
           	})
           	
           	
           	//아티스트 등급 승인 처리 (박재윤 23.03.23)
           	$('.userLevel').on('click', function() {
           		var value = $(this).data('value');
           		//ajax
           		$.ajax({
           			type:"POST",
           			url: "/manage/userLevel",
           			data:{
           				userId: value
           			},
           			dataTyoe: "JSON",
           			
           			beforeSend:function(xhr)
           			{
           				xhr.setRequestHeader("AJAX","ture");
           			},
           			success:function(response)
           			{
           				if(response.code == 0)
    					{
    						alert("승인이 되었습니다.");
    						document.bbsForm.gubun.value = "artistLevelApprove";
    						document.bbsForm.action = "";
    						document.bbsForm.submit();
    					}
           				else
           				{
           					alert("오류가 났습니다.");	
           				}
           			},
           			error: function(xhr,status,error)
    				{
    					icia.common.error(error);
    				}
  
           		})
           	});
            
        });
        //document ready 종료
        
        function fn_fdview(fdBbsSeq)
		{
			document.bbsForm.fdBbsSeq.value = fdBbsSeq;
			document.bbsForm.action = "/funding/fdView";
			document.bbsForm.submit();	
		}
        function fn_view(bbsSeq)
        {
            document.bbsForm.qnaBbsSeq.value = bbsSeq;
            document.bbsForm.action = "/qna/view";
            document.bbsForm.submit();
        }
        
        //백종현
 function fn_selectbox(value)
        {
        	document.bbsForm.userLevel.value = value;
        	document.bbsForm.action = "/manage/manage";
        	document.bbsForm.submit();
        } 
        
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
					</ul></li>
				<li class="single-side"><a href="#" data-value="문의관리"
					class="menu dropdown-toggle">문의관리</a></li>
				<li><a href="#pageSubmenu" data-toggle="collapse"
					aria-expanded="false" class="dropdown-toggle menu-funding">펀딩관리</a>
					<ul class="collapse list-unstyled" id="pageSubmenu">
						<li><a href="#" data-value="펀딩등록승인" class="menu">펀딩등록 승인</a>
						</li>
						<li><a href="#" data-value="공연등록승인" class="menu">공연등록 승인</a>
						</li>
					</ul></li>

			</ul>

			<!-- <ul class="list-unstyled CTAs">
                <li>
                    <a href="https://bootstrapious.com/tutorial/files/sidebar.zip" class="download">Download source</a>
                </li>
                <li>
                    <a href="https://bootstrapious.com/p/bootstrap-sidebar" class="article">Back to article</a>
                </li>
            </ul> -->
		</nav>

		<!-- Page Content  -->
		<div id="content">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div>


					<!-- 서브타이틀 -->
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<h2 id="menu-title">관리자 페이지</h2>
					</div>
				</div>
			</nav>
			<div class="content-container">
				<div class="content-nav"></div>



				<div class="content-main">

					<!-- 회원 정보 관리 -->
					<div class="content-menu 회원정보관리" style="display: block;"
						data-value="회원정보관리">
						<div class="content-search">
							<div class="search-select">
								<select class="selectbox" id="selectbox"
									onchange="fn_selectbox(this.value)">
									<option value="1">회원등급선택</option>
									<option value="1"
										<c:if test="${userLevel eq 1}"></c:if>>일반등급</option>
									<option value="2"
										<c:if test="${userLevel eq 2}"></c:if>>아티스트등급</option>
								</select>
							</div>
						</div>
						<table class="my-table">
							<thead>
								<tr>
									<th>아이디</th>
									<th>이름</th>
									<th>이메일</th>
									<th>상태</th>
									<th>등록일</th>
									<th>회원 정지</th>
								</tr>
							</thead>
							<tbody>


								<c:if test="${!empty userList}">
									<%-- 여기서 옵션 선택에 따라 출력될 내용이 변경됩니다. --%>
									<c:forEach var="list" items="${userList}" varStatus="status">
										<tr>
											<td>${list.userId}</td>
											<td>${list.userName}</td>
											<td>${list.userEmail}</td>
											<td>${list.userLevel eq 2 ? '아티스트등급' : '일반등급'}</td>
											<td>${list.userDate}</td>
											<td><button type="button" id="userOut_${list.userId}"
													class="MyBtn">탈퇴</button></td>
										</tr>
									</c:forEach>
								</c:if>


							</tbody>
						</table>
					</div>






					<div class="content-menu 문의관리" style="display: none;"
						data-value="문의관리">
						<div class="content-search">
							<div class="search-select"></div>
							<div class="search-input">
								<input type="text" placeholder="검색어를 입력하세요" class="search-bar">
								<button class="search-btn">
									<i class="fas fa-search"></i>
								</button>
							</div>
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
								<c:if test="${!empty listQna}">
									<c:forEach var="qna" items="${listQna}" varStatus="status">
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

												<td class="text-center"><c:out value="${qna.userId}" /></td>

												<td><a href="javascript:void(0)"
													onclick="fn_view(${qna.qnaBbsSeq})">
														<div class="text-center my-class2">
															<c:out value="${qna.qnaBbsTitle}" />
														</div>
												</a></td>


												<td class="text-center"><c:out value="${qna.userName}" /></td>
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
					</div>




					<div class="content-menu 펀딩등록승인" style="display: none;">
						<table class="my-table">
							<thead>
								<tr>
									<th>아이디</th>
									<th>제목</th>
									<th>상태</th>
									<th>등록일</th>
									<th>승인</th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${!empty list}">
									<c:forEach var="fdBoard" items="${list}" varStatus="status">
										<c:if test="${fdBoard.fdStatus =='W'}">
											<tr>
												<td class="text-center"><c:out
														value="${fdBoard.userId}" /></td>
												<td><a href="javascript:void(0)"
													onclick="fn_fdview(${fdBoard.fdBbsSeq})"> <c:out
															value="${fdBoard.fdBbsTitle}" />
												</a></td>
												<td>${fdBoard.fdStatus}</td>
												<td class="text-center">${fdBoard.regDate}</td>
												<td><button class="MyBtn fdApprove"
														data-value="${fdBoard.fdBbsSeq}">승인</button></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:if>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="1000"></td>
								</tr>
							</tfoot>
						</table>

					</div>




					<div class="content-menu 공연등록승인" style="display: none;">
						<table class="my-table">
							<thead>
								<tr>
									<th>아이디</th>
									<th>제목</th>
									<th>판매방식</th>
									<th>티켓가격</th>
									<th>신청상태</th>
									<th>신청일</th>
									<th>승인</th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${!empty ctBoard}">
									<c:forEach var="ctBoard" items="${ctBoard}" varStatus="status">
										<c:if test="${ctBoard.fdStatus3 =='W'}">
											<tr>
												<td class="text-center"><c:out
														value="${ctBoard.userId}" /></td>
												<td><c:out value="${ctBoard.ctBbsTitle}" /></td>
												<td><c:out value="${ctBoard.ctPayType}" /></td>
												<td><c:out value="${ctBoard.ctPrice}" /></td>
												<td>${ctBoard.fdStatus3}</td>
												<td class="text-center">${ctBoard.ctRegDate}</td>
												<td><button class="MyBtn ctApprove"
														data-value="${ctBoard.fdBbsSeq}">승인</button></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:if>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="1000"></td>
								</tr>
							</tfoot>
						</table>

					</div>












					<!-- 박재윤 23.03.23 아트스트 등급관리 -->
					<div class="content-menu 아티스트등급관리" style="display: none;">
						<table class="my-table">
							<thead>
								<tr>
									<th>아이디</th>
									<th>사용자 이름</th>
									<th>사용자 연락처</th>
									<th>사용자 이메일</th>
									<th>사용자 상태</th>
									<th>사용등급</th>
									<th>승인</th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${!empty artistList}">
									<c:forEach var="artist" items="${artistList}"
										varStatus="status">
										<tr>
											<td class="text-center">${artist.userId}</td>
											<td>${artist.userName}</td>
											<td>${artist.userTel}</td>
											<td>${artist.userEmail}</td>
											<td>${artist.status}</td>
											<td>${artist.userLevel}</td>
											<td><button class="MyBtn userLevel"
													data-value="${artist.userId}">승인</button></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="1000"></td>
								</tr>
							</tfoot>
						</table>
					</div>


				</div>
			</div>
		</div>
	</div>




	<form name="bbsForm" id="manageForm" method="post">
	   	<input type="hidden" name="qnaBbsSeq" value="" />
		<input type="hidden" name="fdBbsSeq" value="" />
		<input type="hidden" name="userLevel" value="${userLevel}" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="gubun" value="" />
	</form>
</body>
<script>


</script>




</html>