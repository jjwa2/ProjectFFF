<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>공연예매 페이지</title>
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
	$("#ctBbsTitle").focus();
	
	
	 $('#upload').on('click', function () {
     	
		   //공백, 티켓가격 정규식 체크
		   	//모든 공백 체크 정규식
	var emptCheck = /\s/g;
	
	//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
	var numCheck = /^[0-9]+$/; 
	
	if($.trim($('#ctBbsTitle').val()).length <= 0)
	{
		alert('공연제목을 입력하세요.');
		$('#ctBbsTitle').val("");
		$('#ctBbsTitle').focus();
		return;
	}
	
	if($.trim($('#ctBbsContent').val()).length <= 0)
	{
		alert('공연 소개글을 입력하세요.');
		$('#ctBbsContent').val("");
		$('#ctBbsContent').focus();
		return;
	}
	
	if($.trim($('#ctPrice').val()).length <= 0)
	{
		alert('공연 1인 티켓가격을 입력하세요.');
		$('#ctPrice').val("");
		$('#ctPrice').focus();
		return;
	}
	
	if(emptCheck.test($('#ctPrice').val()))
	{
		alert('티켓가격은 공백을 포함할 수 없습니다.');
		$('#ctPrice').focus();
		return;
	}
	
	if(!numCheck.test($('#ctPrice').val()))
	{
		alert('티켓가격 란은 숫자만 입력할 수 있습니다.');
		$('#ctPrice').focus();
		return;
	}
		 
		    //ajax 통신
	        var form = $('#writeForm')[0];
			var formData = new FormData(form);
			
			$.ajax({
				type:"POST",
				enctype:"multipart/form-data",
				url:"/ctBoard/writeProc",
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
						location.href = "/ctBoard/ctlist";
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
		document.bbsForm.action = "/ctBoard/ctlist";
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
	 $(".summernote").summernote('code',  '${c}');
});
</script>
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<body style="margin: 0px; overflow-x: hidden;">
    <div class="main-container">
    <div style="width:50px; height:50px"></div>    
        <div class="main-form">
            <div class="input-form">
            <h2>공연 예매</h2>
	        <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">   
	        			<div>
						      <label>
						        <input name="ctPayType" type="radio" value="spot" checked class="radio"/>
						        <span>현장 결제</span> &nbsp;
						      </label>
						      <label>
						        <input name="ctPayType" type="radio" value="online" class="radio"/>
						        <span>사이트 내 결제</span>
						      </label>
	        			</div> 
	        			<input type="hidden" name="fdBbsSeq" value="${fdBbsSeq}" />
		            	<input type="text" style="color: #191919; width: 100%; margin-bottom:20px;" id="ctBbsTitle" name="ctBbsTitle" placeholder="공연제목을 입력해주세요." value = "DeliSpice INDIE CONCERT" >
		            	<input type="text" style="color: #191919; width: 100%; margin-bottom:20px;" id="ctPrice" name="ctPrice" placeholder="해당 공연의 1인 티켓가격을 입력해주세요." value ="30000">
		            <textarea class="summernote textarea" id="ctBbsContent" name="ctBbsContent" placeholder="공연 소개글을 입력해주세요."></textarea>
		            
		         <div style="text-align: left; margin-top:20px;">
		            <label for="ctFile"><div class="btn-upload btn btn-dark" >파일 업로드하기</div>
		            </label>
		         </div>
		            <input type="file" id="ctFile" name="ctFile" style="display: none;" required="required">
		            <input type="hidden" value="${ctBbsSeq}" id="ctBbsSeq" name="ctBbsSeq"> 
		            
        	</form>
		    </div>
			<form name="bbsForm" id="bbsForm" method="post">
		        	<input type="hidden" name="ctBbsSeq" value="${ctBbsSeq}" />
					<input type="hidden" name="searchType" value="${searchType}" />
					<input type="hidden" name="searchValue" value="${searchValue}" />
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