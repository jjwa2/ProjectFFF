package com.icia.web.model.Kakao;

import java.io.Serializable;

public class KakaoPayOrder implements Serializable {
	private static final long serialVersionUID = 1L;

	private String partnerOrderId; 	// 가맹점 주문번호, 최대 100자 O
	private String partnerUserId; 		// 가맹점 회원 id, 최대 100자 O
	private String itemName; 			// 상품명, 최대 100자 O
	private String itemCode; 			// 상품코드, 최대 100자 X
	private int quantity; 				// 상품 수량 O
	private int totalAmount;			// 상품 총액 O
	private int taxFreeAmount;			// 상품 비과세 금액 O
	private int vatAmount; 				// 상품 부가세 금액
										// 값을 보내지 않을 경우 다음과 같이 VAT 자동 계산
										// (상품총액 - 상품 비과세 금액)/11 : 소수점 이하 반올림
	private String tid; 				// 결제 고유 번호 20자
	private String pgToken; 			// 결제 승인요청을 인증하는 토큰 사용자 결재수단 (우리는 현금)
										// 선택완료시, approval_url로 redirection해줄때 pg_token을 query string으로 전달

	public KakaoPayOrder() {
		partnerOrderId = "";
		partnerUserId = "";
		itemName = "";
		itemCode = "";
		quantity = 0;
		totalAmount = 0;
		taxFreeAmount = 0;
		vatAmount = 0;

		tid="";
		pgToken = "";

	}

	public String getPartnerOrderId() {
		return partnerOrderId;
	}

	public void setPartnerOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}

	public String getPartnerUserId() {
		return partnerUserId;
	}

	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public int getVatAmount() {
		return vatAmount;
	}

	public void setVatAmount(int vatAmount) {
		this.vatAmount = vatAmount;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getPgToken() {
		return pgToken;
	}

	public void setPgToken(String pgToken) {
		this.pgToken = pgToken;
	}





	
}
