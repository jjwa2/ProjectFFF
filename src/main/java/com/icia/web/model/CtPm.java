package com.icia.web.model;

import java.io.Serializable;

public class CtPm implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String paymentNum;
	private String userId;
	private long ctBbsSeq;
	private String pmDate;
	private char pmStatus;
	
	public CtPm()
	{
		paymentNum = "";
		userId = "";
		ctBbsSeq = 0;
		pmDate = "";
		pmStatus = ' '; 
	}

	public String getPaymentNum() {
		return paymentNum;
	}

	public void setPaymentNum(String paymentNum) {
		this.paymentNum = paymentNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}


	public long getCtBbsSeq() {
		return ctBbsSeq;
	}

	public void setCtBbsSeq(long ctBbsSeq) {
		this.ctBbsSeq = ctBbsSeq;
	}

	public String getPmDate() {
		return pmDate;
	}

	public void setPmDate(String pmDate) {
		this.pmDate = pmDate;
	}

	public char getPmStatus() {
		return pmStatus;
	}

	public void setPmStatus(char pmStatus) {
		this.pmStatus = pmStatus;
	}


	
}
