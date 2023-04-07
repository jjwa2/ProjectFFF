package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.NtBoard;

@Repository("ntBoardDao")
public interface NtBoardDao {
	
	//게시물 리스트
	public List<NtBoard> boardList(NtBoard ntBoard);
	
	//게시물 조회
	public NtBoard boardSelect(long ntBbsSeq);
	
	public int boardGroupOrderUpdate(NtBoard ntBoard);
	
	//게시물 총 수
	public long boardListCount(NtBoard ntBoard);

	//게시글 작성
	public int boardInsert(NtBoard ntBoard);

	//게시글 수정
	public int boardUpdate(NtBoard ntBoard);
	
	//게시물 첨부파일 조회
	public NtBoard boardFileSelect(long ntBbsSeq);

	//게시물 삭제 
	public int boardDelete(long ntBbsSeq);
}
