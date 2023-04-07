package com.icia.web.controller;


import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.CtBoard;
import com.icia.web.model.NtBoard;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Review;
import com.icia.web.model.User;
import com.icia.web.service.CtBoardService;
import com.icia.web.service.FdBoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;


@Controller("ctBoardController")
public class CtBoardController 
{
	private static Logger logger = LoggerFactory.getLogger(CtBoardController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	

	//파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired 
	private CtBoardService ctBoardService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private FdBoardService fdBoardService;
	
	
	
	private static final int LIST_COUNT = 100;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	
	//게시글 리스트
	@RequestMapping(value ="/ctBoard/ctlist")	
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)	//매개변수는 2개가 와야함.
	{
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long totalCount = 0;
		List<CtBoard>list = null;
		Paging paging = null;
		CtBoard search = new CtBoard();
		
		//랜덤 캐러셀 이미지
		List<CtBoard> randomList = ctBoardService.randomSelect();
		
		totalCount = ctBoardService.boardListCount(search);
		
		logger.debug("=========================================");
		logger.debug("totalCount :" + totalCount);
		logger.debug("=========================================");
		
		if(totalCount > 0) {
			
			paging = new Paging("ctBoard/ctlist",totalCount,LIST_COUNT,PAGE_COUNT,curPage,"curPage");
			
			paging.addParam("curPage",curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = ctBoardService.boardList(search);
		}
		
		model.addAttribute("randomList", randomList);
		model.addAttribute("list",list);
		model.addAttribute("curPage",curPage);
		model.addAttribute("paging",paging);
		
		return "/ctBoard/ctlist";
	}
	

	
	//게시물 조회
	@RequestMapping(value="/ctBoard/ctView")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq",(long)0);
		
		long curPage= HttpUtil.get(request,"curPage",(long)1);
		
		CtBoard ctBoard = null;
		
		if(fdBbsSeq > 0)
		{
			ctBoard = ctBoardService.boardView(fdBbsSeq);

		}
		logger.debug("유저카테고리입니다."+ctBoard.getUserCategory());
		model.addAttribute("fdBbsSeq",fdBbsSeq);
		model.addAttribute("ctBoard",ctBoard);
		model.addAttribute("curPage",curPage);
		model.addAttribute("cookieUserId",cookieUserId);
		
		
		return "/ctBoard/ctView";
		
		
		}
	
	//게시물 등록
	@RequestMapping(value="/ctBoard/ctWriteForm")
	public String ctWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", (long)1);
		
		User user = userService.userSelect(cookieUserId);
		
		model.addAttribute("user", user);
		//0321 박재영 추가
		model.addAttribute("fdBbsSeq", fdBbsSeq);
		
