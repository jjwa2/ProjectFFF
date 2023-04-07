<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@  include file="/WEB-INF/views/include/head.jsp"%>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
<%@ page import="java.text.NumberFormat"%>
<%
	// 현재후원 금액 포맷
int currentAmountNum = Integer.parseInt(request.getAttribute("currentAmount").toString());
// NumberFormat 클래스 생성
NumberFormat nf = NumberFormat.getNumberInstance();
// 3자리마다 콤마(,) 표시 설정

nf.setGroupingUsed(true);
// 출력할 문자열 생성
String fmCRNum = nf.format(currentAmountNum);

//총 후원금액 포맷
int targetPriceNum = Integer.parseInt(request.getAttribute("targetPrice").toString());
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



<link rel="stylesheet" href="/resources/style/fdView.css">
<link rel="stylesheet" href="/resources/style/pay.css">
	
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
					console.log("입니다."+price)
				}
				if(tierNum ==2)
				{
					  $('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li><li> <c:out value="${fdTier.product2}" /></li> </ul>');
					var price = ${fdTier.price2} 
					$('#price').val(price);
				}
				if(tierNum ==3)
				{
					$('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li><li> <c:out value="${fdTier.product2}" /></li> </li> <li><c:out value="${fdTier.product3}" /></li> </ul>');
					var price = ${fdTier.price3} 
					$('#price').val(price);
				}
				if(tierNum ==4)
				{
					$('#info').html('<ul class="card-ul"> <li>후원만 합니다.</li><li> <c:out value="${fdTier.product2}" /></li> </li> <li><c:out value="${fdTier.product3}" /></li> <li><c:out value="${fdTier.product4}" /></li> </ul>');
					var price = ${fdTier.price4} 
					$('#price').val(price);
				}

				if (confirm("후원하시겠습니까?") == true) {

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
				                
								$('#pricePay').val(price);
								$('#tierNumPay').val(tierNum);
				                
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

		progress.css("width",
<%=percent%>
	+ "%");

		// 후원목표 달성시 목표 달성이라는 글자를 띄우게 하는 문
		var $goalAchieved = $('#goal-achieved'); // 추가한 목표 달성 글자를 선택합니다.
		var $proceedingAchieved = $('#proceeding-achieved')
		// ...

		if (
<%=percent%>
	>= 100) {
			$goalAchieved.show(); // 퍼센트가 100%가 되면 목표 달성 글자를 표시합니다.
			$proceedingAchieved.hide();
		} else {
			$goalAchieved.hide(); // 퍼센트가 100%가 아니면 목표 달성 글자를 숨깁니다.
			$proceedingAchieved.show();
		}

		// ...

	});
</script>


<%
	
%>


