<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@  include file="/WEB-INF/views/include/head.jsp"%>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
<%@ page import="java.text.NumberFormat"%>
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
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!--script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js" type="text/javascript"></script-->

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://kit.fontawesome.com/412379eca8.js" crossorigin="anonymous"></script>


<link rel="stylesheet" href="/resources/style/pay.css">
<link rel="stylesheet" href="/resources/style/fdView.css">
	
<title>Document</title>





<!-- j쿼리 -->
<!-- 각 티어마다 누르면 후원화면이 나오게 하는 모달-->
<script>
	$(document).ready(function() {
		function dis(num) {
			$('.tier' + num).css('hover-events', 'none');
			if ($('#dis' + num).css('display') == 'none') {
				$('#dis' + num).show();
				$("#fd_contents" + num).hide();
				$('.tier' + num).css('border', 'none');
			} else {
				// $('#dis' + num).hide();
				// $("#fd_contents" + num).show();
			}
		}

		$('.tier1').click(function() {
			dis(1);
		});

		$('.tier2').click(function() {
			dis(2);
		});

		$('.tier3').click(function() {
			dis(3);
		});

		$('.tier4').click(function() {
			dis(4);
		});

		// tier4부터 tier10까지도 마찬가지로 추가해주면 됩니다.

		//후원하기 버튼 누르면 발생하는 이벤트(후원인원, 총 금액 카운트)

		$(".btnFd").on("click", function() {
			//각각의 tiernum의 데이터 값 0, 1, 2 마다 버튼 다르게 작동시키기   1티어쪽 후원하기 누르면 1티어쪽만 작동 2티어쪽 후원누르면 2티어쪽만 작동 
			var tierNum = $(this).data("tiernum");
			$('#tierNum').val(tierNum);
			var fdBbsSeq = <c:out value = "${fdBoard.fdBbsSeq}"/>

			if(tierNum >=1 && tierNum<=4 )
			{
				if(tierNum ==1)
				{
						  $('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li> </ul>' );
				
					var price = ${fdTier.price1} 
					$('#price').val(price);
					$('#pricePay').val(price);
					console.log("입니다."+price)
				}
				if(tierNum ==2)
				{
					  $('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li><li> <c:out value="${fdTier.product2}" /></li> </ul>');
					var price = ${fdTier.price2} 
					$('#price').val(price);
					$('#pricePay').val(price);
				}
				if(tierNum ==3)
				{
					$('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li><li> <c:out value="${fdTier.product2}" /></li> </li> <li><c:out value="${fdTier.product3}" /></li> </ul>');
					var price = ${fdTier.price3} 
					$('#price').val(price);
					$('#pricePay').val(price);
				}
				if(tierNum ==4)
				{
					$('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li><li> <c:out value="${fdTier.product2}" /></li> </li> <li><c:out value="${fdTier.product3}" /></li> <li><c:out value="${fdTier.product4}" /></li> </ul>');
					var price = ${fdTier.price4} 
					$('#price').val(price);
					$('#pricePay').val(price);
				}

				
				if('${cookieUserId}' == '') 
				{
					alert("로그인을 해주세요");					

				}
				else if ('${cookieUserId}' != null) 
				{
					if (confirm("후원하시겠습니까?") == true) 
					{
						   $('#loginModal').modal('show');
					}
				}
				
			}

		});
		
		
		//카카오 페이 결제 눌렀을때 팝업띄우는 곳
				$("#btnPay").on("click", function() {
					
					$("#btnPay").prop("disabled", true);

					
					
					//kakakopayReady 주소갖고 컨트롤러로
					icia.ajax.post({
				        url: "/kakao/payReady",
				        data: {itemCode:$("#itemCode").val(), itemName:$("#itemName").val(), quantity:$("#quantity").val(), totalAmount:$("#totalAmount").val(),
				        	   
				        },
				        success: function (response) 
				        {
				        	icia.common.log(response);
				        	
				        	if(response.code == 0)
				        	{
				        		var orderId = response.data.orderId;
				        		var tId = response.data.tId;
				        		var pcUrl = response.data.pcUrl;

				        		$("#orderId").val(orderId);
				        		$("#tId").val(tId);
				        		$("#pcUrl").val(pcUrl);
				        		
				        		//윈도우 팝업, 메뉴바를없엔다 스크롤을 없엔다 등등 
				        		
				        		var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');

				        		var price = $('#price').val();
				        		var tierNum = $('#tierNum').val();
				                
				        		var tierNum = $('#tierNum').val();
								$('#tierNumPay').val(tierNum);
								$('#price').val(price);
				        		console.log("티어번호"+tierNum);
				        		console.log("price"+price);
				        		$("#kakaoForm").submit();
				        		
				        		$("#btnPay").prop("disabled", false);
				        	}
				        	else
				        	{
				        		alert("오류가 발생하였습니다.");
				        		$("#btnPay").prop("disabled", false);
				        	}
				        },
				        error: function (error) 
				        {
				        	icia.common.error(error);
				        	
			        		$("#btnPay").prop("disabled", false);
				        }
				    });				
				});
		
		

		
		

		var progressBar = $(".progress-bar");
		var progress = $(".progress");

		progress.css("width",<%=percent%> + "%");
		if(<%=percent%>>=100)
		{
			progress.css("width",100 + "%");			
		}

		// 후원목표 달성시 목표 달성이라는 글자를 띄우게 하는 문
		var $goalAchieved = $('#goal-achieved'); // 추가한 목표 달성 글자를 선택합니다.

		// ...

		if (<%=percent%> >= 100) {
			$goalAchieved.show(); // 퍼센트가 100%가 되면 목표 달성 글자를 표시합니다.

		} else {
			$goalAchieved.hide(); // 퍼센트가 100%가 아니면 목표 달성 글자를 숨깁니다.

		}

		
		//후원 기간이 끝났을때 마감
		var $fundingProgress = $('#funding-progress');
		var $fundingDeadLine = $('#funding-deadLine');
		var fdStatus = '${fdBoard.fdStatus}'
		
		if(fdStatus == 'Y')
		{
			console.log("안녕하세요");
			
			
			$fundingProgress.show(); // 상태가 Y이면 후원가능 표시
			$fundingDeadLine.hide();
				
		}
		else
		{
			$fundingProgress.hide(); // 시간이지나 상태가 N이면 후원마감
			$fundingDeadLine.show();
			$(".btnFd").prop("disabled", true);
			$(".MyBtn").prop("disabled", true);
			$(".btnFd").css("background-color", "#d4d4d4");
			$(".MyBtn").css("background-color", "#d4d4d4");
			
		}
		
		
		
		
		// ...

		//후원하기 눌렀을떄 스크롤 되는곳
        $('#scroll-btn').click(function () {
            $('html, body').animate({ scrollTop: ($(".tier1").offset().top)-100 }, 100);
            return false;
        });

		

		
		// 재생버튼 모달
		$('.play-button').on('click', function() {
			// 모달을 나타내기
			$('.modal').css('display', 'flex');
		});

		// 모달을 클릭했을 때 모달을 사라지게 하는 이벤트 핸들러
		$('.modal').on('click', function() {
			// 모달을 사라지게 하기
			$('.modal').css('display', 'none');
		});
		
		
		
        
	});
	
			//팔로우 버튼
            function fn_snsFollow(val)
            {
            	
            		//ajax
            		$.ajax({
            			type:"POST",
            			url:"/sns/follow",
            			data:{
            				userId:val
            			},
            			dataType:"JSON",
            			
            			beforeSend:function(xhr){
            				xhr.setRequestHeader("AJAX","true");
            			},
            			success:function(response)
            			{
            				if(response.code ==0)
            				{
            					location.href = "/snsboard/snsmain";
            				}
            				else if(response.code == 500)
            				{
            					alert("매개변수가 오류입니다.");
            					location.href = "/snsboard/snsmain";
            				}
            				else if(response.code == 400)
            				{
            					alert("로그인 후 다시 시도해주세요.");
            					location.href = "/snsboard/snsmain";
            				}
            				else if(response.code == 600)
            				{
            					alert("이미 팔로우하고 있는 아티스트입니다.");
            					location.reload();
            				}
            				else
            				{
            					alert("시스템 오류가 발생하였습니다.");
            					location.href = "/snsboard/snsmain";
            				}
            			},
            			error: function(xhr,status,error)
            			{
            				icia.common.error(error);
            			}
            		});
            }
					
