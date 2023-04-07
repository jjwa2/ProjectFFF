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
import com.icia.web.dao.NtBoardDao;
import com.icia.web.dao.NtBoardDao;
import com.icia.web.model.NtBoard;
import com.icia.web.model.Review;
import com.icia.web.model.NtBoard;



@Service("ntBoardService")
public class NtBoardService 
{
	private static Logger logger = LoggerFactory.getLogger(NtBoardService.class);

	@Autowired
	private NtBoardDao ntBoardDao;
	
	
	public int boardInsert(NtBoard ntBoard)
	{	
		int count = ntBoardDao.boardInsert(ntBoard);
		
		return count;
	}
	
	//게시글 총 리스트(수)
	public long boardListCount(NtBoard ntBoard)
	{
		long count = 0;
		
		try
		{
			count = ntBoardDao.boardListCount(ntBoard);
		}
		catch(Exception e)
		{
			logger.error("[NtBoardService]boardListCount Exception", e);
		}
		
		return count;
	}
	
	//사이트 공지사항 리스트
	public List<NtBoard> boardList(NtBoard ntBoard)
	{
		List<NtBoard> list = null;
		
		try
		{
			list = ntBoardDao.boardList(ntBoard);
		}
		catch(Exception e)
		{
			logger.error("[NtBoardService] boardList Exception", e);
		}
		
		return list;
	}
	
	//공지사항 게시물 상세 페이지
	public NtBoard ntboardView(long ntBbsSeq)
	{
		NtBoard ntBoard = null;
		
		try 
		{
			ntBoard = ntBoardDao.boardSelect(ntBbsSeq);
		} 
		catch (Exception e) 
		{
			logger.error("[NtBoardService] ntboardView Exception", e);
		}
		
		return ntBoard;
	}
	
	//게시물 조회
	public NtBoard boardSelect(long ntBbsSeq)
	{
		NtBoard ntBoard = null;
		
		try {
			ntBoard = ntBoardDao.boardSelect(ntBbsSeq);
			
		} catch (Exception e) {
			// TODO: handle exception
			
			logger.error("[NtBoardService] boardSelect Exception", e);
		}
		
		return ntBoard;
	}
	
	//공지사항 게시글 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(NtBoard ntBoard) throws Exception
	{
		int count = ntBoardDao.boardUpdate(ntBoard);
		
		return count;
	}

	public NtBoard boardSelectView(long ntBbsSeq) 
	{
		NtBoard ntBoard = null;
		
		try
		{
			ntBoard = ntBoardDao.boardSelect(ntBbsSeq);
			
			if(ntBoard != null)
			{
				NtBoard ntFile = ntBoardDao.boardFileSelect(ntBbsSeq);
				
				if(ntFile != null)
				{
					ntBoard.setNtFileSeq(ntFile.getNtFileSeq());
					ntBoard.setNtFileName(ntFile.getNtFileName());
					ntBoard.setNtFileOrgName(ntFile.getNtFileOrgName());
					ntBoard.setNtFileExt(ntFile.getNtFileExt());
					ntBoard.setNtFileSize(ntFile.getNtFileSize());
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[NtBoardService]boardSelectView Exception", e);
		}
		
		return ntBoard;
	}
	
	//게시물 삭제(첨부파일 삭제 미포함)
		public int boardDelete(long ntBbsSeq) {
			
			int count=0;
			
			NtBoard ntBoard = ntBoardDao.boardSelect(ntBbsSeq);
			
			
			if(ntBoard!=null) {
				
				count=ntBoardDao.boardDelete(ntBbsSeq);
				
				
				}
			
			return count;
		}
}
