<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후기 리스트</title>
	<link rel="stylesheet" href="/resources/style/rvList.css">
	<link rel="stylesheet" href="/resources/style/pagination.css">
    <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap"
        rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
    	  <!-- 드롭다운 -->
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  		integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  		crossorigin="anonymous"></script>
  		
  			  <!-- 아이콘 cdn -->
	  <script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>
  		
  		
  	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <script src="/resources/summernote/summernote-lite.js"></script>
    <script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
    <link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
  		
  	<!-- 리스크 페이지 아이콘 CDN -->
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
  	
  	<!-- 폰트 CDN -->
  	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">

  	
  	
</head>

<script type="text/javascript">
    
    $(document).ready(function () {
        $('select').formSelect();
        
    	$("#writebtn").on("click", function() {
    		document.bbsForm.rvSeq.value = "";
    		document.bbsForm.action = "/rvBoard/rvWriteForm";
    		document.bbsForm.submit();
    	});
    	
    	$("#btnSearch").on("click", function() {
    		document.bbsForm.rvSeq.value = "";
    		document.bbsForm.searchType.value = $('#_searchType').val();
    		document.bbsForm.searchValue.value = $('#_searchValue').val();
    		document.bbsForm.curPage.value = "1";
    		document.bbsForm.action = "/rvBoard/rvList";
    		document.bbsForm.submit();
    		
    	});
    	
    	
    	
    });
    
    function fn_view(rvSeq)
    {
    	document.bbsForm.rvSeq.value = rvSeq;
    	document.bbsForm.action = "/rvBoard/rvView";
    	document.bbsForm.submit();
    }
    
    function fn_list(curPage)
    {
    	document.bbsForm.rvSeq.value = "";
    	document.bbsForm.curPage.value = curPage;
    	document.bbsForm.action = "/rvBoard/rvList";
    	document.bbsForm.submit();
    }
</script>


<body style="margin: 0px; overflow-x: hidden;">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div class="snstitle">
      <div class="snstitlemain">REVIEW</div>
      <div class="snstitlesub">공연 및 펀딩 리뷰</div>
    </div>

    <div class="text-warning fundingmain-hr">
      <hr>
    </div>

            <!-- 메인 body 시작 -->
            <div class="main-body-fff">

                <!-- 카드 section 시작 -->
                <div class="main-body-card-top-fff">

                    <!-- search section 시작 -->
                    <div class="main-body-card-search-fff white-text text-lighten-4">
                        <div class="searchForm">
                            <select class="input-field col s12 searchBox" name="_searchType" id="_searchType">
                                <option value="" disabled selected>SEARCH</option>
                                <option value="1">아이디</option>
                                <option value="2">제목</option>
                                <option value="3">내용</option>
                            </select>
                        </div>
                        <div><input type="text" style="height: 45px;"   name="_searchValue" id="_searchValue" value="${seatchValue}" ></div>
                        <div><button type="button" class="btn btn-warning btn-sm amber accent-4" id="btnSearch" name="btnSearch" style="background-color: #191919 !important; border: 0 #191919; box-shadow:0 0 0;"><i class="bi bi-search" style="color:#fff;"></i></button></div>
                    </div>
                    <!-- search section 끝 -->



                    <div class="main-body-card-fff">
		<c:if test="${!empty list}">
			<c:forEach var="review" items="${list}" varStatus="status">
                        <div class="main-body-card-section-fff">
                            <a href="javascript:void(0)" onclick="fn_view(${review.rvSeq})"> <!-- 클릭 시 링크 설정 -->
                                <div class="card-fff">
                                    <!-- 카드 헤더 시작 -->
                                    <div class="card-header-fff">
                                        <div style="text-align: center;"><img src="/resources/upload/${review.rvFileName}" class="card-img-fff"></div>
                                    </div>
                                    <!-- 카드 헤더 끝 -->
                                    <!--  카드 바디 시작 -->
                                    <div class="card-body-fff">
                                        <!-- 카드 바디 헤더 시작 -->
                                        <div class="card-body-header-fff">
                                            <p class="card-title-fff"><c:out value="${review.rvTitle}"/></p>
                                            <p class="card-body-nickname-fff"> <c:out value="${review.userId}"/> </p>
                                        </div>
                                        <p class="card-body-description-fff">${review.rvContent}</p>
                                        <!-- 카드 바디 헤더 끝 -->

                                        <!-- 카드 바디 footer 시작 -->
                                        <div class="card-body-footer-fff">
                                            <i class="bi bi-eye"></i> <c:out value="${review.readCnt}"/>&nbsp;
                                            <i class="bi bi-chat-left"></i> <c:out value="${review.rvReplyCount}"/>
                                            <i class="reg_date"><c:out value="${review.regDate}"/></i>
                                        </div>
                                        <!-- 카드 바디 footer 끝 -->
                                    </div>
                                    <!-- 카드 바디 끝 -->
                                </div>
                            </a>
                        </div>
           </c:forEach>
        </c:if>          
        
    <form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="rvSeq" value="" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>                  
                    </div>
                              
                    <!-- 글쓰기 버튼 -->
                    <div class="card-body-write-btn"><button id="writebtn" class="btn btn-warning btn-sm amber accent-4">write</button>
                    </div>





					<!-- 페이징 -->
                    <div class="main-body-card-paging-fff">
                        <div class="content_detail__pagination cdp">
                        
                        
         <c:if test="${!empty paging}">
         	<c:if test="${paging.prevBlockPage gt 0}">
            	<a onclick="fn_list(${paging.prevBlockPage})"  href="javascript:void(0)" class="cdp_i" style="margin: 0 12px 6px;">prev</a>
         	</c:if>
         	
         	<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
         		<c:choose>
         			<c:when test="${i ne curPage}">
                            <a href="javascript:void(0)" onclick="fn_list(${i})"  href="javascript:void(0)" class="cdp_i">${i}</a>
                    </c:when>
                    <c:otherwise>
                    		<a class="cdp_i" href="javascript:void(0)" style="background-color:#f1a712;">${i}</a>
                    </c:otherwise>
            	</c:choose>
            </c:forEach>
            
            <c:if test="${paging.nextBlockPage > 0}">
                            <a  href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})" class="cdp_i" style="margin: 0 12px 6px;">next</a>
         	</c:if>
         </c:if>
                        </div>
                    </div>
         
         
                </div>
                <!-- 카드 section 끝 -->


                <!-- 오른쪽 aside section 시작 -->
                <div class="main-body-aside">
                    <div class="main-body-aside-best">
                        <div>
                            <table>
                                <th style="font-size: 25px" class="th-title">BEST REVIEW</th>
                                <c:if test="${!empty bestList}">
                                <c:forEach var="review" items="${bestList}" varStatus="status" begin="1" end="8">
                                <tr>
                                    <td> <a href="javascript:void(0)" onclick="fn_view(${review.rvSeq})" class="best-list-title">${review.rvTitle}</a></td>
                                    <td style="text-align:right;">${review.userId}</td>
                                
                                </tr>
                                </c:forEach>
                                </c:if>
                            </table>
                        </div>

                    </div>
                    <div class="main-body-aside-banner"><img src="/resources/images/bn1.jpg" style="height:120%"></div>
                </div>
                <!-- 오른쪽 aside section 끝 --> 

            </div>
            
            
            <!-- 메인 body 끝 -->


            <!-- footer 시작 -->
            
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

                <!-- footer 끝 -->
            </div>
        </div>
  </div>
</body>


</html>