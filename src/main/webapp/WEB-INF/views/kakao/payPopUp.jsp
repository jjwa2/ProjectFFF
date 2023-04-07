<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
function kakaoPayResult(pgToken)
{
	$("#pgToken").val(pgToken);
	 var fdBbsSeq = $("#fdBbsSeq").val();
	 var price = $("#price").val();
		console.log("price"+price);
    document.kakaoForm.action = "/kakao/payResult";
    document.kakaoForm.submit();
}
</script>
</head>
<body>
<!-- 컨트롤러에서 pcUrl 찍었었음. qr코드 뜨는 화면 success일때 env.xml에서 paysuccess 호출 --> 
<iframe width="100%," height="650" src="${pcUrl}" frameborder="0" allowfullscreen=""></iframe>
<form name="kakaoForm" id="kakaoForm" method="post">
	<input type="hidden" name="orderId" id="orderId" value="${orderId}" />
	<input type="hidden" name="tId" id="tId" value="${tId}" />
	<!-- 펀딩에서 쓸꺼 -->
	<input type="hidden" name="userId" id="userId" value="${userId}" />
	<input type="hidden" name="pgToken" id="pgToken" value="" />
	<input type="hidden" name="fdBbsSeq" id="fdBbsSeq" value="${fdBbsSeq}" />
	<input type="hidden" name="tierNum" id="tierNum" value="${tierNum}" />
	<input type="hidden" name="price" id="price" value="${price}" />
	<!-- 공연예매에서 쓸꺼 -->
	
	<input type="hidden" name="userId" id="userId" value="${userId}" />
	<input type="hidden" name="ctBbsSeq" id="ctBbsSeq" value="${ctBbsSeq}" />
	<input type="hidden" name="ctBbsTitle" id="ctBbsTitle" value="${ctBbsTitle}" />
	<input type="hidden" name="venuePlace" id="venuePlace" value="${venuePlace}" />
	<input type="hidden" name="ctDate" id="ctDate" value="${ctDate}" />
	<input type="hidden" name="ctAge" id="ctAge" value="${ctAge}" />
	
</form>
</body>
</html>