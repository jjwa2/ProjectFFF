<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

  	
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script> 
	<link href="/resources/style/qna_inquiry.css" rel="stylesheet">
	<link rel="stylesheet" href="/resources/style/pagination.css">
	
	  <!-- 드롭다운 -->
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  		integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  		crossorigin="anonymous"></script>

  	<!-- nav바 필수 cdn -->
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
  
<!-- 아이콘 cdn -->
	  <script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>
	  
	
	
 <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
<!-- 리스크 페이지 아이콘 CDN -->
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
  	
  	     <!-- toastr -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" 
   integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" 
   crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" 
integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" 
crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  	
  	
<script type="text/javascript">
$(document).ready(function(){
$('select').formSelect();

$("#btnWrite").on("click", function() {
		
		document.bbsForm.qnaBbsSeq.value = "";
		document.bbsForm.action = "/qna/writeForm";
		document.bbsForm.submit();
	});
	
	$("#btnSearch").on("click", function() {
		//새로 조회버튼을 누를 때에는 신규로 넣은 값을 가져가야 함.
		document.bbsForm.qnaBbsSeq.value = "";
		document.bbsForm.searchType.value = $("#searchType").val();
		document.bbsForm.searchValue.value = $("#searchValue").val();
		//조회를 했을 때, 무조건 1페이지로 가야함. 검색 결과가 몇페이지까지 나올지 모르니깐.
    	document.bbsForm.curPage.value = "1";
		document.bbsForm.action = "/qna/inquiry";
		document.bbsForm.submit();
	});
	
});
	
function fn_view(bbsSeq)
{

	document.bbsForm.qnaBbsSeq.value = bbsSeq;
	document.bbsForm.action = "/qna/view";
	document.bbsForm.submit();
	
}

function fn_list(curPage)
{
	document.bbsForm.qnaBbsSeq.value = "";
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/qna/inquiry";
	document.bbsForm.submit();
}

function fn_check()
{
	toastr.warning("비밀글 입니다.");
	return;
}

toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": false,
		  "positionClass": "toast-top-center",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "100",
		  "hideDuration": "1000",
		  "timeOut": "1500",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}

</script>

</head>
<body>
   <div class="main-background">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
        
  <div class="container">

    <div class="snstitle">
      <div class="snstitlemain">문의게시판</div>
      <div class="snstitlesub">문의 할 내용을 아래의 게시판에 작성해주세요</div>
    </div>

    <div class="text-warning fundingmain-hr">
      <hr>
    </div>


    <div class="main-body-card-search-fff white-text text-lighten-4">
      <select name="searchType" id="searchType" class="input-field col s12 searchBox">
        <option value="">조회</option>
        <option value="1"<c:if test="${searchType eq '1'}">selected</c:if> >작성자</option>
        <option value="2"<c:if test="${searchType eq '2'}">selected</c:if> >제목</option>
        <option value="3"<c:if test="${searchType eq '3'}">selected</c:if> >내용</option>
      </select>
      <div><input type="text" placeholder="  검색" class="" id="searchValue" name="searchValue" value="${searchValue}" style="background-color: #191919;"></div>
      <div><button type="button" id="btnSearch" style="background-color: #191919 !important; border: 0 #191919; box-shadow:0 0 0;"><i class="bi bi-search" style="color:#fff;"></i></button></div>
    </div>
    
    <table class="table table-hover">
      <thead>
        <tr class="title">
          <th scope="col" class="text-center" style="width:10%">번호</th>
          <th scope="col" class="text-center" style="width:40%">제목</th>
          <th scope="col" class="text-center" style="width:10%">작성자</th>
          <th scope="col" class="text-center" style="width:15%">날짜</th>
          <th scope="col" class="text-center" style="width:10%">조회수</th>
          <th scope="col" class="text-center" style="width:15%">답변상태</th>
        </tr>
      </thead>
      <tbody>
      
      <!-- list 객체가 비어있지 않으면 -->
      <c:if test="${!empty list}">
      	<c:forEach var="qna" items="${list}" varStatus="status">
      	<tr>
      	<c:choose>
     		<c:when test="${qna.qnaBbsIndent eq 0}">
     		<td class="text-center">${qna.qnaBbsSeq}</td>
     		</c:when>
     		<c:otherwise>
     		<td class="text-center">
     		</c:otherwise>	
    	</c:choose>
    	
    	
		<td>
		
