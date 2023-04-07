<%@page import="com.icia.web.model.FdBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!-- 퍼센트 게이지 계산하는곳 -->
<%@ page import="java.text.NumberFormat"%>
<%
	// 현재후원 금액 포맷
 

List<FdBoard> list = (List<FdBoard>) request.getAttribute("list");



Long[] currentAmount = new Long[list.size()];
Long[] targetPrice = new Long[list.size()];
String[] fmCurrentAmount = new String[list.size()];
String[] fmTargetPrice = new String[list.size()];
NumberFormat nf = NumberFormat.getNumberInstance();


for(int i = 0; i<list.size();i++)
{
	 currentAmount[i] = list.get(i).getCurrentAmount();
	 targetPrice[i] = list.get(i).getTargetPrice();
	 fmCurrentAmount[i] = nf.format(currentAmount[i]);
	 fmTargetPrice[i] = nf.format(targetPrice[i]);
	 
	 

	System.out.println("fmTargetPrice[i] 값입니다. : " + fmTargetPrice[i] + "["+i+"]");

}


/*

//list.get(index)
 //NumberFormat 클래스 생성
NumberFormat nf = NumberFormat.getNumberInstance();
 //3자리마다 콤마(,) 표시 설정

nf.setGroupingUsed(true);
 //출력할 문자열 생성
String fmCRNum = nf.format(currentAmountNum);

//총 후원금액 포맷
long targetPriceNum = Long.parseLong(request.getAttribute("targetPrice").toString());
String fmTGPNum = nf.format(targetPriceNum);

double currentPercent = (double) currentAmountNum / targetPriceNum * 100;
int percent = (int) currentPercent;
System.out.println("퍼센트 금액 " + percent);
*/
%>
<!-- 퍼센트 게이지 계산하는곳 -->


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <link rel="stylesheet" href="/resources/style/fundingList.css">
  
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.min.js"></script>
	<script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js"></script>

  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  
  <!-- 아이콘 cdn -->
  <script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>	
 
  <!-- 드롭다운 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">

  
  
      
<script type="text/javascript">



	function fn_list(curPage)
	{
		document.bbsForm.curPage.value = curPage;
		document.bbsForm.action = "/funding/fundingList";
		document.bbsForm.submit();	
	}
	
	//검색
	$(document).ready(function() {
		$("#btnSearch").on("click", function() {
			console.log("안녕하세요")
			document.bbsForm.fdBbsSeq.value = "";
			document.bbsForm.searchType.value = $("#_searchType").val();
			document.bbsForm.searchValue.value = $("#_searchValue").val();
			document.bbsForm.curPage.value = "1";
			document.bbsForm.action= "/funding/fundingList";
			document.bbsForm.submit();
			
		});
	});
	
	
	$('.funding-btn').click(function() {
	    var fdSeq = $(this).data('fdSeq');
	    fn_fdView(fdSeq);
	});
	
	
	function fn_fdView(fdBbsSeq)
	{
		document.bbsForm.fdBbsSeq.value = fdBbsSeq;
		document.bbsForm.action = "/funding/fdView";
		document.bbsForm.submit();	
	}
	
	
	
	
	//카테고리 선택
$(document).ready(function() {


	
	/*
	$('.btn-categoly').click(function() {
		var categoly = "";
	     categoly = $(this).data('categoly');
		console.log(categoly);
		
		$(this).addClass('active'); // 클릭한 버튼에 'active' 클래스 추가
        $('.btn-categoly').css('background-color', 'red'); // 바디 요소의 배경색 변경

		console.log("1");
		document.bbsForm.categolyValue.value = categoly;
		console.log("2");
		document.bbsForm.action= "/funding/fundingList";
		document.bbsForm.submit();
	});
	*/
	
	
	// initialize Isotope
	var $grid = $('.fundingmain-container').isotope({
	  itemSelector: '.fundingcard',
	  layoutMode: 'fitRows'
	});

	// filter items on button click
	$('.filter-button').on('click', function() {
		  $('.filter-button').removeClass('active');
		  $(this).addClass('active');
		  var filterValue = $(this).attr('data-filter');
		  $grid.isotope({ filter: filterValue });
	  
	});
	
    $('.fdClose').each(function() {
        var fdStatus = $(this).attr('data-fdStatus');
        if(fdStatus =='N')
        {
        	$(this).css('display', 'block');
        }
        	
    });
    
    
    //퍼센트 게이지 바 
    
    $('.progress').each(function() {
        var currentAmount = $(this).data('value');
        var targetPrice = $(this).data('value2');
        
        var percent = currentAmount / targetPrice * 100;
        $(this).css("width", percent+'%');
        	
    });


        $('.h5Percent').each(function() {
            var currentAmount = $(this).data('value');
            var targetPrice = $(this).data('value2');
            
            var percent = Math.floor(currentAmount / targetPrice * 100);
            $(this).text(percent+"%");
            	
        });
	

        
        
        
})
</script>



  <title>Document</title>
