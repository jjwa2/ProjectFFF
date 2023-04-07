package com.icia.web.model;

import java.io.Serializable;

public class FdTier implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long fdBbsSeq;
	private long price1;
	private long price2;
	private long price3;
	private long price4;
	private String product1;
	private String product2;
	private String product3;
	private String product4;
	private long tierCnt;
	
	public FdTier()
	{
		fdBbsSeq = 0;
		price1 =0;
		price2 =0;
		price3 =0;
		price4 =0;
		product1 ="";
		product2 ="";
		product3 ="";
		product4 ="";
		tierCnt =0;
	}


	
	public String getProduct1() {
		return product1;
	}



	public void setProduct1(String product1) {
		this.product1 = product1;
	}



	public long getFdBbsSeq() {
		return fdBbsSeq;
	}

	public void setFdBbsSeq(long fdBbsSeq) {
		this.fdBbsSeq = fdBbsSeq;
	}



	public long getPrice1() {
		return price1;
	}


	public void setPrice1(long price1) {
		this.price1 = price1;
	}


	public long getPrice2() {
		return price2;
	}


	public void setPrice2(long price2) {
		this.price2 = price2;
	}


	public long getPrice3() {
		return price3;
	}


	public void setPrice3(long price3) {
		this.price3 = price3;
	}


	public long getPrice4() {
		return price4;
	}


	public void setPrice4(long price4) {
		this.price4 = price4;
	}


	public String getProduct4() {
		return product4;
	}


	public void setProduct4(String product4) {
		this.product4 = product4;
	}

	public String getProduct2() {
		return product2;
	}

	public void setProduct2(String product2) {
		this.product2 = product2;
	}

	public String getProduct3() {
		return product3;
	}

	public void setProduct3(String product3) {
		this.product3 = product3;
	}

	public long getTierCnt() {
		return tierCnt;
	}

	public void setTierCnt(long tierCnt) {
		this.tierCnt = tierCnt;
	}



}
