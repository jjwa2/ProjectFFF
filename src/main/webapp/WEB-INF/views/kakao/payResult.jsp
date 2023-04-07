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
            background-color: #222222;
            color: #ffffff;
        }

        /* 카드 배경색 */
        .card {
            background-color: #333333;
        }

        /* 카드 타이틀, 내용 글자색 */
        .card-title,
        .card-text {
            color: #ffffff;
        }

        /* 테이블 배경색 */
        .table {
            background-color: #444444;
        }

        /* 짝수 줄 배경색 */
        tr:nth-child(even) {
            background-color: #333333;
        }

        /* 버튼 배경색 */
        .btn-primary {
            background-color: #7c72dc;
            border-color: #7c72dc;
            font-weight: bold;
            padding: 8px 20px;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 30px;
            margin-right: 10px;
        }

        /* 버튼 호버 배경색 */
        .btn-primary:hover {
            background-color: #6b65b6;
            border-color: #6b65b6;
        }

        /* 테이블 헤더 배경색 */
        th {
            background-color: #555555;
        }

        /* 테이블 헤더 글자색 */
        th,
        td {
            color: #ffffff;
        }
        #btnClose{
        margin-left: 20px;
         background-color: #f1a712
        }
    </style>
    
    <script type="text/javascript">
      $(document).ready(function() {
    	  opener.location.reload();
      $("#btnClose").on("click", function() {
 
        window.close();
        
       
    });
  });
      
   
  </script>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card my-5">
                    <div class="card-body text-center">
                        <h5 class="card-title">결제 완료</h5>
                        <p class="card-text">결제가 완료되었습니다.</p>
                        <table class="table table-bordered">
                            <tbody>
                                <tr>
                                    <th>결제일시</th>
                                    <td>${fdPm.pmDate}</td>
                                </tr>
                                <tr>
                                    <th>후원제목</th>
                                    <td>${fdTitle}</td>
                                </tr>
                                <tr>
                                    <th>티어 번호</th>
                                    <td>${fdPm.tierNum}</td>
                                </tr>
                                <tr>
                                    <th>후원한 결제 금액</th>
                                    <td>${price}</td>
                                </tr>
                                <tr>
                                    <th>주문번호</th>
                                    <td>${fdPm.paymentNum}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <button id="btnClose" class="btn btn-primary" type="button">닫기</button>
    
    
</body>
</html>