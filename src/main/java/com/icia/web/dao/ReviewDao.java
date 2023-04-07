package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Review;
import com.icia.web.model.ReviewReply;


@Repository("reviewDao")
public interface ReviewDao 
{
	//게시물 등록
	public int rvBoardInsert(Review review);
	
	//게시물 총 수
	public long boardListCount(Review board);
	
	//게시물 리스트
	public List<Review> boardList(Review review);
	
	//게시물 조회
	public Review boardSelect(long rvSeq);
	
	//게시물 조회수 증가
	public int boardReadCntPlus(long rvSeq);
	
	//게시물 삭제
	public int boardDelete(long rvSeq);
	
	//게시물 수정
	public int boardUpdate(Review review);
	
	//게시물 첨부파일 조회
	public Review boardFileSelect(long rvSeq);
	
	//게시물 첨부파일 삭제
	public int boardFileDelete(long rvSeq);
	
	//댓글 작성
	public int rvReplyInsert(ReviewReply reviewReply);
	
	//댓글 리스트
	public List<ReviewReply> replyList(ReviewReply reviewReply);

	//댓글 조회
	public ReviewReply replySelect(long rvReplySeq);

	//댓글 삭제
	public int replyDelete(long rvReplySeq);

	//인기글 목록
	public List<Review> bestList(Review review);
	
	//종현이 추가
	public List<Review> boardList1(String userId);
	
}
