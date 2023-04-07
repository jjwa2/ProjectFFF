<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/style/default.css">
<link rel="stylesheet" href="/resources/style/ctmain.css">

<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- 제이쿼리 cdn -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>


<!-- Compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

<!-- Compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>


<!--MATERRIALIZW 아이콘 CDN-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<!-- 아이콘 cdn -->
<script src="https://kit.fontawesome.com/20497ca384.js"
	crossorigin="anonymous"></script>

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




<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Work+Sans:ital,wght@0,600;0,800;1,900&display=swap"
	rel="stylesheet">


<!-- 아울 캐러셀 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.min.js"></script>
<script
	src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js"></script>
	
<!-- j쿼리 시작 -->
<script>
$(document).ready(function(){
    function MySlider1__init() {
        $('.my-slider-1 > .owl-carousel').owlCarousel({
            responsive: {
                0: {
                    items: 4
                }
            },
            loop: true,
            dots: false,
            nav: true,
            navText: [$('.am-next'),$('.am-prev')],
            autoplay: true,
            autoplayTimeout: 6000,
            center: true
        });
    }
    MySlider1__init();

    
    
    
	// initialize Isotope
	var $grid = $('.card-main').isotope({
	  itemSelector: '.card-item',
	  layoutMode: 'fitRows'
	});

	// filter items on button click
	$('.filter-button').on('click', function() {
		  $('.filter-button').removeClass('active');
		  $(this).addClass('active');
		  var filterValue = $(this).attr('data-filter');
		  $grid.isotope({ filter: filterValue });
	});
    
    
    
    
    

});


$('.card-btn').click(function() {
    var ctBbsSeq = $(this).data('ctBbsSeq');
    fn_ctView(ctBbsSeq);
});

function fn_view(fdBbsSeq)
{
	document.bbsForm.fdBbsSeq.value = fdBbsSeq;
	document.bbsForm.action = "/ctBoard/ctView";
	document.bbsForm.submit();
}

</script>
<!-- 제이쿼리 끝 -->
</head>

<body>
	<div class="main-container">
		<%@ include file="/WEB-INF/views/include/navigation.jsp"%>

		<div class="snstitle">
			<div class="snstitlemain">CONCERT</div>
			<div class="snstitlesub">공연 일정 안내 및 예매</div>
		</div>

		<div class="text-warning fundingmain-hr">
			<hr>
		</div>



		<c:if test="${!empty randomList}">
			<div class="rec-main">
				<!-- 슬라이더 1 -->
				<div class="my-slider-1">
					<div class="owl-carousel owl-theme">
						<c:forEach var="ctBoard" items="${randomList}" varStatus="status">


							<div class="item">
								<img src="/resources/upload/${ctBoard.fdFileName}" class="rec-item">
								<div class="txtDiv">
									<p class="txt rec-txt">${ctBoard.ctBbsTitle}</p>
								</div>
							</div>
							
							
							
							
							
							
						</c:forEach>
					</div>

					<div class="slider_nav">
						<button class="am-next">
							<i class="bi bi-chevron-left"></i>
						</button>
						<button class="am-prev">
							<i class="bi bi-chevron-right"></i>
						</button>
					</div>
				</div>
			</div>

		</c:if>

		<div class="category-main">
			<div class="category-btn">
			<br><br><br><br>
				<button class="filter-button active" data-filter="*">전체</button>
				<button class="filter-button" data-filter=".힙합">힙합</button>
				<button class="filter-button" data-filter=".재즈">재즈</button>
				<button class="filter-button" data-filter=".댄스">댄스</button>
				<button class="filter-button" data-filter=".ETC">etc</button>
			</div>
		</div>

		<div class="card-main">
			<c:if test="${!empty list}">

				<c:forEach var="ctBoard" items="${list}" varStatus="status">
					<c:if test="${ctBoard.fdStatus3 == 'Y'}">
						<div class="card-item ${ctBoard.userCategory}">
							<a href="javascript:void(0)"onclick="fn_view(${ctBoard.fdBbsSeq})"style="text-decoration: none; color: #fff;"> 
								<img src="/resources/upload/${ctBoard.fdFileName}" class="card-img">
								<p class="card-title">${ctBoard.ctBbsTitle}</p>
							</a>
					
						</div>
					</c:if>
				</c:forEach>
			</c:if>
		</div>

		<form name="bbsForm" id="bbsForm" method="post">
			<input type="hidden" name="fdBbsSeq" value="" /> <input
				type="hidden" name="searchType" value="${searchType}" /> <input
				type="hidden" name="searchValue" value="${searchValue}" /> <input
				type="hidden" name="curPage" value="${curPage}" />

		</form>

	</div>
</body>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>