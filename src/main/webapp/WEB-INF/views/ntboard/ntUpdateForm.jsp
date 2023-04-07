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
	$("#ntBbsTitle").focus();
	
	 $('#upload').on('click', function () {
     	
	        var form = $('#writeForm')[0];
			var formData = new FormData(form);
		
			$.ajax({
				type:"POST",
				enctype:"multipart/form-data",
				url:"/ntboard/updateProc",
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
						alert('게시물이 등록되었습니다.');
						location.href = "/ntboard/ntlist";
					}
					else if(response.code == 400)
					{
						alert('파라미터값이 올바르지않습니다.');
						$('#btnWrite').prop("disabled", false);
					}
					else
					{
						alert('게시물 등록중 오류발생.');
						$('#btnWrite').prop("disabled", false);
					}
				},
				error:function(error){
					icia.common.error(error);
					alert('게시물 등록 중 오류가 발생했습니다.');
					$('#btnWrite').prop("disabled", false);
				}
		    });
	     });
		
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/ntboard/ntlist";
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
	 $(".summernote").summernote('code',  '${ntBoard.ntBbsContent}');
});
</script>
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<body style="margin: 0px; overflow-x: hidden;">
    <div class="main-container">
    <div style="width:50px; height:50px"></div>    
        <div class="main-form">
            <div class="input-form">
            <h2>공지사항 수정</h2>
	        <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">    
		            	<input type="text" style="color: #191919; width: 100%; margin-bottom:20px;" id="ntBbsTitle" name="ntBbsTitle" value="${ntBoard.ntBbsTitle}" placeholder="제목을 입력해주세요.">
		            <textarea class="summernote textarea" id="ntBbsContent" name="ntBbsContent"></textarea>
		            
		         <div style="text-align: left; margin-top:20px;">
		            <label for="ntFile"><div class="btn-upload btn btn-dark">파일 업로드하기</div>
		            </label>
		         </div>
		            <input type="file" id="ntFile" name="ntFile" style="display: none;">
		            <input type="hidden" value="${ntBoard.ntBbsSeq}" id="ntBbsSeq" name="ntBbsSeq"> 
		            
        	</form>
		    </div>
			<form name="bbsForm" id="bbsForm" method="post">
		        	<input type="hidden" name="ntBbsSeq" value="${ntBoard.ntBbsSeq}" />
					<input type="hidden" name="curPage" value="${curPage}" />
		    </form>   
		<div class="btn-form">
		            <button type="button" id="upload" class="btn btn-dark">등록</button>
		            <button type="button" id="btnList"  class="btn btn-dark">목록</button>
		</div>
		</div>
    </div>
</body>
</html>