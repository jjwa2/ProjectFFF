package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Qna;
import com.icia.web.model.QnaReply;

@Repository("qnaDao")
public interface QnaDao {
	//게시글 등록
	public int boardInsert(Qna qna);
	
	//게시물 총 수
	public long boardListCount(Qna qna);
	
	//게시물 리스트
	public List<Qna> boardList(Qna qna);
	
	//게시물 조회
	public Qna boardSelect(long qnaBbsSeq);
	
	//게시물 조회수 증가
	public int boardReadCntPlus(long qnaBbsSeq);
	
	//게시물 수정
	public int boardUpdate(Qna qna);
	
	//게시물 삭제
	public int boardDelete(long qnaBbsSeq);
	
	//게시물 댓글 작성
	public int boardReplyInsert(QnaReply qnaReply);
	
	//게시물 삭제시 답글 수 조회  --추후 삭제
	public int boardAnswersCount(long qnaBbsSeq);
	
	//게시물 그룹 순서 변경  -- 추후 삭제
	public int boardGroupOrderUpdate(Qna qna);
	
	//댓글 삭제
	public int replyDelete(long qnaReplySeq);
	
	//댓글 조회
	public QnaReply replySelect(long qnaReplySeq);
	
	//댓글 리스트
	public List<QnaReply> replyList(QnaReply qnaReply);
	
	//댓글 상태
	public long replyStateUpdate (long qnaBbsSeq);

	
}
