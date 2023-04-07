<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>SNS 업로드 페이지</title>
	<link rel="stylesheet" href="/resources/style/snsWriteForm.css">
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
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">
    
    
    
<script type="text/javascript">
$(document).ready(function() {
	
	$("#snsBoardUpload").on("click", function(){
		var form =$("#writeForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			
			type:"POST",
			enctype:"multipart/form-data",
			url:"/sns/writeProc", //컨트롤러로
			data:formData,
			processData:false, 					//formdata를 string으로 변환하지않음
			contentType:false,					//comtent-type헤어가  multipart/form-data로 전송
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("게시물이 등록되었습니다.")
					location.href = "/snsboard/snsmain";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다11.")
				}
				else
				{
					alert("게시물 등록 중 오류가 발생하였습니다.");
				}
			},
			error:function(error)
			{
				icia.common.error(error);
				alert("게시물 등록 중 오류가 발생하였습니다.");
			}
			
	      });
	});
	
	 $('.summernote').summernote({
	           // 에디터 높이
	           width:600,
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
    <div class="main-container">
    
   
    
    <div style="width:50px; height:50px"></div>    
        <div class="main-form">
            <div class="input-form">

			<div class="title">이미지 미리보기</div>




            <div class="uploadpreview">
             
				<img id="previewImage" alt="">
            </div>
	        
	        <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
	        
	        
		            <textarea class="summernote textarea" id="snsContent" name="snsContent"></textarea>
		            
		         <div style="text-align: left; margin-top:20px;">
		            <label for="rvFile"><div class="btn-upload">파일 업로드하기</div>
		            </label>
		         </div>
		            <input type="file" id="rvFile" name="rvFile" accept="image/*">
        	</form>
		    </div>

		<div class="btn-form">
		
		<button type="button" id="snsBoardUpload" class="btn btn-warning btn-sm amber accent-4">등록</button>
		
		</div>
	</div>
    </div>
    
   	    <script>
	      const inputElement = document.getElementById("rvFile");
	      const previewElement = document.getElementById("previewImage");
	
	      inputElement.addEventListener("change", (e) => {
	        const file = e.target.files[0];
	        const reader = new FileReader();
	
	        reader.onload = (event) => {
	          previewElement.src = event.target.result;
	        };
	
	        reader.readAsDataURL(file);
	      });
	    </script> 
    
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    
</body>
</html>