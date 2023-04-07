<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

     <!-- Compiled and minified JavaScript -->
     <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
     <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
    crossorigin="anonymous"></script> -->
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
 
  
  <link href="/resources/style/regform_prac.css" rel="stylesheet">

  
	  
<link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">
  


 <!-- 드롭다운 -->
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  		integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  		crossorigin="anonymous"></script>
  		
  	<!-- nav바 필수 cdn -->
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
  crossorigin="anonymous"></script>
  
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
    <!-- toastr -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" 
   integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" 
   crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" 
integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" 
crossorigin="anonymous" referrerpolicy="no-referrer"></script>
 <!-- sweet alert cdn (삭제금지) -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>  
  
  
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function() {
    
$("#userId").focus();
    
    
//휴대폰 인증번호 대조
$("#phoneChk2").click(function()
{
	 
	 if($.trim($("#userTel").val()).length<=0)
     {
		toastr.warning("전화번호를 입력해주세요");
       $("#userTel").val("");
       $("#userTel").focus();
       return;
     }	
	      /*if($("#userTel2").val() == code2)*/
	      { 
	    	  toastr.info('인증번호가 일치합니다.');
	           $("#userTel2").attr("disabled",true);
	      }
	     /* 
	      else if($("#userTel2").val() != code2)
	      {
	    	  toastr.warning("인증번호가 비어있거나 불일치 합니다.");
	    	  $("#userTel2").focus();
	      }
	      
	      else
	      {
	    	  toastr.warning('"인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.');
	          return;
	      }*/
	  });

    
});
function register() {
	  if (document.getElementById('btnReg')) {
		  var emptCheck = /\s/g;	//모든 공백 체크 정규식
		    
		  var idCheck = /^[a-zA-Z0-9]{4,12}$/;
	      
	      var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/;
	      
	      var nameCheck = /^[가-힣]{2,5}$/;
	      
	      var telCheck = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;	
	      
	      
	      if($.trim($("#userId").val()).length <= 0)
	      {
	    	toastr.warning("사용자 아이디를 입력하세요.");
	        $("#userId").val("");
	        $("#userId").focus();
	        return;
	      }
	      
	      if(emptCheck.test($("#userId").val()))
	      {
	    	toastr.warning("사용자 아이디는 공백을 포함할 수 없습니다.");
	        $("#userId").focus;
	        return;
	      }
	      if(!idCheck.test($("#userId").val()))
	      {
	    	  toastr.warning("영문과 숫자로 4~12자리를 입력하세요");
	          $("#userId").focus();
	          return;
	      }
	      
	      if($.trim($("#userPwd").val()).length<=0)
	      {
	    	toastr.warning("비밀번호를 입력하세요.");
	        $("#userPwd").val("");
	        $("#userPwd").focus();
	        return;
	      }
	      if(emptCheck.test($("#userPwd").val()))
	      {
	    	toastr.warning("비밀번호는 공백을 포함할 수 없습니다.");
	        $("#userPwd").focus();
	        return;
	      }
	      if(!pwdCheck.test($("#userPwd").val()))
	      {
	    	  toastr.warning("비밀번호는 영문,숫자 조합으로 8~20자리로 입력하세요");
	          $("#userPwd").focus();
	          return;
	      }
	      
	      if($("#userPwd").val() != $("#userPwd2").val())
	      {
	    	toastr.warning("비밀번호가 일치하지 않습니다.");
	        $("#userPwd2").focus();
	        return;
	      }
	      if($.trim($("#userName").val()).length<=0)
	      {
	    	toastr.warning("사용자 이름을 입력하세요.");
	        $("#userName").val("");
	        $("#userName").focus();
	        return;
	      }
	      
	      if(!nameCheck.test($("#userName").val()))
	      {
	    	toastr.warning("사용자 이름은 2~5자리 한글을 입력해주세요.");
	        $("#userName").focus();
	        return;
	      }
	        
	      if(!fn_validateEmail($("#userEmail").val()))
	      {
	    	toastr.warning("사용자 이메일 형식이 올바르지 않습니다.");
	        $("#userEmail").focus();
	        return;
	        
	      }
	      
	      if($.trim($("#userTel").val()).length<=0)
	      {
	    	toastr.warning("전화번호를 입력해주세요");
	        $("#userTel").val("");
	        $("#userTel").focus();
	        return;
	      }	
	      
	      
	      if($.trim($("#userTel2").val()).length<=0)
	      {
	    	toastr.warning("인증번호를 입력해주세요.");
	        $("#userTel2").val("");
	        $("#userTel2").focus();
	        return;
	      }
	      
	      if($.trim($("#userAdd").val()).length <= 0)
	      {
	    	toastr.warning("우편번호를 입력해주세요");
	        return;
	      }	

	      if($.trim($("#userAdd2").val()).length<=0)
	      {
	    	toastr.warning("상세주소를 입력해주세요");
	        $("#userAdd2").val("");
	        $("#userAdd2").focus();
	        return;
	      }	
	      
	      if($.trim($("#userBirth").val()).length <= 0)
	      {
	    	toastr.warning("생년월일을 입력해주세요");
	        return;
	      }	
			
			$("#userPwd").val($("#userPwd2").val());
			
			//아이디 이메일 중복 체크
			$.ajax({
				type:"POST",
				url:"/user/idCheck",
				data:{
					userId:$("#userId").val(),
					userEmail:$("#userEmail").val()
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code ==0)
					{
						Swal.fire({
							icon:'info',
							title:'가입 가능합니다.',
							confirmButtonColor: '#3085d6',
							 confirmButtonText: '확인',
						}).then((result)=>{
							fn_userReg();
						})
						
					}
					else if(response.code == 100)
					{
						toastr.warning("중복된 아이디 입니다.");
						$("#userId").focus();
					}
					else if(response.code == 200)
					{
						toastr.warning("중복된 이메일 입니다.");
						$("#userEmail").focus();
					}
					else if(response.code == 300)
					{
						toastr.warning("아이디 또는 이메일이 중복되었습니다.");
						$("#userId").focus();
					}	
					else if(response.code == 400)
					{
						toastr.warning("정보가 비어있습니다.");
					}	
					else
					{
						toastr.error("오류가 발생하였습니다.");
						$("#userId").focus();
						
					}
				},
				error:function(xhr,status,error)
				{
					icia.common.error(error);
				}
				
			});
			
	  }
	}

 
       


