package com.icia.web.model;

import java.io.Serializable;

public class Review implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long rvSeq;
	private String rvTitle;
	private String rvContent;
	private String regDate;
	private int readCnt;
	private int likeCnt;
	
	private String rvFileOrgName;
	private String rvFileName;
	private String rvFileExt;
	private long rvFileSize;
	private int rvFileSeq;
	
	private String userId;	
	
	private long startRow;
	private long endRow;
	
	private String searchType;	
	private String searchValue;
	
	private int rvReplyCount;
	
	public Review() 
	{
		rvSeq = 0;
		rvTitle = "";
		rvContent = "";
		regDate = "";
		readCnt = 0;
		likeCnt = 0;
		rvFileOrgName = "";
		rvFileName = "";
		rvFileExt = "";
		rvFileSize = 0;
		rvFileSeq = 0;
		
		userId = "";
		
		startRow = 0;
		endRow = 0;
		
		searchType = "";
		searchValue = "";
		
		rvReplyCount = 0;
	}

	
	
	
	public int getRvReplyCount() {
		return rvReplyCount;
	}




	public void setRvReplyCount(int rvReplyCount) {
		this.rvReplyCount = rvReplyCount;
	}




	public long getRvSeq() {
		return rvSeq;
	}

	public void setRvSeq(long rvSeq) {
		this.rvSeq = rvSeq;
	}

	public String getRvTitle() {
		return rvTitle;
	}

	public void setRvTitle(String rvTitle) {
		this.rvTitle = rvTitle;
	}

	public String getRvContent() {
		return rvContent;
	}

	public void setRvContent(String rvContent) {
		this.rvContent = rvContent;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public String getRvFileOrgName() {
		return rvFileOrgName;
	}

	public void setRvFileOrgName(String rvFileOrgName) {
		this.rvFileOrgName = rvFileOrgName;
	}

	public String getRvFileName() {
		return rvFileName;
	}

	public void setRvFileName(String rvFileName) {
		this.rvFileName = rvFileName;
	}

	public String getRvFileExt() {
		return rvFileExt;
	}

	public void setRvFileExt(String rvFileExt) {
		this.rvFileExt = rvFileExt;
	}

	public long getRvFileSize() {
		return rvFileSize;
	}

	public void setRvFileSize(long rvFileSize) {
		this.rvFileSize = rvFileSize;
	}

	public int getRvFileSeq() {
		return rvFileSeq;
	}

	public void setRvFileSeq(int rvFileSeq) {
		this.rvFileSeq = rvFileSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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
