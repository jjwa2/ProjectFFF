<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>후기 수정페이지</title>
	<link rel="stylesheet" href="/resources/style/rvUpdateForm.css">
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
    
<script type="text/javascript">
$(document).ready(function() {
	$("#rvTitle").focus();
	
	$("#btnUpdate").on("click", function() {
		$("#btnUpdate").prop("disabled", true);
		
		if($.trim($("#rvTitle").val()).length <= 0)
		{
			alert("제목을 입력해주세요.");
			$("#rvTitle").val("");
			$("#rvTitle").focus();
			
			$("#btnUpdate").prop("disabled", false);
			return;
		}
		
		if($.trim($("#rvContent").val()).length <= 0)
		{
			alert("내용을 입력해주세요.");
			$("#rvContent").val("");
			$("#rvContent").focus();
			
			$("#btnUpdate").prop("disabled", false);
			return;
		}
		
		var form = $("#updateForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			enctype:"multipart/form-data",
			url:"/rvBoard/rvUpdateProc",
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
					alert("게시물이 수정 되었습니다.");
					document.bbsForm.action = "/rvBoard/rvList";
					document.bbsForm.submit();
				}
				else if(response.code == 400)
				{
					alert("파라미터값이 올바르지않습니다.ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ");
					$("#btnUpdate").prop("disabled", false);
				}
				else if(response.code == 404)
				{
					alert("게시물을 찾을 수 없습니다.");
					location.href = "/rvBoard/rvList";
				}
				else if(response.code == 409)
				{
					alert("파라미터값이 올바르지않습니다.99999999999");
					$("#btnUpdate").prop("disabled", false);
				}
				else if(response.code == 410)
				{
					alert("파라미터값이 올바르지않습니다.101010101010");
					$("#btnUpdate").prop("disabled", false);
				}
				else
				{
					alert("게시물 수정 중 오류가 발생했습니다.1111");
					$("#btnUpdate").prop("disabled", false);
				}
			},
			error:function(error){
				icia.common.error(error);
				alert("게시물 수정 중 오휴가 발생하였습니다.");
				$("#btnUpdate").prop("disabled", false);
			}
	     });
	});
		
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/rvBoard/rvList";
		document.bbsForm.submit();
	});
	
	 $('.summernote').summernote({
	           // 에디터 높이
	           width:1100,
	           height: 340,
	           maxHeight: 340,
	           // 에디터 한글 설정
	           lang: "ko-KR",
	           placeholder: '내용을 입력해주세요.',
	           callbacks: {
	                 onInit: function (c) {
	                     c.editable.html('');
	                 }
	             },
	           toolbar: [
	                // 글꼴 설정
	                ['fontname', ['fontname']],
	                // 글자 크기 설정
	                ['fontsize', ['fontsize']],
	                // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	                ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	                // 글자색
	                ['color', ['forecolor','color']],
	                // 표만들기
	                ['table', ['table']],
	                // 글머리 기호, 번호매기기, 문단정렬
	                ['para', ['ul', 'ol', 'paragraph']],
	                // 줄간격
	                ['height', ['height']],
	                // 코드보기, 확대해서보기, 도움말
	                ['view', ['codeview','fullscreen', 'help']]
	              ],
	              // 추가한 글꼴
	            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
	             // 추가한 폰트사이즈
	            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	            
	}); 
	 $(".summernote").summernote('code',  '${review.rvContent}');
});
</script>
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<body style="margin: 0px; overflow-x: hidden;">
<c:if test="${!empty review}">
    <div class="main-container">
 <div style="width:50px; height:50px"></div>    
        <div class="main-form">
            <div class="input-form"><h2>게시글 수정</h2>
	        <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">    
		            <input type="text" value="${review.rvTitle}"  style="color: #191919; width: 100%; margin-bottom:20px;" id="rvTitle" name="rvTitle">
		            <textarea class="summernote textarea" id="rvContent" name="rvContent"></textarea>
		            
		            <div style="text-align: left; margin-top:20px;">
		            <label for="rvFile"><div class="btn-upload btn btn-dark">파일 업로드하기</div>
		            </label>
		         </div>
		            
		            <input type="file" style="text-align:start; width:100%; margin-top:20px;" id="rvFile" name="rvFile">
		            <input type="hidden" value="${review.rvSeq}" id="rvSeq" name="rvSeq"> 
		            
        	</form>
		    </div>
			<form name="bbsForm" id="bbsForm" method="post">
		        	<input type="hidden" name="rvSeq" value="${review.rvSeq}" />
					<input type="hidden" name="searchType" value="${searchType}" />
					<input type="hidden" name="searchValue" value="${searchValue}" />
					<input type="hidden" name="curPage" value="${curPage}" />
		    </form>   
		<div class="btn-form">
		            <button type="button" id="btnUpdate" class="btn btn-dark">수정</button>
		            <button type="button" id="btnList" class="btn btn-dark">목록</button>
		</div>
		</div>
    </div>
</c:if>
</body>
</html>