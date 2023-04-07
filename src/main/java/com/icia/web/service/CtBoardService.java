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
import com.icia.web.dao.CtBoardDao;
import com.icia.web.model.CtBoard;
import com.icia.web.model.Review;

@Service("ctBoardService")
public class CtBoardService 
{
	private static Logger logger = LoggerFactory.getLogger(CtBoardService.class);
	
	//파일 저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	//게시글 등록
		@Autowired
		private CtBoardDao ctBoardDao;
		
		
	//게시글 총 리스트(수)
	public long boardListCount(CtBoard ctBoard)
	{
		long count = 0;
		
		try
		{
			count = ctBoardDao.boardListCount(ctBoard);
		}
		catch(Exception e)
		{
			logger.error("[CtBoardService]boardListCount Exception", e);
		}
		
		return count;
	}
	
	//게시판 리스트(이미지 파일 목록 )
	public List<CtBoard> boardList(CtBoard ctBoard)
	{
		List<CtBoard> list = null;
		
		try
		{
			list = ctBoardDao.boardList(ctBoard);
		}
		catch(Exception e)
		{
			logger.error("[CtBoardService] boardList Exception", e);
		}
		
		return list;
	}
	
	//게시물 보기(일시,장소,시간..)
	public CtBoard boardView(long fdBbsSeq)
	{
		CtBoard ctBoard = null;
		
		try {
			
			ctBoard = ctBoardDao.boardSelect(fdBbsSeq);
			
			
			
		} catch (Exception e) {
		
			logger.error("[CtBoardService] ctboardView Exception", e);
		
		
		}
		
		return ctBoard;
	}
	
	//게시물 조회
	public CtBoard boardSelect(long ctBbsSeq)
	{
		CtBoard ctBoard = null;
		
		try {
			ctBoard = ctBoardDao.boardSelect(ctBbsSeq);
			
		} catch (Exception e) {
			
			
			logger.error("[CtBoardService] boardSelect Exception", e);
		}
		
		return ctBoard;
	}
	
	//게시글 등록
	public int ctBoardInsert(CtBoard ctBoard)
	{
		int count = 0;
		
		try
		{
			count = ctBoardDao.ctBoardInsert(ctBoard);
		}
		catch(Exception e)
		{
			logger.error("[CtBoardService] CtBoardInsert Exception", e);
		}
		
		return count;
	};
	
	//게시물 삭제
	public int boardDelete(long ctBbsSeq) throws Exception {
		
		int count=0;
		
		CtBoard ctBoard = ctBoardDao.boardSelect(ctBbsSeq);
		
		
		if(ctBoard!=null) {
			
			count=ctBoardDao.boardDelete(ctBbsSeq);
			
			
			}
		
		return count;
	}
	
	
	//게시물 보기 수정페이지
	public CtBoard boardSelectView(long ctBbsSeq)
	{
		CtBoard ctBoard = null;
		
		try
		{
			ctBoard =ctBoardDao.boardSelect(ctBbsSeq);
			
			if(ctBoard != null)
			{
				//객체 중복선언 오류.. CtBoard ctBoard = ctBoardDao.boardFileSelect(ctBbsSeq);
				
				
			}
			
		}
		catch(Exception e)
		{
			logger.error("[CtBoardService]boardSelectView Exception", e);
		}
		
		return ctBoard;
	}
	
	//게시물 수정 폼
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(CtBoard ctBoard) throws Exception
	{
		int count = ctBoardDao.boardUpdate(ctBoard);
		
		return count;
	}
	
	
	
	//캐러셀 랜덤 이미지
	public List<CtBoard> randomSelect()
	{
		List<CtBoard> randomList = null;
		
		try
		{
			randomList = ctBoardDao.randomSelect();
		}
		catch(Exception e)
		{
			logger.error("[CtBoardService] randomSelect Exception", e);
		}
		
		return randomList;
	}
	
	public List<CtBoard> ctWaitList()
	{
		List<CtBoard> ctBoard = null;
		
		try
		{
			ctBoard = ctBoardDao.ctWaitList();
		}
		catch(Exception e)
		{
			logger.error("[CtBoardService] ctWaitList Exception", e);
		}
		
		return ctBoard;
	}
	

	public CtBoard boardSelectBbsSeq(long ctBbsSeq)
	{
		CtBoard ctBoard = null;
		
		try {
			ctBoard = ctBoardDao.boardSelectBbsSeq(ctBbsSeq);
			
		} catch (Exception e) {
			
			
			logger.error("[CtBoardService] boardSelectBbsSeq Exception", e);
		}
		
		return ctBoard;
	}
	
}
