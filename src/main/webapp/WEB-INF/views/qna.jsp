<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- QNA 관련 CSS 링크 -->
  <link rel="stylesheet" href="/resources/style/qna.css">
  
  <!-- 풋터에 필요한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">

  
  <!-- Google fonts-->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
  
  <!-- Core theme CSS (includes Bootstrap)-->
  <!-- <link href="css/styles.css" rel="stylesheet" /> -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
    crossorigin="anonymous"></script>
    <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

    
      <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
     <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
      <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>
	
	



  <title>Document</title>

<script>
  $(document).ready(function(){
    $('.collapsible').collapsible();
  });
</script>

</head>
<body>
  <div class="main-background">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    
    <div class="main-container">
      <div class="headertitle"><span>F</span><span> </span>A<span> </span><span>Q</span></div>
      <ul class="collapsible popout">
        <li>
          <div class="collapsible-header"><i class="material-icons">local_grocery_store</i>공연 보러갈때 필요한게 뭐가있을까요?</div>
          <div class="collapsible-body"><span>예매를 하고나면 티켓번호가 발부되고 티켓번호를 보여주면 입장 가능합니다.(이메일로 받을 수 있습니다.)</span></div>
        </li>
        <li>
          <div class="collapsible-header"><i class="material-icons">attach_money</i>펀딩결제는 어떻게 하는건가요?</div>
          <div class="collapsible-body"><span>상단바에 play 클릭 후 펀딩하기를 누르고 펀딩하고싶은 공연에서 후원하고싶은 티어에 맞게 구매하시면됩니다.(카카오페이 결제)</span></div>
        </li>
        <li>
          <div class="collapsible-header"><i class="material-icons">block</i>비회원으로는 펀딩이 불가능한가요?</div>
          <div class="collapsible-body"><span>규정상 홈페이지 회원분들만 펀딩 가능합니다.</span></div>
        </li>
        <li>
          <div class="collapsible-header"><i class="material-icons">place</i>공연 장소와 일정은 어디서 봐요?</div>
          <div class="collapsible-body"><span>예매하기 버튼을 클릭후 원하는 공연을 누르면 장소와 일정을 확인할 수 있습니다.</span></div>
        </li>
        <li>
          <div class="collapsible-header"><i class="material-icons">supervisor_account</i>아티스트 팔로우를 하는 이유가무엇인가요?</div>
          <div class="collapsible-body"><span>관심있는 아티스트들을 팔로우 하면 아티스트들이 올린 글들을 볼 수 있고 공연일정, 정보들을 빠르고 쉽게 접할 수 있습니다.</span></div>
        </li>
        <li>
          <div class="collapsible-header"><i class="material-icons">help_outline</i>펀딩을 하는 이유가 무엇인가요?</div>
          <div class="collapsible-body"><span>대부분의 힙합 공연은 대형 콘서트 홀이나 대규모 페스티벌에서 이루어지기 때문에, 소규모의 지역적인 힙합 공연은 자금 조달과 마케팅 등의 문제로 쉽게 구현되지 않습니다.<br> 이러한 이유로, 저희는 힙합을 좋아하는 이들이 소규모의 지역적인 힙합 공연에 참여할 수 있도록, 새로운 플랫폼을 만들어 보았습니다.</span></div>
        </li>
      </ul>
    </div>
  
  </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

 <!--로그인 모달 창-->
          <div class="modal fade" id="exampleModal" tabindex1="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="background-wrap">
                  <div class="background"></div>
                </div>
                <form id="accesspanel" class="accesspanel" action="login" method="post">
                  <h1 id="litheader">FFF</h1>
                  <div class="inset">
                    <p>
                      <input type="text" name="id" id="id" placeholder="ID">
                    </p>
                    <p>
                      <input type="password" name="password" id="password" placeholder="Password">
                    </p>
                    <div style="text-align: center;">
                      <div class="checkboxouter">
                        <input type="checkbox" name="rememberme" id="checkedId" value="Remember">
                        <label class="checkbox"></label>
                      </div>
                      <label for="remember">Remember me for 7 days</label>
                    </div>
                    <input class="loginLoginValue" type="hidden" name="service" value="login" />
                  </div>
                  <p class="p-container">
                    <input type="button" name="Login" id="go" value="Login" >
                  </p>
                </form>
              </div>
            </div>
          </div>
    <!--로그인 모달창 끝-->
  
</body>
</html>