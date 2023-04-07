package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.maven.model.Model;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Artist;
import com.icia.web.model.CtBoard;
import com.icia.web.model.FdBoard;
import com.icia.web.model.Paging;
import com.icia.web.model.Qna;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.ArtistService;
import com.icia.web.service.CtBoardService;
import com.icia.web.service.FdBoardService;
import com.icia.web.service.ManageService;
import com.icia.web.service.QnaService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;



@Controller("manageController")
public class ManageController {
	private static Logger logger = LoggerFactory.getLogger(ManageController.class);
	
	//쿠키명
	@Autowired
	private FdBoardService fdBoardService;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ManageService manageService;
	
	@Autowired
	private ArtistService artistService;
	
	@Autowired
	private CtBoardService ctService;
	
	@Value("#{env['auth.cookue.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static final int LIST_COUNT = 1000;
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value = "/manage/manage")
	public String managerMain(ModelMap model, HttpServletRequest request, HttpServletResponse response )
	{
		
		//조회항목(1:작성자, 2:제목, 3:내용)
		//조회값
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long totalCount = 0;
		List<FdBoard> list = null;
		Paging paging = null;
		FdBoard search = new FdBoard();
		String gubun = HttpUtil.get(request, "gubun","");
		List<Artist> artistList = artistService.artistLevelUpList();
		
		List<CtBoard> ctBoard = ctService.ctWaitList();
		
//			search.setSearchValue(searchValue);
		
		totalCount = fdBoardService.fundListCount(search);
		
		logger.debug("==========================================");
		logger.debug("totalCount : " + totalCount);
		logger.debug("==========================================");
		
		if(totalCount > 0)
		{
			paging = new Paging("manage/manage", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			totalCount= fdBoardService.fundListCount(search);
			list = fdBoardService.fundboardList(search);
			
			
		}
		model.addAttribute("gubun", gubun);
		model.addAttribute("list", list);
		model.addAttribute("artistList", artistList);
		model.addAttribute("ctBoard", ctBoard);
		
		//한동수 qna
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		totalCount = 0;
		List<Qna> listQna = null;
		User userQna = null;
		int admin = 0;
		Paging pagingQna = null;
		Qna searchQna = new Qna();
		long curPageQna = HttpUtil.get(request, "curPage", (long)1);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			userQna = userService.userSelect(cookieUserId);
			if(userQna.getUserLevel() == 3)
			{
				admin = 3;
			}
		
		}
		
				
		totalCount = qnaService.boardListCount(searchQna);
		
		if(totalCount > 0)
		{
			pagingQna = new Paging("manage/adminQna" , totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
					
			
			searchQna.setStartRow(paging.getStartRow());
			searchQna.setEndRow(paging.getEndRow());
					
			//리스트 호출
			listQna = qnaService.boardList(searchQna);
			
		}
		
		model.addAttribute("listQna", listQna); 
		model.addAttribute("userQna", userQna);
		model.addAttribute("cookieUserId", cookieUserId);		
		model.addAttribute("admin", admin);

		logger.debug("구분입니다."+gubun);
		
		
		
		
		//백종현 회원관리
		 
		int userLevel = HttpUtil.get(request, "userLevel", 0);
		
		logger.debug("=========================================");
		logger.debug("userLevel :" + userLevel);
		logger.debug("=========================================");

		List<User> userList = null;

		User user = new User();
		logger.debug("종현이 컨트롤러");
		userList = userService.adminUserList(userLevel);

		
		model.addAttribute("userList", userList);
		
		
		
		
		
		
		
		
		
		
		
		return"/manage/manage"; //+jsp
	}
	
	
	
	
	
	@RequestMapping(value = "/manage/fdApprove", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> fdApprove(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", -1);
		logger.debug("컨트롤러입니다.");
		FdBoard fdBaord = new FdBoard();
		
		if(manageService.fdApprove(fdBbsSeq)>0)
		{
			ajaxResponse.setResponse(0, "Success");
		}
		else
		{
			ajaxResponse.setResponse(500, "internal server error");
		}
		
		return ajaxResponse;
			
		
	}
	
	
	
	/**
	 * 패키지명   : com.icia.web.service
	 * 파일명     : ArtistService.java
	 * 작성일     : 2023. 3. 23.
	 * 작성자     : 박재윤
	 * 설명       :
	 */
	@RequestMapping(value = "/manage/userLevel", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userLevel(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId", "");
		
		if(userService.userLevel(userId) > 0 && artistService.userLevelStatus(userId) > 0)
		{
			ajaxResponse.setResponse(0, "Success");
		}
		else
		{
			ajaxResponse.setResponse(500, "internal server error");
		}
		
		return ajaxResponse;
	}
	
	//박재영 공연일정 승인버튼
	@RequestMapping(value = "/manage/ctApprove", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> ctApprove(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", -1);
		String gubun = HttpUtil.get(request, "구분","실패");
		
		if(manageService.ctApprove(fdBbsSeq)>0)
		{
			ajaxResponse.setResponse(0, "Success");
		}
		else
		{
			ajaxResponse.setResponse(500, "internal server error");
		}
		
		return ajaxResponse;
	}
	
	
	
	//회원 계정 정지
		@RequestMapping(value = "/userOut", method = RequestMethod.POST)
		@ResponseBody
		public Response<Object> userOut(HttpServletRequest request, HttpServletResponse response) {
		    Response<Object> ajaxResponse = new Response<Object>();
		    String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		    String userId = HttpUtil.get(request, "userId", "");
		    
		    if (!StringUtil.isEmpty(userId)) {
		        User user = userService.userSelect(userId);

		        if (user != null) {
		        	if (StringUtil.equals(user.getStatus(), "Y")) {
		                user.setStatus("N");

		                if (userService.userUpdate1(user) > 0) {
		                    CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
		                    ajaxResponse.setResponse(0, "Success");
		                } else {
		                    ajaxResponse.setResponse(500, "Internal Server Error");
		                }
		            } else {
		                //정지된 사용자
		                CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
		                ajaxResponse.setResponse(400, "Bad Request");
		            }
		        } else {
		            //사용자 정보 없음(쿠키 삭제)
		            CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
		            ajaxResponse.setResponse(404, "Not Found");
		        }
		    } else {
		        ajaxResponse.setResponse(400, "Bad Request");
		    }

		    return ajaxResponse;
		}
	
	
	
	/*
	 * @RequestMapping(value="/manage/adminView") public String view(ModelMap model,
	 * HttpServletRequest request, HttpServletResponse response) { String
	 * cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	 * 
	 * long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", 0);
	 * 
	 * String searchType = HttpUtil.get(request, "searchType" , ""); String
	 * searchValue = HttpUtil.get(request, "searchValue", ""); long curPage =
	 * HttpUtil.get(request, "curPage", (long)1);
	 * 
	 * 
	 * User user = new User();
	 * 
	 * user = userService.userSelect(cookieUserId);
	 * 
	 * Qna qna = null;
	 * 
	 * 
	 * if(qnaBbsSeq > 0) { qna = qnaService.boardView(qnaBbsSeq); }
	 * 
	 * model.addAttribute("cookieUserId", cookieUserId);
	 * model.addAttribute("qnaBbsSeq", qnaBbsSeq); model.addAttribute("qna", qna);
	 * model.addAttribute("searchValue", searchValue);
	 * model.addAttribute("searchType" , searchType); model.addAttribute("curPage",
	 * curPage);
	 * 
	 * return "/manage/adminView"; }
	 */
	
	
	
}
	
	
	
	
	
	
	
	
	
	
	
	
//	@RequestMapping(value="/manage/fdList")     //네비게이션에서 누른 /board/list 주소를 실행하면 밑에 메소드가 실행됨.
//	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)
//	{
//	//조회항목(1:작성자, 2:제목, 3:내용)
//	String searchType = HttpUtil.get(request, "searchType", "");
//	//조회값
//	String searchValue = HttpUtil.get(request, "searchValue",  "");
//	//현재페이지
//	long curPage = HttpUtil.get(request, "curPage", (long)1);
//	long totalCount = 0;
//	List<FdBoard> list = null;
//	Paging paging = null;
//	FdBoard search = new FdBoard();
//	
////	if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
////	{
////		search.setSearchType(searchType);
////		search.setSearchValue(searchValue);
////	}
//	
//	totalCount = fdBoardService.fundListCount(search);
//	
//	logger.debug("==========================================");
//	logger.debug("totalCount : " + totalCount);
//	logger.debug("==========================================");
//	
//	if(totalCount > 0)
//	{
////		paging = new Paging("board/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
////		
////		paging.addParam("searchType", searchType);
////		paging.addParam("searchValue", searchValue);
////		paging.addParam("curPage", curPage);
//		
//		search.setStartRow(paging.getStartRow());
//		search.setEndRow(paging.getEndRow());
//		
//		totalCount= fdBoardService.fundListCount(search);
//		list = fdBoardService.fundboardList(search);
//		
//	}
//	
//	model.addAttribute("list", list);
//	model.addAttribute("searchType", searchType);
//	model.addAttribute("searchValue", searchValue);
//	model.addAttribute("curPage", curPage);
//	model.addAttribute("paging", paging);
//	
//	return "/manage/manage";
//	}
//	
//	
//	
//	
//	
//}








//@RequestMapping(value = "/manage/manage")
//public String managerMain(ModelMap model, HttpServletRequest request, HttpServletResponse response)
//{
//	String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
//	
//
//	int userLevel = HttpUtil.get(request, "userLevel", 0);
//	
//	logger.debug("=========================================");
//	logger.debug("userLevel :" + userLevel);
//	logger.debug("=========================================");
//
//	List<User> userList = null;
//
//	User user = new User();
//	
//	userList = userService.adminUserList(userLevel);
//
//	
//	model.addAttribute("userList", userList);
//
//	
//	return"/manage/manage";
//}
