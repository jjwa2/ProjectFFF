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
import com.icia.web.dao.UserDao;
import com.icia.web.model.NtBoard;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.NtBoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;


@Controller("ntBoardController")
public class NtBoardController 
{
	private static Logger logger = LoggerFactory.getLogger(NtBoardController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로 
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired 
	private NtBoardService ntBoardService;
	
	private static final int LIST_COUNT = 5;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	//게시물 리스트 조회
	@RequestMapping(value ="/ntboard/ntlist")	
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)	//매개변수는 2개가 와야함.
	{
		String cookieUserId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		long totalCount = 0;
		List<NtBoard> list = null;
		
		Paging paging = null;
		NtBoard search = new NtBoard();
		User user = new User();
		
		if(cookieUserId!="") 
		{
			user = userService.userSelect(cookieUserId);
			logger.debug("이프문입니다.");
		}
		int admin = 0;
		
		
		totalCount = ntBoardService.boardListCount(search);
		
		logger.debug("=========================================");
		logger.debug("totalCount :" + totalCount);
		logger.debug("=========================================");


		if(totalCount > 0) 
		{
			
			paging = new Paging("ntboard/ntlist",totalCount,LIST_COUNT,PAGE_COUNT,curPage,"curPage");
			
			paging.addParam("curPage",curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());

			list = ntBoardService.boardList(search);
		}
		
		if(user.getUserLevel() == 3)
		{
			admin = 3;
		}

		model.addAttribute("user",user);
		model.addAttribute("list",list);
		model.addAttribute("curPage",curPage);
		model.addAttribute("paging",paging);
		model.addAttribute("admin", admin);


		return "/ntboard/ntlist";
	}
	
	//게시물 조회
	@RequestMapping(value="/ntboard/ntView")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		
		String cookieUserId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		long ntBbsSeq = HttpUtil.get(request, "ntBbsSeq",(long)0);
		long curPage= HttpUtil.get(request,"curPage",(long)1);
		
		User user = null;
		
		//본인 글 여부
		String boardMe = "N";
		int admin = 1;
		
		NtBoard ntboard = null;
		
		if(ntBbsSeq > 0)
		{
			ntboard = ntBoardService.ntboardView(ntBbsSeq);
			
			if(ntboard != null && StringUtil.equals(ntboard.getUserId(), cookieUserId))
			{
				boardMe = "Y";
			}
			
			if(!StringUtil.isEmpty(cookieUserId))
			{
				user = userService.userSelect(cookieUserId);
				
				if(user.getUserLevel() == 3)
				{
					admin = 3;
				}
			}
		}
		
		model.addAttribute("user",user);
		model.addAttribute("ntBbsSeq",ntBbsSeq);
		model.addAttribute("ntBoard",ntboard);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("curPage",curPage);
		model.addAttribute("admin", admin);
		