function fn_userReg()
{
	$.ajax({
		type:"POST",
		url:"/user/regProc",
		data:{
			userId:$("#userId").val(),
			userPwd:$("#userPwd").val(),
			userName:$("#userName").val(),
			userEmail:$("#userEmail").val(),
			userTel:$("#userTel").val(),
			userAdd:$("#userAdd").val(),
			userAdd2:$("#userAdd2").val(),
			userBirth:$("#userBirth").val()
			
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
				if(response.code ==0){
				Swal.fire({
					title:'축하합니다. 회원가입되었습니다.',
					icon:'success',
					confirmButtonColor: '#3085d6',
					confirmButtonText: '승인',
				}).then((result)=>{
					if(result.isConfirmed){
						location.href = "/index";
					}
				})
				
			}
				else if(response.code == 100)
				{
					toastr.warning("회원 아이디가 중복 되엇습니다.");
					$("#userId").focus();
				}
				else if(response.code ==400)
				{
					toastr.error("파라미터 값이 올바르지 않습니다.22");
					$("#userId").focus();
				}
				else if(response.code == 500)
				{
					toastr.error("회원 가입 중 오류가 발생하였습니다.");
					$("#userId").focus();
					
				}
				else
				{
					toastr.error("회원 가입 중 오류 발생");
					$("#userId").focus();
				}
				
		},
		
		error:function(xhr,status,error){
			icia.common.error(error);
		}
		
	});
}

//이메일 정규식
function fn_validateEmail(value)
{
	
	var emailReg =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	//숫자나 영어로 시작하고 -_.을 포함한 숫자나 영어만 있고 @가 들어간다. 숫자나 영어로 다시 시작하고 -_.을 포함한 영어나 숫자만 있고. 이들어간다 그리고 2개 또는 3개인 영어로 끝난다.
	
	return emailReg.test(value);
}


//자동 하이픈
const regexPhoneNumber = (target) => {
    target.value = target.value.replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}


//우편주소 js
function findAddr() {
    new daum.Postcode({
      oncomplete: function (data) {
        console.log(data);

        var roadAddr = data.roadAddress;
        var jibunAddr = data.jibunAddress;

        document.getElementById('userAdd3').value = data.zonecode;
        if (roadAddr !== '') {
          document.getElementById("userAdd").value = roadAddr;
        }
        else if (jibunAddr !== '') {
          document.getElementById("userAdd").value = jibunAddr;
        }
      }
    }).open();
  }
  
  
  
//휴대폰 번호 중복체크 

function fn_phone() {

  var userTel = $("#userTel").val();




  $.ajax({
    type: "POST",
    url: "/user/phoneOvl",
    data: {
      userTel: userTel
    },
    datatype: "JSON",
    beforeSend: function(xhr) {
      xhr.setRequestHeader("AJAX", "true");
    },
    success: function(response) 
    {
      if (response.code == 0) 
      {
        Swal.fire({
        	title:'가입 가능한 번호입니다.',
        	icon:'info',
        	 confirmButtonColor: '#3085d6',
        	 confirmButtonText: '확인', 
        }).then((result)=>{
        	fn_phone2();
        })
        
      } 
      else if (response.code == 100) 
      {
        toastr.warning("중복된 휴대폰 번호 입니다.");
        $("#userTel").focus();
      } 
      else if (response.code == 200) 
      {
        toastr.error("유저 핸드폰번호로 이미 가입되어있습니다.");
        $("#userTel").focus();
      }
      else if (response.code == 404) 
      {
        toastr.warning("핸드폰 번호가 비어있습니다.");
      }
      else 
      {
        toastr.error("오류가 발생하였습니다.");
        $("#userTel").focus();
      }
    },
    error: function(xhr, status, error) {
      icia.common.error(error);
    }
  });
}
	
