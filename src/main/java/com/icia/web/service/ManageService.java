package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.FdBoardDao;
import com.icia.web.dao.UserDao;
import com.icia.web.model.User;

@Service("manageService")
public class ManageService {
	private static Logger logger = LoggerFactory.getLogger(ManageService.class);
	
	@Autowired
	private FdBoardDao fdBoardDao;
	@Autowired
	private UserDao userDao;
	
	
	public int fdApprove(long fdBbsSeq)
	{
		int count = 0;
		
		try {
			count = fdBoardDao.fdApprove(fdBbsSeq);
		} catch (Exception e) {
			logger.error("[FdBoardService] boardView Exception", e);
		}
		return count;
	}
	
	
	//공연일정 승인
	public int ctApprove(long fdBbsSeq)
	{
		int count = 0;
		
		try {
			count = fdBoardDao.ctApprove(fdBbsSeq);
		} catch (Exception e) {
			logger.error("[FdBoardService] ctApprove Exception", e);
		}
		return count;
	}
	
	
	


}