		return "/ctBoard/ctWriteForm";
	}	
	
	//게시물 등록 폼(writeproc)
	@RequestMapping(value = "/ctBoard/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		
		String ctBbsTitle = HttpUtil.get(request, "ctBbsTitle", "");
		String ctBbsContent = HttpUtil.get(request, "ctBbsContent", ""); 
		FileData fileData = HttpUtil.getFile(request, "ctFile", UPLOAD_SAVE_DIR);
		String ctPayType = HttpUtil.get(request, "ctPayType", "");
		String ctPrice = HttpUtil.get(request, "ctPrice", "");
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", (long)1);

			
		if(!StringUtil.isEmpty(ctBbsTitle) && !StringUtil.isEmpty(ctBbsContent))
		{
			CtBoard ctBoard = new CtBoard();
			
			ctBoard.setUserId(cookieUserId);
			ctBoard.setCtBbsTitle(ctBbsTitle);
			ctBoard.setFdBbsSeq(fdBbsSeq);
			ctBoard.setCtBbsContent(ctBbsContent);
			ctBoard.setCtPayType(ctPayType);
			ctBoard.setCtPrice(ctPrice);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				ctBoard.setCtFileName(fileData.getFileName());
				ctBoard.setCtFileOrgName(fileData.getFileOrgName());
				ctBoard.setCtFileExt(fileData.getFileExt());
				ctBoard.setCtFileSize(fileData.getFileSize());
			}
			
			
			try
			{
				if(ctBoardService.ctBoardInsert(ctBoard) > 0)
				{
					fdBoardService.fdSatatusUpdate(fdBbsSeq);
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "ubreak server error");
				}
			}
			catch(Exception e)
			{	
				logger.error("[CtBoardController] /ctBoard/writeProc Exception" ,e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "board request");
		}
		
		return ajaxResponse;
	}
	
	
	//게시판 수정(UPDATE)
	@RequestMapping(value="/ctBoard/ctUpdateForm")
	public String ctUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long ctBbsSeq = HttpUtil.get(request, "ctBbsSeq", (long)0);
		String searchType =HttpUtil.get(request, "searchType", "");
		String searchValue =HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		CtBoard ctBoard = null;
		User user = null;
		
		if(ctBbsSeq > 0)
		{
			ctBoard = ctBoardService.boardSelectView(ctBbsSeq);
			
			if(ctBoard != null)
			{
				if(StringUtil.equals(ctBoard.getUserId(), cookieUserId))
				{
					user = userService.userSelect(cookieUserId);
				}
				else
				{
					ctBoard = null;
				}
			}
		}
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("CtBoard", ctBoard);
		model.addAttribute("user", user);
		
		return "/ctBoard/ctUpdateForm";
	}
	
	//게시판 수정(proc)
	@RequestMapping(value="/ctBoard/ctUpdateProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> ctUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long ctBbsSeq = HttpUtil.get(request, "ctBbsSeq", (long)0);
		String ctBbsTitle = HttpUtil.get(request, "ctBbsTitle", "");
		String ctBbsContent = HttpUtil.get(request, "ctBbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "ctFile", UPLOAD_SAVE_DIR);
		
		if(ctBbsSeq > 0)
		{
			CtBoard ctBoard = ctBoardService.boardSelect(ctBbsSeq);
			
			if(!StringUtil.isEmpty(ctBbsTitle))
			{
				if(!StringUtil.isEmpty(ctBbsContent))
				{
					if(ctBoard != null)
					{
						if(StringUtil.equals(ctBoard.getUserId(), cookieUserId))
						{
							ctBoard.setCtBbsSeq(ctBbsSeq);
							ctBoard.setCtBbsTitle(ctBbsTitle);
							ctBoard.setCtBbsContent(ctBbsContent);
							
							if(fileData != null && fileData.getFileSize() >0)
							{
								ctBoard.setCtFileName(fileData.getFileName());
								ctBoard.setCtFileOrgName(fileData.getFileOrgName());
								ctBoard.setCtFileExt(fileData.getFileExt());
								ctBoard.setCtFileSize(fileData.getFileSize());
							}
							
							try
							{
								if(ctBoardService.boardUpdate(ctBoard) > 0)
								{
									ajaxResponse.setResponse(0, "Success");
								}
								else
								{
									ajaxResponse.setResponse(500, "Internal Server Error222");
								}
							}
							catch(Exception e)
							{
								logger.error("[ctBoardController]/ctBoard/ctUpdateProc Exception", e);
								ajaxResponse.setResponse(500, "Internal Server Error");
							}
						}
						else
						{
							ajaxResponse.setResponse(404, "Not Found222");
						}
						
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found");
					}
				}
				else
				{
					ajaxResponse.setResponse(410, "Not Found101010101010101010");
				}
				
			}
			else
			{
				ajaxResponse.setResponse(409, "Bad Request4099999999");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request(400번오류)");
		}
		
		
		return ajaxResponse;
	}
	
	
	//게시물 삭제
		@RequestMapping(value="/ctBoard/delete",method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> delete(HttpServletRequest request,HttpServletResponse response) {
			
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
			long ctBbsSeq = HttpUtil.get(request,"ctBbsSeq",(long)0);
			
			
			if(ctBbsSeq > 0) {
				
				CtBoard ctBoard = ctBoardService.boardSelect(ctBbsSeq);
				
				if(ctBoard!=null) {
					
					if(StringUtil.equals(ctBoard.getUserId(),cookieUserId)) {
						
						try {	 
								if(ctBoardService.boardDelete(ctBoard.getCtBbsSeq()) >0) {
										ajaxResponse.setResponse(0,"success");
								}
								else {
										ajaxResponse.setResponse(500,"internal server error22");
								}
								
						}
						catch(Exception e) {
							logger.error("[CtBoardController /ctboard/delete Exception",e);
							ajaxResponse.setResponse(500,"internal server error");
						}
					}
					else {
						ajaxResponse.setResponse(404,"not found22");
					}
				}
				else {
					ajaxResponse.setResponse(404,"not found");
				}
			}
			else {
				ajaxResponse.setResponse(400,"bad request");
			}
			
			if(logger.isDebugEnabled()) {
				
				logger.debug("[CtBoardController] /ctBoard/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			}
			
			return ajaxResponse;
		}




}
			