</head>
<body>
  <div class="main-background">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

    <div class="snstitle">
      <div class="snstitlemain">FUNDING LIST</div>
      <div class="snstitlesub">펀딩중인 공연정보 입니다. 참여해보세요</div>
      <div class="snstitlebutton">

	      
	      <button class="filter-button active" data-filter="*">전체</button>
		  <button class="filter-button" data-filter=".힙합">힙합</button>
	   	  <button class="filter-button" data-filter=".재즈">재즈</button>
		  <button class="filter-button" data-filter=".댄스">댄스</button>
		  <button class="filter-button" data-filter=".ETC">etc</button>
	      
	      
      </div>
    </div>
    
    
        <!--div class="ml-auto input-group" style="width:50%;">
         <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
				<option value="">조회 항목</option>
				<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>작성자</option>
				<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>제목</option>
				<option value="3" <c:if test="${searchType eq '3'}">selected</c:if>>내용</option>
			</select>
			<input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
			<button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button-->

    <div class="text-warning fundingmain-hr">
      <hr>
    </div>


<% int count= 0;
int count2= 0; 
 %>
<div class="grid">
    <div class="fundingmain-container">
    <c:if test="${!empty list}">	
	<c:forEach var="FdBoard" items="${list}" varStatus="status">
	<%
		String value1 = fmCurrentAmount[count2++];
		String value2 = fmTargetPrice[count++];
	%>
	<c:if test="${FdBoard.fdStatus == 'N' || FdBoard.fdStatus == 'Y'}">
    <div class="fundingcard item ${FdBoard.userCategoly}"  data-value="${FdBoard.userCategoly}">
  <div class="card shadow">
    <a href="javascript:void(0)" class="fdList" onclick="fn_fdView(${FdBoard.fdBbsSeq})">
    

			<c:if test="${FdBoard.fdFileName ==''}">
				<img src="/resources/images/bg-img/bg-1.jpg" class="card-img-top">
			</c:if>
			<c:if test="${FdBoard.fdFileName !=''}">
				<img alt="" src="/resources/upload/${FdBoard.fdFileName}" class="card-img-top">
				<img alt="" src="/resources/images/마감.jpg" class="fdClose"  data-fdStatus ="${FdBoard.fdStatus}">
			</c:if> 
      <div class="card-body">
        <span class="userCategoly">장르 <span style="color: #d8d5d5;font-size: 5px;">|</span>  ${FdBoard.userCategoly}</span>
        <h4 class="card-title">${FdBoard.fdBbsTitle}</h4>
        <p class="card-text">장소 : ${FdBoard.venuePlace}<br>펀딩목표금액 : <%=value2%> 
        원<br>펀딩마감날짜 : ${FdBoard.fdEndDate}</p>
        <p class="card-text" style="font-weight:bold;"> <h5 class="h5Percent" style="display: inline;" data-value = "${FdBoard.currentAmount}" data-value2 ="${FdBoard.targetPrice}"></h5>   현재 후원 금액 : <%=value1%></p>
                
			<div class="progress-bar">
				<div class="progress"  data-value = "${FdBoard.currentAmount}" data-value2 ="${FdBoard.targetPrice}">
				</div>
			</div>
      </div>
      <div class="d-flex p-3 card-footer1">
        <div class="flex-shrink-0">

             <img src="/resources/upload/${FdBoard.fileProfileName}" class="circular-image">
        </div>
        <div class="flex-grow-1 ms-3 mt-1">
          <h6 class="fw-bold mb-0">${FdBoard.userId}</h6>
          <p class="text-muted">${FdBoard.userIntroduce}</p>
        </div>
      </div>
	</a>
  </div>
</div>
</c:if>

	</c:forEach>
	</c:if>		

    </div>
    </div>
    


    <div class="text-warning fundingmain-hr">
      <hr>
    </div>
            
    <form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="fdBbsSeq" value="" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage} " />
		<input type="hidden" name="categolyValue" value="" />
	</form>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
</body>
</html>

