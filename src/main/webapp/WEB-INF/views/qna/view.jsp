<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>문의 리스트</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%@ include file="/WEB-INF/views/include/head.jsp" %>

<link
    href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap"
    rel="stylesheet">
<link rel="stylesheet" href="/resources/style/qna_view.css">
<link rel="stylesheet" href="/resources/style/pagination.css">
<!-- 마이페이지 아이콘 -->
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

<!-- Compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

  	<!-- nav바 필수 cdn -->
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<script type="text/javascript">

$(document).ready(function(){
	
	<c:choose>
		<c:when test="${empty qna}">
		
		Swal.fire({
			 title: '올바른 회원이 아닙니다.',
	            icon: 'error',
	            confirmButtonColor: '#f1a712',
	            confirmButtonText: 'OK'             
		}).then((result)=>{
			if(result.isConfirmed)
			{
				document.bbsForm.action = "/qna/inquiry";
				document.bbsForm.submit();
			}	
		})
			
	</c:when>
		
		
	<c:otherwise>
		$("#btnList").on("click", function() {
			document.bbsForm.action = "/qna/inquiry";
			document.bbsForm.submit();
		});
		
		$("#btnReply").on("click", function() {
			document.bbsForm.action = "/qna/replyForm";
			document.bbsForm.submit();
		});
			
		<c:if test="${boardMe eq 'Y' || admin eq 3}">
		
		$("#btnUpdate").on("click", function() {
			document.bbsForm.action = "/qna/updateForm";
			document.bbsForm.submit();
		});
		
		
		
		$("#btnDelete").on("click", function(){
			Swal.fire({
				 title: '삭제하시겠습니까?',
		            icon: 'question',
		            showCancelButton: true,
		            confirmButtonColor: '#3085d6',
		            cancelButtonColor: '#d33',
		            confirmButtonText: '승인',
		            cancelButtonText: '취소'
		         
			}).then((result)=>{
				if(result.isConfirmed)
			{
				
				var qnaBbsSeq = ${qna.qnaBbsSeq};
				
				$.ajax
				({
					type:"POST",
					url:"/qna/delete",
					data:{
						qnaBbsSeq: qnaBbsSeq
					},
					datatype:"JSON",
				    beforeSend:function(xhr){
			    	   xhr.setRequestHeader("AJAX" , "true");
			    	  },
			    	  success:function(response)
			    	  {
			    		  if(response.code == 0)
			    		  {
			    			  location.href = "/qna/inquiry";
			    		  }
			    		  else if(response.code == 400)
			    		  {
			    			  Swal.fire("파라미터 값이 올바르지 않습니다.", 'error');
			    		  }
			    		  else if(response.code == 404)
			    		  {
			    			  alert("게시물을 찾을 수 없습니다.");
			    			  location.href = "/qna/inquiry";
			    		  }	  
			    		  else if(response.code == -999)
			    		  {
			    			  Swal.fire("댓글 게시물이 존재하여 삭제할 수 없습니다.",'error');
			    		  }	  
			    		  else
			    		  {
			    			  Swal.fire("게시물 삭제 중 오류가 발생하였습니다.",'error');
			    		  }	  
			    			  
			    	  },
			    	  error:function(xhr, status, error)
			    	  {
			    		  icia.common.error(error);
			    	  }
				});
			}
			})
			
		});
		</c:if>
			
	</c:otherwise>    
</c:choose> 

$("#replybtn").on("click", function(){
	
	var form = $("#qnaReplyForm")[0];
	var formData = new FormData(form);
	
	$.ajax({
		type:"POST",
		enctype:"multipart/form-data",
		url:"/qna/qnaReplyProc",
		data:formData,
		processData:false,			
		contentType:false,			
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{  
				alert("등록되었습니다.");
				document.bbsForm.action = "/qna/view";
				document.bbsForm.submit();
			}

			else if(response.code == 500)
			{
				alert('파라미터값이 올바르지않습니다.');
				location.href = "/qna/inquiry";
			}
			else
			{
				alert('댓글 등록중 오류발생.');
				location.href = "/qna/inquiry";
			}
		},
		error:function(error){
			icia.common.error(error);
			alert('댓글 등록 중 오류가 발생했습니다.');
			location.href = "/qna/inquiry";
		}	
    });
});


$("#replybtn").on("click", function(){
	
	$.ajax({
		type:"POST",
		url:"/qna/qnaReplyState",
		data:{
			qnaBbsSeq:$("#qnaBbsSeq").val()
		},
		dataType: "JSON",
		 beforeSend: function(xhr) {
	    	 xhr.setRequestHeader("AJAX","true");
			
		},
		success:function(response){
			if(response.code==0) {
				location.href="/qna/view"; 
			}
			else if(response.code==400){
				alert("오류 발생.");
				location.href="/qna/view";
			}
			else {
				alert("오류 발생.");
				location.href="/qna/view";
			}
		},
		error:function(xhr,status,error) {
			icia.common.error(error);
		}
	});
});
});

