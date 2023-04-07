<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
 
 
 
   	<link rel="stylesheet" href="/resources/style/NtView.css">
   	<link rel="stylesheet" href="/resources/style/media.css">
   	<link rel="stylesheet" href="/resources/style/pagination.css">
    <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
   
   
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">



	  <!-- 제이쿼리 cdn -->
  	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

      <!-- Compiled and minified CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

      <!-- Compiled and minified JavaScript -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

      <!--MATERRIALIZW 아이콘 CDN-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	<!-- 아이콘 cdn -->
   <script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>
   
   <!-- 드롭다운 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>





<!-- j쿼리 시작 -->
<script type="text/javascript">
$(document).ready(function() {
	
	$("#writebtn").on("click", function() {
		document.bbsForm.ntBbsSeq.value = "";
		document.bbsForm.action = "/ntboard/ntWriteForm";
		document.bbsForm.submit();
	});
	
});

function fn_view(bbsSeq)
{
	document.bbsForm.ntBbsSeq.value = bbsSeq; //bbsseq를 빼고 임의의 값 대입시 오류 발생 
	document.bbsForm.action="/ntboard/ntView";  
	document.bbsForm.submit();
}

function fn_list(curPage)
{
	document.bbsForm.ntBbsSeq.value="";
	document.bbsForm.curPage.value=curPage;
	document.bbsForm.action="/ntboard/ntlist";
	document.bbsForm.submit();
}
</script>
<!-- j쿼리 끝 -->
</head>
<body>
   <div class="main-background">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    <div class="text-warning fundingmain-hr">
    </div>
      <div class="snstitle">
      <div class="snstitlemain">NOTICE</div>
      <div class="snstitlesub">사이트 공지사항</div>
    </div>
    <div class="text-warning fundingmain-hr">
      <hr>
    </div> 
    
    
    
    <div class="board_wrap">
        <div class="board_list_wrap">
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">글쓴이</div>
                    <div class="date">작성일</div>
                </div>
        <c:if test="${!empty list}">
        	<c:forEach var="ntboard" items="${list}" varStatus="status">   
                <div>
                    <div class="num">${ntboard.ntBbsSeq}</div>
                    <div class="title"><a  href="javascript:void(0)" onclick="fn_view(${ntboard.ntBbsSeq})" style="text-decoration: none; color: inherit;">${ntboard.ntBbsTitle}</a></div>
                    <div class="writer">${ntboard.userId}</div>
                    <div class="date">${ntboard.ntRegDate}</div>
                   
                </div>
            </c:forEach>
        </c:if>        
            </div>
            
            
             <div class="board_btn d-grid gap-2 d-md-flex justify-content-md-end">
            <c:if test="${admin eq 3}">
              <button type="button" class="btn btn-warning btn-sm amber accent-4"
              style="margin-top:30px;"id="writebtn">글쓰기</button>
            </c:if>
             </div>
            
            <!-- 페이징 시작 -->
            <div class="board_page">
            
   <c:if test="${!empty paging}">
   	
   			<c:if test="${paging.prevBlockPage gt 0}">
            	<a onclick="fn_list(${paging.prevBlockPage})"  href="javascript:void(0)" class="bt prev" style="text-decoration: none; color: inherit;"><<</a>
         	</c:if>
   		    
   		    <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
         		<c:choose>
         			<c:when test="${i ne curPage}">
                            <a href="javascript:void(0)" onclick="fn_list(${i})"  href="javascript:void(0)" class="num" style="text-decoration: none; color: inherit;">${i}</a>
                    </c:when>
                    <c:otherwise>
                    		<a href="javascript:void(0)"  class="num on" style="text-decoration: none; color: inherit;">${i}</a>
                    </c:otherwise>
            	</c:choose>
            </c:forEach>    	
            	
            	<c:if test="${paging.nextBlockPage > 0}">
                            <a  href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})" class="bt next"style="text-decoration: none; color: inherit;"></a>
         	</c:if>
            	
         
          </c:if>
          
          </div>
  
           
        </div>
        
      <form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="ntBbsSeq" value="" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>  
       
       
    </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>