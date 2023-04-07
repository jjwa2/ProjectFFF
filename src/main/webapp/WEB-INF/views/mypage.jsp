<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%-- <%@  include file="/WEB-INF/views/include/head.jsp" %>
 --%>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--   <link rel="stylesheet" href="/resources/style/index-main.css">
 -->  
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  
  
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://kit.fontawesome.com/20497ca384.js" crossorigin="anonymous"></script>
 
 
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script src="https://kit.fontawesome.com/002ce34e95.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <link rel="stylesheet" href="/resources/style/index-mypage.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">
	
	
  <title>마이페이지</title>
  <script>
  
  
    function showPage(id) {
      // hide all contents
      var contents = document.getElementsByClassName("content");
      for (var i = 0; i < contents.length; i++) {
        contents[i].classList.add("slide");
        contents[i].classList.add("hide");
      }

      // show selected content
      var selectedContent = document.getElementById(id);
      selectedContent.classList.remove("hide");
      selectedContent.classList.remove("slide");

      /*
      // reset all active links
      var links = document.getElementsByTagName("a");
      for (var i = 0; i < links.length; i++) {
        links[i].classList.remove("active");
      }

      // set active link
      var activeLink = document.querySelector('a[href="#' + id + '"]');
      activeLink.classList.add("active");
    */
    }
    
    

    function checkPassword() {
      var password = document.getElementById("password1").value;
      // 비밀번호 체크 로직을 작성합니다.
      if (password === "${user.userPwd}") {
        // 비밀번호가 일치할 경우, 회원정보 수정 페이지를 보여줍니다.
        document.getElementById("editInfo").style.display = "block";
        // 현재 페이지를 감춥니다.
        document.querySelector("section1:first-of-type").style.display = "none";
      } else {
    	  Swal.fire({
    		 	icon: 'error',                         // Alert 타입
	            title: '비밀번호를 입력해주세요.',         // Alert 제목
	            text: '비밀번호 확인 후 사용 가능합니다.',  // Alert 내용
	        });
      }
    }
    
    
    function checkPassword1() {
        var password = document.getElementById("password2").value;
        // 비밀번호 체크 로직을 작성합니다.
        if (password === "${user.userPwd}") {
          // 비밀번호가 일치할 경우, 회원정보 수정 페이지를 보여줍니다.
          document.getElementById("editInfo1").style.display = "block";
          // 현재 페이지를 감춥니다.
          document.querySelector("section2:first-of-type").style.display = "none";
        } else {
        	Swal.fire({
	            icon: 'error',                         // Alert 타입
	            title: '비밀번호를 입력해주세요.',         // Alert 제목
	            text: '비밀번호 확인 후 사용 가능합니다.',  // Alert 내용
	        });
        }
      }
     
    
    $(document).ready(function() {


    	
    	$("#btnUpdate").on("click", function() {
    		
    		// 모든 공백 체크 정규식
    		var emptCheck = /\s/g;
    		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
    		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
    				
    		if($.trim($("#userPwd1").val()).length <=0) {
    			
   			  Swal.fire({
   	    		 	icon: 'error',                         // Alert 타입
   		            title: '비밀번호를 입력해주세요.',         // Alert 제목
		            text: '필수 입력 항목 입니다.',  // Alert 내용
   		        });
    			$("#userPwd1").val("");
    			$("#userPwd1").focus();
    			return;
    		}
    		
    		if(emptCheck.test($("#userPwd1").val())) {
    			
    			  Swal.fire({
    	    		 	icon: 'error',                         // Alert 타입
    		            title: '비밀번호를 확인해주세요',         // Alert 제목
    		            text: '공백을 포함할 수 없습니다.',  // Alert 내용
    		        });
    			$("#userPwd1").focus();
    			return;
    		}
    		
    		if(!idPwCheck.test($("#userPwd1").val())) {
    			 
    			Swal.fire({
 	    		 	icon: 'error',                         // Alert 타입
 		            title: '비밀번호를 확인해주세요',         // Alert 제목
 		            text: '비밀번호는 영문 대소문자와 숫자로 4~12자리입니다.',  // Alert 내용
    			});
    			$("#userPwd1").focus();
    			return;
    		}
    		
    		if($("#userPwd1").val()!= $("#userPwd2").val()) {
    			Swal.fire({
 	    		 	icon: 'error',                         // Alert 타입
 		            title: '비밀번호를 확인해주세요',         // Alert 제목
 		            text: '비밀번호가 일치하지 않습니다.',  // Alert 내용
    			});
    			$("#userPwd2").focus();
    			return;
    		}
    		
    		if($.trim($("#userName").val()).length <=0) {
    			Swal.fire({
 	    		 	icon: 'error',                         // Alert 타입
 		            title: '비밀번호를 확인해주세요',         // Alert 제목
 		            text: '사용자 이름을 입력하세요.',  // Alert 내용
    			});
    			$("#userName").val("");
    			$("#userName").focus();
    			return;
    		}
    		
    		if(!fn_validateEmail($("#userEmail").val())) {
    			Swal.fire({
 	    		 	icon: 'error',                         // Alert 타입
 		            title: '비밀번호를 확인해주세요',         // Alert 제목
 		            text: '사용자 이메일 형식이 올바르지 않습니다.',  // Alert 내용
    			});
    			$("#userEmail").focus();
    			return;
    		}
    		
    		$("#userPwd").val($("#userPwd1").val());
    		
    		$.ajax({
    			type:"POST",
    			url:"/mypageProc",
    			data:{
    				userId:$("#userId").val(),
    				userPwd:$("#userPwd").val(),
    				userName:$("#userName").val(),
    				userEmail:$("#userEmail").val()
    			},
    			datatype:"JSON",
    			 beforeSend: function(xhr) {
    		    	 xhr.setRequestHeader("AJAX","true");
    			},
    			success:function(response) {
    				
    				if(response.code==0){
    					Swal.fire({
    	 	    		 	icon: 'success',                         // Alert 타입
    	 		            title: '회원 정보가 수정되었습니다.',         // Alert 제목
    	    			});
    					location.href="/";
    				}
    				else if(response.code==400) {
    					Swal.fire({
    	 	    		 	icon: 'error',                         // Alert 타입
    	 		            title: '오류가 발생했습니다.',         // Alert 제목
    	 		            text: '파라미터 값이 올바르지 않습니다.',  // Alert 내용
    	    			});
    					$("#userId").focus();
    				}
    				else if(response.code==404) {
    					Swal.fire({
    	 	    		 	icon: 'error',                         // Alert 타입
    	 		            title: '오류가 발생했습니다.',         // Alert 제목
    	 		            text: '회원 정보가 없습니다.',  // Alert 내용
    	    			});
    					location.href="/";
    				}
    				else if(response.code==500) {
    					Swal.fire({
    	 	    		 	icon: 'error',                         // Alert 타입
    	 		            title: '오류가 발생했습니다.',         // Alert 제목
    	 		            text: '회원 정보 수정 중 오류가 발생하였습니다.',  // Alert 내용
    	    			});
    					$("#userId").focus();
    				}
    				else {
    					Swal.fire({
    	 	    		 	icon: 'error',                         // Alert 타입
    	 		            title: '오류가 발생했습니다.',         // Alert 제목
    	 		            text: '회원 정보 수정 중 오류가 발생하였습니다2.',  // Alert 내용
    	    			});
    					$("#userId").focus();
    				}
    			},
    			error:function(xhr,status,error) {
    				
    				icia.common.error(error);
    			}
    		});
    	});
    });

    function fn_validateEmail(value)
    {
    	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    	
    	return emailReg.test(value);
    }

    //회원 탈퇴