		return "/ntboard/ntView";
		
		
	}
	
	
	//게시글 등록 폼
	@RequestMapping(value="/ntboard/ntWriteForm")
	public String ntWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		User user = userService.userSelect(cookieUserId);
		
		int userlevel = user.getUserLevel();
				
		model.addAttribute("user", user);
		model.addAttribute("userlevel", userlevel);
		
		return "/ntboard/ntWriteForm";
	}
	
	@RequestMapping(value="/ntboard/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String ntBbsTitle = HttpUtil.get(request, "ntBbsTitle", "");
		String ntBbsContent = HttpUtil.get(request, "ntBbsContent", "");
		
		FileData fileData = HttpUtil.getFile(request, "ntFile", UPLOAD_SAVE_DIR);
		
		if(!StringUtil.isEmpty(ntBbsTitle) && !StringUtil.isEmpty(ntBbsContent))
		{
			NtBoard ntBoard = new NtBoard();
			
			ntBoard.setUserId(cookieUserId);
			ntBoard.setNtBbsTitle(ntBbsTitle);
			ntBoard.setNtBbsContent(ntBbsContent);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				ntBoard.setNtFileName(fileData.getFileName());
				ntBoard.setNtFileOrgName(fileData.getFileOrgName());
				ntBoard.setNtFileExt(fileData.getFileExt());
				ntBoard.setNtFileSize(fileData.getFileSize());
			}
			
			try
			{
				if(ntBoardService.boardInsert(ntBoard) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error22222");
				}
			}
			catch(Exception e)
			{
				logger.error("[NtBoardController]/ntBoard/writeProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad request");
		}
		
		
		return ajaxResponse;
	}
	
	//게시판 수정 화면
	@RequestMapping(value="/ntboard/ntUpdateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long ntBbsSeq = HttpUtil.get(request, "ntBbsSeq", (long)0);
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		NtBoard ntBoard = null;
		User user = null;
		
		if(ntBbsSeq > 0)
		{
			ntBoard = ntBoardService.boardSelectView(ntBbsSeq);
			
			if(ntBoard != null)
			{
				if(StringUtil.equals(ntBoard.getUserId(), cookieUserId))
				{
					user = userService.userSelect(cookieUserId);
				}
				else
				{
					ntBoard = null;
				}
			}
		}
			
		model.addAttribute("curPage", curPage);
		model.addAttribute("ntBoard", ntBoard);
		model.addAttribute("user", user);
	
		return "/ntboard/ntUpdateForm";
	}
	
	//게시판 수정 
	@RequestMapping(value="/ntboard/updateProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long ntBbsSeq = HttpUtil.get(request, "ntBbsSeq", (long)0);
		String ntBbsTitle = HttpUtil.get(request, "ntBbsTitle", "");
		String ntBbsContent = HttpUtil.get(request, "ntBbsContent", "");
		
		FileData fileData = HttpUtil.getFile(request, "ntFile", UPLOAD_SAVE_DIR);
		
		if(ntBbsSeq > 0)
		{
			NtBoard ntBoard = ntBoardService.boardSelect(ntBbsSeq);
			
			if(!StringUtil.isEmpty(ntBbsTitle))
			{
				if(!StringUtil.isEmpty(ntBbsContent))
				{
					if(ntBoard != null)
					{
						if(StringUtil.equals(ntBoard.getUserId(), cookieUserId))
						{
							ntBoard.setNtBbsSeq(ntBbsSeq);
							ntBoard.setNtBbsTitle(ntBbsTitle);
							ntBoard.setNtBbsContent(ntBbsContent);
							
							if(fileData != null && fileData.getFileSize() >0)
							{
								ntBoard.setNtFileName(fileData.getFileName());
								ntBoard.setNtFileOrgName(fileData.getFileOrgName());
								ntBoard.setNtFileExt(fileData.getFileExt());
								ntBoard.setNtFileSize(fileData.getFileSize());
							}
							
							try
							{
								if(ntBoardService.boardUpdate(ntBoard) > 0) 
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
								
							}
						}
						
					
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found");
					}
					
				}
				else
				{
					ajaxResponse.setResponse(410, "Not Found2222");
				}
				
			}
			else
			{
				ajaxResponse.setResponse(409, "Bad Request222");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	//게시물 삭제
		@RequestMapping(value="/ntboard/delete",method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> delete(HttpServletRequest request,HttpServletResponse response) {
			
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
			long ntBbsSeq = HttpUtil.get(request,"ntBbsSeq",(long)0);
			
			
			if(ntBbsSeq > 0) {
				
				NtBoard ntBoard = ntBoardService.boardSelect(ntBbsSeq);
				
				if(ntBoard!=null) {
					
					if(StringUtil.equals(ntBoard.getUserId(),cookieUserId)) {
						
						try {	 
								if(ntBoardService.boardDelete(ntBoard.getNtBbsSeq()) >0) {
										ajaxResponse.setResponse(0,"success");
								}
								else {
										ajaxResponse.setResponse(500,"internal server error22");
								}
								
						}
						catch(Exception e) {
							logger.error("[NtBoardController /ntboard/delete Exception",e);
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
				
				logger.debug("[NtBoardController] /ntboard/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			}
			
			return ajaxResponse;
		}
	


}
			

