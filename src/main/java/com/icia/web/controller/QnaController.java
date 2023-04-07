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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Qna;
import com.icia.web.model.QnaReply;
import com.icia.web.model.Response;
import com.icia.web.model.ReviewReply;
import com.icia.web.model.User;
import com.icia.web.service.QnaService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("qnaController")
public class QnaController {
private static Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private QnaService qnaService;
	@Autowired
	private UserService userService;
	
	private static final int LIST_COUNT = 7;
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value= "/qna/inquiry")
	public String inquiry(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String searchType = HttpUtil.get(request, "searchType", "");
				//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
				//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
				//총게시물 수
		long totalCount = 0;
				//게시물 리스트
		List<Qna> list = null;
				//페이징
		Paging paging = null;
				
		Qna search = new Qna();
		
		User user = null;

		int admin = 0;
		
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			user = userService.userSelect(cookieUserId);
			if(user.getUserLevel() == 3)
			{
				admin = 3;
			}
		
		}
				
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
				
		totalCount = qnaService.boardListCount(search);
				
		if(totalCount > 0)
		{
			paging = new Paging("qna/inquiry" , totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
					
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
					
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
					
			//리스트 호출
			list = qnaService.boardList(search);
			
		}
				
		model.addAttribute("list", list); 
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue",searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("user", user);
		model.addAttribute("cookieUserId", cookieUserId);		
		model.addAttribute("admin", admin);
		
		return "/qna/inquiry";
	}
	
	//글쓰기
	@RequestMapping(value = "/qna/writeForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//사용자 쿠키 보여줌
		User user = userService.userSelect(cookieUserId);
		model.addAttribute("user", user);
		
		return "/qna/writeForm";
	}
	
	//게시물 등록
			@RequestMapping(value = "/qna/writeProc", method=RequestMethod.POST)
			@ResponseBody						
			public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
			{
				Response<Object> ajaxResponse = new Response<Object>();
				String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
				
				//타이틀 ,내용 가져오기
				String qnaBbsTitle = HttpUtil.get(request, "qnaBbsTitle", "");
				String qnaBbsContent = HttpUtil.get(request, "qnaBbsContent", ""); 
				String qnaBbsSecret = HttpUtil.get(request, "qnaBbsSecret", "");
				
				
				if(!StringUtil.isEmpty(qnaBbsTitle) && !StringUtil.isEmpty(qnaBbsContent))
				{	//둘 다 값이 있으면 HiBoard 객체에 각각의 값들을 넣어서 적용
					Qna qna = new Qna();
					qna.setQnaBbsTitle(qnaBbsTitle);
					qna.setQnaBbsContent(qnaBbsContent);
					qna.setUserId(cookieUserId);
					
					//체크박스 값이 체크되어 있다면 "y"로 설정
			        if(qnaBbsSecret.equals("on")) 
			        {
			            qna.setQnaBbsSecret("Y");
			        } 
			        else 
			        {
			            qna.setQnaBbsSecret("N");
			        }
					
					try
					{
						if(qnaService.boardInsert(qna) > 0) 
						{
							ajaxResponse.setResponse(0,"Success");
						}
						else
						{
							ajaxResponse.setResponse(500,"internal server error");
						}
					}
					catch(Exception e)
					{
						logger.error("[qnaController]/board/writeProc Exception" , e);
						ajaxResponse.setResponse(500, "internal server error");
					}		
				}
				else
				{
					ajaxResponse.setResponse(400, "board request");
				}
				
				return ajaxResponse;
			}
	
	//게시물,댓글 조회 
	@RequestMapping(value="/qna/view")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", 0);
		
		String searchType = HttpUtil.get(request, "searchType" , "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		
		User user = new User();
		
		user = userService.userSelect(cookieUserId);
		
		//본인글 여부 체크
		String boardMe = "N";
		int admin = 0;
		
		Qna qna = null;
		
		List<QnaReply> qnaList = null;
		QnaReply qnaReply = new QnaReply();
		qnaReply.setQnaBbsSeq(qnaBbsSeq);
		
		// 사용자 로그인 여부 체크
	    boolean isLoggedIn = !StringUtil.isEmpty(cookieUserId);
		
		
		if(isLoggedIn && qnaBbsSeq > 0)
		{
			qna = qnaService.boardView(qnaBbsSeq);
			
			if(qna != null && StringUtil.equals(qna.getUserId(), cookieUserId))
			{
				boardMe = "Y";
			}
			if(user.getUserLevel() == 3)
			{
				admin = 3;
			}
		}
		
		
		qnaList = qnaService.replyList(qnaReply);
		
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("qnaBbsSeq", qnaBbsSeq);
		model.addAttribute("qna", qna);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("searchType" , searchType);
		model.addAttribute("curPage", curPage);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("admin", admin);
		model.addAttribute("isLoggedIn", isLoggedIn);
		
		return "/qna/view";
	}
	
	//게시글 삭제
	@RequestMapping(value="/qna/delete" , method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", (long)0);
		int admin = 0;
		
		User user = new User();
		
		user = userService.userSelect(cookieUserId);
		
		if(qnaBbsSeq > 0)
		{
			Qna qna = qnaService.boardSelect(qnaBbsSeq);
			
			if(qna != null)
			{
				if(StringUtil.equals(qna.getUserId(), cookieUserId) || user.getUserLevel() == 3)
				{
					try
					{
						
						if(qnaService.boardDelete(qnaBbsSeq) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "internal server error");
						}
					}
					
			
					catch(Exception e)
					{
						logger.error("[QnaController] /qna/delete Exception", e);
						ajaxResponse.setResponse(500, "internal server error");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[QnaController]/qna/delete rsponse\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}
	
	//게시글 수정 폼
	@RequestMapping(value="/qna/updateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue" , "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Qna qna = null;
		User user = null;
		
		if(qnaBbsSeq > 0)
		{
			qna = qnaService.boardSelectView(qnaBbsSeq);
			
			if(qna != null)
			{
				if(StringUtil.equals(qna.getUserId(), cookieUserId))
				{
					user = userService.userSelect(cookieUserId);
				}
				else
				{	
					qna = null;
				}
			}
		}
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("qna", qna);
		model.addAttribute("user", user);
		
		return "/qna/updateForm";
	}
	
	//게시물 수정
		@RequestMapping(value="/qna/updateProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> updateProc(MultipartHttpServletRequest request,HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", (long)0);
			String qnaBbsTitle = HttpUtil.get(request, "qnaBbsTitle", "");
			String qnaBbsContent = HttpUtil.get(request, "qnaBbsContent", "");
			logger.debug("컨트롤러입니다." + qnaBbsSeq);
			
			if(qnaBbsSeq > 0 && !StringUtil.isEmpty(qnaBbsTitle) && !StringUtil.isEmpty(qnaBbsContent))
			{
				Qna qna = qnaService.boardSelect(qnaBbsSeq);
				if(qna != null)
				{
					if(StringUtil.equals(qna.getUserId(), cookieUserId))
					{
						qna.setQnaBbsSeq(qnaBbsSeq);
						qna.setQnaBbsTitle(qnaBbsTitle);
						qna.setQnaBbsContent(qnaBbsContent);
						
						
						try
						{
							if(qnaService.boardUpdate(qna) > 0)
							{
								ajaxResponse.setResponse(0, "success");
							}
							else
							{
								ajaxResponse.setResponse(500, "server error2222");
							}
						}
						catch(Exception e)
						{
							logger.error("[QnaController] /qna/updateProc Exception", e);
							ajaxResponse.setResponse(500, "server error");
						}
						
					}
					else
					{
						ajaxResponse.setResponse(404, "not found22");
					}	
				}
				else
				{
					ajaxResponse.setResponse(404, "not found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "bad request");
			}
			
			if(logger.isDebugEnabled())
			{
				logger.debug("[QnaController] /qna/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			}
			
			return ajaxResponse;
		}
	
	//댓글 삭제
	@RequestMapping(value="/qna/replyDelete",  method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long qnaReplySeq = HttpUtil.get(request, "qnaReplySeq", (long)0);
		
		if(qnaReplySeq > 0)
		{
			QnaReply qnaReply = qnaService.replySelect(qnaReplySeq);
			
			if(qnaReply != null)
			{
				if(StringUtil.equals(qnaReply.getUserId(), cookieUserId))
				{
					try
					{
						if(qnaService.replyDelete(qnaReplySeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error2");
						}
					}
					catch(Exception e)
					{
						logger.error("[QnaController]/qna/replyDelete Exception", e);
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
	
	//댓글 등록
	@RequestMapping(value="/qna/qnaReplyProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> qnaReplyProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String qnaReplyContent = HttpUtil.get(request, "qnaReplyContent", "");
		long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", (long)0);

		
		if(!StringUtil.isEmpty(qnaReplyContent))
		{
				QnaReply qnaReply = new QnaReply();

				
				qnaReply.setUserId(cookieUserId);
				qnaReply.setQnaReplyContent(qnaReplyContent);
				qnaReply.setQnaBbsSeq(qnaBbsSeq);
				
		
				try
				{
					if(qnaService.boardReplyInsert(qnaReply) > 0)
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
					logger.error("[QnaController]/qna/qnaReplyProc Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
				
		}
		
		return ajaxResponse;
	}

	//댓글의 답변 상태
		@RequestMapping(value="/qna/qnaReplyState", method = RequestMethod.POST)
		@ResponseBody
		public Response<Object> qnaReplyState(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			long qnaBbsSeq = HttpUtil.get(request, "qnaBbsSeq", (long)0);
			
			if(qnaService.replyStateUpdate(qnaBbsSeq) > 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				ajaxResponse.setResponse(400, "fail");
			}
			
			
			return ajaxResponse;
		}
	
	
}
