package com.icia.web.model;

import java.io.Serializable;

public class Qna implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long qnaBbsSeq;		//문의글 번호
	private String userId;		//아이디
	private String qnaBbsTitle;	//문의글 제목
	private String qnaBbsContent;
	private String qnaRegDate;
	private int qnaBbsReadCnt;	//문의글 조회수
	private String qnaBbsAnswerState;
	private String qnaBbsSecret;
	private int qnaBbsIndent;
	private long qnaBbsParent;
	private int qnaBbsOrder;
	private long qnaBbsGroup;
	
	private String userName;		//추후에 admin?
	
	private long startRow;	//시작 rownum
	private long endRow;	//끝 rownum
	
	private String searchType;	//검색타입(1.작성자 2.제목 3.내용)
	private String searchValue;	//검색 값
	
	public Qna()
	{
		qnaBbsSeq = 0;
		userId = "";
		qnaBbsTitle = "";
		qnaBbsContent = "";
		qnaRegDate = "";
		qnaBbsReadCnt = 0;
		qnaBbsAnswerState = "N";
		qnaBbsSecret = "";
		qnaBbsIndent = 0;
		qnaBbsParent = 0;
		qnaBbsOrder = 0;
		qnaBbsGroup = 0;
		
		userName = "";		//추후에 admin?
		
		startRow = 0;	//시작 rownum
		endRow = 0;	//끝 rownum
		
		searchType = "";	//검색타입(1.작성자 2.제목 3.내용)
		searchValue = "";	//검색 값
	}

	

	public long getQnaBbsSeq() {
		return qnaBbsSeq;
	}



	public void setQnaBbsSeq(long qnaBbsSeq) {
		this.qnaBbsSeq = qnaBbsSeq;
	}



	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getQnaBbsTitle() {
		return qnaBbsTitle;
	}

	public void setQnaBbsTitle(String qnaBbsTitle) {
		this.qnaBbsTitle = qnaBbsTitle;
	}

	public String getQnaBbsContent() {
		return qnaBbsContent;
	}

	public void setQnaBbsContent(String qnaBbsContent) {
		this.qnaBbsContent = qnaBbsContent;
	}

	public String getQnaRegDate() {
		return qnaRegDate;
	}

	public void setQnaRegDate(String qnaRegDate) {
		this.qnaRegDate = qnaRegDate;
	}

	public int getQnaBbsReadCnt() {
		return qnaBbsReadCnt;
	}

	public void setQnaBbsReadCnt(int qnaBbsReadCnt) {
		this.qnaBbsReadCnt = qnaBbsReadCnt;
	}

	public String getQnaBbsAnswerState() {
		return qnaBbsAnswerState;
	}

	public void setQnaBbsAnswerState(String qnaBbsAnswerState) {
		this.qnaBbsAnswerState = qnaBbsAnswerState;
	}

	public String getQnaBbsSecret() {
		return qnaBbsSecret;
	}

	public void setQnaBbsSecret(String qnaBbsSecret) {
		this.qnaBbsSecret = qnaBbsSecret;
	}

	public int getQnaBbsIndent() {
		return qnaBbsIndent;
	}

	public void setQnaBbsIndent(int qnaBbsIndent) {
		this.qnaBbsIndent = qnaBbsIndent;
	}

	public long getQnaBbsParent() {
		return qnaBbsParent;
	}

	public void setQnaBbsParent(long qnaBbsParent) {
		this.qnaBbsParent = qnaBbsParent;
	}

	public int getQnaBbsOrder() {
		return qnaBbsOrder;
	}

	public void setQnaBbsOrder(int qnaBbsOrder) {
		this.qnaBbsOrder = qnaBbsOrder;
	}

	public long getQnaBbsGroup() {
		return qnaBbsGroup;
	}

	public void setQnaBbsGroup(long qnaBbsGroup) {
		this.qnaBbsGroup = qnaBbsGroup;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
	

}
