package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.CtBoard;
import com.icia.web.model.CtPm;
import com.icia.web.model.Review;
import com.icia.web.model.SnsBoard;

@Repository("ctBoardDao")
public interface CtBoardDao {
	

	//게시물 등록
	public int ctBoardInsert(CtBoard ctBoard);
	
	//게시물 총 수
	public long boardListCount(CtBoard ctBoard);

	//게시물 리스트
	public List<CtBoard> boardList(CtBoard ctBoard);
	
	//게시물 조회
	public CtBoard boardSelect(long fdBbsSeq);
		
	//게시물 그룹 수정
	public int boardGroupOrderUpdate(CtBoard ctBoard);
	
	//게시물 수정
	public int boardUpdate(CtBoard ctBoard);
	
	//게시물 삭제
	public int boardDelete(long ctBbsSeq);
	
	//게시물 첨부파일 조회
	public CtBoard boardFileSelect(long ctBbsSeq);
	
	//캐러셀 랜덤 이미지
	public List<CtBoard> randomSelect();
	
	//예매 정보 인설트
	public int ctPaymentInsert(CtPm ctPm);
	//예메 정보 조회
	
	public CtPm ctPmSelect(String paymentNum);
	
	public List<CtBoard> ctWaitList();
	
	//게시물 조회 2
	public CtBoard boardSelectBbsSeq(long ctBbsSeq);
}
