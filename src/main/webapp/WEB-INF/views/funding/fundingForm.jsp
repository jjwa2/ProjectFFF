<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/resources/style/fundingForm.css">
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
 
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">


  
      <!-- Compiled and minified CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

      <!-- Compiled and minified JavaScript -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

      <!--MATERRIALIZW 아이콘 CDN-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

      <!-- 자바스크립트 -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  
     <!-- 드롭다운 -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  	  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  	  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>
  
 	 <!-- 아이콘 cdn -->
     <script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>
     
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#fundUpload").on("click", function(){
		var form =$("#fundingForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			
			type:"POST",
			enctype:"multipart/form-data",
			url:"/fund/uploadProc", //컨트롤러로
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
					alert("펀딩 등록신청이 완료 되었습니다.")
					location.href = "/snsboard/artistMypage";
				}
				else if(response.code == 400)
				{
					alert("등록 중 서버에 문제가 발생하였습니다.33")
					location.href = "/snsboard/artistMypage";
				}
				else if(response.code == 500)
				{
					alert("파라미터 값이 올바르지 않습니다.")
					location.href = "/snsboard/artistMypage";
				}
				else
				{
					alert("펀딩 등록 중 오류가 발생하였습니다.22");
					location.href = "/snsboard/artistMypage";
				}
			},
			error:function(error)
			{
				icia.common.error(error);
				alert("펀딩 등록 중 오류가 발생하였습니다.11");
			}
			
	      });
	});

	
});



//우편주소 js
function findAddr() {
    new daum.Postcode({
      oncomplete: function (data) {
        console.log(data);

        var roadAddr = data.roadAddress;
        var jibunAddr = data.jibunAddress;

        document.getElementById('userAdd3').value = data.zonecode;
        if (roadAddr !== '') {
          document.getElementById("userAdd").value = roadAddr;
        }
        else if (jibunAddr !== '') {
          document.getElementById("userAdd").value = jibunAddr;
        }
      }
    }).open();
  }



