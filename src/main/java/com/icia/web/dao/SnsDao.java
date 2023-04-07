
package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.ReviewReply;
import com.icia.web.model.SnsBoard;
import com.icia.web.model.SnsReply;


@Repository("snsDao")
public interface SnsDao
{
	//게시물 등록
	public int snsBoardInsert(SnsBoard snsBoard);
	
	//특정 아이디로 총 게시물 숫자 구하기
	public long snsListCount(String userId);
	
	//특정 아이디로 조회 후 해당 아이디 게시물 불러오기
	public List<SnsBoard> snsBoardList(String userId);
	
	//특정아이디로 게시물 내용 구하기
	public SnsBoard snsSelect(long snsSeq);
	
	//게시글 삭제하기
	public int snsDelete(long snsSeq);
	
	//댓글 작성
	public int snsReplyInsert(SnsReply snsReply);
	
	//댓글 리스트
	public List<SnsReply> snsreplyList(long snsSeq);
	
	//댓글 찾기(1개)
	public SnsReply replySelect(long snsReplySeq);
	
	public int replyDelete(long snsReplySeq);
	
}




