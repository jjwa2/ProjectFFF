<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.DateFormat"%>
<%@page import="com.icia.web.model.FdBoard"%>

<%	
	// 현재후원 금액 포맷
	long currentAmountNum = Long.parseLong(request.getAttribute("currentAmount").toString());
	// NumberFormat 클래스 생성
	NumberFormat nf = NumberFormat.getNumberInstance();
	// 3자리마다 콤마(,) 표시 설정
	
	nf.setGroupingUsed(true);
	// 출력할 문자열 생성
	String fmCRNum = nf.format(currentAmountNum);
	//
	//총 후원금액 포맷
	long targetPriceNum = Long.parseLong(request.getAttribute("targetPrice").toString());
	String fmTGPNum = nf.format(targetPriceNum);
	
	double currentPercent = (double) currentAmountNum / targetPriceNum * 100;
	int percent = (int) currentPercent;
	
	System.out.println("퍼센트 금액 " + percent);
	
	//남은 일수 구하기
	Date today = new Date();
	String fdEndDate = request.getAttribute("fdEndDate").toString();
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	String dateToStr = dateFormat.format(today);
	
	Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(dateToStr);
	Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(fdEndDate);
	
	long diffSec = (format2.getTime() - format1.getTime()) / 1000; //초 차이
	
	long remainDay = diffSec / (24*60*60);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- 아티스트마이페이지 관련 CSS 링크 -->
  <link rel="stylesheet" href="/resources/style/artistMypage.css">
  
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	
	  <!-- CSS only -->
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

      <!--MATERRIALIZW 아이콘 CDN-->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  		
<%@  include file="/WEB-INF/views/include/head.jsp" %>
  
 
<title>Insert title here</title>
</head>
<body>
  <div class="main-background">


    <!-- 펀딩중인 정보 모달-->
    <!-- 23.03.20 박재윤 수정 -->
      
<c:choose> 
  <c:when test="${fdBoard.fdBbsSeq > 0}">  
  
<div class="black-bg" class="modal">
    <div class="white-bg">
 		<div class="artistDetailTitle">${fdBoard.fdBbsTitle}</div>
 		

 		 <div class="artistDetailImage">
 		  <img class="artistDetailImage" src="/resources/upload/${fdBoard.fdFileName}">
 		 </div>

         <div class="artistDetailGoal">
         	<div class="artistDetailGoalPercent">
         		<%=percent%>%
         	</div>
         	<div class="artistDetailGoalPrice">
         		<%=fmTGPNum%>원
         	</div>
         </div>

 		 <div class="artistDetailBar">
		<div class="fundingDoneBar">
    		<div class="progress-bar">
				<div class="progress"  data-value = "${currentAmount}" data-value2 ="${targetPrice}">
				</div>
			</div>
        </div>
 		 </div>
 		 
 		 <div class="artistDetailGoalFoot">
 		  <div class="artistDetailGoalFootTitle">
 		  	남은기간:
 		  </div>
 		  <div class="artistDetailGoalFootPeriod">
 		  <%if(remainDay>0) 
 		  {%>
 		  	<%=remainDay %>일
 		  <%} %>
 		  <%if(remainDay<=0)
 		  { %>
 		  	후원마감
 		  <%} %>
 		  
 		  </div>
 		 </div>
 		 
 		 <div class="artistDetailGoalButton">
 		 	<button type="button" class="btn btn-dark" href="javascript:void(0)" onclick="fn_fdView(${fdBoard.fdBbsSeq})">상세페이지</button>
 		 </div>
	 </div>
</div>	
	</c:when>
	
	<c:otherwise>
	  <div class="black-bg2" class="modal">
	      <div class="white-bg2">
		
			<div class="artistDetailOtherTitle">
				펀딩에 도전하세요.<br> F.F.F는 아티스트의 무한한 가능성을 응원합니다.
			</div>
			
		  </div>
	</div>	
	</c:otherwise>
   
</c:choose>   

      
      <!-- 펀딩 완료된 모달 -->
      <!-- 23.03.20 박재윤 수정 -->
<c:choose> 
  <c:when test="${fdBoard.fdBbsSeq > 0}">
      <div class="black-bg1" class="modal">
       <div class="white-bg1">
       
        <div class="artistDetailTitle">${fdBoard.fdBbsTitle}</div>
 		
		<div class="fundingDoneBody">
		 <div class="fundingDoneImage">
 		  <img class="fundingDoneImage" src="/resources/upload/${fdBoard.fdFileName}">
 		 </div>
 		 <div class="fundingDoneInfo">
 		 	<div class="fundingDoneInfoItem">
 		 		공연날짜
 		 	</div>
 		 	<div class="fundingDoneInfoItems">
 		 		${fdBoard.ctDate}
 		 	</div>
 		 	<div class="fundingDoneInfoItem">
 		 	────────────
 		 	</div>
 		 	<div class="fundingDoneInfoItem">
 		 		공연장소
 		 	</div>
 		 	 <div class="fundingDoneInfoItems">
 		 		${fdBoard.venuePlace}
 		 	</div>
 		 	<div class="fundingDoneInfoItem">
 		 	────────────
 		 	</div>
 		 	 <div class="fundingDoneInfoItem">
 		 		공연연령
 		 	</div>
 		 	<div class="fundingDoneInfoItems">
 		 		${fdBoard.ctAge}
 		 	</div>
 		 	<div class="fundingDoneInfoItem">
 		 	────────────
 		 	</div>
 		 	 <div class="fundingDoneInfoItem">
 		 		수용인원
 		 	</div>
 		 	<div class="fundingDoneInfoItems">
 		 		${fdBoard.capacity}명
 		 	</div>
 		 </div> 
		</div>
		
		<div class="fundingDoneGoal">
         	<div class="artistDetailGoalPercent">
         		<%=percent%>%
         	</div>
         	<div class="artistDetailGoalPrice">
         		<%=fmTGPNum%>원
         	</div>
         </div>
		
		
		<div class="fundingDoneBar">
    		<div class="progress-bar">
				<div class="progress"  data-value = "${currentAmount}" data-value2 ="${targetPrice}">
				</div>
			</div>
        </div>

