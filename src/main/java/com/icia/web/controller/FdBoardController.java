package com.icia.web.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.icia.common.util.FileUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.ArtProfile;
import com.icia.web.model.Artist;
import com.icia.web.model.FdBoard;
import com.icia.web.model.FdPm;
import com.icia.web.model.FdTier;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.SnsBoard;
import com.icia.web.model.User;
import com.icia.web.service.ArtistService;
import com.icia.web.service.FdBoardService;

import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;
import com.sun.net.httpserver.HttpServer;
import com.sun.org.apache.xml.internal.resolver.helpers.Debug;

@Controller("fdBoardController")
public class FdBoardController {

	private static Logger logger = LoggerFactory.getLogger(FdBoardController.class);

	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
		
	@Autowired
	private UserService userService;

	@Autowired
	private FdBoardService fdBoardService;

	@Autowired
	private ArtistService artistService;
	
	private static final int LIST_COUNT = 5; // 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5; // 페이징 수
	
	private static final int FUND_LIST_COUNT = 1000; // 펀딩 페이지의 게시물 수
	private static final int FUND_PAGE_COUNT = 5; // 페이징 수

	//게시물 상세페이지 조회 0309 배정현
	@RequestMapping(value="/funding/fdView")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", (long)16);
		


		
		//본인글 여부
		String boardMe = "N";
		FdBoard fdBoard = new FdBoard();
		fdBoard = fdBoardService.boardSelect(fdBbsSeq);
		Artist artist = new Artist();
		ArtProfile artProfile = new ArtProfile();
		
		long currentAmount = fdBoard.getCurrentAmount();
		long targetPrice = fdBoard.getTargetPrice();
		String userId = fdBoard.getUserId();
		String fdFile2Name = fdBoard.getFdFile2Name();
		logger.debug("펀딩에 쓸 사진입니다."+fdFile2Name);
		artist = artistService.artistSelect(userId);
		artProfile = artistService.getProfile(userId);
		
		String artFileName = artProfile.getFileProfileName();
		

		model.addAttribute("fdBbsSeq", fdBbsSeq);
		model.addAttribute("fdBoard", fdBoard);
		logger.debug("FdBoard FdBbsTitle()" + fdBoard.getFdBbsTitle());
		model.addAttribute("currentAmount", currentAmount);
		model.addAttribute("targetPrice", targetPrice);
		model.addAttribute("artFileName", artFileName);
		model.addAttribute("artist",artist);
		model.addAttribute("cookieUserId",cookieUserId);

		

		FdTier fdTier = new FdTier();
		fdTier = fdBoardService.tierSelect(fdBbsSeq);
		String url = fdTier.getProduct1();
		String urlslid =url.substring(url.indexOf("=") + 1); 
		fdTier.setProduct1(urlslid);
		model.addAttribute("fdTier", fdTier);