//휴대폰 인증문자 발송
var code2 = "";

function fn_phone2(){
	
	var telCheck = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;	
	
	var userTel = $("#usreTel").val();
		
	if($.trim($("#userTel").val()).length<=0)
      {
        toastr.warning("전화번호를 입력해주세요");
        $("#userTel").val("");
        $("#userTel").focus();
        return;
      }	
      
      if(!telCheck.test($("#userTel").val()))
      {
    	toastr.warning("형식에 맞는 전화번호를 적어주세요.(-필수)");
    	$("#userTel").focus();
    	return;
      }
      
    Swal.fire({
    	icon:'success',
    	title:'인증번호 발송이 완료되었습니다.',
    	text:'휴대폰에서 인증번호 확인을 해주십시오.',
    });
    
    var userTel = $("#userTel").val();
    console.log(userTel);
    $.ajax({
        type:"GET", 
        url:"/user/phoneCheck", 
        data: {userTel : userTel}, 
        cache : false,
        success:function(data)
        {
            if(data == "error")
            { 
            	toastr.warning("휴대폰 번호가 올바르지 않습니다.");
                $("#userTel").attr("autofocus",true);
            }
            else
            {           
                $("#userTel2").attr("disabled",false);
                $("#phoneChk2").attr("disabled",false);
                $("#userTel").attr("readonly",true);
                code2 = data;
                console.log(code2);
                
            
            }
        }
        
    });
}
	 
	toastr.options = {
			  "closeButton": true,
			  "debug": false,
			  "newestOnTop": false,
			  "progressBar": false,
			  "positionClass": "toast-top-center",
			  "preventDuplicates": false,
			  "onclick": null,
			  "showDuration": "100",
			  "hideDuration": "1000",
			  "timeOut": "2500",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut"
			}
	

</script>


</head>
<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <div class="main-background">
 
    
    
    <form   class="joinForm">
  
    <div class="container">

      <p class="jointitle">회원가입</p>

      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input type="text" id="userId" class="autocomplete" data-length="12" required value="Nero2">
              <label for="autocomplete-input">아이디</label>
            </div>
          </div>
        </div>
      </div>

      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input type="password" id="userPwd" class="autocomplete" data-length="20" required value = "a1234567">
              <label for="autocomplete-input">비밀번호</label>
            </div>
          </div>
        </div>
      </div>

      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input type="password" id="userPwd2" class="autocomplete" data-length="20" required value = "a1234567">
              <label for="autocomplete-input">비밀번호 확인</label>
            </div>
          </div>
        </div>
      </div>

      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input type="text" id="userName" class="autocomplete" data-length="5" required value ="배정현">
              <label for="autocomplete-input">이름(2~5한글)</label>
            </div>
          </div>
        </div>
      </div>

      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input id="userEmail" type="email" class="validate" autocomplete="off" value ="xlah1gh@naver.com">
              <label for="email">이메일</label>
              <span class="helper-text" data-error="wrong" data-success="right"></span>
            </div>
          </div>
        </div>
      </div>

        <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12" style="position: relative;">
              <input type="text" id="userTel" class="autocomplete" name="userTel" oninput="regexPhoneNumber(this)" maxlength="13" required value ="010-3050-9245">
              <label for="autocomplete-input">전화번호</label>
              <button id="phoneChk" onclick="fn_phone()" type="button" class="waves-effect waves-light btn" style="position: absolute; right: 0; width: auto;" >핸드폰 인증</button>
            </div>
          </div>
        </div>
      </div>


	<div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input type="text" class="autocomplete" id="userTel2" name="userTel2" style="position: relative;" disabled required>
              <label for="autocomplete-input">인증번호</label>
              <button  type="button" class="waves-effect waves-light btn" id="phoneChk2" style="position: absolute; right: 0; width: auto;" disabled>확인</button>
            </div>
          </div>
        </div>
      </div>
	



      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">

              <input type="text" id="userAdd" class="autocomplete" placeholder="도로명" style="position: relative;" readonly>

              <input id="userAdd3" class="waves-effect waves-light btn" type="button" value="우편번호" readonly onclick="findAddr()" style="position: absolute; right: 0; width: auto;">

              <input type="text" class="detail_addr" id="userAdd2" placeholder="상세주소">
              <label for="autocomplete-input">주소</label>

            </div>
          </div>
        </div>
      </div>

      <div class="textForm">
        <div class="col s12">
          <div class="row">
            <div class="input-field col s12">
              <input type="date" class="datepicker" id="userBirth" min="1900-01-01" max="2023-04-05">
              <label for="autocomplete-input">생년월일</label>
            </div>
          </div>
        </div>
      </div>
        
          <input type="button" class="btn1 w-btn-outline w-btn-yellow-outline" id="btnReg" value="회원가입" onclick="register()" />

    </div>
</form>
</div>
    
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>
  
</html>