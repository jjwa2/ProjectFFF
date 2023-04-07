package com.icia.web.model;

import java.io.Serializable;

public class FdBoard implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long fdBbsSeq;
	private String userId;
	private String fdBbsTitle;

	private int readCnt;
	private String regDate;
	private String fdStartDate;
	private String fdEndDate;
	private long targetPrice;
	private String ctDate;
	private String venuePlace;
	private String venuePlaceAdd;
	private String ctAge;
	private long capacity;
	private String fdStatus;
	private String fdStatus2;
	private String fdStatus3;
	private long currentAmount;
	
	private String fdFileOrgName;		
	private String fdFileName;	
	private String fdFile2OrgName;		
	private String fdFile2Name;
	private String fdFileExt;			
	private long fdFileSize;		
	
	private FdTier fdTier; 
	
	private long startRow;		//시작row	
	private long endRow; 		//끝row
	
	private String searchType;	//검색타입
	private String searchValue;	//검색값
	
	private String userCategoly;
	private String userIntroduce;
	
	private String fileProfileName;
	
	private String categolyValue;
	
	public  FdBoard()
	{
		fdBbsSeq = 0;
		userId = "";
		fdBbsTitle = "";
		readCnt = 0;
		regDate = "";
		fdStartDate = "";
		fdEndDate = "";
		targetPrice = 0;
		ctDate = "";
		venuePlace = "";
		venuePlaceAdd = "";
		ctAge = "";
		capacity =0;
		fdStatus = "N";
		fdStatus2 = "N";
		fdStatus3 = "N";
		currentAmount = 0;
		
		fdFileOrgName = "";	
		fdFileName = "";		
		fdFileExt = "";			
		fdFileSize = 0;	
		
		fdFile2OrgName = "";		
		fdFile2Name = "";
		
		fdTier = null;
		
		startRow = 0;
		endRow = 0;
		
		
		searchType = "";	
		searchValue = "";
		
		userCategoly = "";
		userIntroduce = "";
		
		fileProfileName = "";
		categolyValue = "";
	}
	
	public String getVenuePlaceAdd() {
		return venuePlaceAdd;
	}




	public void setVenuePlaceAdd(String venuePlaceAdd) {
		this.venuePlaceAdd = venuePlaceAdd;
	}




	public String getFdStatus() {
		return fdStatus;
	}




	public String getFdStatus2() {
		return fdStatus2;
	}




	public String getFdStatus3() {
		return fdStatus3;
	}




	public void setFdStatus3(String fdStatus3) {
		this.fdStatus3 = fdStatus3;
	}




	public void setFdStatus(String fdStatus) {
		this.fdStatus = fdStatus;
	}




	public void setFdStatus2(String fdStatus2) {
		this.fdStatus2 = fdStatus2;
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




	public FdTier getFdTier() {
		return fdTier;
	}



	public void setFdTier(FdTier fdTier) {
		this.fdTier = fdTier;
	}



	public String getCtAge() {
		return ctAge;
	}


	public void setCtAge(String ctAge) {
		this.ctAge = ctAge;
	}


	public String getFdFileOrgName() {
		return fdFileOrgName;
	}

	public void setFdFileOrgName(String fdFileOrgName) {
		this.fdFileOrgName = fdFileOrgName;
	}

	public String getFdFileName() {
		return fdFileName;
	}

	public void setFdFileName(String fdFileName) {
		this.fdFileName = fdFileName;
	}

	public String getFdFileExt() {
		return fdFileExt;
	}

	public void setFdFileExt(String fdFileExt) {
		this.fdFileExt = fdFileExt;
	}

	public long getFdFileSize() {
		return fdFileSize;
	}

	public void setFdFileSize(long fdFileSize) {
		this.fdFileSize = fdFileSize;
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

	public long getFdBbsSeq() {
		return fdBbsSeq;
	}

	public void setFdBbsSeq(long fdBbsSeq) {
		this.fdBbsSeq = fdBbsSeq;
	}
	
	

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFdBbsTitle() {
		return fdBbsTitle;
	}

	public void setFdBbsTitle(String fdBbsTitle) {
		this.fdBbsTitle = fdBbsTitle;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getFdStartDate() {
		return fdStartDate;
	}

	public void setFdStartDate(String fdStartDate) {
		this.fdStartDate = fdStartDate;
	}

	public String getFdEndDate() {
		return fdEndDate;
	}

	public void setFdEndDate(String fdEndDate) {
		this.fdEndDate = fdEndDate;
	}

	public long getTargetPrice() {
		return targetPrice;
	}

	public void setTargetPrice(long targetPrice) {
		this.targetPrice = targetPrice;
	}

	public String getCtDate() {
		return ctDate;
	}

	public void setCtDate(String ctDate) {
		this.ctDate = ctDate;
	}

	public String getVenuePlace() {
		return venuePlace;
	}

	public void setVenuePlace(String venuePlace) {
		this.venuePlace = venuePlace;
	}



	public long getCapacity() {
		return capacity;
	}

	public void setCapacity(long capacity) {
		this.capacity = capacity;
	}

	public long getCurrentAmount() {
		return currentAmount;
	}

	public void setCurrentAmount(long currentAmount) {
		this.currentAmount = currentAmount;
	}




	public String getFdFile2OrgName() {
		return fdFile2OrgName;
	}




	public void setFdFile2OrgName(String fdFile2OrgName) {
		this.fdFile2OrgName = fdFile2OrgName;
	}




	public String getFdFile2Name() {
		return fdFile2Name;
	}




	public void setFdFile2Name(String fdFile2Name) {
		this.fdFile2Name = fdFile2Name;
	}




	public String getCategolyValue() {
		return categolyValue;
	}




	public void setCategolyValue(String categolyValue) {
		this.categolyValue = categolyValue;
	}



}