</head>
<body style="margin: 0px;">



	<div class="main-box">



		<div class=" py-5 border-bottom mb-4 bg-dark">
			<div class="title-box">
				<h2>
					<c:out value="${fdBoard.fdBbsTitle}" />
				</h2>
			</div>
			<div class="main-container">
				<div class=" temp-box">

					<img class="main_img"
						src="https://tumblbug-pci.imgix.net/326f0b30dedd61b1b4ab402a546ed23ff763b676/57a9b6ca4418fc63f6a5a655d8ea53e1c2b1bb68/aa202cea1bb2b924d1b3e8f399ee9b6869fb34fa/a9961ac2-bb79-491c-af5c-550daee35458.png?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=544ca54de8abfbec2ebe6f0ea3c1856b"
						alt="">

				</div>
				<div class="sub-box">
					<div class="temp-box">
						<div class="card-body">
							<div>
								<h5>목표금액</h5>
								<span style="display: inline;">
									<h2 style="display: inline;"><%=fmTGPNum%></h2>원
								</span>

							</div>

							<div>
								<h5>모인금액</h5>
								<span style="display: inline;">
									<h2 style="display: inline;"><%=fmCRNum%></h2>원 <%=percent%>%
								</span>
								<!-- 퍼센트 게이지 바 -->
								<div class="progress-bar">
									<div class="progress" style="width: 60%;">
										<sapn style="margin-left: 10px"> <%=percent%>%</sapn>
									</div>
								</div>
								<div id="proceeding-achieved" style="display: none;">후원
									진행중</div>
								<div id="goal-achieved" style="display: none;">목표 달성!</div>
							</div>
							<div class="my-6">
								<h5>남은시간</h5>
								<span style="display: inline;">
									<h2 style="display: inline;">4</h2>일
								</span>
							</div>
							<div class="my-6">
								<h5>후원자</h5>
								<span style="display: inline;">
									<h2 style="display: inline;">
										<c:out
											value="${fdTier.tierCnt} " />
									</h2>명
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>





		<div class="main-container">
			<div class="temp-box" style="background-color: green;">
				<img
					src="https://tumblbug-psi.imgix.net/326f0b30dedd61b1b4ab402a546ed23ff763b676/57a9b6ca4418fc63f6a5a655d8ea53e1c2b1bb68/aa202cea1bb2b924d1b3e8f399ee9b6869fb34fa/026be79d-5079-4ff5-bafe-94bf461b2b86.jpg?ixlib=rb-1.1.0&w=1240&auto=format%2C%20compress&lossless=true&ch=save-data&s=a83ed38b8728e05f758b5b015e73c164"
					alt=""> <br> <br> <br> <br> <br> <br>
				<br> <br> <br> <br> <br> <br>
				<div style="margin: 20px;">
					글 내용 <br> <br> <br> <br> <br> <br> <br>
					<br> <br> <br> <br> <br> <br> <br>
					<br> <br> <br> <br> <br> <br> <br>
					<br> <br> <br> <br> <br> <br> <br>


				</div>

			</div>
			<div class="sub-box">
				<div class="temp-box">
					<div class="card-header">프로필</div>
					<div class="card-body">

						<div class="box" style="background: #BDBDBD; float: left;">
							<img class="profile"
								src="data:image/jpeg;base64,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">
						</div>
						<div style="margin-left: 120px; margin-top: 10px;">
							<h4>정상수</h4>
							<div>나는 정상수 입니다.</div>
						</div>
					</div>
				</div>

				<div class="temp-box"
					style="text-decoration: none; -webkit-tap-highlight-color: rgba(0, 0, 0, .1);">
					<div class="card-header">공연 정보</div>
					<div class="card-body">
						공연장소
						<h5 style="display: inline;">테스트1</h5>

						<br>
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
				</div>




				<div class="temp-box tier1">
					<div class="card-header">1티어</div>
					<div class="card-body">
						<div id="fd_contents">
							<h2>
								<c:out value="${fdTier.price1}" />
								+
							</h2>
							<div>후원만 합니다.</div>
						</div>
						<div id='dis1' style="display: none;">
							</select>
							<button type="button" class="btnFd btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal" data-tiernum="1">로그인</button>
							<button class="fdBtn" data-tiernum="1">후원하기</button>
						</div>
						<!-- <button class="button-1" id='show' onclick="dis()">show</button> -->
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
				</div>

				<div class="temp-box tier2">
					<div class="card-header">2티어</div>
					<div class="card-body">
						<div id="fd_contents">

							<h2>
								<c:out value="${fdTier.price2}" />
								+
							</h2>
							<div>기본 싸인 CD SET</div>
							<ul class="card-ul">
								<c:if test="${not empty fdTier.product1}">
									<li><c:out value="${fdTier.product1}" /></li>
								</c:if>
								<c:if test="${not empty fdTier.product2}">
									<li><c:out value="${fdTier.product2}" /></li>
								</c:if>

							</ul>
						</div>
						<div id='dis2' style="display: none;">
							<h7>문어소년 2집 [BOYHOOD] 싸인 CD ( x 1 )</h7>
							<select name="" id="" class="form-select">
								<option value="0" selected disabled>옵션을 선택해주세요</option>
								<option value="1">싸인 미포함</option>
								<option value="2">싸인 포함</option>
							</select>