function fn_replyDelete(qnaReplySeq) {
	Swal.fire({
		title:'댓글을 삭제하겠습니까?',
		icon:'question',
		 showCancelButton: true,
         confirmButtonColor: '#3085d6',
         cancelButtonColor: '#d33',
         confirmButtonText: '승인',
         cancelButtonText: '취소'
	}).then((result)=>{
		if(result.isConfirmed){
			
	    $.ajax({
	      type: "POST",
	      url: "/qna/replyDelete",
	      data: {
	        qnaReplySeq: qnaReplySeq
	      },
	      datatype: "JSON",
	      beforeSend: function(xhr) {
	        xhr.setRequestHeader("AJAX", "true");
	      },
	      success: function(response) {
	        if (response.code == 0) 
	        {
	          document.bbsForm.action = "/qna/view";
	          location.reload();
	        } 
			  
	        else if (response.code == 500) 
	        {
	          alert("댓글 작성자가 아닙니다.");
	          location.href = "/qna/view";
	        } 
	        else if (response.code == 400)
	        {
	          alert("댓글이 존재하지않습니다.");
	          location.href = "/qna/view";
	        } 
	        else 
	        {
	          alert("시스템 오류가 발생하였습니다.");
	        }
	      },
	      error: function(xhr, status, error) {
	        icia.common.error(error);
	      }
	    });
	  
		}
	})
	  
	}


</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<c:if test="${!empty qna}">
	<div class="view" style="margin: 0 auto; width:80%">
		<div class="view-main">
			<div class="view-main-info">
				<div class="view-title">
					<hr>
		 			<p style="font-size: 30px; padding-left:20px"><c:out value="${qna.qnaBbsTitle}"/></p>
		 		</div>
				<div class="view-info">
					<div class="view-info-detail" style="padding-left:15px; margin-bottom:10px">
               			<div class="view-writer"><c:out value="${qna.userId}"/> &nbsp; |</div>
                		<div class="view-regdate"><c:out value="${qna.qnaRegDate}"/> &nbsp; |</div>
                		<div class="view-readcnt">조회수 : <c:out value="${qna.qnaBbsReadCnt}"/></div>
            		</div>
            		<div style="width: 50%;"></div>
            	</div>
            </div>
            <hr>
            <div class="view-content" style="padding-left: 20px; padding-top:40px; height: 300px;">
                <p>${qna.qnaBbsContent}</p>
            </div>
			<hr>
			<div class="writebtn">
				<button type="button" id="btnList" class="btn btn-warning btn-sm amber accent-4">리스트</button> &nbsp;
	           	<c:if test="${boardMe eq 'Y'}">
	                <button type="button" id="btnUpdate" class="btn btn-warning btn-sm amber accent-4">수정</button> &nbsp;
					<button type="button" id="btnDelete"  class="btn btn-warning btn-sm amber accent-4">삭제</button>
				</c:if>
				<c:if test="${admin eq 3}">
					<button type="button" id="btnDelete"  class="btn btn-warning btn-sm amber accent-4">삭제</button>
				</c:if>
            </div>
        </div>
		
		<!-- 댓글 영역 시작  -->
		
		<p style="font-size: 20px width:70%; height:30px;"></p>
		<div class="reply-main">
		<c:if test = "${!empty qnaList}">
			<c:forEach var="qnaReply" items="${qnaList}" varStatus="status">
				<div class="reply-main-view">
					<input type="hidden" value="${qnaReply.qnaReplySeq}" id="qnaReplySeq" name="qnaReplySeq">
					<div class="reply-writer">${qnaReply.userId}</div>
					<div class="reply-content">${qnaReply.qnaReplyContent}</div>
					<div class="reply-regdate">${qnaReply.qnaReplyDate}</div>
					<c:if test="${qnaReply.userId eq cookieUserId}">
						<button type="button" class="reply-delete" id="replyDelete" name="replyDelete" onclick="fn_replyDelete(${qnaReply.qnaReplySeq})"
						class="reply-delete"><i class="bi bi-x-square"></i></button>
					</c:if>
				</div>
			</c:forEach>
		</c:if>
		
		<div class="reply-writeform">
		    <form id="qnaReplyForm" name="qnaReplyForm"  method="post">
		    
			    <input type="hidden" value="${qnaReply.userId}" id="userId" name="userId"/>
			    <input type="hidden" value="${qna.qnaBbsSeq}"  id="qnaBbsSeq" name="qnaBbsSeq"/>
		    	<c:if test = "${admin eq 3}">
					<textarea id="qnaReplyContent" name="qnaReplyContent" class="rvReplyContent"></textarea>	
				</c:if>
			</form>
		</div>
		<c:if test = "${admin eq 3}">		
			<div class="reply-writebtn">
		   		<button type="button" name="replybtn" id="replybtn" class="btn btn-warning btn-sm amber accent-4">reply</button>
		  	</div>
		</c:if>	        
		</div>
		<!-- 댓글 영역 끝 -->
	</div>
	
	<!-- footer 시작 -->
   	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   	<!-- footer 끝 -->
</c:if>            
	

<form name="bbsForm" id="bbsForm" method="post">
	<input type="hidden" name="qnaBbsSeq" value="${qnaBbsSeq}" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curpage}" />
</form>



</body>
</html>