		String fdEndDate = fdBoard.getFdEndDate();
	    fdEndDate = fdEndDate.replaceAll("-", "");
		logger.debug("컨트롤러 endDate값입니다."+ fdEndDate);
		System.out.println(fdBbsSeq);
		

		
		return "/funding/fdView"; //+jsp
	}
		
		
	//결제 0309 배정현
		@RequestMapping(value = "/funding/funding",method = RequestMethod.POST )
		@ResponseBody
		public Response<Object> funding(ModelMap model,HttpServletRequest request, HttpServletResponse response)
		{
			
			String CookieuserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			Response<Object> ajaxResponse = new Response<Object>();
			long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", (long)0);
			int tierNum = HttpUtil.get(request, "tierNum", 0);
			
			FdPm fdPm = new FdPm();
			fdPm.setFdBbsSeq(fdBbsSeq);
			//fdPm.setUserId(userId);
			fdPm.setTierNum(tierNum);

			//해당 티어 후원자수 카운트

			logger.debug("0번대");
			ajaxResponse.setResponse(0, "Success");
			

			
			return ajaxResponse;
		}
		

		

		
		//박재영 추가 기능
		//펀딩게시판 업로드
		@RequestMapping(value="/fund/uploadProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> fundUploadProc(MultipartHttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			//아티스트인지 체크할것
			
			//쿠키아이디가 회원인지 확인해서 맞을때 파일 추가
			
			String fundTitle = HttpUtil.get(request, "fundTitle", "");

			String fundEndDate = HttpUtil.get(request, "fundEndDate", "");

			String fundAdress = HttpUtil.get(request, "userAdd", "");
			String fundPlace = HttpUtil.get(request, "userAdd2", "");
			String fundArtDate = HttpUtil.get(request, "fundArtDate", "");
			String fundAge = HttpUtil.get(request, "fundAge", "");
			long fundCapa = HttpUtil.get(request, "fundCapa", (long)0);
			long fundGoal = HttpUtil.get(request, "fundGoal", (long)0);
			
			String tear1product = HttpUtil.get(request, "tear1product", "");
			String tear2product = HttpUtil.get(request, "tear2product", "");
			String tear3product = HttpUtil.get(request, "tear3product", "");
			String tear4product = HttpUtil.get(request, "tear4product", "");
			
			long tear1price = HttpUtil.get(request, "tear1price", (long)0);
			long tear2price = HttpUtil.get(request, "tear2price", (long)0);
			long tear3price = HttpUtil.get(request, "tear3price", (long)0);
			long tear4price = HttpUtil.get(request, "tear4price", (long)0);
			
			//쿠키아이디가 회원인 경우 파일명을 아이디.확장자로 처리
			FileData fileData = HttpUtil.getFile(request, "fundPoster", UPLOAD_SAVE_DIR);
			FileData fileData2 = HttpUtil.getFile(request, "fundFile", UPLOAD_SAVE_DIR);
			
			
			logger.debug("666666666666" + fundTitle);
			logger.debug("666666666666" + fundEndDate);
			logger.debug("666666666666" + fundAdress);
			logger.debug("666666666666" + fundPlace);
			logger.debug("666666666666" + fundArtDate);
			logger.debug("666666666666" + fundAge);
			logger.debug("666666666666" + fundCapa);
			logger.debug("666666666666" + fundGoal);
			
			
			
			
			if(!StringUtil.isEmpty(fundTitle) && !StringUtil.isEmpty(fundEndDate) && !StringUtil.isEmpty(fundAdress) && !StringUtil.isEmpty(fundPlace) && !StringUtil.isEmpty(fundArtDate) && !StringUtil.isEmpty(fundAge) && !StringUtil.isEmpty(fundCapa) && !StringUtil.isEmpty(fundGoal))
			{
				FdBoard fdBoard = new FdBoard();
				
				fdBoard.setUserId(cookieUserId);
				fdBoard.setFdBbsTitle(fundTitle);

				fdBoard.setFdEndDate(fundEndDate);
				fdBoard.setTargetPrice(fundGoal);
				fdBoard.setCtDate(fundArtDate);
				fdBoard.setVenuePlace(fundPlace);
				fdBoard.setVenuePlaceAdd(fundAdress);
				fdBoard.setCtAge(fundAge);
				fdBoard.setCapacity(fundCapa);
				fdBoard.setFdStatus("W");
				fdBoard.setFdStatus2("Y");
				fdBoard.setFdFileOrgName(fileData.getFileOrgName());
				fdBoard.setFdFileName(fileData.getFileName());
				fdBoard.setFdFileExt(fileData.getFileExt());
				fdBoard.setFdFileSize(fileData.getFileSize());
				fdBoard.setCurrentAmount(0);
				
				fdBoard.setFdFile2OrgName(fileData2.getFileOrgName());
				fdBoard.setFdFile2Name(fileData2.getFileName());
				
				if(!StringUtil.isEmpty(tear1price) && !StringUtil.isEmpty(tear2price) && !StringUtil.isEmpty(tear3price) && !StringUtil.isEmpty(tear4price))
				{
					FdTier fdTier = new FdTier();
					fdTier.setPrice1(tear1price);
					fdTier.setPrice2(tear2price);
					fdTier.setPrice3(tear3price);
					fdTier.setPrice4(tear4price);
					fdTier.setTierCnt(0);
					
					if(!StringUtil.isEmpty(tear1product))
					{
						fdTier.setProduct1(tear1product);
					}
					if(!StringUtil.isEmpty(tear2product))
					{
						fdTier.setProduct2(tear2product);
					}
					if(!StringUtil.isEmpty(tear3product))
					{
						fdTier.setProduct3(tear3product);
					}
					if(!StringUtil.isEmpty(tear4product))
					{
						fdTier.setProduct4(tear4product);
					}
					
					fdBoard.setFdTier(fdTier);
					
				}

			  try
			  {
				 if(fdBoardService.fdBoardInsert(fdBoard) > 0)
				 {
					ajaxResponse.setResponse(0, "Success");
				 }
				 else
				 {
					ajaxResponse.setResponse(400, "internal server error");
				 }
			  }
			  catch(Exception e)
			  {
					logger.error("[FdBoardController] /fund/uploadProc Exception", e);
					ajaxResponse.setResponse(400, "internal server error1");
			  }
			}
			else
			{
				ajaxResponse.setResponse(500, "parameter error");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[FdBoardController] /fund/uploadProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			}
			
			
			return ajaxResponse;
		}
		
		
	
		
		//0308 박재영 추가 컨트롤러
		//펀딩 메인페이지 호출
		@RequestMapping(value = "/funding/fundingList")
		public String fundingMain(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
			//조회항목(1:작성자, 2:제목, 3:내용)
			String searchType = HttpUtil.get(request, "searchType", "");
			//조회값
			String searchValue = HttpUtil.get(request, "searchValue",  "");
			//카테고리 조회
			String categolyValue = HttpUtil.get(request, "categolyValue",  "");

			//현재페이지
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			long totalCount = 0;
			
			logger.debug("컨트롤러 카테고리입니다." + categolyValue);
			List<FdBoard> list = null;
			Paging paging = null;
			FdBoard search = new FdBoard();
			search.setCategolyValue(categolyValue);
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				search.setSearchType(searchType);
				search.setSearchValue(searchValue);

				
			}
			
			totalCount = fdBoardService.fundListCount(search);
			
			logger.debug("==========================================");
			logger.debug("totalCount : " + totalCount);
			logger.debug("==========================================");
			
			if(totalCount > 0)
			{
				paging = new Paging("funding/fundingList", totalCount, FUND_LIST_COUNT, FUND_PAGE_COUNT, curPage, "curPage");
				
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				

				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				logger.debug("컨트롤러 리스트 카테고리입니다." + search.getCategolyValue());
				list = fdBoardService.fundboardList(search);
			}
			
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			
			return "/funding/fundingList";
		}
		

	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

		
		/**
		 * 패키지명   : com.icia.web.controller
		 * 파일명     : FdBoardController.java
		 * 작성일     : 2023. 03. 20.
		 * 작성자     : 박재윤
		 * 설명       : artistMypage.jsp에서 사용자의 펀딩정보 조회
		 * 			FdBoardDao.xml 로 연결해서 DB에서 값가져옴
		 */
		@RequestMapping(value = "/snsboard/artistMypage")
		public String artistMypageFdSelect(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

			FdBoard fdBoard = fdBoardService.artistMypageFdSelect(cookieUserId);
			
			if(!StringUtil.isEmpty(fdBoard.getFdEndDate()))
			{
				logger.debug("if문입니다.");
			}
			else
			{
				fdBoard = new FdBoard();
				fdBoard.setFdEndDate("0000-00-00");
				logger.debug("else문입니다.");
			}
			
			long currentAmount = fdBoard.getCurrentAmount();
			long targetPrice = fdBoard.getTargetPrice();
			String fdEndDate = fdBoard.getFdEndDate();
			
			model.addAttribute("fdBoard", fdBoard);
			model.addAttribute("currentAmount", currentAmount);
			model.addAttribute("targetPrice", targetPrice);
			model.addAttribute("fdEndDate", fdEndDate);
			
			return "/snsboard/artistMypage";
		}
		
		

	
	
}