</script>



  
<title>Insert title here</title>
</head>
<body>
  <div class="main-background">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

 <form name="fundingForm" id="fundingForm" method="post" enctype="multipart/form-data">
    <div class="white-bg">
      <div class="funding-funding">
        <p style="font-size: 20px;">펀딩 계획서</p>
      </div>
     
      
      <div class="funding-head">
        <div class="funding-title">
                      <div class="row">
                          <div class="row">
                            <div class="input-field col s12">
                              <textarea id="fundTitle" name="fundTitle" class="materialize-textarea" placeholder="펀딩 제목을 입력해주세요." >THE 23TH ANNUAL SUNSET DANCE CONCERT</textarea>
                              <label for="fundTitle">펀딩 제목</label>
                            </div>
                          </div>
                      </div>
        </div>
        <div class="funding-date">
          <div class="funding-date-end">
              <div class="textForm">
                <div class="col s12">
                  <div class="row">
                    <div class="input-field col s12">
                      <input type="date" class="datepicker" id="fundEndDate" name="fundEndDate">
                      <label for="fundEndDate">펀딩마감날짜</label>
                    </div>
                  </div>
                </div>
              </div>
          </div>
        
          <div class="funding-date-start">
            <div class="textForm">
              <div class="col s12">
                <div class="row">
                  <div class="input-field col s12">
                    <input type="date" class="datepicker" id="fundArtDate" name="fundArtDate">
                    <label for="fundStartDate">공연날짜</label>
                  </div>
                </div>
              </div>
            </div>
          </div>


        </div>
      </div>
      

        <div class="col s12" style="margin-left: 20px; margin-right: 20px;">
          <div class="row">
            <div class="input-field col s12">

              <input type="text" name="userAdd" id="userAdd" class="autocomplete" placeholder="도로명" style="position: relative;" readonly>

              <input id="userAdd3" class="waves-effect waves-light btn" type="button" value="우편번호" readonly onclick="findAddr()" style="margin-right: 20px; position: absolute; right: 0; width: auto;">

              <input type="text" class="detail_addr" name="userAdd2" id="userAdd2" placeholder="공연장 상세 주소" value = "홍대 상상마당">
              <label for="autocomplete-input">공연장 주소</label>

            </div>
          </div>
        </div>



        <div style="margin-left: 30px;">
          공연연령대
        </div>
        <div class="funding-body2" style="margin-left: 100px; margin-top:20px;">
            <p style="flex-grow : 1;">
              <label>
                <input name="fundAge" id="fundAge" value="전체관람가" type="radio" checked />
                <span>전체관람가</span>
              </label>
            </p>
            <p style="flex-grow : 1;">
              <label>
                <input name="fundAge" id="fundAge" value="만 15세 이상" type="radio" />
                <span>만 15세 이상</span>
              </label>
            </p>
            <p style="flex-grow : 1;">
              <label>
                <input name="fundAge" id="fundAge" value="만 19세 이상" type="radio"  />
                <span>만 19세 이상</span>
              </label>
            </p>
        </div>

      <div class="funding-body3">
        <div class="row">
            <div class="row">
              <div class="input-field col s6">
                <input id="fundCapa" name="fundCapa" type="text" class="validate" value = "500">
                <label for="fundCapa">공연장 수용인원</label>
              </div>
              <div class="input-field col s6">
                <input id="fundGoal" name="fundGoal" type="tel" class="validate" value = "5000000">
                <label for="fundGoal">목표금액</label>
              </div>
            </div>
        </div>
      </div>
      <hr class="hr-1 yellow darken-4" >
      
      <div class="funding-foot">
        <div class="funding-tear1">
                  <div class="funding-tear2-title">
            결제상품 별 결제금액을 입력해주세요(*필수사항)
          </div>
                    <br>
                  <div class="row">
            <div class="input-field col s6">
              티어 1 결제금액: 
              <input value="10000" id="tear1price" name="tear1price" type="text" class="validate" >
            </div>
          </div>

          <div class="row">
            <div class="input-field col s6">
              티어 2 결제금액: 
              <input value="30000" id="tear2price" name="tear2price" type="text" class="validate" >
            </div>
          </div>

          <div class="row">
            <div class="input-field col s6">
              티어 3 결제금액: 
              <input value="50000" id="tear3price" name="tear3price" type="text" class="validate" >
            </div>
          </div>
          
          <div class="row">
            <div class="input-field col s6">
              티어 4 결제금액: 
              <input value="100000" id="tear4price" name="tear4price" type="text" class="validate" >
            </div>
          </div>
          
                            <div>
            포스터
          </div>
        

    <div class="file-field input-field">
      <div class="btn">
        <span>File</span>
        <input type="file" id="fundPoster" name="fundPoster">
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text" id="fundPoster" name="fundPoster">
      </div>
    </div>

          <div class="row">
            <div class="input-field col s6">
               샘플영상Url:
              <input value="https://www.youtube.com/watch?v=haPZ2olT4N0" id="tear1product" name="tear1product" type="text" class="validate">
            </div>
          </div>
          
        </div>
        

        
        
        
        <div class="funding-tear2">

          <div>
            결제상품 별 베네핏을 입력해주세요(*선택사항)
          </div>
          <br>
         <div class="row">
            <div class="input-field col s6" style="text-align:center;">
            </div>
            <br>
            <P>* 티어 1 은 특전상품이 없는 기본 가격입니다.<P>
            <br>

          </div>
          <div class="row">
            <div class="input-field col s6">
              티어 2 상품특전: 
              <input value="인천을 대표해 1집 및 싸인 등본" id="tear2product" name="tear2product" type="text" class="validate" >
            </div>
          </div>

          <div class="row">
            <div class="input-field col s6">
              티어 3 상품특전: 
              <input value="아티스트 Nero의 손편지" id="tear3product" name="tear3product" type="text" class="validate">
            </div>
          </div>

          <div class="row">
            <div class="input-field col s6">
              티어 4 상품특전: 
              <input value="아티스트 Nero와의 저녁식사권" id="tear4product" name="tear4product" type="text" class="validate">
            </div>
          </div>

          <div>
           브로셔
          </div>
        

    <div class="file-field input-field">
      <div class="btn">
        <span>File</span>
        <input type="file" id="fundFile" name="fundFile">
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text" id="fundFile" name="fundFile">
      </div>
    </div>
  
  
          <button type="button" id="fundUpload" class="waves-effect waves-light btn-large"><i class="material-icons left">cloud</i>계획서 제출하기</button>
        
  
        </div>

      </div>
      
        </div>
      </div>
    </div>
    </form>


    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  

</body>
</html>