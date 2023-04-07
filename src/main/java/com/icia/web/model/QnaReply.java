package com.icia.web.model;

import java.io.Serializable;

public class QnaReply implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long qnaReplySeq;
	private long qnaBbsSeq;
	private String userId;
	private String qnaReplyContent;
	private String qnaReplyDate;
	
	public QnaReply()
	{
		qnaReplySeq = 0;
		qnaBbsSeq = 0;
		userId = "";
		qnaReplyContent = "";
		qnaReplyDate ="";
	}

	public long getQnaReplySeq() {
		return qnaReplySeq;
	}

	public void setQnaReplySeq(long qnaReplySeq) {
		this.qnaReplySeq = qnaReplySeq;
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

	public String getQnaReplyContent() {
		return qnaReplyContent;
	}

	public void setQnaReplyContent(String qnaReplyContent) {
		this.qnaReplyContent = qnaReplyContent;
	}

	public String getQnaReplyDate() {
		return qnaReplyDate;
	}

	public void setQnaReplyDate(String qnaReplyDate) {
		this.qnaReplyDate = qnaReplyDate;
	}
	
	

}
