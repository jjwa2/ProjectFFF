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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.ArtProfile;
import com.icia.web.model.Artist;
import com.icia.web.model.Follow;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.ReviewReply;
import com.icia.web.model.SnsBoard;
import com.icia.web.model.SnsReply;
import com.icia.web.model.User;
import com.icia.web.service.ArtistService;
import com.icia.web.service.FollowService;
import com.icia.web.service.SnsService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;


@Controller("snsController")
public class SnsController {

	private static Logger logger = LoggerFactory.getLogger(SnsController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//아티스트 프로필 사진경로
	@Value("#{env['upload.art.save.dir']}")
	private String UPLOAD_ART_SAVE_DIR;
	
	@Autowired
	private SnsService snsService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ArtistService artistService;
	
	@Autowired
	private FollowService followService;
	
	private static final int LIST_COUNT = 3;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	
	@RequestMapping(value = "/snsboard/snsmain")
	public String snsmain(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String followerId = HttpUtil.get(request, "followerId", "");
		List<Follow> follow = null;
		List<Follow> followSns = null;
		
		Follow followww = new Follow();
		Artist artist = new Artist();
		
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			followww.setFollowingId(cookieUserId);
			
			if(!StringUtil.isEmpty(followerId))
			{
				followww.setFollowerId(followerId);
				artist = artistService.artistSelect(followerId);
			}
			

			if(followService.followListCount(cookieUserId) > 0)
			{
				follow = followService.followList(cookieUserId);
				followSns = followService.followSnsList(followww);
			}
		}
		
		
		//추천 아티스트 리스트업
		List<Artist> artlist = artistService.allArtistSelect(cookieUserId);
		model.addAttribute("artist", artist);
	    model.addAttribute("artlist", artlist);
	    model.addAttribute("follow", follow);
	    model.addAttribute("followSns", followSns);
	    model.addAttribute("cookieUserId", cookieUserId);

	
		
		return "/snsboard/snsmain";
	}
	
	//팔로우 하기
	@RequestMapping(value = "/sns/follow", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> follow(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId", "");
		
		Follow follow = new Follow();
		
		
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(userId))
		
	    {
	        // 팔로우한 사용자 목록 조회
	        List<Follow> followingList = followService.followList(cookieUserId);
	        boolean alreadyFollowing = false;
	        for(Follow following : followingList) {
	            if(following.getFollowerId().equals(userId)) {
	                alreadyFollowing = true;
	                break;
	            }
	        }
	        // 이미 팔로우한 사용자인 경우
	        if(alreadyFollowing) {
	            ajaxResponse.setResponse(600, "already following");
	        }
	        else {
	            follow.setFollowerId(userId);
	            follow.setFollowingId(cookieUserId);
	    
	            if(followService.followInsert(follow) > 0)
	            {
	                ajaxResponse.setResponse(0, "success");
	            }
	            else
	            {
	                ajaxResponse.setResponse(400, "server error");
	            }
	        }
	    }
		else
		{
			ajaxResponse.setResponse(500, "maegae error");
		}

		
		return ajaxResponse;
	}
	
	//언팔로우하기 0316 추가
	@RequestMapping(value = "/sns/unfollow", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> unfollow(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId", "");
		
		Follow follow = new Follow();
		
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(userId))
		{
			follow.setFollowerId(userId);
			follow.setFollowingId(cookieUserId);
			
			if(followService.followDelete(follow) > 0)
			{
				ajaxResponse.setResponse(0, "success");
			}
			else
			{
				ajaxResponse.setResponse(400, "server error");
			}
			
		}
		else
		{
			ajaxResponse.setResponse(500, "maegae error");
		}

		
		return ajaxResponse;
	}
	
//	@RequestMapping(value = "/sns/select", method=RequestMethod.POST)
//	@ResponseBody
//	public Response<Object> select(HttpServletRequest request, HttpServletResponse response)
//	{
//		Response<Object> ajaxResponse = new Response<Object>();
//		String followerId = HttpUtil.get(request, "followerId", "");
//		List<SnsBoard> list = null;
//		
//
//		JsonObject json = new JsonObject();
//		
//		if(!StringUtil.isEmpty(followerId))
//		{
//			list = snsService.snsBoardList(followerId);
//			
//            JsonArray sns = new JsonArray();
//            for (SnsBoard snsBoard : list) {
//                JsonObject item = new JsonObject();
//                item.addProperty("id", snsBoard.getUserId());
//                item.addProperty("title", snsBoard.getSnsContent());
//                item.addProperty("content", snsBoard.getSnsFileName());
//                item.addProperty("content", snsBoard.getUserCategoly());
//                item.addProperty("content", snsBoard.getUserIntroduce());
//                item.addProperty("content", snsBoard.getFileProfileName());
//                sns.add(item);
//            }
//            json.add("list", sns);
//			
//            ajaxResponse.setResponse(0, "success");
//
//		}
//		else
//		{
//			ajaxResponse.setResponse(500, "maegae error");
//		}
//		
//		return ajaxResponse;
//	}
	

	
	
		
	
	
	
