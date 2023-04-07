package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.web.dao.ReviewDao;
import com.icia.web.model.Review;
import com.icia.web.model.ReviewReply;

@Service("reviewService")
public class ReviewService 
{
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	
	//파일 저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private ReviewDao reviewDao;
	
	public int rvBoardInsert(Review review)
	{
		int count = reviewDao.rvBoardInsert(review);
		
		return count;
	}
	
	//게사물 총 수 
	public long boardListCount(Review review)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.boardListCount(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]boardListCount Exception", e);
		}
		
		
		return count;
	}
	
	//게시물 리스트
	public List<Review> boardList(Review review)
	{
		List<Review> list = null;
		
		try
		{
			list = reviewDao.boardList(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]boardList Exception", e);
		}
		
		return list;
	}
	
	//인기글 리스트
	public List<Review> bestList(Review review)
	{
		List<Review> bestList = null;
		
		try
		{
			bestList = reviewDao.bestList(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]bestList Exception", e);
		}
		
		return bestList;
	}
	
	//게시물 보기
	public Review boardView(long rvSeq)
	{
		Review review = null;
		
		try
		{
			review = reviewDao.boardSelect(rvSeq);
			
			if(review != null)
			{
				//조회수 증가
				reviewDao.boardReadCntPlus(rvSeq);
			}
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]boardView Exception", e);
		}
		
		return review;
	}
	
	//게시물 조회
	public Review boardSelect(long rvSeq)
	{
		Review review = null;
		
		try
		{
			review = reviewDao.boardSelect(rvSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]boardSelect Exception", e);
		}
		
		return review;
	}
	
	//게시물 삭제
	public int boardDelete(long rvSeq)
	{
		int count = 0;
		
		Review review = reviewDao.boardSelect(rvSeq);
		
		if(review != null)
		{
			count = reviewDao.boardDelete(rvSeq);
			
			if(count > 0)
			{
				FileUtil.deleteFile(UPLOAD_SAVE_DIR +  FileUtil.getFileSeparator()
				+ review.getRvFileName());
				
				logger.debug("service ###################################################");
				logger.debug("UPLOAD_SAVE_DIR : " + UPLOAD_SAVE_DIR);
				logger.debug("FileUtil.getFileSeparator() : " + FileUtil.getFileSeparator());
				logger.debug("review.getRvFileName() : " + review.getRvFileName());
				logger.debug("service ###################################################");
			}
		}
		
		return count;
	}
	
	//게시물 보기 수정페이지
	public Review boardSelectView(long rvSeq)
	{
		Review review = null;
		
		try
		{
			review = reviewDao.boardSelect(rvSeq);
			
			if(review != null)
			{
				Review rvFile = reviewDao.boardFileSelect(rvSeq);
				
				if(rvFile != null)
				{
					review.setRvFileSeq(rvFile.getRvFileSeq());
					review.setRvFileName(rvFile.getRvFileName());
					review.setRvFileOrgName(rvFile.getRvFileOrgName());
					review.setRvFileExt(rvFile.getRvFileExt());
					review.setRvFileSize(rvFile.getRvFileSize());
				}
			}
			
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]boardSelectView Exception", e);
		}
		
		return review;
	}
	
	//게시물 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(Review review) throws Exception
	{
		int count = reviewDao.boardUpdate(review);
		
		return count;
	}
	
	//댓글 작성
	public int rvReplyInsert(ReviewReply reviewReply)
	{
		int count = reviewDao.rvReplyInsert(reviewReply);
		
		return count;
	}
	
	//댓글 목록
	public List<ReviewReply> replyList(ReviewReply reviewReply)
	{
		List<ReviewReply> replyList = null;
		
		try
		{
			replyList = reviewDao.replyList(reviewReply);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]replyList Exception", e);
		}
		
		return replyList;
	}

	//댓글 조회
	public ReviewReply replySelect(long rvReplySeq)
	{
		ReviewReply reviewReply = null;
		
		try
		{
			reviewReply = reviewDao.replySelect(rvReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]replySelect Exception", e);
		}
		return reviewReply;
	}

	
	//댓글 삭제
	public int replyDelete(long rvReplySeq)
	{
		int count = 0;
		
		ReviewReply reviewReply = reviewDao.replySelect(rvReplySeq);
		
		if(reviewReply != null)
		{
			count = reviewDao.replyDelete(rvReplySeq);
		}
		
		return count;
	}
	
	
	//게시물 데이터 불러오기
	public List<Review> boardList1(String userId)
	{
		List<Review> list = null;
		
		try
		{
			list = reviewDao.boardList1(userId);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService]boardList1 Exception", e);
		}
		
		return list;
	}
	
	
}






