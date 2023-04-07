/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : UserController.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.controller;

import java.util.Random;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.MailSendService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;
import com.sun.xml.internal.ws.resources.HttpserverMessages;

@Controller("userController")
public class UserController
{
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MailSendService mailService;
	
	
	
	
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	@ResponseBody  //json이나 xml 형태로 넘어감 body쪽에 들어감
	public Response<Object> login(HttpServletRequest request, HttpServletResponse response)
	{
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		Response<Object> ajaxResponse = new Response<Object>();
		
		HttpSession session = request.getSession();
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
		{
			User user = userService.userSelect(userId);
			
			if(!StringUtil.equals(user.getStatus(),"N"))
			{
				if(user != null)
				{
					session.setAttribute("userLevel", user.getUserLevel());
					
					if(StringUtil.equals(user.getUserPwd(), userPwd))
					{
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
						
						ajaxResponse.setResponse(0, "Success"); // 로그인 성공
					}
					else
					{
						ajaxResponse.setResponse(-1, "Passwords do not match"); // 비밀번호 불일치
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found"); // 사용자 정보 없음 (Not Found) null
				}
			}
			else
			{
				ajaxResponse.setResponse(700, "non exist"); // 파라미터가 올바르지 않음 (Bad Request)  공백
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)  공백
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/login response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}

	
	//회원가입 페이지
	@RequestMapping(value = "/user/regForm_prac",method=RequestMethod.GET)
	public String reqForm_prac(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(StringUtil.isEmpty(cookieUserId))
		{
			return "/user/regForm_prac";
		}
		else
		{
			CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
			return "redirect:/";
		}
	}
	
	
	//아이디,이메일 중복 체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response) {
	    Response<Object> ajaxResponse = new Response<Object>();
	    String userId = HttpUtil.get(request, "userId");
	    String userEmail = HttpUtil.get(request, "userEmail");
	    
	    if(!StringUtil.isEmpty(userId))
		{
	    	if(!StringUtil.isEmpty(userEmail))
	    	{
				if(userService.userSelect(userId) == null)
				{
					if(userService.userSelect2(userEmail) == null)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(200, "Duplicate Email");
					}
				}
				else
				{
					ajaxResponse.setResponse(100, "Duplicate ID");
				}
			}
	    	else
	    	{
	    		ajaxResponse.setResponse(300, "Empty Email");
	    	}
		}
	    else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}




			
	
	//휴대폰번호 중복 체크
			@RequestMapping(value="/user/phoneOvl", method=RequestMethod.POST)
			@ResponseBody
			public Response<Object> phoneOvl(HttpServletRequest request, HttpServletResponse response) {
			    Response<Object> ajaxResponse = new Response<Object>();
			    String userTel = HttpUtil.get(request, "userTel");
			   
			    User user = userService.userSelect3(userTel);

			    if (!StringUtil.isEmpty(userTel)) 
			    {
			        if (user == null) 
			        {
			            if (userService.userSelect(userTel) == null) 
			            {
			                ajaxResponse.setResponse(0, "Success");
			            }
			            else 
			            {
			                ajaxResponse.setResponse(100, "Duplicate userTel");
			            }
			        } 
			        else if (StringUtil.equals(user.getUserTel(), userTel))
			        {
			            ajaxResponse.setResponse(200, "Invalid userTel");
			        } 
			        else 
			        {
			            ajaxResponse.setResponse(0, "Success");
			        }
			    }
			    else 
			    {
			        ajaxResponse.setResponse(404, "UserTel not found");
			    }

			    return ajaxResponse;
			}




			
			
