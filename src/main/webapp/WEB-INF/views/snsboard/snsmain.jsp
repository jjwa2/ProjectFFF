<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
  <link rel="stylesheet" href="/resources/style/snsmain.css">
  
  <link href="https://fonts.googleapis.com/css2?family=Tourney:ital,wght@1,100&display=swap" rel="stylesheet">
  
  <!-- 구글폰트 CDN -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">

  
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	

  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  


      <!-- 자바스크립트 -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
      
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap" rel="stylesheet">

      


<script type="text/javascript">
$(document).ready(function() {

	$('#reply-btn').on('click', submitForm);

	$('#snsReplyForm').on('keydown', function(event) {
	  if (event.keyCode === 13) { // Enter key code
	    event.preventDefault(); // Prevent default Enter behavior (submitting the form)
	    submitForm();
	  }
	});
	
	$(".search").on("keyup", function(event) {
		  if (event.keyCode === 13) {
		    var searchQuery = $(this).val();
		    $.ajax({
		      type: "POST",
		      url: "/sns/search",
		      data: {
		        userId: searchQuery
		      },
		      dataType: "json",
		      beforeSend: function(xhr) {
		        xhr.setRequestHeader("AJAX", "true");
		      },
		      success: function(response) {
		        var modal = document.getElementById("myModal");
		        modal.style.display = "block";
		        var findArtistList = document.getElementsByClassName("findArtistList")[0];
		        findArtistList.innerHTML = "";
		        for (var i = 0; i < response.data.length; i++) {
		          var artist = response.data[i];
		          var html =  '<div class="findArtistttt">' +
			        	          '<div class="findArtistImage">' +
			                      '  <img class="findArtistImagee" src="/resources/upload/'+artist.fileProfileName+'" alt="내 프로필">' +
			                      '</div>' +
			                      '<div class="findArtistInfo">' +
			                      '  <div class="findArtistId">' +
			                      '    ' + artist.userId +
			                      '  </div>' +
			                      '  <div class="findArtistContent">' +
			                      '    ' + artist.userIntroduce +
			                      '  </div>' +
			                      '</div>' +
			                      '<div class="findArtistButton">' + 
			                      '<a href="javascript:void(0)" onclick="fn_snsFollow(`'+artist.userId+'`)"><button type="button" class="btn btn-warning" style="background-color: #039be5; border: none; font-size: 12px;">팔로우</button></a>' +
			                      '</div>'+
		                      '</div>'+
		                      '<hr>';
		          var div = document.createElement("div");
		          div.innerHTML = html;
		          findArtistList.appendChild(div);
		        }
		      },
		      error: function(xhr, status, error) {
		        icia.common.error(error);
		      }
		    });
		  }
		});

	$(function() {
		  $('.bookmark').click(function() {
		    $(this).attr('src', '/resources/images/sns/heartRed.png');
		  });
		});

});


function submitForm() {
	  var form = $('#snsReplyForm')[0];
	  var formData = new FormData(form);
	  
	  $.ajax({
	    type:"POST",
	    enctype:"multipart/form-data",
	    url:"/snsmain/snsReplyProc",
	    data:formData,
	    processData:false,
	    contentType:false,
	    cache:false,
	    beforeSend:function(xhr){
	      xhr.setRequestHeader("AJAX", "true");
	    },
	    success:function(response){
	      if(response.code == 0)
	      {
	        location.href = "/snsboard/snsmain";
	      }
	      else if(response.code == 400)
	      {
	        alert('파라미터값이 올바르지않습니다.');
	      }
	      else
	      {
	        alert('댓글 등록중 오류발생.');
	      }
	    },
	    error:function(error){
	      icia.common.error(error);
	      alert('댓글 등록 중 오류가 발생했습니다.');
	    }
	  });
	}



function fn_list(curPage)
{
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/snsboard/snsmain";
	document.bbsForm.submit();	
}

