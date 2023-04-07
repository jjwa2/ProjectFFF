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
import com.icia.web.dao.FdBoardDao;
import com.icia.web.model.FdBoard;
import com.icia.web.model.FdPm;
import com.icia.web.model.FdTier;
import com.icia.web.model.SnsBoard;

@Service("fdBoardService")

public class FdBoardService {
	private static Logger logger = LoggerFactory.getLogger(FdBoardService.class);

	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	@Autowired
	private FdBoardDao fdBoardDao;


	//티어별 해당 티어 가져오는 서비스 0309 배정현
	public FdTier tierView(long fdBbsSeq, int tierNum) {

			FdTier fdTier = null;
		try {
			fdTier = fdBoardDao.tierSelect(fdBbsSeq);

		} catch (Exception e) {

			logger.error("[FdBoardService] boardView Exception", e);
		}
		return fdTier;
	}
	
	
	//현재 금액 후원된 금액 카운트 (후원이 완료되면 해당 티어 금액 만큼 update) 0309 배정현
	public int currentAmountUpdate(long fdBbsSeq, int tierNum)
	{
		int count = 0;
		try {
			count = fdBoardDao.currentAmountUpdate(fdBbsSeq, tierNum);
		}
		catch (Exception e) {
			logger.error("[fdBoardService] currentAmountUpdate Exception", e);
		}
		return count;
		
	}
	
	//펀딩내역불러오기 0309 배정현
	public List<FdPm> fdPmList(String userId)
	{
		
		List<FdPm> fdPm = null;
		
		try 
		{
			fdPm = fdBoardDao.fdPmList(userId);
		}
		catch(Exception e)
		{
			logger.error("[fdBoardService] pmSelect Exception", e);
		}
		
		return fdPm;
	}
	
	//펀딩 상세 페이지 표시 0309 배정현
	public FdBoard boardSelect(long fdBbsSeq) {
		FdBoard fdBoard = null;

		try {

			fdBoard = fdBoardDao.boardSelect(fdBbsSeq);

		} catch (Exception e) {

			logger.error("[FdBoardService] boardView Exception", e);

		}
		return fdBoard;
	}
	
	
	//결제 하는 서비스 0309 배정현
		@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class )
		public int fdPaymentInsert(FdPm fdPm, long price)
		{
			int count =0;
			long fdBbsSeq = fdPm.getFdBbsSeq();
			logger.debug("서비스 BbsSeq값입니다."+fdBbsSeq);
			try {
				count = fdBoardDao.fdPaymentInsert(fdPm);
				count = fdBoardDao.tierCnt(fdBbsSeq);
				count = fdBoardDao.currentAmountUpdate(fdBbsSeq,price);
			} catch (Exception e) {
				logger.error("[fdBoardService] fdPaymentInsert Exception", e);
			}
			return count;
			
		}
		
		public FdTier tierSelect(long fdBbsSeq)
		{
			FdTier fdTier = new FdTier();
			try {
				fdTier = fdBoardDao.tierSelect(fdBbsSeq);
			} catch (Exception e) {
				logger.error("[FdBoardService] tierSelect Exception", e);
			}
			
			return fdTier;
		}
	
		//배정현 추가 0308
		//펀딩 결제 정보 셀렉트 서비스
		public FdPm fdPmSelect(String paymentNum)
		{
			FdPm fdPm = new FdPm();
			
			if(paymentNum != null)
			{
				try {
					fdPm = fdBoardDao.fdPmSelect(paymentNum);
					
				} catch (Exception e) {
					logger.error("[FdBoardService] fdPmSelect Exception", e);
				}
			}
			return fdPm;
		}
	
		
		
		
		
		
		
		
	
	
	
	
	//박재영 추가0307
	//펀딩게시글 인서트 서비스
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int fdBoardInsert(FdBoard fdBoard)throws Exception
	{
		int count = fdBoardDao.fdBoardInsert(fdBoard);
		
		if(count > 0 && fdBoard.getFdTier() != null)
		{

			fdBoardDao.fdTierInsert(fdBoard.getFdTier());
		}
		
		return count;
	}

	//박재영 추가0308
	//펀딩 목록 총 숫자 구하기
	public long fundListCount(FdBoard fdBoard)
	{
		long count = 0;
		
		try
		{
			count = fdBoardDao.fundListCount(fdBoard);
		}
		catch(Exception e)
		{
			logger.error("[FdBoardService] fundListCount Exception", e);
		}
		
		return count;
	}
	
	
	//박재영 추가0308
	//펀딩 리스트 출력
	//게시물 리스트
	public List<FdBoard> fundboardList(FdBoard fdBoard)
	{
		List<FdBoard> list = null;
		
		try
		{
			logger.debug("서비스쪽 카테고리 출력1"+ fdBoard.getCategolyValue());
			list = fdBoardDao.fundboardList(fdBoard);
		}
		catch(Exception e)
		{
			logger.error("[FdBoardService] fundboardList Exception", e);
		}
		
		return list;
	}
	
	
	//메인페이지 뿌릴 시퀀스 제일 높은 2개
	public List<FdBoard> fdCorrentSelect()
	{
		List<FdBoard> list = null;
		
		try
		{
			list = fdBoardDao.fdCorrentSelect();
		}
		catch(Exception e)
		{
			logger.error("[FdBoardService] fdCorrentSelect Exception", e);
		}
		
		return list;
	}
	
	
	public List<FdBoard> fdRecommendSelect()
	{
		List<FdBoard> listt = null;
		
		try
		{
			listt = fdBoardDao.fdRecommendSelect();
		}
		catch(Exception e)
		{
			logger.error("[FdBoardService] fdRecommendSelect Exception", e);
		}
		
		return listt;
	}
	
	
	public void fdSatatusUpdate(long fdBbsSeq)
	{
		
		try
		{
			fdBoardDao.fdSatatusUpdate(fdBbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[FdBoardService] fdSatatusUpdate Exception", e);
		}
		
	}
	
	
	
	
	/**
	 * 패키지명   : com.icia.web.service
	 * 파일명     : FdBoardService.java
	 * 작성일     : 2023. 03. 20.
	 * 작성자     : 박재윤
	 * 설명       : FdBoardController 연결
	 */
	public FdBoard artistMypageFdSelect(String userId)
	{
		FdBoard fdBoard = null;
		
		try 
		{
			fdBoard = fdBoardDao.artistMypageFdSelect(userId);
			
			if(fdBoard == null)
			{
				fdBoard = new FdBoard();
			}
			
		} 
		catch (Exception e) 
		{
			logger.error("[FdBoardService] artistMypageFdSelect Exception", e);
		}
		
		return fdBoard;
	}
	

}
