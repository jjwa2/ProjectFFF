<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">

$(document).ready(function() {
    
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
	                var tierNum = $("#tierNum").val();
	                var fdBbsSeq = $("#fdBbsSeq").val();
	                var price = $("#price").val();
	                
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
});

function movePage()
{
	location.href = "/funding/fdView";
}
</script>

<script>
console.log('${payment}');
</script>
<link rel="stylesheet" href="/resources/style/pay.css">
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation2.jsp" %>
   <div class="container">
        <h2>결제창 예제</h2>
            <div class="form-group">
                <label for="title">펀딩 제목:</label>
                <input type="text" class="form-control" id="title" name="title" disabled value = "${fdBoard.fdBbsTitle}">
            </div>
            <div class="form-group">
                <label for="tier">티어번호:</label>
                <input type="text" class="form-control" id="tier" name="tier" disabled value ="${tierNum}">
            </div>
            <div class="form-group">
                <label for="price">후원금액</label>
                <input type="text" class="form-control" id="price" name="price" disabled value = "${price}">
            </div>

            <div class="form-group">
                <label for="info">상품정보:</label>
                <div class="form-control" id="info" name="info" disabled
                    style="height: 200px; overflow-y: scroll; overflow: hidden;" white-space: nowrap;>
                    
                    							<ul class="card-ul">
								<c:if test="${tierNum ==1}">
									<li>후원만 합니다.</li>
								</c:if>
								<c:if test="${tierNum >=2 && not empty fdTier.product2}">
									<li><c:out value="${fdTier.product2}" /></li>
								</c:if>
								<c:if test="${tierNum >=3 && not empty fdTier.product3}">
									<li><c:out value="${fdTier.product3}" /></li>
								</c:if>
								<c:if test="${tierNum >=4 && not empty fdTier.product4}">
									<li><c:out value="${fdTier.product4}" /></li>
								</c:if>
							</ul>
                </div>
            </div>
		<div class="form-group row">
			<div class="col-sm-12">
				<button type="button" id="btnPay" class="btn btn-primary" title="카카오페이">카카오페이</button>
			</div>

		</div>
    </div>
	</form>
	<!-- 타겟인 popup인곳에 form을 넘겨주겠다-->
	<form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
		<input type="hidden" name="orderId" id="orderId" value="" />
		<input type="hidden" name="tId" id="tId" value="" />
		<input type="hidden" name="pcUrl" id="pcUrl" value="" />
		<input type="hidden" name="fdBbsSeq" id="fdBbsSeq" value="${fdBoard.fdBbsSeq}" />
		<input type="hidden" name="tierNum" id="tierNum" value="${tierNum}" />
		<input type="hidden" name="price" id="price" value="${price}" />
	
		<input type="hidden" name="itemCode" id="itemCode" maxlength="32" class="form-control mb-2" placeholder="상품코드" value="0123456789" />
		<input type="hidden" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="상품명" value="비타민씨" />
		<input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="1" />
		<input type="hidden" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="30000" />
	
	</form>	
	

	
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js">
    </script>
</div>
</body>
</html>