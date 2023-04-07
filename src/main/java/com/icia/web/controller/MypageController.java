package com.icia.web.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.ArtProfile;
import com.icia.web.model.FdPm;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Review;
import com.icia.web.model.User;
import com.icia.web.service.ArtistService;
import com.icia.web.service.FdBoardService;
import com.icia.web.service.ReviewService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("mypageController")
public class MypageController 
{
	private static Logger logger = LoggerFactory.getLogger(MypageController.class);

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private FdBoardService fdBoardService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ArtistService artistService;
	
	@RequestMapping(value = "/mypage",method=RequestMethod.GET)
	public String mypage(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
				

		User user = userService.userSelect(cookieUserId);
		List<FdPm> fdPm = fdBoardService.fdPmList(cookieUserId);
		List<Review> review = reviewService.boardList1(cookieUserId);
		
		ArtProfile artProfile = artistService.getProfile(cookieUserId);
		
		model.addAttribute("artProfile", artProfile);
		model.addAttribute("user", user);
		model.addAttribute("fdPm", fdPm);
		model.addAttribute("review", review);
		
		return "/mypage";
	}
	
	
	
	//회원정보수정 실행
		@RequestMapping(value = "/mypageProc", method = RequestMethod.POST)
		@ResponseBody
		public Response<Object> mypageUpdateProc(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			String userPwd = HttpUtil.get(request, "userPwd");
			String userName = HttpUtil.get(request, "userName");
			String userEmail = HttpUtil.get(request, "userEmail");
			
			if(!StringUtil.isEmpty(cookieUserId))
			{
				User user = userService.userSelect(cookieUserId);
				
				if(user != null)
				{
					if(StringUtil.equals(user.getStatus(), "Y"))
					{
						if(!StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail))
						{
							user.setUserPwd(userPwd);
							user.setUserName(userName);
							user.setUserEmail(userEmail);
							
							if(userService.userUpdate(user) > 0)
							{
								ajaxResponse.setResponse(0, "Success");
							}
							else
							{
								ajaxResponse.setResponse(500, "Internal Server Error");
							}
						}
						else
						{
							ajaxResponse.setResponse(400, "Bad Request3");
						}
					}
					else
					{
						//정지된 사용자
						CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
						ajaxResponse.setResponse(400, "Bad Request");
					}
				}
				else
				{
					//사용자 정보 없음(쿠키 삭제)
					CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
					ajaxResponse.setResponse(404, "Not Found");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
			
			return ajaxResponse;
		}
		
		//회원 탈퇴
		@RequestMapping(value = "/mypageOut", method = RequestMethod.POST)
		@ResponseBody
		public Response<Object> mypageOut(HttpServletRequest request, HttpServletResponse response) {
		    Response<Object> ajaxResponse = new Response<Object>();
		    String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		    if (!StringUtil.isEmpty(cookieUserId)) {
		        User user = userService.userSelect(cookieUserId);

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

}
