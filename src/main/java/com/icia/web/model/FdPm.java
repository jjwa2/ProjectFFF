package com.icia.web.model;

import java.io.Serializable;

public class FdPm implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String paymentNum;
	private String userId;
	private int tierNum;
	private long fdBbsSeq;
	private String pmDate;
	private char pmStatus;
	
	public FdPm()
	{
		paymentNum = "";
		userId = "";
		tierNum = 0;
		fdBbsSeq = 0;
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

	public int getTierNum() {
		return tierNum;
	}

	public void setTierNum(int tierNum) {
		this.tierNum = tierNum;
	}

	public long getFdBbsSeq() {
		return fdBbsSeq;
	}

	public void setFdBbsSeq(long fdBbsSeq) {
		this.fdBbsSeq = fdBbsSeq;
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