function fn_snsDelete(val)
{
	if(confirm("게시물을 삭제 하시겠습니까?") == true)
	{	
		
		//ajax
		$.ajax({
			type:"POST",
			url:"/sns/delete",
			data:{
				snsSeq:val
			},
			datatype:"JSON",
			
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX","true");
			},
			success:function(response)
			{
				if(response.code ==0)
				{
					alert("게시물이 삭제 되었습니다.");
					location.href = "/snsboard/snsmain";
				}
				else if(response.code == 500)
				{
					alert("작성한 게시글이 없습니다");
					location.href = "/snsboard/snsmain";
				}
				else if(response.code == 400)
				{
					alert("작성자 본인이 아닙니다");
					location.href = "/snsboard/snsmain";
				}
				else if(response.code == 300)
				{
					alert("삭제하는 도중 오류가 발생하였습니다.");
					location.href = "/snsboard/snsmain";
				}
				else
				{
					alert("시스템 오류가 발생하였습니다.");
				}
			},
			error: function(xhr,status,error)
			{
				icia.common.error(error);
			}
		});
		
	}
}

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



function fn_snsUnfollow(val)
{
		//ajax
		$.ajax({
			type:"POST",
			url:"/sns/unfollow",
			data:{
				userId:val
			},
			datatype:"JSON",
			
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

function fn_snsSelect(val)
{
	document.bbsForm2.followerId.value = val;
	document.bbsForm2.action = "/snsboard/snsmain";
	document.bbsForm2.submit();	
}


function fn_replyDelete(val)
{
	if(confirm("댓글을 삭제 하시겠습니까?") == true)
	{	
		//ajax
		$.ajax({
			type:"POST",
			url:"/snsBoard/replyDelete",
			data:{
				snsReplySeq:val
			},
			datatype:"JSON",
			
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX","true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					location.reload();
				}
				else if(response.code == 500)
				{
					alert("댓글 작성자가 아닙니다.");
					location.reload();
				}
				else if(response.code == 400)
				{
					alert("댓글이 존재하지않습니다.");
					location.reload();
				}
				else
				{
					alert("시스템 오류가 발생하였습니다.");
					location.reload();
				}
			},
			error: function(xhr,status,error)
			{
				icia.common.error(error);
			}
		});
		
	}
}



//모달 열기 함수
function openModal() {
  var modal = document.getElementById("myModal");
  modal.style.display = "block";
  
  document.body.style.overflow = "hidden";
}

// 모달 닫기 함수
function closeModal() {
  var modal = document.getElementById("myModal");
  modal.style.display = "none";
  
  document.body.style.overflow = "auto";
}


// 모달 창 외부 클릭 시 모달 닫기
window.onclick = function(event) {
  var modal = document.getElementById("myModal");
  if (event.target == modal) {
    closeModal();
  }
}





</script>
</head>
<body>   
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    <c:if test="${empty follow}">	
   <div class="main-container">
         <header>
        <div class="left_box">
          <div class="camera_box">
            <!-- <img class="camera" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/logo.png"
            style="filter: invert(100%)" alt="인스타 사진" /-->
          </div>
          <div class="line">|</div>
          <div class="logo_box">
            
          </div>
        </div>
        <span class="seach_box">
          <input type="search" class="search" placeholder="아티스트 검색" style="background-color: rgba(209, 203, 195, 0); color: aliceblue;" />
        </span>
        <div class="right_box">
          <div class="d-grid gap-4 d-md-block" id="login" style="margin-left: 120px;">
          
          
          <c:if test="${sessionScope.userLevel == 2 or sessionScope.userLevel == 3}">
            <a href="/snsboard/snsWriteForm"><button id="snsBoardUpload" class="btn btn-primary" type="button" style="background-color: #039be5; border: none; font-size: 12px;">게시물 업로드</button></a>
          </c:if>
          
          </div>
        </div>
      </header>
   
   
    <div class="snstitle">
      <div class="snstitlemain">추천 아티스트</div>
      <div class="snstitlesub">아래의 아티스트를 팔로우해서 아트스트와 소통을 해보세요</div>
    </div>
	<div class="snstitlebutton"><button class="btn btn-warning" onclick="location.reload()">추천새로받기</button></div>
    <div class="text-warning fundingmain-hr">
      <hr>
    </div>
   
   
   

		
    <div class="fundingmain-container">


    <c:if test="${!empty artlist}">	
    <c:forEach var="Artist" items="${artlist}" varStatus="status">	
      <div class="fundingcard">
        <div class="card shadow">
          <div class="cardimageback" >
            <img src="/resources/upload/${Artist.fileProfileName}" class="card-img-top cardimage">
          </div>
          <div class="follow">
         	 <button type="button" class="btn btn-warning" onClick="fn_snsFollow('${Artist.userId}')">팔로우</button>
          </div>
          <div class="card-body">
            <span class="badge rounded-pill bg-primary artbadge">${Artist.userCategoly}</span>
            <p class="mt-2 artId">${Artist.userId}</p>
            <p class="card-text artIntro">${Artist.userIntroduce}</p>
          </div>
        </div>
      </div>
     </c:forEach>
     </c:if>

    </div>
    
    
    <div id="myModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    
    
    <div class="findArtistList">
 
    	
    	
    </div>
        
    
    
    
  </div>
</div>
    
    
    
   
   
   </div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</c:if>




















<c:if test="${!empty follow}">

    
        <div class="main-container">
    
    
      <header>
        <div class="left_box">
          <div class="camera_box">
            <!-- <img class="camera" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/logo.png"
            style="filter: invert(100%)" alt="인스타 사진" /> -->
          </div>
          <div class="line">|</div>
          <div class="logo_box">
            
          </div>
        </div>
        <span class="seach_box">
          <input type="search" class="search" placeholder="아티스트 검색" style="background-color: rgba(209, 203, 195, 0); color: aliceblue;" />
        </span>
        <div class="right_box">
          <div class="d-grid gap-4 d-md-block" id="login" style="margin-left: 120px;">
          <c:if test="${sessionScope.userLevel == 2 or sessionScope.userLevel == 3}">
            <a href="/snsboard/snsWriteForm"><button class="btn btn-primary" type="button" style="background-color: #039be5; border: none; font-size: 12px;">게시물 업로드</button></a>
          </c:if>
          </div>
        </div>
      </header>
      <!--/header-->




      <div class="none"></div>
      <div class="main_body">
      

        <article>
        <div class="followtitletitle">
        
        <span class="followtitletitle-left">
        <a class="slide-1">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-caret-left" viewBox="0 0 16 16">
        <path d="M10 12.796V3.204L4.519 8 10 12.796zm-.659.753-5.48-4.796a1 1 0 0 1 0-1.506l5.48-4.796A1 1 0 0 1 11 3.204v9.592a1 1 0 0 1-1.659.753z"/>
        </a>
        </span>
        
        </svg>팔로우 리스트   
        
        <span class="followtitletitle-right">
        <a class="slide-2">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-caret-right" viewBox="0 0 16 16">
        <path d="M6 12.796V3.204L11.481 8 6 12.796zm.659.753 5.48-4.796a1 1 0 0 0 0-1.506L6.66 2.451C6.011 1.885 5 2.345 5 3.204v9.592a1 1 0 0 0 1.659.753z"/>
        </svg>
        </a>
        </span>     
        </div>
        


          <div class="story">
            <ul class="story_list">
               
            
    <c:if test="${!empty follow}">	
    <c:forEach var="Follow" items="${follow}" varStatus="status">	
            
              <li class="sub_story">
                <div class="textttt">
                  <a  href="javascript:void(0)" onClick="fn_snsSelect('${Follow.followerId}')"><img src="/resources/upload/${Follow.fileProfileName}" alt="프로필" /></a>

                  <span class="sub_story_id">${Follow.followerId}</span>
                  
                </div>
              </li>
              &nbsp;&nbsp;
     </c:forEach>
     </c:if>
    
     

    <form name="bbsForm2" id="bbsForm2" method="get">
		<input type="hidden" name="followerId" value="" />
	</form>
              
              
            </ul>
          </div>
          
         <c:if test="${!empty followSns}">	 
         	<c:forEach var="FollowSns" items="${followSns}" varStatus="status">	
          <div class="empty_box"></div>
          <div class="feed">
            <div class="feed_id">
              <div class="id_round">
                <div class="id_box">
                  <div class="id_box_img">
                    <img class="id_img" src="/resources/upload/${FollowSns.fileProfileName}" alt="내 프로필">
                  </div>
                  <div class="id_container">
                    <div class="id_name">${FollowSns.followerId}</div>
                    <div class="place">${FollowSns.userIntroduce}</div>
                  </div>
                </div>
                <div class="more_details">
                <a class="nav-link btn-sm" id="MenuLink4" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <img src="/resources/images/sns/more.png" style="filter: invert(100%)" alt="더보기">
                </a>
                <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="MenuLink4">
      		    <li><a class="dropdown-item" href="/qna">수정</a></li>
          		<li><button class="dropdown-item" id="snsDelete" type="button" onClick="fn_snsDelete(${FollowSns.snsSeq})">삭제</button></li>
               </ul>
                </div>
              </div>
            </div>
            <div class="feed_picture">
              <img src="/resources/upload/${FollowSns.snsFileName}" alt="피드 사진">
            </div>
            <!--feedbottom-->
            <div class="feed_bottom">
              <div class="emoticon_box">
                <div class="emoticon_box2">
         
                </div>
                <div class="bookmark_box">
                  <img class="bookmark" src="/resources/images/sns/heart.png" style="filter: invert(100%)" alt="하트"/>
                </div>
              </div>
            </div>
            <!--/feedbottom-->
            <div class="feed_like_box">
              <div class="feed_like_picture">
                <img class="feed_like_peolpe" src="/resources/images/bg-img/a1.jpg" alt="세원">
              </div>
              <div class="feed_like">DONGSU님 외 263명이 좋아합니다.</div>
            </div>
            <div class="feed_article">
              <div class="feed_article_box">
                <div class="comments_container">
                  <div class="comments">${FollowSns.followerId} ${FollowSns.snsContent}</div>
          
                </div>
                <div class="comments1">댓글 <span id="count"></span></div>
                <div class="comments1_box">
            <c:if test="${!empty FollowSns}">	 
         	<c:forEach var="FollowReply" items="${FollowSns.snsReplyList}" varStatus="status">	
         	
         		<div class="commentsContainer">
             		<div class="comments">${FollowReply.userId} ${FollowReply.snsReplyContent}</div>
             		
             		<div class="commentsDeleteBtn">
             		<c:if test="${FollowReply.userId eq cookieUserId}">
                		<a type="button" id="replyDelete" name="replyDelete" onClick="fn_replyDelete(${FollowReply.snsReplySeq})"
                		 class="reply-delete"><span class="reply-deleteBtn">댓글삭제</span></a>
                	</c:if>
             		</div>
             		
         		</div>

                  

            </c:forEach>
            </c:if>      
                </div>
                <div class="new_comments">
                </div>
              </div>
            </div>
            <div class="inputContainer">
              <div class="type_comment">
            
              <form id="snsReplyForm" name="snsReplyForm"  method="post">
                <input type="hidden" value="${FollowSns.snsSeq}"  id="snsSeq" name="snsSeq">
                <input id="snsReplyContent" name="snsReplyContent" class="inputBox" type="text" placeholder="댓글 달기...">
              </form>
              
              </div>
              <span>
                <button class="buttonBox" type="button" id="reply-btn">게시</button>
              </span>
            </div>
          </div>
          </c:forEach>
          </c:if>
          
          
          
          	
        </article>

    	
    	
        <aside>
        <c:if test="${artist.fileProfileName != ''}">
        <div class="followerinfo">아티스트 정보</div>
        </c:if>
          <div class="feed_right_container">
            <div class="my_profile">
              <div class="profile_none">
              <c:if test="${artist.fileProfileName != ''}">
                <div class="my_profile_box1">
                  <img src="/resources/upload/${artist.fileProfileName}" alt="내 프로필">
                </div>
                	</c:if>
                <div class="my_profile_id"><c:out value="${artist.userId}"/></div>
                
              </div>
            </div>
            
            <c:if test="${artist.fileProfileName != ''}">
            <div>
                <a href="javascript:void(0)" onClick="fn_snsUnfollow('${artist.userId}')"><button class="btn btn-primary my_profile_id_follow" type="button" style="background-color: #039be5; border: none; font-size: 12px;">손절</button></a>
            </div>
            </c:if>
            
            <c:if test="${artist.fileProfileName == ''}">
            <div class="recommendation_boxtop">&nbsp;&nbsp;</div>
            </c:if>
            
            <div class="recommendation_box">
              <div class="recommendation">회원님을 위한 추천</div>
            </div>	   
            
            
            
 
           
            <div class="users">
            <c:if test="${!empty artlist}">	
            <c:forEach var="Artist" items="${artlist}" varStatus="status">	
              <div class="user">
                <div class="my_profile_box2">
                  <img src="/resources/upload/${Artist.fileProfileName}" alt="내 프로필">
                </div>
                <div class="my_profile_main_box">
                  <div class="my_profile_id_box">
                    <div class="my_profile_id1">${Artist.userId}</div>
                    <div class="my_profile_id2">${Artist.userCategoly}</div>
                  </div>
                  <div class="recofollow" style="cursor: pointer;"><a onClick="fn_snsFollow('${Artist.userId}')">팔로우</a></div>
                </div>
              </div>
            </c:forEach>
            </c:if>
            </div>
            
            
            
            <div class="other_box">
              <div class="other1">
                <span class="span1">소개</span>
                <span class="span1">도움말</span>
                <span class="span1">∙</span>
                <span class="span1">홍보 센터</span>
                <span class="span1">∙</span>
                <span class="span1">API</span>
                <span class="span1">∙</span>
                <span class="span1">채용 정보</span>
                <span class="span1">∙</span>
                <span class="span1">개인정보처리방침</span>
                <span class="span1">∙</span></br>
              </div>
              <div class="other2">
                <span class="span1">약관</span>
                <span class="span1">∙</span>
                <span class="span1">위치</span>
                <span class="span1">∙</span>
                <span class="span1">인기 계정</span>
                <span class="span1">∙</span>
                <span class="span1">해시태그</span>
                <span class="span1">∙</span>
                <span class="span1">언어</span>
              </div>
            </div>
            <div class="other_box">
              <span class="span1">© 2023 F. F. F</span>
            </div>
          </div>
        </aside>
      </div>





<div id="myModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    
    
    <div class="findArtistList">
 
    	
    	
    </div>
        
    
    
    
  </div>
</div>



















	<nav>
		<ul class="pagination justify-content-center">
			<c:if test="${!empty paging }"> <!-- 페이징 객체가비어있지않으면 보여줘라 -->
				<c:if test="${paging.prevBlockPage gt 0 }"> <!-- >  = gt  이전 블럭 페이지가 있으면 보여줘라-->
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
				</c:if>
				
				<c:forEach var ="i" begin = "${paging.startPage}" end = "${paging.endPage}">
					<c:choose>
						<c:when test="${i ne curPage}">  <!-- ne = != -->
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
						</c:when>
						<c:otherwise>
						<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;" >${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
				<c:if test="${paging.nextBlockPage gt 0}">
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
				</c:if>
			</c:if>			
		</ul>
	</nav>
	
	<form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="curPage" value="${curPage} " />
	</form>
	    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</div>
</c:if>	

<script type="text/javascript">
var currentPosition = 0;

$('.slide-1').on('click',function(){
  currentPosition += 104;
  $('.sub_story').css('transform', 'translateX(' + currentPosition + 'px)');
});

$('.slide-2').on('click',function(){
  currentPosition -= 104;
  $('.sub_story').css('transform', 'translateX(' + currentPosition + 'px)');
});
</script>





  
</body>
</html>