	//회원가입
	@RequestMapping(value="/user/regProc",method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userName = HttpUtil.get(request,"userName" );
		String userEmail = HttpUtil.get(request, "userEmail");
		String userAdd = HttpUtil.get(request, "userAdd");
		String userAdd2 = HttpUtil.get(request, "userAdd2");
		String userTel = HttpUtil.get(request, "userTel");
		String userBirth = HttpUtil.get(request, "userBirth");
		
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) &&!StringUtil.isEmpty(userAdd) &&!StringUtil.isEmpty(userAdd2) && !StringUtil.isEmpty(userTel) && !StringUtil.isEmpty(userBirth))
		{
			if(userService.userSelect(userId)==null)
			{
				//성공
				User user = new User();
				
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserLevel(1);
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				user.setUserAdd(userAdd);
				user.setUserAdd2(userAdd2);
				user.setUserTel(userTel);
				//user.setUserDate(userDate);
				//user.setUserGender(userGender);
				user.setUserBirth(userBirth);
				user.setStatus("Y");
				
				
				if(userService.userInsert(user) > 0)
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
				//실패
				ajaxResponse.setResponse(100, "Duplicate ID");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request22");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/regProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		
		return ajaxResponse;
	}
	
	
	//로그아웃
	@RequestMapping(value = "/user/loginOut", method = RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response)
	{
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
		{
			//CookieUtil.deleteCookie(request, response,"/", AUTH_COOKIE_NAME);
			CookieUtil.deleteCookie(request, response,"/",AUTH_COOKIE_NAME);
		}
		return "redirect:/";	
	}
	
	
	
	
	//비밀번호 찾기
			@RequestMapping(value ="/user/pwFindForm", method=RequestMethod.POST)
			@ResponseBody
			public Response<Object> pwFindForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			{
				Response<Object> ajaxResponse = new Response<Object>();
				
				String userId = HttpUtil.get(request, "userId");
				String userTel = HttpUtil.get(request, "userTel");
				String userEmail = HttpUtil.get(request, "userEmail");
				
				JsonObject json = new JsonObject();
				
				
				User user = userService.userSelect(userId);
				
				if(user == null) {
				    ajaxResponse.setResponse(405, "유저가 존재하지 않습니다");
				    return ajaxResponse;
				}
				String userPwd = user.getUserPwd();
				
				
				if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userTel) && !StringUtil.isEmpty(userEmail))
				{
					if(StringUtil.equals(user.getUserId(), userId))
					{
						if(StringUtil.equals(user.getUserEmail(), userEmail))
						{
								if(userService.userSelect2(userEmail) != null)
								{
									if(StringUtil.equals(user.getUserTel(), userTel))
									{
										
										ajaxResponse.setResponse(0, "Success" , json);
											
										json.addProperty("userPwd",userPwd );
										
									}
									else
									{
										ajaxResponse.setResponse(500, "회원정보와 일치하지 않는 전화번호 입니다.");
									}
								}
								else 
								{
									ajaxResponse.setResponse(400, "파라미터 값이 올바르지 않습니다.222");
								}
						}
						else
						{
							ajaxResponse.setResponse(100, "회원정보와 일치하는 이메일이 아닙니다");
						}
					}
					else
					{
						ajaxResponse.setResponse(200, "아이디가 같지 않다");
					}
				}
				else
				{
					ajaxResponse.setResponse(300, "정보가 비어있다.");
				}
				
				return ajaxResponse;
			}
		
		
			
			//아이디 찾기
					@RequestMapping(value ="/user/idFindForm", method=RequestMethod.POST)
					@ResponseBody
					public Response<Object> idFindForm(HttpServletRequest request, HttpServletResponse response)
					{
						Response<Object> ajaxResponse = new Response<Object>();
						
						String userEmail = HttpUtil.get(request, "userEmail");
						String userTel = HttpUtil.get(request, "userTel");
				
						JsonObject json = new JsonObject();
						
						
						User user = userService.userSelect2(userEmail);
						if(user == null) {
						    ajaxResponse.setResponse(305, "입력해라");
						    return ajaxResponse;
						}
						
						String userId = user.getUserId();
						
						
						if(!StringUtil.isEmpty(userEmail))
							{
								if(StringUtil.equals(user.getUserEmail(), userEmail))
								{
									if(!StringUtil.isEmpty(userTel))
									{
										if(StringUtil.equals(user.getUserTel(), userTel))
										{
											json.addProperty("userId",userId);
											
											ajaxResponse.setResponse(0, "Success" , json);
										}
										else
										{
											ajaxResponse.setResponse(300, "사용자의 전화번호가 같지 않다" );
										}
									}
									else
									{
										ajaxResponse.setResponse(400, "전화번호가 비어있다.");
									}
								}
								else
								{
									ajaxResponse.setResponse(100, "이메일이 같지 않다" );
								}
							}
							else
							{
								ajaxResponse.setResponse(200, "비어있다" );
							}
						
						
						return ajaxResponse;
					}
	
	
					//핸드폰 문자 발송 (랜덤번호 발송)
					@RequestMapping(value ="/user/phoneCheck")
					@ResponseBody
					public String phoneCheck(String userTel) {
						 
				        Random rand  = new Random(); 
				        
				        String numStr = "";
				        
				        for(int i = 0; i < 5; i++) 
				        {
				            String ran = Integer.toString(rand.nextInt(10));
				            numStr += ran;
				        }
				        
				        System.out.println("수신자 번호 : " + userTel);
				        System.out.println("인증번호 : " + numStr);
				        
				          userService.certifiedPhoneNumber(userTel, numStr); 
			
				         
				          return numStr;
				    }
					

					//이메일 전송
					@RequestMapping(value ="/user/EmailChk")
					@ResponseBody
					public Response<Object> emailChk(HttpServletRequest request, HttpServletResponse response)
					{
						Response<Object> ajaxResponse = new Response<Object>();
						String email = HttpUtil.get(request, "userEmail");
						
						System.out.println("이메일 인증 요청이 들어옴!");
						System.out.println("이메일 인증 이메일 : " + email);
						
						String num =  mailService.joinEmail(email);
						
						ajaxResponse.setResponse(0, "성공", num);
						
						
						return ajaxResponse;
					}
					
					

					//아이디 찾기 이메일 전송
					@RequestMapping(value = "/user/idEmail")
					@ResponseBody
					public Response<Object> idEmail(HttpServletRequest request, HttpServletResponse response) {
					    Response<Object> ajaxResponse = new Response<Object>();
					    String userEmail = HttpUtil.get(request, "userEmail");

					    try 
					    {
					        User user = userService.userSelect2(userEmail);

					        if (user != null) 
					        {
					            String userId = user.getUserId();
					           

					            System.out.println("이메일 요청이 들어옴!");
					            System.out.println("이메일 전송 이메일" + userEmail);

					            mailService.joinEmail3(userEmail, userId);

					            ajaxResponse.setResponse(0, "Success");
					        }
					        else 
					        {
					            ajaxResponse.setResponse(-1, "User not found");
					        }
					    } 
					    catch (Exception e)
					    {
					        e.printStackTrace();
					        ajaxResponse.setResponse(-1, "Error occurred");
					    }

					    return ajaxResponse;
					}

					
					//비밀번호찾기 이메일 전송
					@RequestMapping(value = "/user/pwdEmail")
					@ResponseBody
					public Response<Object> pwdEmail(HttpServletRequest request, HttpServletResponse response) {
					    Response<Object> ajaxResponse = new Response<Object>();
					    String userEmail = HttpUtil.get(request, "userEmail");
					    String userId = HttpUtil.get(request, "userId");
					    
					    try 
					    {
					        User user = userService.userSelect(userId);

					        if (user != null) 
					        {
					            String userPwd = user.getUserPwd();
					        

					            System.out.println("이메일 요청이 들어옴!");
					            System.out.println("이메일 전송 이메일" + userEmail);

					            mailService.joinEmail4(userEmail, userPwd);

					            ajaxResponse.setResponse(0, "Success");
					        }
					        else 
					        {
					            ajaxResponse.setResponse(-1, "User not found");
					        }
					    } 
					    catch (Exception e)
					    {
					        e.printStackTrace();
					        ajaxResponse.setResponse(-1, "Error occurred");
					    }

					    return ajaxResponse;
					}
					
					

					

	
	
}



