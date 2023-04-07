package com.icia.web.controller;

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

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Review;
import com.icia.web.model.ReviewReply;
import com.icia.web.model.User;
import com.icia.web.service.ReviewService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("reviewController")
public class ReviewController 
{
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private UserService userService;
	
	private static final int LIST_COUNT = 6;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/rvBoard/rvList")
	public String rvList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String searchType =HttpUtil.get(request, "searchType", "");
		String searchValue =HttpUtil.get(request, "searchValue", "");
		
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long totalCount = 0;
		
		List<Review> list = null;
		List<Review>  bestList = null;
		
		Paging paging = null;
		Review search = new Review();
		
		User user = null;
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			user = userService.userSelect(cookieUserId);
		}
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		
		totalCount = reviewService.boardListCount(search);
		
		logger.debug("===================================");
		logger.debug("totalCount : " + totalCount);
		logger.debug("===================================");
		
		if(totalCount > 0)
		{
			paging = new Paging("rvBoard/rvList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = reviewService.boardList(search);
			bestList = reviewService.bestList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("bestList", bestList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("user", user);
		
		return "/rvBoard/rvList";
	}
	
	
	//게시물 등록 폼
	@RequestMapping(value="/rvBoard/rvWriteForm")
	public String rvWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		//사용자 정보 조회
		User user = userService.userSelect(cookieUserId);
		model.addAttribute("user", user);
		
		return "/rvBoard/rvWriteForm";
	}
	
	
	
	
	
	
	//게시물 등록
	@RequestMapping(value="/rvBoard/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String rvTitle = HttpUtil.get(request, "rvTitle", "");
		String rvContent = HttpUtil.get(request, "rvContent", "");
		
		FileData fileData = HttpUtil.getFile(request, "rvFile", UPLOAD_SAVE_DIR);
		
		if(!StringUtil.isEmpty(rvTitle) && !StringUtil.isEmpty(rvContent))
		{
			Review review = new Review();
			
			review.setUserId(cookieUserId);
			review.setRvTitle(rvTitle);
			review.setRvContent(rvContent);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				review.setRvFileName(fileData.getFileName());
				review.setRvFileOrgName(fileData.getFileOrgName());
				review.setRvFileExt(fileData.getFileExt());
				review.setRvFileSize(fileData.getFileSize());
			}
			
			try
			{
				if(reviewService.rvBoardInsert(review) > 0)
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
				logger.error("[ReviewController]/rvBoard/writeProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad request");
		}
		
		return ajaxResponse;
	}
	
	//게시글 상세페이지 및 댓글 목록
	@RequestMapping(value="/rvBoard/rvView")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rvSeq = HttpUtil.get(request, "rvSeq", (long)0);
		String searchType =HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		String boardMe = "N";
		
		Review review = null;
		
		List<ReviewReply> replyList = null;
		ReviewReply reviewReply = new ReviewReply();
		reviewReply.setRvSeq(rvSeq);

		
		if(rvSeq > 0)
		{
			review = reviewService.boardView(rvSeq);
			
			if(review != null && StringUtil.equals(review.getUserId(), cookieUserId))
			{
				boardMe = "Y";
			}
		}
		
		replyList = reviewService.replyList(reviewReply);
		
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("rvSeq", rvSeq);
		model.addAttribute("review", review);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("replyList", replyList);
		
		return "/rvBoard/rvView";
	}
	
	//댓글 삭제
	@RequestMapping(value="/rvBoard/replyDelete", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rvReplySeq = HttpUtil.get(request, "rvReplySeq", (long)0);
		
		if(rvReplySeq > 0)
		{
			ReviewReply reviewReply = reviewService.replySelect(rvReplySeq);
			
			if(reviewReply != null)
			{
				if(StringUtil.equals(reviewReply.getUserId(), cookieUserId))
				{
					try
					{
						if(reviewService.replyDelete(rvReplySeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error22");
						}
					}
					catch(Exception e)
					{
						logger.error("[HiBoardController]/rvBoard/replyDelete Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error");
					}
				}
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	//게시물 삭제
	@RequestMapping(value="/rvBoard/delete", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rvSeq = HttpUtil.get(request, "rvSeq", (long)0);
		
		if(rvSeq > 0)
		{
			Review review = reviewService.boardSelect(rvSeq);
			
			if(review != null)
			{
				if(StringUtil.equals(review.getUserId(), cookieUserId))
				{
					
					try 
					{
						if(reviewService.boardDelete(rvSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error22");
						}
					}
					catch(Exception e)
					{
						logger.error("[HiBoardController] /rvBoard/delete Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error");
					}
				}
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;		
	}
	
	//게시물 수정화면
	@RequestMapping(value="/rvBoard/rvUpdateForm")
	public String rvUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rvSeq = HttpUtil.get(request, "rvSeq", (long)0);
		String searchType =HttpUtil.get(request, "searchType", "");
		String searchValue =HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Review review = null;
		User user = null;
		
		if(rvSeq > 0)
		{
			review = reviewService.boardSelectView(rvSeq);
			
			if(review != null)
			{
				if(StringUtil.equals(review.getUserId(), cookieUserId))
				{
					user = userService.userSelect(cookieUserId);
				}
				else
				{
					review = null;
				}
			}
		}
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("review", review);
		model.addAttribute("user", user);
		
		return "/rvBoard/rvUpdateForm";
	}
	
	//게시판 업데이트
	@RequestMapping(value="/rvBoard/rvUpdateProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> rvUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rvSeq = HttpUtil.get(request, "rvSeq", (long)0);
		String rvTitle = HttpUtil.get(request, "rvTitle", "");
		String rvContent = HttpUtil.get(request, "rvContent", "");
		FileData fileData = HttpUtil.getFile(request, "rvFile", UPLOAD_SAVE_DIR);
		
		if(rvSeq > 0)
		{
			Review review = reviewService.boardSelect(rvSeq);
			
			if(!StringUtil.isEmpty(rvTitle))
			{
				if(!StringUtil.isEmpty(rvContent))
				{
					if(review != null)
					{
						if(StringUtil.equals(review.getUserId(), cookieUserId))
						{
							review.setRvSeq(rvSeq);
							review.setRvTitle(rvTitle);
							review.setRvContent(rvContent);
							
							if(fileData != null && fileData.getFileSize() >0)
							{
								review.setRvFileName(fileData.getFileName());
								review.setRvFileOrgName(fileData.getFileOrgName());
								review.setRvFileExt(fileData.getFileExt());
								review.setRvFileSize(fileData.getFileSize());
							}
							
							try
							{
								if(reviewService.boardUpdate(review) > 0)
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
								logger.error("[ReviewController]/rvBoard/rvUpdateProc Exception", e);
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
				ajaxResponse.setResponse(409, "Bad Request99999999");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		
		return ajaxResponse;
	}
	
	//댓글 등록
	@RequestMapping(value="/rvBoard/rvReplyProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> rvReplyProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rvReplyContent = HttpUtil.get(request, "rvReplyContent", "");
		long rvSeq = HttpUtil.get(request, "rvSeq", (long)0);
		
		if(!StringUtil.isEmpty(rvReplyContent))
		{
				ReviewReply reviewReply = new ReviewReply();
				
				reviewReply.setUserId(cookieUserId);
				reviewReply.setRvReplyContent(rvReplyContent);
				reviewReply.setRvSeq(rvSeq);
				
				try
				{
					if(reviewService.rvReplyInsert(reviewReply) > 0)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(500, "Internal Server Error");
					}
				}
				catch(Exception e)
				{
					logger.error("[ReviewController]/rvBoard/rvReplyProc Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
		}
		
		return ajaxResponse;
	}
	
	
}













