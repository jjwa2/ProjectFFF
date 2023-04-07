package com.icia.web.model;

import java.io.Serializable;

public class CtBoard implements Serializable{
	
	private static final long serialVersionUID = 1L;


	private long ctBbsSeq;		//공연일정 게시판 번호 
	private long fdBbsSeq;		//펀딩 게시판 번호
	private String userId;		//관리자 아이디 
	private String ctBbsTitle;	//공연일정 게시물 제목
	private String ctBbsContent;//공연일정 게시물 내용
	private String ctRegDate;	//게시물 등록일
	private String userName;	//관리자 이름
	private long startRow;		
	private long endRow; 		
	private String searchType;	
	private String searchValue;	
	
	private String ctFileOrgName;
	private String ctFileName;
	private String ctFileExt;
	private long ctFileSize;
	private String ctDate;
	private String venuePlace;
	private String venuePlaceAdd;
	private String ctAge;
	private long capacity;
	private String userCategory;
	private String userIntroduce;
	
	private String ctPayType;
	private String ctPrice;
	
	private String fdFileName;
	
	private String fileProfileName;
	
	private String fdStatus3;
	
	public CtBoard()
	{
		ctBbsSeq= 0;
		fdBbsSeq= 0;
		userId = "";		
		ctBbsTitle= "";	
		ctBbsContent= "";
		ctRegDate= "";	
		userName= "";	
		startRow= 0;		
		endRow= 0; 		
		searchType = "";
		searchValue= "";
		ctFileName = "";
		ctFileExt = "";
		ctFileSize = 0;
		ctDate="";
		venuePlace="";
		venuePlaceAdd="";
		ctAge="";
		userCategory="";
		
		fdFileName = "";
		
		ctPayType = "";
		ctPrice = "";
		
		fileProfileName = "";
		capacity= 0;
		userIntroduce="";
		
		fdStatus3="";
	}

	
	
	
	public String getVenuePlaceAdd() {
		return venuePlaceAdd;
	}




	public void setVenuePlaceAdd(String venuePlaceAdd) {
		this.venuePlaceAdd = venuePlaceAdd;
	}




	public String getFdStatus3() {
		return fdStatus3;
	}




	public void setFdStatus3(String fdStatus3) {
		this.fdStatus3 = fdStatus3;
	}




	public String getUserIntroduce() {
		return userIntroduce;
	}




	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}




	public long getCapacity() {
		return capacity;
	}




	public void setCapacity(long capacity) {
		this.capacity = capacity;
	}




	public String getFileProfileName() {
		return fileProfileName;
	}




	public void setFileProfileName(String fileProfileName) {
		this.fileProfileName = fileProfileName;
	}




	public String getCtPayType() {
		return ctPayType;
	}



	public void setCtPayType(String ctPayType) {
		this.ctPayType = ctPayType;
	}



	public String getCtPrice() {
		return ctPrice;
	}



	public void setCtPrice(String ctPrice) {
		this.ctPrice = ctPrice;
	}



	public String getFdFileName() {
		return fdFileName;
	}



	public void setFdFileName(String fdFileName) {
		this.fdFileName = fdFileName;
	}



	public long getCtBbsSeq() {
		return ctBbsSeq;
	}

	public void setCtBbsSeq(long ctBbsSeq) {
		this.ctBbsSeq = ctBbsSeq;
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

	public String getCtBbsTitle() {
		return ctBbsTitle;
	}

	public void setCtBbsTitle(String ctBbsTitle) {
		this.ctBbsTitle = ctBbsTitle;
	}

	public String getCtBbsContent() {
		return ctBbsContent;
	}

	public void setCtBbsContent(String ctBbsContent) {
		this.ctBbsContent = ctBbsContent;
	}


	public String getCtRegDate() {
		return ctRegDate;
	}

	public void setCtRegDate(String ctRegDate) {
		this.ctRegDate = ctRegDate;
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

	public String getCtFileOrgName() {
		return ctFileOrgName;
	}

	public void setCtFileOrgName(String ctFileOrgName) {
		this.ctFileOrgName = ctFileOrgName;
	}

	public String getCtFileName() {
		return ctFileName;
	}

	public void setCtFileName(String ctFileName) {
		this.ctFileName = ctFileName;
	}

	public String getCtFileExt() {
		return ctFileExt;
	}

	public void setCtFileExt(String ctFileExt) {
		this.ctFileExt = ctFileExt;
	}

	public long getCtFileSize() {
		return ctFileSize;
	}

	public void setCtFileSize(long ctFileSize) {
		this.ctFileSize = ctFileSize;
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

	public String getCtAge() {
		return ctAge;
	}

	public void setCtAge(String ctAge) {
		this.ctAge = ctAge;
	}

	public String getUserCategory() {
		return userCategory;
	}

	public void setUserCategory(String userCategory) {
		this.userCategory = userCategory;
	}

	
	
}
