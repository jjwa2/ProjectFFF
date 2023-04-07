<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후기 리스트</title>
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
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">
	    
	  		
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
<c:choose>
	<c:when test="${empty review}">
	
		alert("조회하신 조회물이 존재하지 않습니다.");
		document.bbsForm.action = "/rvBoard/rvList";
		document.bbsForm.submit();
	
	</c:when>
	<c:otherwise>
	
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/rvBoard/rvList";
		document.bbsForm.submit();
	});
	
<c:if test="${boardMe eq 'Y'}">
	$("#btnUpdate").on("click", function() {
		document.bbsForm.action = "/rvBoard/rvUpdateForm";
		document.bbsForm.submit();
	});
	
	$("#btnDelete").on("click", function(){
		if(confirm("게시물을 삭제 하시겠습니까?") == true)
		{
			//ajax
			$.ajax({
				type:"POST",
				url:"/rvBoard/delete",
				data:{
					rvSeq:<c:out value="${review.rvSeq}" />
				},
				dataType:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code == 0)
					{
						alert("게시물이 삭제되었습니다.");
						location.href = "/rvBoard/rvList";
					}
					else if(response.code == 400)
					{
						alert("파리미터 값이 올바르지않습니다.");
					}
					else if(response.code == 404)
					{
						alert("게시물을 찾을 수 없습니다.");
						location.href = "/rvBoard/rvList";
					}
					
					else
					{
						alert("게시물 삭제 중 오류가 발생하였습니다.");
					}
				},
				error:function(xhr, status, error){
						icia.common.error(error);
				}
			});
		}
	});
</c:if>
	</c:otherwise> 
</c:choose>  

$('#reply-btn').on('click', function () {
	
	if($.trim($('#rvReplyContent').val()).length <= 0)
	{
		alert('댓글을 입력하세요.');
		$('#rvReplyContent').val("");
		$('#rvReplyContent').focus();
		return;
	};	
	
	if($('#rvReplyContent').val().length > 100)
	{
		alert('댓글은 100자까지만 입력가능합니다.');
		$('#rvReplyContent').focus();
		return;
	};
	
    var form = $('#rvReplyForm')[0];
	var formData = new FormData(form);
	
	$.ajax({
		type:"POST",
		enctype:"multipart/form-data",
		url:"/rvBoard/rvReplyProc",
		data:formData,
		processData:false,			//formData를 String으로 변환하지않음
		contentType:false,			//contentType해더가 multipart/form-data로 전송
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				document.bbsForm.action = "/rvBoard/rvView";
				document.bbsForm.submit();
			}
			else if(response.code == 400)
			{
				alert('로그인 후 댓글을 작성해주세요.');
			}
			else
			{
				alert('댓글 등록중 오류발생.');
			}
		},
		error:function(error){
			icia.common.error(error);
			alert('댓글 등록 중 오류가 발생했습니다.');
		}
    });
   });



});


function fn_replyDelete(val)
{
	if(confirm("댓글을 삭제 하시겠습니까?") == true)
	{	
		//ajax
		$.ajax({
			type:"POST",
			url:"/rvBoard/replyDelete",
			data:{
				rvReplySeq:val
			},
			datatype:"JSON",
			
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX","true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					document.bbsForm.action = "/rvBoard/rvView";
					document.bbsForm.submit();
				}
				else if(response.code == 500)
				{
					alert("댓글 작성자가 아닙니다.");
					location.href = "/rvBoard/rvView";
				}
				else if(response.code == 400)
				{
					alert("댓글이 존재하지않습니다.");
					location.href = "/rvBoard/rvView";
				}
				else
				{
					alert("시스템 오류가 발생하였습니다.");
				}
			},
			error: function(xhr,status,error)
			{
				icia.common.error(error);
			}
		});
		
	}
}
</script>

<body style="margin: auto 0; overflow-x: hidden;">
<c:if test="${!empty review}">
    <div class="view"  style="margin: 0 auto; width:80%">
        <div class="view-main">
            <div class="view-main-info">
                <div class="view-title">
                    <hr>
                    <p style="font-size: 30px; padding-left:20px"><c:out value="${review.rvTitle}"/></p>
                </div>
                <div class="view-info">
                    <div class="view-info-detail" style="padding-left:15px; margin-bottom:10px">
                        <div class="view-writer"><c:out value="${review.userId}"/> &nbsp; | </div>
                        <div class="view-regdate"><c:out value="${review.regDate}"/> &nbsp; | </div>
                        <div class="view-readcnt">조회수 : <c:out value="${review.readCnt}"/></div>
                    </div>
                    <div style="width: 50%;"></div>
                </div>
            </div>
            <hr>
            <div class="view-content" style="padding-left: 20px;">
            <img src="/resources/upload/${review.rvFileName}">
                <p>${review.rvContent}</p>
            </div>
            <hr>
            <div class="writebtn">
           	 	<button type="button" id="btnList" class="btn btn-warning btn-sm amber accent-4">리스트</button> &nbsp;
           	<c:if test="${boardMe eq 'Y'}">
                <button type="button" id="btnUpdate" class="btn btn-warning btn-sm amber accent-4">수정</button> &nbsp;
				<button type="button" id="btnDelete"  class="btn btn-warning btn-sm amber accent-4">삭제</button>
			</c:if>
            </div>
        </div>
        
        
        
        
        
        <!-- 댓글 영역 시작 -->
        
        <p style="font-size: 20px width:70%; height:30px;">댓글</p>
        <div class="reply-main">
    <c:if test="${!empty replyList}">
    		<c:forEach var="reviewReply" items="${replyList}" varStatus="status">
            	<div class="reply-main-view">
            		<input type="hidden" value="${reviewReply.rvReplySeq}"  id="rvReplySeq" name="rvReplySeq">
                	<div class="reply-writer">${reviewReply.userId}</div>
                	<div class="reply-content">${reviewReply.rvReplyContent}</div>
                	<div class="reply-regdate">${reviewReply.regDate}</div>
                	<c:if test="${reviewReply.userId eq cookieUserId}">
                		<button type="button" id="replyDelete" name="replyDelete" onClick="fn_replyDelete(${reviewReply.rvReplySeq})"
                		 class="reply-delete"><i class="bi bi-x-square"></i></button>
                	</c:if>
           	 </div>
        	</c:forEach>
   </c:if>
            
            <div class="reply-writeform">
            <form id="rvReplyForm" name="rvReplyForm"  method="post">
            	<input type="hidden" value="${reviewReply.userId}" id="userId" name="userId">
            	<input type="hidden" value="${review.rvSeq}"  id="rvSeq" name="rvSeq">
                <textarea id="rvReplyContent" name="rvReplyContent" class="rvReplyContent"></textarea>
                <button type="button" id="reply-btn" class="btn btn-warning btn-sm amber accent-4">reply</button>
            </form>
            
            </div>
        </div>
    </div>

		<!-- 댓글 영역 끝  -->
		



    <!-- footer 시작 -->
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

        <!-- footer 끝 -->
</c:if>

<form name="bbsForm" id="bbsForm" method="post">
	<input type="hidden" name="rvSeq" value="${rvSeq}" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>

</body>
</html>