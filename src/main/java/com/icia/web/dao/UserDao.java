/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.dao
 * 파일명     : UserDao.java
 * 작성일     : 2021. 1. 19.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.User;


@Repository("userDao")
public interface UserDao
{
	

	public User userSelect(String userId);
	//회원가입
	public int userInsert(User user);
	
	//회원정보 수정
	public int userUpdate(User user);
		
	//회원 탈퇴
	public char userUpdate1(User user);
	
	//아이디 찾기
	public User userSelect2(String userEmail);

	//비밀번호 체크
	public User userSelect3(String userTel);
	
	//유저 레벨 승인(박재윤 23.03.23)
	public int userLevel(String userId);
	
	//관리자 페이지 유저 리스트
		public List<User> adminUserList(int userLevel);
}