<c:choose>
	<c:when test="${fdBoard.fdStatus eq 'Y'}">
         <div class="fundingDoneTail">
	         <p class="fundingDoneNotice"> 펀딩 진행 중입니다. 남은 펀딩 기간 : <%=remainDay %>일</p>
	     </div>

	</c:when>
	<c:otherwise>
	
		<c:choose>
			<c:when test="${fdBoard.fdStatus2 eq 'Y'}">
			
				<div class="fundingDoneTail">
		         <p class="fundingDoneNotice">축하드립니다! 성공적으로 펀딩이 완료되었습니다.<br>상세 공연내용을 작성하여 공연일정 등록을 부탁드립니다.</p>
		        </div>
		        
		        <div class="fundingDoneButton">
		 		 	<button type="button" class="btn btn-dark" href="javascript:void(0)" onclick="fn_fdWrite(${fdBoard.fdBbsSeq})">공연일정 등록하기</button>
		 		</div>
		     
		    </c:when>
			<c:otherwise>
			
			<div class="fundingDoneTail">
		         <p class="fundingDoneNotice">아쉽지만, 펀딩이 달성되지 못하였습니다.</p>
		    </div>
			
			</c:otherwise>
		</c:choose>
	
	</c:otherwise>
	
</c:choose>		 
       </div>
      </div>
	</c:when>	
	<c:otherwise>
	</c:otherwise>
</c:choose>



	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>





















    <div class="title-container">
      <div class="sub-title">
        펀딩에 도전하세요
      </div>
      <div class="main-title">
        START FUNDING<br><br>
      </div>
      <div>

      </div>>
    </div>

    <div class="artist-container">
            <div class="artist-item hover01">
          <a onclick="fn_fundingForm(${fdBoard.fdBbsSeq})" href="javascript:void(0)" style="text-decoration: none; color: inherit;">
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
      </a>

      
      
      <div class="artist-item hover01" id="login">
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
      <div class="artist-item hover01" id="login1">
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
    
     <form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="fdBbsSeq" value="" />
	</form>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

  </div>
  
  <script>
      $('#login').on('click',function(){
        $('.black-bg').addClass('show-modal');
        $('.black-bg2').addClass('show-modal2');
      })
      $('#close').on('click',function(){
        $('.black-bg').removeClass('show-modal')
      })
      
      $('#login1').on('click',function(){
        $('.black-bg1').addClass('show-modal1')
        modal.style.display = "block";
      })
      $('#close1').on('click',function(){
        $('.black-bg1').removeClass('show-modal1')
      })
      
      
  	//퍼센트 게이지 바 (빨간색줄)
    $('.progress').each(function() {
        var currentAmount = $(this).data('value');
        var targetPrice = $(this).data('value2');
        
        var percent = currentAmount / targetPrice * 100;
        $(this).css("width", percent+'%');
        
    });
      
   $(document).on('click','.black-bg', function(e){
   	  if ( e.target == document.querySelector('.black-bg')) {
   	    document.querySelector('.black-bg').classList.remove('show-modal');
   	  }
   	});
   
   $(document).on('click','.black-bg1', function(e){
  	  if ( e.target == document.querySelector('.black-bg1')) {
  	    document.querySelector('.black-bg1').classList.remove('show-modal1');
  	  }
  	});
   
   $(document).on('click','.black-bg2', function(e){
    	  if ( e.target == document.querySelector('.black-bg2')) {
    	    document.querySelector('.black-bg2').classList.remove('show-modal2');
    	  }
   });

        
   

  	function fn_fdView(fdBbsSeq)
	{
		document.bbsForm.fdBbsSeq.value = fdBbsSeq;
		document.bbsForm.action = "/funding/fdView";
		document.bbsForm.submit();	
	}
  	
  	function fn_fdWrite(fdBbsSeq)
	{
		document.bbsForm.fdBbsSeq.value = fdBbsSeq;
		document.bbsForm.action = "/ctBoard/ctWriteForm";
		document.bbsForm.submit();	
	}
  	
  	
  	//OPEN 눌렀을때 처리
    function fn_fundingForm(fdBbsSeq)
	{
  		if(fdBbsSeq > 0)
  		{
  			alert("한명의 아티스트는 하나의 펀딩만 등록 가능합니다.");
  			location.href = "#";
  		}
  		else
  		{
  			location.href = "/funding/fundingForm";
  		}
	}
  </script>


</body>
</html>