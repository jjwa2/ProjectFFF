<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">

    <title>결제 완료</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: white;
            color: black;
            font-family: "PretendardVariable";
        }
        .payBar
        {
        	width: 100%;
        	height: 20px;
        	background-color: #157347;
        }
        .payBarTicketNum
        {
        	margin-top:20px;
        	margin-left:20px;
        	font-size: 30px;	
        }
        .payBarTicketNum1
        {
         	margin-left:20px;
         	margin-top:20px;
         	font-size: 15px;	
        }
        .payBarTicketNotice
        {
        	margin-left:20px;
        	font-size: 15px;
        }
        
                /* 테이블 헤더 배경색 */
        th {
            background-color: black;
        }

        /* 테이블 헤더 글자색 */
        th
        {
           margin-top:20px;
           margin-left:20px;
           color:white;
        }
        td {
            color:black;
        }
        table
        {
           margin-top:20px;
           margin-left:20px;
        }
        .payBarTicketButton1
        {
        	text-align: right;
        	margin-right: 44px;
        }
        .payBarTicketButton2
        {
        	margin-top:178px;
        	text-align: right;
        	margin-right: 44px;
        }
        .payFoot
        {
        	margin-top: 26.1px;
        	width: 100%;
        	height: 20px;
        	background-color: #157347;
        }
        


        #btnClose{
        margin-left: 20px;
        }
    </style>
    
    <script type="text/javascript">
      $(document).ready(function() {
    	  opener.location.reload();
      $("#btnClose").on("click", function() {
 
        window.close();
        
       
    });
  });
      
      
  
      
      
      function fn_email(){
    	  
     	 const paymentNum = '${ctPm.paymentNum}';
      	 const ctBbsTitle = '${ctBoard.ctBbsTitle}';
     	 const pmDate = '${ctPm.pmDate}';
     	 const ctPrice = '${ctBoard.ctPrice}';
          
          $.ajax({
       	   type:"POST",
       	   url:"/kakao/Email",
       	   data:{
       		   paymentNum:paymentNum,
       		   ctBbsTitle:ctBbsTitle,
       		   pmDate:pmDate,
       		   ctPrice:ctPrice
       	   },
       	   datatype:"JSON",
       	   beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					num = response.data;
					console.log(num);
					console.log(paymentNum);
					alert("귀하의 메일로 전송이 완료되었습니다.");
					
				},
				error:function(xhr,status,error)
				{
					icia.common.error(error);
				}
       	            
       	});
     }
   
  </script>
</head>
<body>

<div class="payBar"></div>
    <div class="container">
    	<div class="payBarTicketNum">#결제완료</div>
    	<div class="payBarTicketNum1">예매번호 : ${ctPm.paymentNum}</div>
    	<div class="payBarTicketNotice">*현재 결제완료 페이지를 공연장 입구에서 담당직원에게 보여주세요.</div>
    	
    	
    	
    	<div class="payBarTicketNum">#결제정보</div>
    	<table class="table table-bordered" style="width: 90%;">
                            <tbody>
                                <tr>
                                    <th>공연제목</th>
                                    <td>${ctBoard.ctBbsTitle}</td>
                                </tr>
                                <tr>
                                    <th>결제일시</th>
                                    <td>${ctPm.pmDate}</td>
                                </tr>
                                <tr>
                                    <th>티켓 금액</th>
                                    <td>${ctBoard.ctPrice}원</td>
                                </tr>
                            </tbody>
                        </table>
    	
    	
    </div>
    
    
    <div class="payBarTicketButton1">
         <button id="emailSend" class="btn btn-dark" type="button" onclick="fn_email()">이메일로 티켓 받기</button>
    </div>
	
	<div class="payBarTicketButton2">
	    <button id="btnClose" class="btn btn-dark" type="button">닫기</button>
	</div>
<div class="payFoot"></div>
    
</body>
</html>