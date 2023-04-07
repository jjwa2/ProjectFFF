<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/resources/style/artistdetail.css">
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

      <!-- Compiled and minified CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

      <!-- Compiled and minified JavaScript -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

  <title>Document</title>
</head>
<body style="margin: 0px;">
  <div class="main-background">
    <div class="black-bg">
      <div class="white-bg">
        <div class="row">
          <form class="col s12">
            <div class="row">
              <div class="input-field col s12">
                <input placeholder="공연명을 작성해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">공연명</label>
              </div>
              <div class="input-field col s6">
                <input placeholder="목표금액을 작성해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">공연목표금액</label>
              </div>
              <div class="input-field col s6">
                <input placeholder="펀딩마감 날짜를 작성해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">펀딩마감날짜</label>
              </div>
              <div class="input-field col s6">
                <input placeholder="공연일정을 입력해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">공연일정</label>
              </div>
              <div class="input-field col s6">
                <input placeholder="공연장소를 입력해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">공연장소</label>
              </div>
              <div class="input-field col s6">
                <input placeholder="관객 연령제한을 입력해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">공연연령대</label>
              </div>
              <div class="input-field col s6">
                <input placeholder="공연 최대 수용인원을 입력해주세요" id="first_name" type="text" class="validate">
                <label for="first_name">최대 수용인원</label>
              </div>
              
                <div class="row">
				      <div class="row">
				        <div class="input-field col s11">
				          <textarea id="textarea1" class="materialize-textarea"></textarea>
				          <label for="textarea1">Textarea</label>
				        </div>
				      </div>
				 </div>
               
            </div>
          </form>
        </div>
      </div>
    </div> 
    




    <div class="title-container">
      <div class="sub-title">
        펀딩에 도전하세요
      </div>
      <div class="main-title">
        START FUNDING<br><br>
      </div>
      <div>

      </div>
    </div>

    <div class="artist-container">
      <div class="artist-item hover01" id="login">
        <figure>
          <div class="item-logo">
            <img src="/resources/images/icon/start1.png" alt="logo1">
          </div>
          <div class="item-title">
            O P E N
          </div>
          <div class="item-main">
            계획중인 공연에 대한 계획을 정해진<BR>
            양식에 맞춰 작성 후 제출해주세요<BR>
            당사에서 컨펌 후 펀딩을 시작합니다<BR>
              ─────────────────
          </div>
        </figure>
      </div>
      <div class="artist-item hover01">
        <figure>
          <div class="item-logo">
            <img src="/resources/images/icon/start2.png" alt="logo2">
          </div>
          <div class="item-title">
            I N G
          </div>
          <div class="item-main">
            현재 진행중인 펀딩 정보를<BR>
            확인하실 수 있는 버튼입니다<BR>
            펀딩 진행사항을 체크해주세요<BR>
            ──────────────
          </div>
        </figure>
      </div>
      <div class="artist-item hover01">
        <figure>
          <div class="item-logo">
            <img src="/resources/images/icon/start3.png" alt="logo3">
          </div>
          <div class="item-title">
            LET'S SHOW
          </div>
          <div class="item-main">
            성공적으로 펀딩이 완료된 경우<BR>
            상단의 버튼을 클릭하여<BR>
            추가적인 공연정보를 입력해주세요<BR>
            ────────────────
          </div>
        </figure>
      </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

  </div>

  <script>
      $('#login').on('click',function(){
        $('.black-bg').addClass('show-modal')
      })
      $('#close').on('click',function(){
        $('.black-bg').removeClass('show-modal')
      })
  </script>
 
</body>
</html>