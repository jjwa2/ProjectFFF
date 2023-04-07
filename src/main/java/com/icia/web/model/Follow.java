package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class Follow implements Serializable{

	private static final long serialVersionUID = 1L;

	private String followerId;
	private String followingId;
	
	private String userCategoly;
	private String userIntroduce;
	
	private String fileProfileName;
	
	private long snsSeq;	
	private String snsContent;
	private String snsFileName;	
	
	private List<SnsReply> snsReplyList;
	
	public Follow()
	{
		followerId = "";
		followingId = "";
		
		userCategoly = "";
		userIntroduce = "";
		
		fileProfileName = "";
		
		snsSeq = 0;	
		snsContent = "";
		snsFileName = "";	
		
		snsReplyList = null;
	}

	
	
	public List<SnsReply> getSnsReplyList() {
		return snsReplyList;
	}



	public void setSnsReplyList(List<SnsReply> snsReplyList) {
		this.snsReplyList = snsReplyList;
	}



	public long getSnsSeq() {
		return snsSeq;
	}



	public void setSnsSeq(long snsSeq) {
		this.snsSeq = snsSeq;
	}



	public String getSnsContent() {
		return snsContent;
	}



	public void setSnsContent(String snsContent) {
		this.snsContent = snsContent;
	}



	public String getSnsFileName() {
		return snsFileName;
	}



	public void setSnsFileName(String snsFileName) {
		this.snsFileName = snsFileName;
	}



	public String getFollowerId() {
		return followerId;
	}

	public void setFollowerId(String followerId) {
		this.followerId = followerId;
	}

	public String getFollowingId() {
		return followingId;
	}

	public void setFollowingId(String followingId) {
		this.followingId = followingId;
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
	
	
	
	
}
