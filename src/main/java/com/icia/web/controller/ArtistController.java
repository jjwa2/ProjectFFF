package com.icia.web.controller;

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
import com.icia.web.model.ArtProfile;
import com.icia.web.model.Artist;
import com.icia.web.model.FdBoard;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.ArtistService;
import com.icia.web.service.FdBoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;


@Controller("artistController")
public class ArtistController {

	private static Logger logger = LoggerFactory.getLogger(ArtistController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//아티스트 프로필 사진경로
	@Value("#{env['upload.art.save.dir']}")
	private String UPLOAD_ART_SAVE_DIR;
	
	@Autowired
	private ArtistService artistService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private FdBoardService fdBoardService;
	
	//등급업 페이지로 이동
	@RequestMapping(value = "/user/artistUpgrade", method=RequestMethod.GET)
	public String Artistupgrade(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = null;
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			user = userService.userSelect(cookieUserId);
		}
		
		model.addAttribute("user", user);
		
		return "/user/artistUpgrade";
	}
	
	
	

	//아티스트 프로필 등록 요청
	@RequestMapping(value="/artist/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> artistUpdate(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		//아티스트인지 체크할것
		
		//아티스트 장르받기
		
		//아티스트 소개글 받기
		//쿠키아이디가 회원인지 확인해서 맞을때 파일 추가
		
		String userCategoly = HttpUtil.get(request, "userCategoly", "");
		String userIntroduce = HttpUtil.get(request, "userIntroduce", "");
		
		//쿠키아이디가 회원인 경우 파일명을 아이디.확장자로 처리
		FileData fileData = HttpUtil.getFile(request, "fileProfileName", UPLOAD_SAVE_DIR);
		logger.debug("===========================");
		logger.debug("fileData" + fileData);
		
		if(!StringUtil.isEmpty(userCategoly) && !StringUtil.isEmpty(userIntroduce))
		{
			Artist artist = new Artist();
			
			artist.setUserId(cookieUserId);
			artist.setUserCategoly(userCategoly);
			artist.setUserIntroduce(userIntroduce);
			logger.debug("33333333333333333333333333");
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				logger.debug("2222222222222222222222222222222");
				ArtProfile artProfile = new ArtProfile();
				
				artProfile.setUserId(cookieUserId);
				artProfile.setFileProfileName(fileData.getFileName());
				artProfile.setFileExt(fileData.getFileExt());
				artProfile.setFileSize(fileData.getFileSize());
				
				artist.setArtProfile(artProfile);
			}

			try
			{
				if(artistService.artistUpdate(artist) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "internal server error");
				}
			}
			catch(Exception e)
			{
				logger.error("[ArtistController] /artist/update Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "boad request");
		}
		
		return ajaxResponse;
	}
	
	
//	//0310 박재영 추가 아티스트상세페이지 이동
//	@RequestMapping(value = "/snsboard/artistMypage", method=RequestMethod.GET)
//	public String artistMypage(ModelMap model,HttpServletRequest request, HttpServletResponse response)
//	{
//		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
//		FdBoard fdBoard = new FdBoard();
//		
//		if(!StringUtil.isEmpty(cookieUserId))
//		{
//			fdBoard = fdBoardService.
//		}
//		
//		return "/snsboard/artistMypage";
//	}
}
