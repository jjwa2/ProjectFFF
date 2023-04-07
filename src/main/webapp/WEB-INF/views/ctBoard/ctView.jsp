<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/style/pay.css">
<link rel="stylesheet" href="/resources/style/ctView.css">
<meta charset="UTF-8">



<title>공연게시판</title>
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<%@  include file="/WEB-INF/views/include/head.jsp"%>

<script type="text/javascript">

$(document).ready(function() {
	$(".btnFd").on("click", function() {
		//각각의 tiernum의 데이터 값 0, 1, 2 마다 버튼 다르게 작동시키기   1티어쪽 후원하기 누르면 1티어쪽만 작동 2티어쪽 후원누르면 2티어쪽만 작동 

			
		if('${cookieUserId}' == '') 
		{
			alert("로그인을 해주세요");					

		}
		else if ('${cookieUserId}' != null) 
		{
			if (confirm("예매하시겠습니까?") == true) 
			{
				   $('#loginModal').modal('show');
			}
		}
	
			
			

	});
	
	
	<c:choose>
		<c:when test="${empty ctBoard}">
		
			alert("조회하신 조회물이 존재하지 않습니다.");
			document.bbsForm.action = "/ctBoard/ctlist";
			document.bbsForm.submit();
		
		</c:when>
		<c:otherwise>
		
		$("#btnList").on("click", function() {
			document.bbsForm.action = "/ctBoard/ctlist";
			document.bbsForm.submit();
		});
		
	<c:if test="${boardMe eq 'Y'}">
		$("#btnUpdate").on("click", function() {
			document.bbsForm.action = "/ctBoard/ctUpdateForm";
			document.bbsForm.submit();
		});
		
		$("#btnDelete").on("click", function(){
			if(confirm("게시물을 삭제 하시겠습니까?") == true)
			{
				//ajax
				$.ajax({
					type:"POST",
					url:"/ctBoard/delete",
					data:{
						ctBbsSeq:<c:out value="${ctBoard.ctBbsSeq}" />
					},
					dataType:"JSON",
					beforeSend:function(xhr){
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response){
						if(response.code == 0)
						{
							alert("게시물이 삭제되었습니다.");
							location.href = "/ctBoard/ctlist";
						}
						else if(response.code == 400)
						{
							alert("파리미터 값이 올바르지않습니다.");
						}
						else if(response.code == 404)
						{
							alert("게시물을 찾을 수 없습니다.");
							location.href = "/ctBoard/ctlist";
						}
						
						else
						{
							alert("게시물 삭제 중 오류가 발생하였습니다.");
						}
					},
					error:function(xhr, status, error){
							icia.common.error(error);
					}
				});
			}
			
	
	});
		
		</c:if>
		 </c:otherwise>
		</c:choose>
		
		
		
		//카카오 페이 결제 눌렀을때 팝업띄우는 곳
		$("#btnPay").on("click", function() {
			$("#btnPay").prop("disabled", true);
			//kakakopayReady 주소갖고 컨트롤러로
			icia.ajax.post({
		        url: "/kakao/payReady",
		        data: {itemCode:$("#itemCode").val(), itemName:$("#itemName").val(), quantity:$("#quantity").val(), totalAmount:$("#totalAmount").val()

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

		
 });
 //ready 종료
 

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
					alert("팔로우 중 서버의 오류가 발생했습니다.");
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
	
<body>

<div class="main-container">
   <c:if test="${!empty ctBoard}">	
 <div class="ctViewContainer">
	
     <div class="ctViewMainBadge">
    	<button type="button" class="btn btn-success btn-sm">단독판매</button>
	 </div>
	
	 <div class="ctViewMainTitle">
  		<p>${ctBoard.ctBbsTitle}</p>
 	 </div>
 	 
 	 
 		
		<div class="ctViewMainBody">
		 <div class="ctViewMainImage">
 		  <img class="ctViewMainImage" src="/resources/upload/${ctBoard.fdFileName}">
 		 </div>
 		 <div class="ctViewMainInfo">
 		    <div class="ctViewMainInfoItem">
 		 		공연종류
 		 	</div>
 		 	<div class="ctViewMainInfoItems">
 		 		${ctBoard.userCategory}
 		 	</div>
 		 	<div class="ctViewMainInfoItem">
 		 	────────────────────
 		 	</div>
 		 	<div class="ctViewMainInfoItem">
 		 		공연날짜
 		 	</div>
 		 	<div class="ctViewMainInfoItems">
 		 		${ctBoard.ctDate}
 		 	</div>
 		 	<div class="ctViewMainInfoItem">
 		 	──────────────────── 
 		 	</div>
 		 	<div class="ctViewMainInfoItem">
 		 		공연장소
 		 	</div>
 		 	 <div class="ctViewMainInfoItems">
 		 		${ctBoard.venuePlace}
 		 	</div>
 		 	<div class="ctViewMainInfoItem">
 		 	────────────────────
 		 	</div>
 		 	 <div class="ctViewMainInfoItem">
 		 		공연연령
 		 	</div>
 		 	<div class="ctViewMainInfoItems">
 		 		${ctBoard.ctAge}
 		 	</div>
 		 	<div class="ctViewMainInfoItem">
 		 	────────────────────
 		 	</div>
 		 	 <div class="ctViewMainInfoItem">
 		 		수용인원
 		 	</div>
 		 	<div class="ctViewMainInfoItems">
 		 		${ctBoard.capacity}명
 		 	</div>
 		 	
 		 	<div class="ctViewMainInfoButton">
 		 	 
					<c:choose>
						<c:when test="${ctBoard.ctPayType eq 'online'}"> 		 	
					 		 	 <button type="button" class="btnFd MyBtn" data-bs-target="#loginModal">예매하기</button>
						</c:when>
						<c:otherwise>
								 <p style="text-align: center;">해당 공연은 현장 발매입니다.</p>
						</c:otherwise>
					</c:choose>
 		 	</div>
 		 	
 		 
 		 	
 		 </div> 
		</div>
		
		
		
	  <div class="container mt-5">
      <ul class="list">
        <li class="tab-button firstButton orange">상세정보</li>
        <li class="tab-button">공연장정보</li>
        <li class="tab-button">예매안내</li>
      </ul>
      
      
      
      
      <div class="tab-content show">
      
      
      <!-- 공연상세정보 블럭 -->
      
      <div class="tab-content-MainInfo-contain">
      
        <div class="tab-content-MainInfo">
        
        	<div class="tab-content-MainInfo-artistinfo">아티스트 정보</div>
        	
        	
        	<div class="tab-content-MainInfo-artistContain">
        	    <div class="tab-content-MainInfo-imagebox">
	      		  <img class="tab-content-MainInfo-image" src="/resources/upload/${ctBoard.fileProfileName}">
	      	    </div>
	      	    
	      	    <div class="tab-content-MainInfo-infobox">
	      	    	<div class="tab-content-MainInfo-infobox-item">
	      	    	   ${ctBoard.userId}<br>
	      	    	   ${ctBoard.userIntroduce}
	      	    	   <div class="tab-content-MainInfo-infobox-follow">
	      	    	    <button type="button" class="btn btn-warning" onClick="fn_snsFollow('${ctBoard.userId}')">팔로우</button>
	      	    	   </div>
	      	    	</div>
	
	      	    </div>
        	</div>
        	
        	
        	<div class="tab-content-MainInfo-ctintroduce">공연 소개글</div>
        	
	        	<div class="tab-content-MainInfo-ctintroduceMain">
	        	   "${ctBoard.ctBbsContent}"
	        	</div>
        	
        	
        	<div class="tab-content-MainInfo-ticketTitle">티켓 가격 정보</div>
	      		<div class="tab-content-MainInfo-ticketInfo">
	      			■ 일반석 : <span class="ticketInfo">${ctBoard.ctPrice}</span> 원
	      		</div>
	      	
	      	<div class="tab-content-MainInfo-bro">공연 정보</div>
	      		<div class="tab-content-MainInfo-broMainImage">
	      			<img class="tab-content-MainInfo-broMainImageFile" src="/resources/upload/${ctBoard.ctFileName}">
	      		</div>
	      	
	      </div>
	      
	      
	      <div class="tab-content-MainInfo-ad">
	        <div class="tab-content-MainInfo-ad-title">이달의 추천 공연🌼</div>
	        
	        <div class="tab-content-MainInfo-adRecommand">
	        	<img class="tab-content-MainInfo-adRecommandImage" src="/resources/images/bg-img/bg-1.jpg">
	        	<div class="tab-content-MainInfo-adRecommandTitle">
	        		6월 선우종아 재즈콘서트
	        	</div>
	        </div>
	      </div>
	      
	    <!-- tab-content-MainInfo-contain 블럭마감 -->  	
        </div>
      </div>
      
      
      
      
      <div class="tab-content">
        <div class="tab-content-Placeinfo">
         <p>오시는 길</p>
         
         <div class="tab-content-Placeinfo-placename">
         	${ctBoard.venuePlace}
         </div>
         
         
         <!-- 지도를 표시할 div 입니다 -->
			<div id="map" style="width:100%;height:550px;"></div>
			
			<!-- services 라이브러리 불러오기 -->
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=630c1f3529084ebd45f131381ff33981&libraries=services"></script>

         
         
         
         
         
         
         
         
         
        </div>
      </div>
      
      
      
      <div class="tab-content">
        <div class="tab-content-advanceInfo">
        
       <h3>티켓 수령 방법 안내</h3>
       <br><br>
	   <h5>현장수령</h5>
	- 예매번호가 포함되어 있는 예매확인서와 예매자의 실물 신분증(복사본 및 사진 불가) 을 매표소에 제출하시면 편리하게 티켓을 수령하실 수 있습니다.<br>
	※ 공연별 정책이 상이하니 자세한 내용은 예매페이지 내 상세정보 확인 부탁드립니다.<br>
	    <br><br>
		<h5>배송</h5>
	- 배송을 선택하신 경우 예매완료(결제익일) 기준 4~5일 이내에 예매 시 입력하신 주소로 배송됩니다. (주말/공휴일 제외한 영업일 기준)<br>
	- 일괄배송의 경우 공연 별로 배송일자가 상이하며 지정된 배송일자 기준으로 배송이 시작됩니다. (지정된 배송일자는 상세정보 및 예매공지사항에서 확인할 수 있습니다.)<br>
	- 지역 및 배송서비스 사정에 따라 배송사가 변경될 수 있으며, 배송일이 추가적으로 소요될 수 있습니다. (CJ대한통운, 우체국 외 1개 업체)<br>
	    <br><br>
	    <h5>취소/환불 안내</h5>
	
	- 취소마감시간 이후 또는 관람일 당일 예매하신 건에 대해서는 취소/변경/환불이 불가합니다.<br>
	- 예매수수료는 예매 당일 밤 12시 이전까지 취소 시 환불 가능합니다.<br>
	- 배송이 시작된 경우 취소마감시간 이전까지 멜론티켓 고객센터로 티켓을 반환해주셔야 환불이 가능하며, 도착한 일자 기준으로 취소수수료가 부과됩니다.<br>
	(* 단, 반환된 티켓의 배송료는 환불되지 않으며 일괄배송 상품의 경우 취소에 대한 자세한 문의는 고객센터로 문의해 주시기 바랍니다.)<br>
	- 예매취소 시점과 결제 시 사용하신 신용카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있습니다.<br>
	- 티켓 부분 취소 시 신용카드 할부 결제는 티켓 예매 시점으로 적용됩니다. (무이자할부 행사기간이 지날 경우 혜택 받지 못하실 수 있으니 유의하시기 바랍니다. )<br>
	- 취소일자에 따라 아래와 같이 취소수수료가 부과됩니다.<br>
	(예매 후 7일 이내라도 취소시점이 관람일로부터 10일 이내라면 관람일 기준의 취소수수료가 부과됩니다.)<br>
        
        <br><br>
        
        <table style="border: 1px solid white;">
		  <thead style="border: 1px solid white;">
		    <tr style="border: 1px solid white;">
		      <th style="border: 1px solid white;">취소일</th>
		      <th style="border: 1px solid white;">취소수수료</th>
		    </tr>
		  </thead>
		  <tbody style="border: 1px solid white;">
		    <tr style="border: 1px solid white;">
		      <td style="border: 1px solid white;">예매 후 7일이내</td>
		      <td style="border: 1px solid white;">없음</td>
		    </tr>
		    <tr style="border: 1px solid white;">
		      <td style="border: 1px solid white;">예매 후 8일 ~ 관람일 10일이내</td>
		      <td style="border: 1px solid white;">장당 4000원 (티켓금액의 10% 한도)</td>
		    </tr>
		    <tr style="border: 1px solid white;">
		      <td style="border: 1px solid white;">관람일 9일 전 ~ 7일전</td>
		      <td style="border: 1px solid white;">티켓금액의 10%</td>
		    </tr>
		    <tr style="border: 1px solid white;">
		      <td style="border: 1px solid white;">관람일 6일 전 ~ 3일전</td>
		      <td style="border: 1px solid white;">티켓금액의 20%</td>
		    </tr>
		    <tr style="border: 1px solid white;">
		      <td style="border: 1px solid white;">관람일 2일 전 ~ 1일전</td>
		      <td style="border: 1px solid white;">티켓금액의 30%</td>
		    </tr>
		  </tbody>
		</table>
		
		<br><br>
		
		<h2>궁금하신 사항이 있다면 고객센터의 FAQ를 확인하거나 1:1문의를 이용해주세요.</h2>
        
        
        
        </div>


      </div>
    </div> 
		
		
	
	
	
 </div>
</c:if>

</div>


<script type="text/javascript">
for(let i=0; i<3; i++){
	  $('.tab-button').eq(i).on('click',function(){
	    $('.tab-button').removeClass('orange');
	    $('.tab-button').eq(i).addClass('orange')
	    $('.tab-content').removeClass('show');
	    $('.tab-content').eq(i).addClass('show')
	    
	    map.relayout()
	  })
	}
</script>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>




	<!-- 후원 모달 -->
	<div class="modal fade" id="loginModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">예매하기</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- 후원 폼 -->
					<div class="container">
						<div class="form-group">
							<label for="title">공연 제목:</label> <input type="text"
								class="form-control" id="title" name="title" disabled
								value="${ctBoard.ctBbsTitle}">
						</div>
						<div class="form-group">
							<label for="price">티켓금액</label> <input type="text"
								class="form-control" id="price" name="price" disabled value="${ctBoard.ctPrice}">
						</div>
						<div class="form-group">
							<label for="venuePlace">공연장소:</label> <input type="text"
								class="form-control" id="venuePlace" name="venuePlace" disabled value="${ctBoard.venuePlace}">
						</div>
						<div class="form-group">
							<label for="price">공연날짜</label> <input type="text"
								class="form-control" id="ctDate" name="ctDate" disabled value="${ctBoard.ctDate}">
						</div>
						<div class="form-group">
							<label for="price">공연연령</label> <input type="text"
								class="form-control" id="ctAge" name="ctAge" disabled value="${ctBoard.ctAge}">
						</div>

						<div class="form-group row">
							<div class="col-sm-12">
								<button type="button" id="btnPay" class="MyBtn"
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
		
		<input type="hidden" name="ctBbsSeq" id="ctBbsSeq" value="${ctBoard.ctBbsSeq}" />
		<input type="hidden" name="price" id="price" value="${ctBoard.ctPrice}" />
		<input type="hidden" name="ctDate" id="ctDate" value="${ctBoard.ctPrice}" />
		<input type="hidden" name="venuePlace" id="venuePlace" value="${ctBoard.venuePlace}" />
		<input type="hidden" name="ctBbsTitle" id="ctBbsTitle" value="${ctBoard.ctBbsTitle}" />
		<input type="hidden" name="ctAge" id="ctAge" value="${ctBoard.ctAge}" />
		
	</form>	
				</div>
			</div>
		</div>
	</div>



<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
            center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표 (서울시청)
            level: 3 // 지도의 확대 레벨
        };
    // 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch('${ctBoard.venuePlaceAdd}', function(result, status) {

    	// 검색된 위치를 중심으로 지도 범위를 재설정하고 마커를 생성합니다 
    	if (status === kakao.maps.services.Status.OK) {
    	    // 검색한 위치를 기준으로 지도 범위를 재설정합니다
    	    var bounds = new kakao.maps.LatLngBounds();
    	    bounds.extend(new kakao.maps.LatLng(result[0].y-(-0.0012), result[0].x -0.0030));
    	    map.setBounds(bounds);

    	    // 검색된 위치를 중심으로 마커를 생성합니다 
    	    var markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x);
    	    var marker = new kakao.maps.Marker({
    	        position: markerPosition,
    	        map: map
    	     
    	    });
    	} else {
    	    alert('지도를 생성할 수 없습니다. 주소명을 확인해주세요.');
    	}
    });
    

</script>







</body>
</html>














