<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
	<link rel="stylesheet" href="/resources/style/rvView.css">
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
  		
  	<!-- 리스크 페이지 아이콘 CDN -->
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
  		
  	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <script src="/resources/summernote/summernote-lite.js"></script>
    <script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
    <link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
  		
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/ntboard/ntlist";
		document.bbsForm.submit();
	});
	
	$("#btnUpdate").on("click", function() {
		document.bbsForm.action = "/ntboard/ntUpdateForm";
		document.bbsForm.submit();
	});
	
	$("#btnDelete").on("click", function(){
		if(confirm("게시물을 삭제 하시겠습니까?") == true)
		{
			//ajax
			$.ajax({
				type:"POST",
				 url:"/ntboard/delete",
				 data: {
					 ntBbsSeq:<c:out value="${ntBoard.ntBbsSeq}" />
				 },
				 datatype:"JSON",
				 beforeSend:function(xhr) {
						xhr.setRequestHeader("AJAX","true");
					},
					success:function(response) {
						if(response.code==0) {
							alert("게시물이 삭제되었습니다.");
							location.href="/ntboard/ntlist";
						}
						else if(response.code==400) {
							alert("파라미터 값이 올바르지 않습니다.");
						}
						else if(response.code==404) {
							alert(" 게시물을 찾을 수 없습니다.");
							location.href="/ntboard/ntlist";
						}
						else if(response.code==-999) {
							alert("답변 게시물이 존재하여 삭제할 수 없습니다.");
						}
						else {
							alert("게시물 삭제 중 오류가 발생하였습니다.");
						}
						
					},
					error:function(xhr,status,error) {
						icia.common.error(error);
					}
						
			});
		}
	});

});

</script>

<body style="margin: auto 0; overflow-x: hidden;">
<c:if test="${!empty ntBoard}">
    <div class="view"  style="margin: 0 auto; width:80%">
        <div class="view-main" style="margin:50px;">
            <div class="view-main-info">
                <div class="view-title">
                    <hr>
                    <p style="font-size: 30px; padding-left:20px"><c:out value="${ntBoard.ntBbsTitle}"/></p>
                </div>
                <div class="view-info">
                    <div class="view-info-detail" style="padding-left:15px; margin-bottom:10px;justify-content: unset;">
                        <div class="view-writer"><c:out value="${ntBoard.userId}"/> &nbsp; | &nbsp;&nbsp;</div>
                        <div class="view-regdate"><c:out value="${ntBoard.ntRegDate}"/> &nbsp; </div>
                        <div class="view-readcnt"></div>
                    </div>
                    <div style="width: 50%;"></div>
                </div>
            </div>
            <hr>
            <div class="view-content" style="padding-left: 20px;">
            <c:if test="${ntBoard.ntFileSize > 0}">
            <img src="/resources/upload/${ntBoard.ntFileName}">
            </c:if>
                <p>${ntBoard.ntBbsContent}</p>
            </div>
            <hr>
            <div class="writebtn">
           	 	<button type="button" id="btnList" class="btn btn-warning btn-sm amber accent-4">목록</button> &nbsp;
           	<c:if test="${admin eq 3}">
                <button type="button" id="btnUpdate" class="btn btn-warning btn-sm amber accent-4">수정</button> &nbsp;
				<button type="button" id="btnDelete"  class="btn btn-warning btn-sm amber accent-4">삭제</button>
			</c:if>
            </div>
        </div>
    </div>


 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</c:if>

<form name="bbsForm" id="bbsForm" method="post">
	<input type="hidden" name="ntBbsSeq" value="${ntBbsSeq}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>

</body>
</html>