	//게시물 등록
	@RequestMapping(value="/sns/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String snsContent = HttpUtil.get(request, "snsContent", "");
		FileData fileData = HttpUtil.getFile(request, "rvFile", UPLOAD_SAVE_DIR);
		
		logger.debug("======================");
		logger.debug("cookieUserId" + cookieUserId);
		logger.debug("snsContent" + snsContent);
		logger.debug("fileData" + fileData);
		logger.debug("======================");
		
		if(!StringUtil.isEmpty(snsContent))
		{
			 Artist artist = artistService.artistSelect(cookieUserId);
			 SnsBoard snsBoard = new SnsBoard();
			

			 snsBoard.setUserId(cookieUserId);
			 snsBoard.setSnsContent(snsContent);
			 snsBoard.setSnsCategory(artist.getUserCategoly());
			 snsBoard.setSnsFileName(fileData.getFileName());
			 snsBoard.setSnsFileOrgName(fileData.getFileOrgName());
			 snsBoard.setSnsFileExt(fileData.getFileExt());
			 snsBoard.setSnsFileSize(fileData.getFileSize());
			 
			 
			 if(snsService.snsBoardInsert(snsBoard) > 0)
			 {
				ajaxResponse.setResponse(0, "Success");
			 }
			 else
			 {
				ajaxResponse.setResponse(500, "internal server error");
			 }
		}
		else
		{
			ajaxResponse.setResponse(400, "bad request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[SnsController] /sns/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		
		return ajaxResponse;

	}
	
	
	//게시물 삭제 
	@RequestMapping(value = "/sns/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> snsDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long snsSeq = HttpUtil.get(request, "snsSeq", (long)0);
		SnsBoard snsBoard = snsService.snsSelect(snsSeq);

			if(snsBoard != null)
			{
				if(StringUtil.equals(snsBoard.getUserId(), cookieUserId))
				{
					if(snsService.snsDelete(snsSeq) > 0)
					{
						ajaxResponse.setResponse(0, "success");
					}
					else
					{
						ajaxResponse.setResponse(300, "DB munzae");
					}
				}
				else
				{
					ajaxResponse.setResponse(400, "not you");
				}
			}
			else
			{
				ajaxResponse.setResponse(500, "board empty");
			}
		
		return ajaxResponse;
	}
	
	
	//댓글 등록
	@RequestMapping(value="/snsmain/snsReplyProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> snsReplyProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String snsReplyContent = HttpUtil.get(request, "snsReplyContent", "");
		long snsSeq = HttpUtil.get(request, "snsSeq", (long)0);
		
		if(!StringUtil.isEmpty(snsReplyContent))
		{
				SnsReply snsReply = new SnsReply();
				
				snsReply.setUserId(cookieUserId);
				snsReply.setSnsReplyContent(snsReplyContent);
				snsReply.setSnsSeq(snsSeq);
				
				try
				{
					if(snsService.snsReplyInsert(snsReply) > 0)
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
	  
	  @RequestMapping(value="/sns/search", method = RequestMethod.POST)
	  @ResponseBody
	  public Response<Object> search(HttpServletRequest request, HttpServletResponse response, ModelMap model) 
	  {
	    String searchQuery = request.getParameter("userId"); // AJAX로 전송된 검색어 받아오기
	    Response<Object> ajaxResponse = new Response<Object>();
	    List<Artist> results = null;
	    
	    if(!StringUtil.isEmpty(searchQuery))
	    {
	      results = artistService.searchArtist(searchQuery);
	      ajaxResponse.setData(results); // 검색 결과를 Response 객체에 저장
	    }
	    else
	    {
	      ajaxResponse.setResponse(500, "Internal Server Error");
	    }

	    return ajaxResponse;
	  }
	
	  
		//댓글 삭제
		@RequestMapping(value="/snsBoard/replyDelete", method = RequestMethod.POST)
		@ResponseBody
		public Response<Object> replyDelete(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			long snsReplySeq = HttpUtil.get(request, "snsReplySeq", (long)0);
			
			if(snsReplySeq > 0)
			{
				SnsReply reviewReply = snsService.replySelect(snsReplySeq);
				
				if(reviewReply != null)
				{
					if(StringUtil.equals(reviewReply.getUserId(), cookieUserId))
					{
						try
						{
							if(snsService.replyDelete(snsReplySeq) > 0)
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


}
