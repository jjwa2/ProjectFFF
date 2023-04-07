<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <link rel="stylesheet" href="/resources/style/artistUpgrade.css">

  <!-- 폰트 영역 CDN-->
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


<script type="text/javascript">
$(document).ready(function() {
	
	$("#artistUpgrade").on("click", function(){
		var form =$("#artistUpdateForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			
			type:"POST",
			enctype:"multipart/form-data",
			url:"/artist/updateProc", //컨트롤러로
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
					alert("아티스트 등급 신청이 완료 되었습니다.")
					location.href = "/index";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.")
				}
				else
				{
					alert("아티스트 등급 신청 중 오류가 발생하였습니다.");
				}
			},
			error:function(error)
			{
				icia.common.error(error);
				alert("아티스트 등급 신청 중 오류가 발생하였습니다.");
			}
			
	      });
	});

	
});
</script>

<title>Insert title here</title>
</head>
<body>
  <div class="main-background">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    
<form name="artistUpdateForm" id="artistUpdateForm" method="post" enctype="multipart/form-data">
<c:if test="${!empty user}">
    <div class="black-bg">
      <div class="white-bg">
        <div class="upgrade-title">
          <p>등급변경요청</p>
        </div>
        <div class="upgrade-main">
          <div class="upgrade-info">
            <div class="upgrade-info-item1">
              <div class="row">
                  <div class="row">
                    <div class="input-field col s6">
                      <textarea id="icon_prefix2" class="materialize-textarea" disabled><c:out value="${user.userId}" /></textarea>
                      <label for="icon_prefix2">ID</label>
                    </div>
                  </div>
              </div>
            </div>
            <div class="upgrade-info-item2">
              <div class="row">
                  <div class="row">
                    <div class="input-field col s6">
                      <textarea id="icon_prefix2" class="materialize-textarea" disabled><c:out value="${user.userName}" /></textarea>
                      <label for="icon_prefix2">사용자 이름</label>
                    </div>
                  </div>
              </div>
            </div>
            <div class="upgrade-info-item3">
              <label>카테고리</label>
              <select class="browser-default" name="userCategoly" id="userCategoly">
                <option value="" disabled selected>장르를 선택해주세요</option>
                <option value="힙합" name="힙합" id="힙합">힙합</option>
                <option value="댄스" name="댄스" id="댄스">댄스</option>
                <option value="재즈" name="재즈" id="재즈">재즈</option>
                <option value="ETC" name="ETC" id="ETC">ETC</option>
              </select>
            </div>
          </div>
          <div class="upgrade-profile">
            <div class="uploadpreview">
					<img id="previewImage" alt="">
            </div>
            <div class="upgrade-profile-upload">
                <div class="file-field input-field" id="fileInput">
                  <div class="btn amber darken-2 btn-small">
                    <span>PROFILE</span>
                    <input type="file" id="fileProfileName" name="fileProfileName">
                  </div>
                  <div class="file-path-wrapper">
                    <input class="file-path validate" type="text">
                  </div>
                </div>
            </div>
            
          </div>
        </div>
        <div class="upgrade-sub">
          <div class="row">
            <div class="input-field col s10">
              <textarea id="userIntroduce" name="userIntroduce" class="materialize-textarea" data-length="100" placeholder="관객들에게 당신을 잘 나타낼 수 있는 글을 작성해주세요"></textarea>
              <label for="userIntroduce">아티스트 소개글</label>
            </div>
          </div>
        </div>
        <div class="upgrade-button" id="artistUpgrade">
          <a class="waves-effect waves-light btn amber darken-2">제출하기</a>
        </div>
      </div>
    </div> 
</c:if>
</form>
</div> 
    
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

  <script>
  // 파일 선택 후 미리보기
  function previewFile() {
    var preview = document.querySelector('.upgrade-profile-preview');
    var file = document.querySelector('input[type=file]').files[0];
    var reader = new FileReader();

    reader.onloadend = function() {
      preview.style.backgroundImage = "url(" + reader.result + ")";
    }

    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.style.backgroundImage = "";
    }
  }

  document.querySelector('#filePreview').addEventListener('change', previewFile);
</script>

   	    <script>
	      const inputElement = document.getElementById("fileProfileName");
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

</body>
</html>