package com.icia.web.model;

import java.io.Serializable;

/**
 * @author USER
 *
 */
public class NtBoard implements Serializable{
	
	private static final long serialVersionUID = 1L;


	private long ntBbsSeq;		//게시물번호
	private String userId;		//관리자아이디
	private int userLevel;	
	private String ntBbsTitle;	//게시물 제목
	private String ntBbsContent;//게시물 내용
	private String ntRegDate;	//게시물 등록일
	
	private int ntFileSeq;
	private String ntFileOrgName;
	private String ntFileName;
	private String ntFileExt;
	private long ntFileSize;
	
	private long startRow;		//시작row	
	private long endRow; 		//끝row
	
	
	public NtBoard()
	{
		ntBbsSeq= 0;		
		userId = "";	
		userLevel = 0;
		ntBbsTitle= "";	
		ntBbsContent= "";
		ntRegDate= "";	
		
		startRow= 0;		
		endRow= 0; 	
		
		ntFileSeq = 0;
		ntFileOrgName = "";
		ntFileName = "";
		ntFileExt = "";
		ntFileSize = 0;
		
	}

	

	public int getUserLevel() {
		return userLevel;
	}



	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}



	public long getNtBbsSeq() {
		return ntBbsSeq;
	}


	public void setNtBbsSeq(long ntBbsSeq) {
		this.ntBbsSeq = ntBbsSeq;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getNtBbsTitle() {
		return ntBbsTitle;
	}


	public void setNtBbsTitle(String ntBbsTitle) {
		this.ntBbsTitle = ntBbsTitle;
	}


	public String getNtBbsContent() {
		return ntBbsContent;
	}


	public void setNtBbsContent(String ntBbsContent) {
		this.ntBbsContent = ntBbsContent;
	}


	public String getNtRegDate() {
		return ntRegDate;
	}


	public void setNtRegDate(String ntRegDate) {
		this.ntRegDate = ntRegDate;
	}


	public int getNtFileSeq() {
		return ntFileSeq;
	}


	public void setNtFileSeq(int ntFileSeq) {
		this.ntFileSeq = ntFileSeq;
	}


	public String getNtFileOrgName() {
		return ntFileOrgName;
	}


	public void setNtFileOrgName(String ntFileOrgName) {
		this.ntFileOrgName = ntFileOrgName;
	}


	public String getNtFileName() {
		return ntFileName;
	}


	public void setNtFileName(String ntFileName) {
		this.ntFileName = ntFileName;
	}


	public String getNtFileExt() {
		return ntFileExt;
	}


	public void setNtFileExt(String ntFileExt) {
		this.ntFileExt = ntFileExt;
	}


	public long getNtFileSize() {
		return ntFileSize;
	}


	public void setNtFileSize(long ntFileSize) {
		this.ntFileSize = ntFileSize;
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

	
	
	
}