<c:if test="${admin eq 3}">
			<c:if test = "${qna.qnaBbsSecret eq 'Y' }">	
		  		<a href="javascript:void(0)" onclick="fn_view(${qna.qnaBbsSeq})">
			
				<div class="text-center my-class2" style="text-decoration: none; color : #fff;" onmouseover="this.style.color='#000'" onmouseout="this.style.color='#fff'"><i class="fa-solid fa-lock"></i>&nbsp;&nbsp;<c:out value="${qna.qnaBbsTitle}"/></div>				
		   		</a>
		   	</c:if>
		   	<c:if test = "${qna.qnaBbsSecret eq 'N'}">
		   		<a href="javascript:void(0)" onclick="fn_view(${qna.qnaBbsSeq})">
			
				<div class="text-center my-class2"  style="text-decoration: none; color : #fff;" onmouseover="this.style.color='#000'" onmouseout="this.style.color='#fff'"><c:out value="${qna.qnaBbsTitle}"/></div>
			
		   		</a>
		   	</c:if>
		</c:if>
		
		
		<c:if test="${admin ne 3}">	
			<c:if test="${qna.qnaBbsSecret eq 'Y'}">
				<c:if test="${cookieUserId eq qna.userId}">
					
			  		<a href="javascript:void(0)" onclick="fn_view(${qna.qnaBbsSeq})"/>
			  		<div class="text-center my-class2" style="text-decoration: none; color : #fff;" onmouseover="this.style.color='#000'" onmouseout="this.style.color='#fff'"><i class="fa-solid fa-lock"></i>&nbsp;&nbsp;<c:out value="${qna.qnaBbsTitle}"/></div>
			  	</c:if>
			  	
			  	<c:if test="${cookieUserId ne qna.userId}">
			  		
			  		<a href="javascript:void(0)" onclick="fn_check()"/>	
			  		<div class="text-center my-class1" ><i class="fa-solid fa-lock"></i>&nbsp;&nbsp;<c:out value="비밀글입니다."/></div>
			  	</c:if>
		
			      	 	
			</c:if>     
			      
			<c:if test="${qna.qnaBbsSecret eq 'N'}">
			
		  		<a href="javascript:void(0)" onclick="fn_view(${qna.qnaBbsSeq})">
			
				<div class="text-center my-class2" style="text-decoration: none; color : #fff;" onmouseover="this.style.color='#000'" onmouseout="this.style.color='#fff'">
    <c:out value="${qna.qnaBbsTitle}"/>
</div>

			
		   		</a>
			</c:if>
		</c:if>
		 
		</td>
    	<td class="text-center"><c:out value="${qna.userName}"/></td>
    	<td class="text-center">${qna.qnaRegDate}</td>
    	<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="3" value="${qna.qnaBbsReadCnt}"/></td>
    	<td class="text-center"><c:out value="${qna.qnaBbsAnswerState eq 'Y' ? '답변완료' : '답변 미완료'}"/></td>
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
      
       <button type="button" id="btnWrite" class="btn btn-warning btn-sm amber accent-4">글쓰기</button>
      <div class="main-body-card-paging-fff">
      	<div class="content_detail__pagination cdp">
      	<c:if test="${!empty paging}">
      		 <c:if test="${!empty paging}">
         	<c:if test="${paging.prevBlockPage gt 0}">
            	<a onclick="fn_list(${paging.prevBlockPage})"  href="javascript:void(0)" class="cdp_i">prev</a>
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
                            <a  href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})" class="cdp_i">next</a>
         	</c:if>
         </c:if>
      	</c:if>
      	</div>
      </div>
      
      
  
   <form name="bbsForm" id="bbsForm" method="post">
   	<input type="hidden" name="qnaBbsSeq" value="" />
   	<input type="hidden" name="searchType" value="${searchType}" />
   	<input type="hidden" name="searchValue" value="${searchValue}" />
   	<input type="hidden" name="curPage" value="${curPage}" />
   	
   </form>
    
    </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>