<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css"> 
  <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script> 
  
  <!-- 메인페이지 관련 CSS 링크1 -->
  <link rel="stylesheet" href="/resources/style/index-main.css">
  <link rel="stylesheet" href="/resources/style/login.css">
  
  <!-- 풋터에 필요한 CDN -->
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
  
  
<%@  include file="/WEB-INF/views/include/head.jsp" %>
   
  <title>Document</title>
  <script>
  
  $(document).ready(function() {
	  
	    AOS.init({
	        duration: 1000,
	        easing: 'ease-in-out',
	        once: true
	    });
	    
	    const images = ['/resources/images/bg-img/bg-3.jpg', '/resources/images/bg-img/bg-2.jpg', '/resources/images/bg-img/bg-1.jpg'];
	    let currentIndex = 0;

	    function changeImage() {
	      currentIndex++;
	      if (currentIndex >= images.length) {
	        currentIndex = 0;
	      }
	      const imgElement = document.querySelector('.main-item-image');
	      imgElement.classList.remove('active');
	      setTimeout(() => {
	        imgElement.src = images[currentIndex];
	        if (currentIndex !== 0) {
	          imgElement.classList.add('active');
	        }
	      }, 500);
	    }

	    setInterval(changeImage, 5000);

	    setInterval(changeImage, 5000);
	    
	  
		$("#loginbtn").on("click",function(){
			$("#userId").focus();
		});
		
		$("#userId").on("keypress", function(e){
			
			if(e.which == 13)
			{	
				fn_loginCheck();
			}
			
		});
		
		$("#userPwd").on("keypress", function(e){
			
			if(e.which == 13)
			{	
				fn_loginCheck();
			}
			
		});
			
		//로그인 버튼 선택시
		$("#Login").on("click", function() {
			fn_loginCheck();
		});
		
		//회원가입 버튼 선택시
		//$("#btnReg").on("click", function() {
		//	location.href = "/user/regForm_prac";
		//	});
		
	});
  
  function fn_loginCheck()
  {
  	if($.trim($("#userId").val()).length <= 0)
  	{
  		alert("아이디를 입력하세요.");
  		$("#userId").val("");
  		$("#userId").focus();
  		return;
  	}
  	
  	if($.trim($("#userPwd").val()).length <= 0)
  	{
  		alert("비밀번호를 입력하세요");
  		$("#userPwd").val("");
  		$("#userId").focus();
  		return;
  	}
  	
  	$.ajax({
  		type: "POST",
  		url: "/user/login",		//디스페쳐 서블릿이 받고 다시 컨트롤러로 간다
  		data: {
  			userId:$("#userId").val(),
  			userPwd:$("#userPwd").val()
  		},
  		datatype:"JSON",
  		beforeSend:function(xhr){
  			xhr.setRequestHeader("AJAX", "true");	//AJAX 통신을 알려주는 것
  		},
  		success:function(response){
  			
  			if(!icia.common.isEmpty(response))
  				{
  					icia.common.log(response);
  					
  					var code = icia.common.objectValue(response, "code", -500); //코드값이 없을때 -500으로 처리
  					
  					if(code == 0)
  						{
  								
  							location.href ="/index"; 		
  						}
  					else
  						{
  							if(code == -1)
  								{
  									alert("비밀번호가 올바르지 않습니다.");
  									$("#userId").focus();
  								}
  							else if(code == 404)
  								{
  									alert("아이디와 일치하는 사용자 정보가 없습니다.");
  									$("#userId").focus();
  								}
  							else if(code == 400)
  								{
  									alert("파라미터 값이 올바르지 않습니다.");
  									$("#userId").focus();
  								}
  							else if(code == 700)
								{
									alert("탈퇴된 회원입니다");
									location.href ="/index"; 	
								}
  							//회원 탈퇴
  							else if(code == -999)
  								{
  									alert("탈퇴된 계정입니다.");
  									location.href ="/"; 
  								}
  							else
  								{
  									alert("오류가 발생하였습니다.");
  									$("#userId").focus();
  								}
  						}
  				}
  			else
  				{
  					alert("오류가 발생하였습니다.");
  					$("#userId").focus();
  				}
  		},
  		error:function(xhr, status, error)
  		{
  			icia.common.error(error);
  		}
  		
  	
  	});
  
  }
  
  // 아이디 7일 저장
  $(document).ready(function(){
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var key = getCookie("key");
	    $("#userId").val(key); 
	     
	    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	    if($("#userId").val() != ""){ 
	        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#userId").val(), 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#userId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#userId").val(), 7); // 7일 동안 쿠키 보관
	        }
	    });
	    
	    $("#idFind").on("click",function(){
	    	location.href="/user/idFind";
	    }); 
	    
	    $("#pwFind").on("click",function(){
	    	location.href="/user/pwFind";
	    }); 
  });

	// 쿠키 저장하기 
	// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	// 쿠키 삭제
	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}
   
	// 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) { // 쿠키가 존재하면
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
	
	function fn_fdView(fdBbsSeq)
	{
		document.bbsForm.fdBbsSeq.value = fdBbsSeq;
		document.bbsForm.action = "/funding/fdView";
		document.bbsForm.submit();	
	}
	
  </script>
  
  
  
