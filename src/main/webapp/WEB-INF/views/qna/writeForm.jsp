<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <script src="/resources/summernote/summernote-lite.js"></script>
    <script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
    
    
    <link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<link rel="stylesheet" href="/resources/style/qna_write.css">
	
	
	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
	<!-- nav바 필수 cdn -->
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>
  
    <!-- 드롭다운 -->
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  		integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  		crossorigin="anonymous"></script>
  
  
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">
  

 <!-- toastr -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" 
   integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" 
   crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" 
integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" 
crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


	
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function(){
	
	var qnaBbsSecret = ""; // 체크박스 상태 저장 변수
	
	$("#qnaBbsTitle").focus();
	
	$("#qnaBbsSecret").on("click", function() {
		
	    if ($("#qnaBbsSecret").is(":checked")) 
	    {
	    	qnaBbsSecret = "Y"; // 체크됐을 때
	    } 
	    else 
	    {
	    	qnaBbsSecret = "N"; // 체크 안됐을 때
	    }
	});
	
	$("#btnWrite").on("click", function(){
		 $("#btnWrite").prop("disabled" , true);	//글쓰기 저장버튼 비활성화
		   
	      if($.trim($("#qnaBbsTitle").val()).length <= 0)
	      {
	    	  toastr.warning("제목을 입력하세요.");
	    	  $("#qnaBbsTitle").val("");
	    	  $("#qnaBbsTitle").focus();
	    	  
	    	  $("#btnWrite").prop("disabled", false);
	    	  
	    	  return;
	    	  
	      }	  
		 
	      if($.trim($("#qnaBbsContent").val()).length <= 0)
	      {
	    	  toastr.warning("내용을 입력하세요");
	    	  $("#qnaBbsContent").val("");
	    	  $("#qnaBbsContent").focus();
	    	  
	    	  $("#btnWrite").prop("disabled", false);
	    	  
	    	  return;
	      }	
	      
	      var form = $("#writeForm")[0];
	      var formData = new FormData(form);
		  //스프링 프레임워크에서는 디스패쳐가 컨트롤러를 찾을 때 해당 url의 값을 가지고 RequsetMapping어노테이션을 찾아간다. 
		  
		  // isPrivate 변수를 formData에 추가
      	  formData.append("qnaBbsSecret", qnaBbsSecret);
		  
	      $.ajax({
	    	  type:"POST",
	    	  enctype:"multipart/form-data",
	    	  url:"/qna/writeProc",
	    	  data:formData,
	    	  processData:false,				
	    	  contentType:false,				
	    	  cache:false,
	    	  beforeSend:function(xhr){
	    		  xhr.setRequestHeader("AJAX" , "true");
	    	  },
	    	  success:function(response)
	    	  {
	    		  if(response.code == 0)
	    			{
	    			  Swal.fire({
	    				  title:'게시글이 등록되었습니다.',
	    				  icon:'success',
	    				  confirmButtonColor: '#3085d6',
	    				  confirmButtonText: '확인'		 
	    			  }).then((result)=>{
	    				  if(result.isConfirmed){
	    					  location.href = "/qna/inquiry";
	    				  }
	    				  
	    			  })
	    		
	    			  
	    			}
	    		  else if(response.code == 400)
	    			{
	    			  toastr.warning("파라미터 값이 올바르지 않습니다.");
	    			  //버튼 활성화 처리
	    			  $("#btnWrite").prop("disabled", false);
	    			}  
	    		  else
	    			{
	    			  toastr.error("게시물 등록 중 오류가 발생하였습니다.");
	    			  $("#btnWrite").prop("disabled",false);
	    			}  
	    	  },
	    	  error:function(error)
	    	  {
	    		  icia.common.error(error);
	    		  toastr.error("게시물 등록 중 오류가 발생하였습니다.");
	    		  $("#btnWrite").prop("disabled", false);	//저장버튼 활성화
	    	  }
	      });
	});
	
	$("#btnList").on("click", function() {
		   document.bbsForm.action = "/qna/inquiry";
		   document.bbsForm.submit();
		  
	   });

	
	$('.summernote').summernote({
        // 에디터 높이
        width:1300,
        height: 340,
        minHeight:340,
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
	
	
	
	toastr.options = {
			  "closeButton": true,
			  "debug": false,
			  "newestOnTop": false,
			  "progressBar": false,
			  "positionClass": "toast-top-center",
			  "preventDuplicates": false,
			  "onclick": null,
			  "showDuration": "100",
			  "hideDuration": "1000",
			  "timeOut": "2500",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut"
			}
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="background">
  <div class="container">
	<div class="snstitle">
      <div class="snstitlemain">문의글 작성</div>
    </div>
    
	 <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
      <input type="text" name="userName" id="userName" maxlength="20" value="${user.userName}" style="ime-mode:active;" class="form-control  mt-2 mb-2" readonly />
      <input type="text" name="qnaBbsTitle" id="qnaBbsTitle" maxlength="100" placeholder="제목을 입력하세요" style="ime-mode:active;" class="form-control mb-2" required />
      <div class="form-group">
         <textarea  class="summernote" rows="10" name="qnaBbsContent" id="qnaBbsContent"  style="ime-mode:active; resize : none;" placeholder="" required></textarea>
      </div>
      <div class="form-group row">
         <div class="col-sm-12">
            <button type="button" id="btnWrite" class="sear_btn btn btn-warning" title="등록">등록</button>
            <button type="button" id="btnList" class="sear_btn btn btn-dark" title="목록">목록</button>
           	<input type="checkbox" name="qnaBbsSecret" id="qnaBbsSecret" class="checkbox"/>비밀글
            
         </div>

      </div>
   </form>
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="searchType" value="" />
      <input type="hidden" name="searchValue" value="" />
      <input type="hidden" name="curPage" value="" />
   </form>
	
</div>
</div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>