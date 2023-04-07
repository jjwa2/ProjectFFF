package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class SnsBoard implements Serializable{
	
	private static final long serialVersionUID = 1L;


	private long snsSeq;		
	private String userId;	
	private String snsContent;
	private String snsCategory;	
	private String snsDate;	

	private String snsFileOrgName;		
	private String snsFileName;		
	private String snsFileExt;			
	private long snsFileSize;		
	
	private long startRow;		//시작row	
	private long endRow; 		//끝row
	
	private String userCategoly;
	private String userIntroduce;
	
	private String fileProfileName;
	
	public SnsBoard()
	{
		snsSeq = 0;		
		userId = "";	
		snsContent = "";
		snsCategory = "";	
		snsDate = "";
		
		snsFileOrgName = "";	
		snsFileName = "";		
		snsFileExt = "";			
		snsFileSize = 0;	
		
		startRow = 0;
		endRow = 0;
		
		userCategoly = "";
		userIntroduce = "";
		
		fileProfileName = "";
	}

	
	








	public String getUserCategoly() {
		return userCategoly;
	}






	public void setUserCategoly(String userCategoly) {
		this.userCategoly = userCategoly;
	}






	public String getUserIntroduce() {
		return userIntroduce;
	}






	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}






	public String getFileProfileName() {
		return fileProfileName;
	}






	public void setFileProfileName(String fileProfileName) {
		this.fileProfileName = fileProfileName;
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




	public long getSnsSeq() {
		return snsSeq;
	}


	public void setSnsSeq(long snsSeq) {
		this.snsSeq = snsSeq;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getSnsContent() {
		return snsContent;
	}


	public void setSnsContent(String snsContent) {
		this.snsContent = snsContent;
	}


	public String getSnsCategory() {
		return snsCategory;
	}


	public void setSnsCategory(String snsCategory) {
		this.snsCategory = snsCategory;
	}


	public String getSnsDate() {
		return snsDate;
	}


	public void setSnsDate(String snsDate) {
		this.snsDate = snsDate;
	}


	public String getSnsFileOrgName() {
		return snsFileOrgName;
	}


	public void setSnsFileOrgName(String snsFileOrgName) {
		this.snsFileOrgName = snsFileOrgName;
	}


	public String getSnsFileName() {
		return snsFileName;
	}


	public void setSnsFileName(String snsFileName) {
		this.snsFileName = snsFileName;
	}


	public String getSnsFileExt() {
		return snsFileExt;
	}


	public void setSnsFileExt(String snsFileExt) {
		this.snsFileExt = snsFileExt;
	}


	public long getSnsFileSize() {
		return snsFileSize;
	}


	public void setSnsFileSize(long snsFileSize) {
		this.snsFileSize = snsFileSize;
	}

}
