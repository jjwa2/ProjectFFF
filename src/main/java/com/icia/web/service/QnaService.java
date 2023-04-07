package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.QnaDao;
import com.icia.web.model.Qna;
import com.icia.web.model.QnaReply;
import com.icia.web.model.ReviewReply;

@Service("qnaService")
public class QnaService {
	private static Logger logger = LoggerFactory.getLogger(QnaService.class);
	
	@Autowired
	private QnaDao qnaDao;
	
	public int boardInsert(Qna qna)
	{
		int count = qnaDao.boardInsert(qna);
		
		return count;
	}
	
	//총 게시물 수
	public long boardListCount(Qna qna)
	{
		long count = 0;
		
		try
		{
			count = qnaDao.boardListCount(qna);
		}
		catch(Exception e)
		{
			logger.error("[qnaService]boardListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<Qna> boardList(Qna qna)
	{
		List<Qna> list = null;
		
		try
		{
			list = qnaDao.boardList(qna);
		}
		catch(Exception e)
		{
			logger.error("[QnaService] boardList Exception",e);
		}
		return list;
	}
	
	//게시물 보기
	public Qna boardView(long qnaBbsSeq)
	{
		Qna qna = null;
		
		try
		{
			qna = qnaDao.boardSelect(qnaBbsSeq);
			
			if(qna != null)
			{
				//조회수 증가
				qnaDao.boardReadCntPlus(qnaBbsSeq);
			}
		}
		catch(Exception e)
		{
			logger.error("[QnaService] boardView Exception",e);
		}
		
		return qna;
	}
	//게시물 조회
	public Qna boardSelect(long qnaBbsSeq)
	{
		Qna qna = null;
		
		try
		{
			qna = qnaDao.boardSelect(qnaBbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[qnaService] boardSelect Exception",e);
		}
		
		return qna;
	}
	
	
	//게시물 삭제
	public int boardDelete(long qnaBbsSeq) throws Exception
	{
		int count = 0;
		
		Qna qna = qnaDao.boardSelect(qnaBbsSeq);
		
		if(qna != null)
		{
			count = qnaDao.boardDelete(qnaBbsSeq);
		}
		
		return count;
	}
	
	//게시물 보기 수정 페이지
	public Qna boardSelectView(long qnaBbsSeq)
	{
		Qna qna = null;
		
		try
		{
			qna = qnaDao.boardSelect(qnaBbsSeq);
			
		}
		catch(Exception e)
		{
			logger.error("{QnaService boardSelectView Exception" , e);
		}
		return qna;
	}
	
	//게시물 수정
	
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int boardUpdate(Qna qna) throws Exception
		{
			int count = qnaDao.boardUpdate(qna);
			
			return count;
		}
	
	
	
	//댓글 작성
		public int boardReplyInsert(QnaReply qnaReply)
		{
			int count = qnaDao.boardReplyInsert(qnaReply);
			
			return count;
		}
		
	//댓글 목록
	public List<QnaReply> replyList(QnaReply qnaReply)
	{
		List<QnaReply> replyList = null;
		
		try
		{
			replyList = qnaDao.replyList(qnaReply);
		}
		catch(Exception e)
		{
			logger.error("[QnaService]replyList Exception", e);
		}
		return replyList;
	}
	
	
	//댓글 조회
	public QnaReply replySelect(long qnaReplySeq)
	{
		QnaReply qnaReply = null;
		
		try
		{
			qnaReply = qnaDao.replySelect(qnaReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[QnaService]replySelect Exception", e);
		}
		return qnaReply;
	}
	
	//댓글 삭제
		public int replyDelete(long qnaReplySeq)
		{
			int count = 0;
			
			QnaReply qnaReply = qnaDao.replySelect(qnaReplySeq);
			
			if(qnaReply != null)
			{
				count = qnaDao.replyDelete(qnaReplySeq);
				
				logger.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				logger.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				logger.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			}
			
			return count;
		}
		
		//댓글의 답변 상태
		public long replyStateUpdate (long qnaBbsSeq)
		{
			long count = 0;
			
			try {
				count = qnaDao.replyStateUpdate(qnaBbsSeq);
			}
			catch(Exception e)
			{
				logger.error("[QnaService]replyStateUpdate Exception", e);
			}
			
			return count;
		}
	
	
	
	
}
