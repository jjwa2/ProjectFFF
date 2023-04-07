package com.icia.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.icia.web.model.FdBoard;
import com.icia.web.model.FdPm;
import com.icia.web.model.FdTier;
import com.icia.web.model.SnsBoard;

@Repository("fbBoardDao")
public interface FdBoardDao {

	public FdBoard boardSelect(long fdBbsSeq);

	public FdTier tierSelect(long fdBbsSeq);

	public int fdBoardInsert(FdBoard fdBoard);
	
	public int fdTierInsert(FdTier fdTier);
	
	public List<FdPm> fdPmList (String userId);
	
	public int tierCnt(long fdBbsSeq);

	public int currentAmountUpdate(@Param("fdBbsSeq")long fdBbsSeq, @Param("price")long price);
	
	public int fdPaymentInsert(FdPm fdPm);
	
	public long paymentNumSelect();

	public long fundListCount(FdBoard fdBoard);
	
	public List<FdBoard> fundboardList(FdBoard fdBoard);
	
	public FdPm fdPmSelect(String paymentNum);
	
	public List<FdBoard> fdCorrentSelect();
	
	public List<FdBoard> fdRecommendSelect();
	
	//23.03.20 박재윤 artistMypage 사용자 펀딩 정보 조회
	public FdBoard artistMypageFdSelect(String userId);
	
	public int fdApprove(long fdBbsSeq);
	
	public int ctApprove(long fdBbsSeq);
	
	public void fdSatatusUpdate(long fdBbsSeq);
}
