<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@  include file="/WEB-INF/views/include/head.jsp"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>




<link rel=stylesheet href="/resources/style/idFind.css" />
<link rel="stylesheet" href="/resources/style/navigation.css">

<!-- Compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

<!-- Compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!-- 드롭다운 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>


<!-- 아이콘 cdn -->
<script src="https://kit.fontawesome.com/20497ca384.js"
	crossorigin="anonymous"></script>

<!-- toastr -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
	integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
	integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>



<style>
.btn {
	background-color: #fff;
	color: black;
	border-radius: 15px;
}

.btn:hover {
	background-color: #FFAB00 !important;
}
</style>

</script>

<title>Document</title>

<script>
  
//자동 하이픈
  const regexPhoneNumber = (target) => {
      target.value = target.value.replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
  }

  
//아이디 찾기 휴대폰 인증
	var code4 = "";
	
	var telCheck = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	function fn_phone3(){
		var userTel = $("#userTel").val();
			
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
			
	      toastr.info('인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.');
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
	                $("#phoneChk2").attr("disabled", false);
	                code4 = data;
	                console.log(code4);
	                
	                $("phoneChk2").click(function(){
	                	var userTel2 = $("#userTel2").val();
	                	if(userTel2 == code4)
	                	{
	                		toastr.info("인증번호가 일치합니다.");
	                		$("#userTel2").attr("disabled",true);
	  			            $("#findCheck2").attr("disabled", false);
	                	}
	                	else
	                	{
	                		toastr.warning("인증번호가 일치하지 않습니다.");
	                		$("#userTel2").val("");
	                		$("#userTel2").focus();
	                		return;
	                	}
	                });
	            }
	        }
	        
	    });
	}
    
    //아이디 찾기 ajax
  $(document).ready(function(){
	 
	  $("#findCheck2").on("click", function(){
	    	
	    	$.ajax({
				type:"POST",
				url:"/user/idFindForm",
				data:{
					userEmail:$("#userEmail").val(),
					userTel:$("#userTel").val()
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code ==0)
					{
						
						Swal.fire({
							   title: '아이디 찾기 완료',
							   text: '유저의 이메일로 전송했습니다.',
							   icon: 'Success',
							 
							   
							}).then(result => {
							   // 만약 Promise리턴을 받으면,
							   if (result.isConfirmed) {

									var userId = response.data.userId;
									
									console.log("아이디는"+ userId);
								 
								   $.ajax({
							       	   type:"POST",
							       	   url:"/user/idEmail",
							       	   data:{
							       		   userEmail:$("#userEmail").val(),
							       		   userId:userId
							       	   },
							       	   datatype:"JSON",
							       	   beforeSend:function(xhr){
												xhr.setRequestHeader("AJAX", "true");
											},
											success:function(response){
												if(response == 0)
												{
													userId = response.data;
													console.log(userId);
												}	
												else if(response == -1)
												{
													alert("오류");
												}	
									
												
											},
											error:function(xhr,status,error)
											{
												icia.common.error(error);
											}
							       	            
							       	});
							      
							   }
							});
						
						
					}
					else if(response.code == 100)
					{
						toastr.warning("이메일이 일치하지 않습니다");
						$("#userEmail").focus();
					}
		
					else if(response.code == 200)
					{
						toastr.warning("이메일이 비어있습니다");
						$("#userEmail").focus();
					}
					else if(response.code == 300)
					{
						toastr.warning("사용자의 전화번호가 일치하지 않습니다.");
						$("#userTel").focus();
					}
					else if(response.code == 305)
					{
						toastr.warning("유저정보가 비어있습니다.");
						$("#userId").focus();
					}	
					else if(response.code == 400)
					{
						toastr.warning("전화번호가 비어있습니다.");
						$("#userTel").focus();
					}
					else
					{
						toastr.error("오류가 발생하였습니다.");
						$("#userEmail").focus();
						
					}
				},
				error:function(xhr,status,error)
				{
					icia.common.error(error);
				}
				
				
			});
	    });
	  
	  
	//휴대폰 인증번호 대조
		 $("#phoneChk2").click(function() {
			 
			 if($.trim($("#userTel").val()).length<=0)
		      {
				toastr.warning("전화번호를 입력해주세요");
		        $("#userTel").val("");
		        $("#userTel").focus();
		        return;
		      }	
			      if($("#userTel2").val() == code4)
			      { 
			    	  toastr.info('인증번호가 일치합니다.');
			           $("#userTel2").attr("disabled",true);
			           $("#findCheck2").attr("disabled", false);
			      }
			      else
			      {
			    	  toastr.warning('"인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.');
			          return;
			      }
			  }); 
  });
   
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
	<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
	<div class="idFind-form">
		<form action="idFindForm2" class="form-horizontal" method="post"
			name="pfrm">

			<div class="row">
				<div align="center">
					<p class="fontfont">아이디 찾기</p>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-form-label col-3" style="margin-left: 80px;">이메일</label>
				<div class="col-6" class="emailFind">
					<input type="text" class="form-control" name="mail" id="userEmail"
						placeholder="메일을 입력하세요." required>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-form-label col-3" style="margin-left: 80px;">휴대폰
					번호</label>
				<div class="col-6">

					<input type="text" class="form-control2" name="userTel"
						id="userTel" placeholder="휴대폰 번호를 입력하세요."
						oninput="regexPhoneNumber(this)" maxlength="13" required>
					<button id="phoneChk" onclick="fn_phone3()" type="button"
						class="waves-effect waves-light btn userTel"
						style="position: absolute; right: 0;">핸드폰 인증</button>

				</div>
			</div>

			<div class="form-group row">
				<label class="col-form-label col-3" style="margin-left: 80px;">인증
					번호</label>
				<div class="col-6">

					<input type="text" class="form-control2" name="userTel2"
						id="userTel2" placeholder="인증번호를 입력하세요." disabled required>
					<button type="button" class="waves-effect waves-light btn userTel2"
						id="phoneChk2" style="position: absolute; right: 0; width: auto;"
						disabled>확인</button>

				</div>
			</div>


			<div class="form-group row findidBtn">
				<button type="button" id="findCheck2"
					class="waves-effect waves-light btn findid findidBtn"
					style="margin-left: 450px; position: relative; top: 50px;" disabled>아이디
					찾기</button>
			</div>
	</div>
	</form>

	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>

</html>