</script>


<%
	
%>


</head>
<body style="margin: 0px;">



	<div class="main-box">



		<div class=" py-5 border-bottom mb-4 bg-dark">
   <div class="fdViewContainer">
   
     <div class="fdViewMainBadge">
    	<button type="button" class="btn btn-success btn-sm">${artist.userCategoly}</button>
    	<button type="button" class="btn btn-success btn-sm">${fdBoard.ctAge}</button>
	 </div>
	
	 <div class="fdViewMainTitle">
  		<p><c:out value="${fdBoard.fdBbsTitle}" /></p>
 	 </div>
   
   
    		
     <div class="fdViewMainBody">
	    <div class="fdViewMainImageBox">
	        <c:if test="${fdBoard.fdFileName ==''}">
					<img class="main_img" src="https://tumblbug-pci.imgix.net/326f0b30dedd61b1b4ab402a546ed23ff763b676/57a9b6ca4418fc63f6a5a655d8ea53e1c2b1bb68/aa202cea1bb2b924d1b3e8f399ee9b6869fb34fa/a9961ac2-bb79-491c-af5c-550daee35458.png?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=544ca54de8abfbec2ebe6f0ea3c1856b" alt="">
			</c:if>
			<c:if test="${fdBoard.fdFileName !=''}">
					<img alt="" src="/resources/upload/${fdBoard.fdFileName}" class="fdViewMainImage">
					 <div class="play-button"></div>
			</c:if>

 		</div>
 		
 		<div class="fdViewMainInfo">
 		    <div class="fdViewMainInfoItem">
 		 		펀딩목표금액
 		 	</div>
 		 	<div class="fdViewMainInfoItems">
 		 		<span class="fdViewMainInfoItem-Goal"><%=fmTGPNum%></span> 원
 		 	</div>
 		 	
 		 	<div class="fdViewMainInfoItem">
 		 		현재펀딩금액
 		 	</div>
 		 	<div class="fdViewMainInfoItems">
 		 		<div class="fdViewMainInfoItem-Goal"><%=fmCRNum%> <span class="fdViewMainInfoItem-Goalwon">원</span></div> <%=percent%>%
 		 	</div>
 		 	
 		 	<div class="progress-bar">
			 <div class="progress" style="width: <%=percent%>%;">
		     </div>
			</div>
			
			<!-- 정현팀장한테 확인 할 부분 
			<div class="proceeding">
		     <div id="goal-achieved" style="display: none;">목표 달성!</div>
		    </div-->
			
			<div class="fdViewMainInfoItem">
 		 		펀딩기간
 		 	</div>
 		 	<div class="fdViewMainInfoItems">
 		 	   <c:out value="${fdBoard.fdStartDate}" /> ~
			   <c:out value="${fdBoard.fdEndDate}" />

			   <div id = "funding-progress" style="display: none; color:#e8a21d;">후원가능</div>
			   <div id = "funding-deadLine" style="display: none; color:#e8a21d;">후원마감</div>
 		 	</div>
 		 	
 		 	<div class="fdViewMainInfoItem">
 		 		후원인원
 		 	</div>
 		 	<div class="fdViewMainInfoItems">
 		 	   <span class="fdViewMainInfoItem-people"><c:out value="${fdTier.tierCnt}"/></span> 명
 		 	</div>
 		 	
 		 	
 		 	
 		 	
 		 	<div class="fdViewMainInfoButton">
 		 	 <button type="button" class="btnFd MyBtn" id="scroll-btn" class="MyBtn btnFd MyBtn">후원하기</button>
 		 	</div>

 		 </div> 
		</div>
	

			<h6 class="sample-info">샘플곡을 들어보실려면 포스터를 클릭해주세요</h6>
			<br>
		<div class="fdViewMainBody2">
		
		    <div class="container mt-5">
		      <ul class="list">
		        <li class="tab-button orange">공연정보</li>
		        <li class="tab-button">아티스트 정보</li>
		      </ul>
		      <div class="tab-content show">
		        
	        		<div class="ctInfo">
						<p style="display: inline;">공연장소  </p>
						<p style="display: inline;"> <c:out value="${fdBoard.venuePlace}" /></p>
					</div>
					<div class="ctInfo">
						<p style="display: inline;">공연날짜  </p>
						<p style="display: inline;"> <c:out value="${fdBoard.ctDate}" /></p>
					</div>
					<div class="ctInfo">
						<p style="display: inline;">관람가능연령  </p>
						<p style="display: inline;"> <c:out value="${fdBoard.ctAge}" /></p>
					</div>
					<div class="ctInfo">
						<p style="display: inline;">수용인원  </p>
						<p style="display: inline;"> <c:out value="${fdBoard.capacity}" />명</p>
					</div>
				
		        
		      </div>
		      <div class="tab-content">
		        
				   <div class="tab-content-MainInfo-artistContain">
		        	    <div class="tab-content-MainInfo-imagebox">
			      		  <img class="tab-content-MainInfo-image" src="/resources/upload/${artFileName}">
			      	    </div>
			      	    
			      	    <div class="tab-content-MainInfo-infobox">
			      	    	<div class="tab-content-MainInfo-infobox-item">
			      	    	   ${fdBoard.userId}<br>
			      	    	   ${artist.userIntroduce}
			      	    	   <div class="tab-content-MainInfo-infobox-follow">
			      	    	    <button type="button" class="btn btn-warning" onClick="fn_snsFollow('${fdBoard.userId}')">팔로우</button>
			      	    	   </div>
			      	    	</div>
			      	    </div>
		        	</div>

		      </div>
		    </div> 
		</div>
	
	<!-- maincontain 끝 -->    
	<hr style="color:white;">
	</div>
		</div>	


		<div class="main-container">
			<div class="temp-box";">
			

			<c:if test="${fdBoard.fdFile2Name == ''}">	
			<img alt="" src="/resources/upload/샘플공연포스터.jpg">
			</c:if>
			<c:if test="${fdBoard.fdFile2Name !=''}">
				<img alt="" src="/resources/upload/${fdBoard.fdFile2Name}">
			</c:if> 
			
			
				<!-- 절대 지우면 안됨!!!!! -->
				<!-- 절대 지우면 안됨!!!!! -->
				<!-- 절대 지우면 안됨!!!!! -->	
				<!-- 절대 지우면 안됨!!!!! -->
				<div style="margin: 20px;">
				<!-- 절대 지우면 안됨!!!!! -->
				<!-- 절대 지우면 안됨!!!!! -->
				<!-- 절대 지우면 안됨!!!!! -->
				<!-- 절대 지우면 안됨!!!!! -->
				
				
				
				
				</div>

			</div>
			<div class="sub-box sub-2">



				<div class="temp-box tier1">
					<div class="card-header">1 티어</div>
					<div class="card-body">
						<div id="fd_contents">
							<p class="fd_contentsTitle">
								<c:out value="${fdTier.price1}" />
								+
							</p>
							<div>후원만 합니다.</div>
						</div>

						<div id='dis1' style="display: none;">

							
							
						</div>
						<!-- <button class="button-1" id='show' onclick="dis()">show</button> -->
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
					<div class="card-footer">

						<button type="button" class="btnFd MyBtn" data-bs-target="#loginModal" data-tiernum="1">후원하기</button>
					</div>
				</div>

				<div class="temp-box tier2">
					<div class="card-header">2 티어</div>
					<div class="card-body">
						<div id="fd_contents">

							<p class="fd_contentsTitle">
								<c:out value="${fdTier.price2}" />
								+
							</p>
							<div style="margin-left: 16px">
											
							

							</div>
							<div style="margin-left: 12px;">[후원하고 아래의 혜택을 가져가세요.]</div>
							<ul class="card-ul">
							
								<c:if test="${not empty fdTier.product2}">
								
									<li><c:out value="${fdTier.product2}" /></li>
								</c:if>

							</ul>
						</div>
						<div id='dis2' style="display: none;">

						</div>
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
					<div class="card-footer">

						<button type="button" class="btnFd MyBtn" data-bs-target="#loginModal" data-tiernum="2">후원하기</button>
					</div>
				</div>



				<div class="temp-box tier3">
					<div class="card-header">3 티어</div>
					<div class="card-body">
						<div id="fd_contents">

							<p class="fd_contentsTitle">
								<c:out value="${fdTier.price3}" />
								+
							</p>
							<div style="margin-left: 12px;">[후원하고 아래의 혜택을 가져가세요.]</div>
							<ul class="card-ul">
								<c:if test="${not empty fdTier.product2}">
								
									<li><c:out value="${fdTier.product2}" /></li>
								</c:if>
								<c:if test="${not empty fdTier.product3}">
									<li><c:out value="${fdTier.product3}" /></li>
								</c:if>

							</ul>
						</div>
						<div id='dis3' style="display: none;">
						
						</div>
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
					<div class="card-footer">

						<button type="button" class="btnFd MyBtn" data-bs-target="#loginModal" data-tiernum="3">후원하기</button>
					</div>
				</div>



				<div class="temp-box tier4">
					<div class="card-header">4 티어</div>
					<div class="card-body">
						<div id="fd_contents">

							<p class="fd_contentsTitle">
								<c:out value="${fdTier.price4}" />
								+
							</p>
							<div style="margin-left: 12px;">[후원으로 아래의 혜택을 가져가세요.]</div>
							<ul class="card-ul">

								<c:if test="${not empty fdTier.product2}">
									<li><c:out value="${fdTier.product2}" /></li>
								</c:if>
								<c:if test="${not empty fdTier.product3}">
									<li><c:out value="${fdTier.product3}" /></li>
								</c:if>
								<c:if test="${not empty fdTier.product4}">
									<li><c:out value="${fdTier.product4}" /></li>
								</c:if>
							</ul>
						</div>
						<div id='dis4' style="display: none;">
						<div class="d-grid gap-2 d-md-block"></div>
					    </div>
					</div>
					<div class="card-footer">

						<button type="button" class="btnFd MyBtn" data-bs-target="#loginModal" data-tiernum="4">후원하기</button>
					</div>
				</div>


			</div>
		</div>

	</div>


    <%@ include file="/WEB-INF/views/include/footer.jsp" %>







	<!-- 후원 모달 -->
	<div class="modal fade" id="loginModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">후원하기</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
				
					<!-- 후원 폼 -->
					<div class="container-modal">
						<div class="form-group">
							<label for="title">펀딩 제목:</label> <input type="text"
								class="form-control" id="title" name="title" disabled
								value="${fdBoard.fdBbsTitle}">
						</div>
						<div class="form-group">
							<label for="tier">티어번호:</label> <input type="text"
								class="form-control" id="tierNum" name="tierNum" disabled value="">
						</div>
						<div class="form-group">
							<label for="price">후원금액</label> <input type="text"
								class="form-control" id="pricePay" name="pricePay" disabled value="">
						</div>

						<div class="form-group">
							<label for="info">상품정보:</label>
							<div class="form-control" id="info" name="info" disabled
								style="height: 100px; overflow-y: scroll; overflow: hidden;"
								white-space:nowrap;>

								<ul class="card-ul">


								</ul>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-12">
								<button type="button" id="btnPay" class="btn btn-primary"
									title="카카오페이">카카오페이</button>
							</div>

						</div>
					</div>
					<!-- 타겟인 popup인곳에 form을 넘겨주겠다-->
	<form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
		<input type="hidden" name="orderId" id="orderId" value="" />
		<input type="hidden" name="tId" id="tId" value="" />
		<input type="hidden" name="pcUrl" id="pcUrl" value="" />
		<input type="hidden" name="itemCode" id="itemCode" maxlength="32" class="form-control mb-2" placeholder="상품코드" value="0123456789" />
		<input type="hidden" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="상품명" value="비타민씨" />
		<input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="1" />
		<input type="hidden" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="30000" />
		
		<!-- 우리가 쓸꺼 -->
		<input type="hidden" name="fdBbsSeq" id="fdBbsSeq" value="${fdBoard.fdBbsSeq}" />
		<input type="hidden" name="tierNum" id="tierNumPay" value="" />
		<input type="hidden" name="price" id="price" value="" />
	
	</form>	
				</div>
			</div>
		</div>
	</div>


	<div class="modal">
		<iframe src="https://www.youtube.com/embed/${fdTier.product1}"
			frameborder="0" allowfullscreen></iframe>
	</div>

</body>
<script type="text/javascript">
for(let i=0; i<3; i++){
	  $('.tab-button').eq(i).on('click',function(){
	    $('.tab-button').removeClass('orange');
	    $('.tab-button').eq(i).addClass('orange')
	    $('.tab-content').removeClass('show');
	    $('.tab-content').eq(i).addClass('show')
	  })
	}
</script>
</html>
