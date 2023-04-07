package com.icia.web.model;

import java.io.Serializable;

public class ReviewReply  implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long rvReplySeq;
	private long rvSeq;
	private String rvReplyContent;
	private String regDate;
	
	private String userId;
	
	public ReviewReply()
	{
		rvReplySeq = 0;
		rvSeq = 0;
		rvReplyContent = "";
		regDate = "";
		
		userId = "";
	}

	public long getRvReplySeq() {
		return rvReplySeq;
	}

	public void setRvReplySeq(long rvReplySeq) {
		this.rvReplySeq = rvReplySeq;
	}

	public long getRvSeq() {
		return rvSeq;
	}

	public void setRvSeq(long rvSeq) {
		this.rvSeq = rvSeq;
	}

	public String getRvReplyContent() {
		return rvReplyContent;
	}

	public void setRvReplyContent(String rvReplyContent) {
		this.rvReplyContent = rvReplyContent;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
