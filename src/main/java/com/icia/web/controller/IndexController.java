/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Artist;
import com.icia.web.model.FdBoard;
import com.icia.web.model.FdBoardWrapper;
import com.icia.web.model.Paging;
import com.icia.web.service.ArtistService;
import com.icia.web.service.FdBoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;


@Controller("indexController")
public class IndexController
{
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	@Autowired
	private UserService userService;

	@Autowired
	private FdBoardService fdBoardService;

	@Autowired
	private ArtistService artistService;
	
	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
	    List<FdBoard> recent = fdBoardService.fdCorrentSelect();
	    List<FdBoard> recommend = fdBoardService.fdRecommendSelect();
	    
	    List<Artist> mainArtist = artistService.mainArtistSelect();
	    
	    FdBoardWrapper wrapper = new FdBoardWrapper(recent, recommend);
	    
	    model.addAttribute("wrapper", wrapper);
	    model.addAttribute("mainArtist", mainArtist);
	    
	    return "/index";
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	@RequestMapping(value = "/qna", method=RequestMethod.GET)
	public String qna(HttpServletRequest request, HttpServletResponse response)
	{
		return "/qna";
	}
	
	@RequestMapping(value = "/funding/fundingForm", method=RequestMethod.GET)
	public String fundingForm(HttpServletRequest request, HttpServletResponse response)
	{
		return "/funding/fundingForm";
	}
	
	@RequestMapping(value = "/user/pwFind", method=RequestMethod.GET)
	public String pwFind(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/pwFind";
	}
	
	@RequestMapping(value = "/user/idFind", method=RequestMethod.GET)
	public String idFind(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/idFind";
	}
	
	
	@RequestMapping(value = "/snsboard/snsWriteForm", method=RequestMethod.GET)
	public String snsWriteForm(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{
		return "/snsboard/snsWriteForm";
	}
	
	
	
}