</head>
<body>
    <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="main-background">
  <img class="main-item-image active" src="/resources/images/bg-img/bg-4.jpg">
  <img class="main-item-image" src="/resources/images/bg-img/bg-2.jpg">
  <img class="main-item-image" src="/resources/images/bg-img/bg-3.jpg">
  <div class="main-image">
    <div class="main-item">
      <span class="main-item3">함께 만드는 공연펀드 사이트</span>
      <h4 class="main-title main-sub">FUN, FOND, FUND<BR></h4>
    </div>
  </div>
</div>
    
    
    
    <div class="main-fundinglist">
    	
      <div class="main-fundinglist-banner-container">
       <img class="main-fundinglist-banner" src="/resources/images/therise5_z.jpg">
      </div>
      
    
      <div class="main-fundinglist-title">
      	R E C E N T
      </div>
      
      <div class="main-fundinglist-recent-contain" data-aos="zoom-in">
      
      
       <c:forEach items="${wrapper.recent}" var="board">
      
	      <div class="main-fundinglist-recent">
	      <a href="javascript:void(0)" class="fdList" onclick="fn_fdView(${board.fdBbsSeq})">
	      	<div class="main-fundinglist-recent-imagebox">
	      		<img class="main-fundinglist-recent-image" src="/resources/upload/${board.fdFileName}">
	      	</div>
	      </a>
	      	<div class="main-fundinglist-recent-content">
	      		펀딩콘텐츠<br>
	      		${board.userId} - ${board.fdBbsTitle}
	      	</div>
	      </div>
	      </c:forEach>
	      
      </div>

      <div class="main-fundinglist-subtitle">
      	R E C O M M E N D
      </div>
      
          <div class="main-fundinglist-recommend-contain">
          
          
		  <c:forEach items="${wrapper.recommend}" var="bborad">
          
          
	      <div class="main-fundinglist-recommend" data-aos="fade-up" data-aos-duration="1000">
	        <a href="javascript:void(0)" class="fdList" onclick="fn_fdView(${bborad.fdBbsSeq})">
	      	<div class="main-fundinglist-recommend-imagebox">
	      		<img class="main-fundinglist-recommend-image" src="/resources/upload/${bborad.fdFileName}">
	      	</div>
	      	</a>
	      	<div class="main-fundinglist-recommend-content">
	      		펀딩콘텐츠<br>
	      		${bborad.userId} - ${bborad.fdBbsTitle}
	      	</div>
	      </div>
	      
	      </c:forEach>
	      
	      
      </div>

      
    </div>
    
    <div class="main-artistlist">
      <div class="main-artistlist-title">
      	A R T I S T
      </div>
      
      
      <div class="main-artistlist-main">
      	
      	     
          <div class="main-artistlist-main-recommend-contain">
          
          <c:forEach var="Main" items="${mainArtist}" varStatus="status">	
	        <div class="main-artistlist-main-recommend" data-aos="zoom-in">
	      	<div class="main-artistlist-main-recommend-imagebox">
	      		<img class="main-artistlist-main-recommend-image" src="/resources/upload/${Main.fileProfileName}">
	      	</div>
	      	<div class="main-artistlist-main-recommend-content">
	      		${Main.userCategoly}<br>
	      		${Main.userId} - ${Main.userIntroduce}
	      	</div>
	      </div>
	      </c:forEach>


	      
	      
      	
      	
      	
      </div>
    </div>
    
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </div>
    
    
    

 
    
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
                      <input type="text" name="userId" id="userId" placeholder="ID">
                    </p>
                    <p>
                      <input type="password" name="userPwd" id="userPwd" placeholder="Password">
                    </p>
                    <div style="text-align: center;">
                      <div class="checkboxouter">
                        <input type="checkbox" name="rememberme" id="checkId" value="Remember">
                        <label class="checkbox"></label>
                      </div>
                      <label for="remember">Remember me for 7 days</label>
                    </div>
                    <input class="loginLoginValue" type="hidden" name="service" value="login" />
                  </div>
                  <p class="p-container">
                    <input type="button" name="Login" id="Login" value="Login" >
                     <div class="regformbtn">
                  <input type="button" name="idFind" id="idFind"  class="idpwFind" value="아이디 찾기" ><a href="/user/idFind"></a>
                   <input type="button" name="pwFind" id="pwFind" class="idpwFind" value="비밀번호 찾기" ><a href="/user/pwFind"></a>
                    </div>
                  </p>
                </form>
              </div>
            </div>
          </div>
    <!--로그인 모달창 끝-->
    
    
    <form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="fdBbsSeq" value="" />
	</form>
  
</body>
</html>