$(document).ready(function(){
        $("#btnOut").on("click", function(){
            Swal.fire({
                title: '정말 탈퇴 하시겠습니까?',
                text: "다시 되돌릴 수 없습니다. 신중하세요.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '탈퇴',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    // status 값이 "Y"라면 "N"으로 변경
                    if($.trim($("#status").val()) == "Y") {
                        $("#status").val("N");
                    }
                
                    $.ajax({
                        type:"POST",
                        url:"/mypageOut",
                        data:{
                            status: $("#status").val()
                        },
                        
                        dataType:"JSON",
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader("AJAX", "true");
                        },
                        success:function(response) {
                            if(response.code == 0) {
                                Swal.fire({
                                        icon: 'success',                         // Alert 타입
                                        title: '회원 탈퇴가 완료되었습니다.',         // Alert 제목
                                    });
                                location.href = "/";
                            } else if(response.code == 400) {
                                Swal.fire({
                                        icon: 'error',                         // Alert 타입
                                        title: '오류가 발생했습니다.',         // Alert 제목
                                        text: '이미 정지된 회원입니다.',  // Alert 내용
                                    });
                                location.href = "/mypage";
                            } else if(response.code == 404) {
                                Swal.fire({
                                        icon: 'error',                         // Alert 타입
                                        title: '오류가 발생했습니다.',         // Alert 제목
                                        text: '회원 정보 수정 중 오류가 발생하였습니다.',  // Alert 내용
                                    });
                                location.href = "/mypage";
                            } else if(response.code == 500) {
                                Swal.fire({
                                        icon: 'error',                         // Alert 타입
                                        title: '오류가 발생했습니다.',         // Alert 제목
                                        text: '회원 정보 수정 중 오류가 발생하였습니다2.' // Alert 내용
                                    });
                                location.href = "/mypage";
                            } else {
                                Swal.fire({
                                        icon: 'error',                         // Alert 타입
                                        title: '오류가 발생했습니다.',         // Alert 제목
                                        text: '회원 정보 수정 중 오류가 발생하였습니다3.',  // Alert 내용
                                    });
                                location.href = "/mypage";
                            }
                        },
                        error:function(xhr, status, error) {
                            icia.common.error(error);
                        }
                        
                    });
                }
                else {
                    location.href = "/mypage";
                }
            });
        });
});
  
    
    
  </script>
