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

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.SnsDao;
import com.icia.web.model.ReviewReply;
import com.icia.web.model.SnsBoard;
import com.icia.web.model.SnsReply;


@Service("snsService")
public class SnsService
{
	private static Logger logger = LoggerFactory.getLogger(SnsService.class);

	@Autowired
	private SnsDao snsDao;
	
	
	//게시물 등록
	public int snsBoardInsert(SnsBoard snsBoard)
	{
		int count = 0;
		
		try
		{
			count = snsDao.snsBoardInsert(snsBoard);
		}
		catch(Exception e)
		{
			logger.error("[SnsService] snsBoardInsert Exception", e);
		}
		
		return count;
	};
	
	
	//회원아이디로 총 게시물 숫자 구하기
	public long snsListCount(String userId)
	{
		long count = 0;
		
		try
		{
			count = snsDao.snsListCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[SnsService]boardListCount Exception", e);
		}
		
		return count;
	}
	
	//특정 아이디로 조회 후 해당 아이디 게시물 불러오기
	public List<SnsBoard> snsBoardList(String userId)
	{
		List<SnsBoard> list = null;
		
		try
		{
			list = snsDao.snsBoardList(userId);
		}
		catch(Exception e)
		{
			logger.error("[SnsService]snsBoardList Exception", e);
		}
		
		return list;
	};
	
	//특정아이디로 게시물 불러오기
	public SnsBoard snsSelect(long snsSeq)
	{
		SnsBoard list = null;
		
		try
		{
			list = snsDao.snsSelect(snsSeq);
		}
		catch(Exception e)
		{
			logger.error("[SnsService]snsSelect Exception", e);
		}
		
		return list;
	};

	//게시물 삭제
	public int snsDelete(long snsSeq)
	{
		int count = 0;
		
		try
		{
			count = snsDao.snsDelete(snsSeq);
		}
		catch(Exception e)
		{
			logger.error("[SnsService]snsDelete Exception", e);
		}
		
		return count;
	};
	

	
	//첨부파일을 DB에서 불러오는 기능
	public SnsBoard getSnsFile(int snsSeq)
	{
		SnsBoard snsBoard = null;
		
		try
		{
			
		}
		catch(Exception e)
		{
			
		}
		
		return snsBoard;
	};
	
	//회원 탈퇴 시 유저의 게시물 삭제(?)
	public int userAllDelete(String userId)
	{
		int count = 0;
		
		try
		{
			
		}
		catch(Exception e)
		{
			
		}
		
		return count;
	};
	
	//댓글 작성
	public int snsReplyInsert(SnsReply snsReply)
	{
		int count = snsDao.snsReplyInsert(snsReply);
		
		return count;
	}
	
	public SnsReply replySelect(long snsReplySeq)
	{
		SnsReply sns = null;
		
		try
		{
			sns = snsDao.replySelect(snsReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[SnsService]replySelect Exception", e);
		}
		
		return sns;
	};
	
	public int replyDelete(long snsReplySeq)
	{
		int count = 0;
		
		try
		{
			count = snsDao.replyDelete(snsReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[SnsService]replyDelete Exception", e);
		}
		
		return count;
	};
	

}
