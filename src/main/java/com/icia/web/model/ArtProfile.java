package com.icia.web.model;

import java.io.Serializable;

public class ArtProfile implements Serializable{

	private static final long serialVersionUID = 1L;

	private String userId;
	
	// 파일 저장 경로
	private String filePath;
	
	private long fileSize;
	private String fileExt;
	private String fileDate;
	private String fileProfileName;
	
	
	public ArtProfile()
	{
		userId = "";
		
		filePath = "";
		
		fileSize = 0;
		fileExt = "";
		fileDate = "";
		fileProfileName = "";
	}

	
	
	public String getFilePath() {
		return filePath;
	}



	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}






	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}



	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public String getFileDate() {
		return fileDate;
	}

	public void setFileDate(String fileDate) {
		this.fileDate = fileDate;
	}

	public String getFileProfileName() {
		return fileProfileName;
	}

	public void setFileProfileName(String fileProfileName) {
		this.fileProfileName = fileProfileName;
	}
}
