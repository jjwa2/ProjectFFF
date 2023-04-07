/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.service
 * 파일명     : UserService.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
//import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.icia.web.dao.UserDao;
import com.icia.web.model.User;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;





@Service("userService")
public class UserService
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	
	@Autowired
	private UserDao userDao;
	

	public User userSelect(String userId)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}
	
	//회원가입
	public int userInsert(User user)
	{
		int count = 0;
		
		
		try 
		{
			count = userDao.userInsert(user);
			
		}
		catch (Exception e) 
		{
			logger.error("[UserService] userInsert Exception", e);
		}
		
		
		
		return count;
	}
	
	//회원정보 수정
	public int userUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userUpdate Exception", e);
		}
		return count;
	}
	
	public char userUpdate1(User user)
	{
		char count = ' ';
		
		try
		{
			count = userDao.userUpdate1(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userUpdate Exception", e);
		}
		return count;
	}

	
	//아이디 찾기
	public User userSelect2(String userEmail)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect2(userEmail);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect2 Exception", e);
		}
		
		return user;
	}
	
	
	//휴대폰 인증
	public void certifiedPhoneNumber(String userTel, String numStr) {
		 
        String api_key = "NCSYOHVBJWKAOHKN";
          String api_secret = "YIBA5VGXSRKIRFM39OKN3J75XOTWG0IP";
          Message coolsms = new Message(api_key, api_secret);

        
          HashMap<String, String> params = new HashMap<String, String>();
          params.put("to", userTel);    
          params.put("from", "010-3050-9245");   
          params.put("type", "SMS");
          params.put("text", "<FFF> 인증 번호는"+"["+ numStr+ "]"+" 입니다. 정확히 입력해주세요. ");
          params.put("app_version", "test app 1.2"); 

          try 
          {
              JSONObject obj = (JSONObject) coolsms.send(params);
              System.out.println(obj.toString());
          } 
          catch (CoolsmsException e)
          {
              System.out.println(e.getMessage());
              System.out.println(e.getCode());
          }
          
   }
	
	//핸드폰 체크
	public User userSelect3(String userTel)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect3(userTel);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect3 Exception", e);
		}
		
		return user;
	}
	
	
	//아티스트 승인 박재윤 (23.03.23)
	public int userLevel(String userId)
	{
		int count = 0;
		
		try
		{
			count = userDao.userLevel(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userLevel Exception", e);
		}
		
		return count;
	}
	
	
	
	
	//관리자 페이지 유저 리스트
	public List<User> adminUserList(int userLevel)
	{
		List<User> userList = null;
		
		try
		{
			userList = userDao.adminUserList(userLevel);
		}
		catch(Exception e)
		{
			logger.error("[UserService] adminUserList Exception", e);
		}
		
		return userList;
	}

	
	


}