<button type="button" class="btnFd btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal" data-tiernum="2">로그인</button>
							<button class="fdBtn" data-tiernum="2">후원하기</button>
						</div>
						<!-- <button class="button-1" id='show' onclick="dis()">show</button> -->
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
				</div>




				<div class="temp-box tier3">
					<div class="card-header">3티어</div>
					<div class="card-body">
						<div id="fd_contents">

							<h2>
								<c:out value="${fdTier.price3}" />
								+
							</h2>
							<div>기본 싸인 CD SET</div>
							<ul class="card-ul">
								<c:if test="${not empty fdTier.product1}">
									<li><c:out value="${fdTier.product1}" /></li>
								</c:if>
								<c:if test="${not empty fdTier.product2}">
									<li><c:out value="${fdTier.product2}" /></li>
								</c:if>
								<c:if test="${not empty fdTier.product3}">
									<li><c:out value="${fdTier.product3}" /></li>
								</c:if>

							</ul>
						</div>
						<div id='dis3' style="display: none;">
							<h7>문어소년 3집 [BOYHOOD] 싸인 CD ( x 1 )</h7>
							<select name="" id="" class="form-select">
								<option value="0" selected disabled>옵션을 선택해주세요</option>
								<option value="1">싸인 미포함</option>
								<option value="2">싸인 포함</option>
							</select>
							<button type="button" class="btnFd btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal" data-tiernum="3">로그인</button>
							<button class="fdBtn" data-tiernum="3">후원하기</button>
						</div>
						<!-- <button class="button-1" id='show' onclick="dis()">show</button> -->
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
				</div>







				<div class="temp-box tier4">
					<div class="card-header">4티어</div>
					<div class="card-body">
						<div id="fd_contents">

							<h2>
								<c:out value="${fdTier.price4}" />
								+
							</h2>
							<div>기본 싸인 CD SET</div>
							<ul class="card-ul">
								<c:if test="${not empty fdTier.product1}">
									<li><c:out value="${fdTier.product1}" /></li>
								</c:if>
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
							<h7>문어소년 3집 [BOYHOOD] 싸인 CD ( x 1 )</h7>
							<select name="" id="" class="form-select">
								<option value="0" selected disabled>옵션을 선택해주세요</option>
								<option value="1">싸인 미포함</option>
								<option value="2">싸인 포함</option>
							</select>
							<button class="fdBtn" data-tiernum="4">후원하기</button>
						</div>
						<!-- <button class="button-1" id='show' onclick="dis()">show</button> -->
						<div class="d-grid gap-2 d-md-block"></div>
					</div>
				</div>


			</div>
		</div>

	</div>


	<div class="footer-container" style="background-color: green;">
		<div class="footer-main">
			<div class="footer-sub1">
				<div class="footer-sub1-item1">F. F. F</div>
				<div class="footer-sub1-item2">서브메뉴바(미정)</div>
			</div>
			<div class="footer-sub2">
				<div class="footer-sub2-item1">
					<p class="footer-subtitle">Links</p>
					<p>HOME NOTICE FUNDING ARTIST CONTACT US</p>
				</div>
				<div class="footer-sub2-item2">
					<p class="footer-subtitle">Have a question?</p>
					<p>
						090-080-0760<br>hello@company.com
					</p>
				</div>
				<div class="footer-sub2-item3">
					<p class="footer-subtitle">Location</p>
					<p>South Korea, Seoul</p>
				</div>
			</div>
			<div class="footer-sub3">
				<div class="footer-sub3-item1">Copyright © ICIA Company</div>
				<div class="footer-sub3-item2">Terms & Conditions Privacy
					Policy Your Feedback</div>
			</div>
		</div>

	</div>












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
					<div class="container">
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
								class="form-control" id="price" name="price" disabled value="">
						</div>

						<div class="form-group">
							<label for="info">상품정보:</label>
							<div class="form-control" id="info" name="info" disabled
								style="height: 200px; overflow-y: scroll; overflow: hidden;"
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
					</form>
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
		<input type="hidden" name="price" id="pricePay" value="" />
	
	</form>	
				</div>
			</div>
		</div>
	</div>



