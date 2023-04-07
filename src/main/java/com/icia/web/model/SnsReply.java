package com.icia.web.model;

import java.io.Serializable;

public class SnsReply  implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long snsReplySeq;
	private long snsSeq;
	private String snsReplyContent;
	private String userId;
	
	public SnsReply()
	{
		snsReplySeq = 0;
		snsSeq = 0;
		snsReplyContent = "";
		userId = "";
	}

	public long getSnsReplySeq() {
		return snsReplySeq;
	}

	public void setSnsReplySeq(long snsReplySeq) {
		this.snsReplySeq = snsReplySeq;
	}

	public long getSnsSeq() {
		return snsSeq;
	}

	public void setSnsSeq(long snsSeq) {
		this.snsSeq = snsSeq;
	}

	public String getSnsReplyContent() {
		return snsReplyContent;
	}

	public void setSnsReplyContent(String snsReplyContent) {
		this.snsReplyContent = snsReplyContent;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
}
