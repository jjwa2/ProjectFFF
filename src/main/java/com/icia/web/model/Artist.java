package com.icia.web.model;

import java.io.Serializable;

public class Artist implements Serializable{

	private static final long serialVersionUID = 1L;

	private String userId;
	private String userCategoly;
	private String userIntroduce;
	
	private int userLevel;
	private String userName;
	private String userEmail;
	private String userTel;
	private String status;
	
	private ArtProfile artProfile; //프로필사진
	
	private String fileProfileName;
	
	private String artistLevelStatus;
	
	public Artist()
	{
		userId = "";
		userCategoly = "";
		userIntroduce = "";
		
		fileProfileName = "";
		artProfile = null;
		
		artistLevelStatus = "";
		
		userLevel = 0;
		userName = "";
		userEmail = "";
		userTel = "";
		status = "";
	}
	
	

	
	
	public int getUserLevel() {
		return userLevel;
	}





	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}





	public String getUserName() {
		return userName;
	}





	public void setUserName(String userName) {
		this.userName = userName;
	}





	public String getUserEmail() {
		return userEmail;
	}





	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}





	public String getUserTel() {
		return userTel;
	}





	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}





	public String getStatus() {
		return status;
	}





	public void setStatus(String status) {
		this.status = status;
	}





	public String getArtistLevelStatus() {
		return artistLevelStatus;
	}





	public void setArtistLevelStatus(String artistLevelStatus) {
		this.artistLevelStatus = artistLevelStatus;
	}





	public String getFileProfileName() {
		return fileProfileName;
	}



	public void setFileProfileName(String fileProfileName) {
		this.fileProfileName = fileProfileName;
	}



	public ArtProfile getArtProfile() {
		return artProfile;
	}

	public void setArtProfile(ArtProfile artProfile) {
		this.artProfile = artProfile;
	}



	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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
	
	
}