</head>
  <body>


<%@  include file="/WEB-INF/views/include/navigation.jsp" %>

      <main>
      <section class="main-container">


    <div class="snstitle">
      <div class="snstitlemain">마이페이지</div>
      <div class="snstitlesub">참여한 펀딩, 작성한 내 글 등을 관리해보세요</div>
    </div>
    
    
    <div class="user-info">
    	<div class="user-info-image">
<c:choose>
	<c:when test="${user.userLevel == '2'}">
			<img src="/resources/upload/${artProfile.fileProfileName}" alt="사용자 프로필 사진">
	</c:when>
	<c:otherwise>
    		<img src="/resources/images/profile.png" alt="기본 프로필 사진">
	</c:otherwise>
</c:choose>
    	</div>
    	<div>
    		<div class="user-details">
            <h2>${user.userId}</h2>
            <c:if test="${user.userLevel == '1'}">
             <a href="/user/artistUpgrade" style="text-decoration: none; color: inherit;"><button id="login">등급 변경</button></a>
            </c:if>
            <p>${user.userEmail}</p>
            <p>${user.userTel}</p>
          </div>
    	</div>
    </div>
    
    
    
    
    <div class="text-warning fundingmain-hr">
      <hr>
    </div>


        <div class="tabs">
          <ul>
            <li><a href="#" onclick="showPage('content1')">펀딩 내역</a></li>
            <li><a href="#" onclick="showPage('content2')">내 게시글</a></li>
            <li><a href="#" onclick="showPage('content3')">회원 정보 수정</a></li>
            <li><a href="#" onclick="showPage('content4')">회원 탈퇴</a></li>
          </ul>
        </div>




		<div class="content slide" id="content1">
	  		<h2 class="content-title">펀딩 내역</h2>
	  		<div class="scrollable-container">
			<table class="table table-hover">
			  <thead>
			    <tr style="background-color: #dee2e6;">
			      <th scope="col" class="text-center" style="width:20%">결제번호</th>
			      <th scope="col" class="text-center" style="width:10%">유저 아이디</th>
			      <th scope="col" class="text-center" style="width:20%">티어번호</th>
			      <th scope="col" class="text-center" style="width:20%">펀딩 게시판 번호</th>
			      <th scope="col" class="text-center" style="width:20%">결제 일자</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:if test="${!empty fdPm}">
			      <c:forEach var="list" items="${fdPm}" varStatus="status">            
			        <tr>
			          <td><a style="color : #fff; text-decoration: none;">${list.paymentNum}</a></td>
			          <td><a style="color : #fff; text-decoration: none;">${list.userId}</a></td>
			          <td><a style="color : #fff; text-decoration: none;">${list.tierNum}</a></td>
			          <td><a style="color : #fff; text-decoration: none;">${list.fdBbsSeq}</a></td>
			          <td><a style="color : #fff; text-decoration: none;">${list.pmDate}</a></td>
			        </tr>
			      </c:forEach>
			    </c:if>
			  </tbody>
			</table>
			</div>
		</div>
        


        <div class="content hide" id="content2">
          <h2 class="content-title">내 게시글</h2>
          <div class="scrollable-container">
          <table class="table table-hover">
		  	<thead>
		  		<tr style="background-color: #dee2e6;">
					<th scope="col" class="text-center" style="width:10%">번호</th>
					<th scope="col" class="text-center" style="width:40%">제목</th>
					<th scope="col" class="text-center" style="width:10%">작성자</th>
					<th scope="col" class="text-center" style="width:30%">날짜</th>
					<th scope="col" class="text-center" style="width:10%">조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${!empty review}">
				<c:forEach var="list" items="${review}" varStatus="status">
				<tr>
					<td><a style="color : #fff; text-decoration: none;">${list.rvSeq}</a></td>
 					<td><a style="color : #fff; text-decoration: none; cursor: pointer;" onclick="location.href='/rvBoard/rvView?rvSeq=${list.rvSeq}'">${list.rvTitle}</a></td>	
					<td><a style="color : #fff; text-decoration: none;">${list.userId}</a></td>
					<td><a style="color : #fff; text-decoration: none;">${list.regDate}</a></td>
					<td><a style="color : #fff; text-decoration: none;">${list.readCnt}</a></td>
				</tr>
				</c:forEach>	
			</c:if>
			</tbody>
		</table>
		</div>
       </div>



        <div class="content hide" id="content3">
          <section1 class="content-susu">
            <h2 class="content-title">회원정보 수정</h2>
            <form class="susu">
            <div class="susu-div">
              <label class="susu-label" for="password">현재 비밀번호:</label>
              <input type="password" id="password1" name="password1" required/>
              <button type="button" onclick="checkPassword()">확인</button>
			</div>              
            </form>
          </section1>


          <section id="editInfo" style="display:none;">
            <div class="scrollable-container">
            <h2 class="content-title">회원정보 수정</h2>
            <form class="susu">
                <div class="form-group">
                    <label for="username">사용자 아이디</label>
                   		${user.userId}
                </div>
                <div class="form-group">
                    <label for="username">비밀번호</label>
                    <input type="password" class="form-control" id="userPwd1" name="userPwd1" value="${user.userPwd}" placeholder="비밀번호" maxlength="12" />
                </div>
                <div class="form-group">
                    <label for="username">비밀번호 확인</label>
                    <input type="password" class="form-control" id="userPwd2" name="userPwd2" value="${user.userPwd}" placeholder="비밀번호 확인" maxlength="12" />
                </div>
                <div class="form-group">
                    <label for="username">사용자 이름</label>
                    <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" placeholder="사용자 이름" maxlength="15" />
                </div>
                <div class="form-group">
                    <label for="username">사용자 이메일</label>
                    <input type="text" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}" placeholder="사용자 이메일" maxlength="30" />
                </div>
                <input type="hidden" id="userId" name="userId" value="${user.userId}" />
                <input type="hidden" id="userPwd" name="userPwd" value="" />
                <button type="button" id="btnUpdate">수정</button>
            </form>
          </div>
          </section>
        </div>
        
        
        <div class="content hide" id="content4">
          <section2>
            <h2 class="content-title">회원 탈퇴</h2>
            <form class="out">
            <div class="out-div">
              <label class="out-label" for="password">현재 비밀번호:</label>
              <input type="password" id="password2" name="password2" required>
              <button type="button" id="btnOut" onclick="checkPassword1()">확인</button>
            </div> 
            </form>
          </section2>
        </div>

    </section>
    
    
          <%@ include file="/WEB-INF/views/include/footer.jsp" %>    

  </body>
</html>
