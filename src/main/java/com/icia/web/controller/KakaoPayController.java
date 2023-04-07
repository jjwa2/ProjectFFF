package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Kakao.KakaoPayApprove;
import com.icia.web.model.Kakao.KakaoPayOrder;
import com.icia.web.model.Kakao.KakaoPayReady;
import com.icia.web.model.CtBoard;
import com.icia.web.model.CtPm;
import com.icia.web.model.FdBoard;
import com.icia.web.model.FdPm;
import com.icia.web.model.FdTier;
import com.icia.web.model.Response;
import com.icia.web.model.User;
import com.icia.web.service.CtBoardService;
import com.icia.web.service.FdBoardService;
import com.icia.web.service.KakaoPayService;
import com.icia.web.service.MailSendService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController 
{
	private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
	
	@Autowired
	private FdBoardService fdBoardService;
	
	@Autowired
	private CtBoardService ctBoardService;
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MailSendService mailService;
	
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@RequestMapping(value="/kakao/pay")
	public String pay(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{

		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", (long)9999);
		int tierNum = HttpUtil.get(request, "tierNum", 999);
		long price = HttpUtil.get(request, "price", 1234);
		//본인글 여부
		FdBoard fdBoard = new FdBoard();
		
		fdBoard = fdBoardService.boardSelect(fdBbsSeq);
		//FdPm fdPm = new FdPm();
		FdTier fdTier = new FdTier();
		fdTier = fdBoardService.tierSelect(fdBbsSeq);
		

		//fdPm.setFdBbsSeq(fdBbsSeq);
		//fdPm.setTierNum(tierNum);
		//fdPm.setUserId(cookieUserId);
		//int count = fdBoardService.fdPaymentInsert(fdPm);
		
		
		model.addAttribute("fdTier", fdTier);
		model.addAttribute("fdBbsSeq", fdBbsSeq);
		model.addAttribute("fdBoard", fdBoard);
		model.addAttribute("tierNum", tierNum);
		model.addAttribute("price", price);
		logger.debug("FdBoard FdBbsTitle()" + fdBoard.getFdBbsTitle());
		
		
		
		
		
		
		
		return "/kakao/pay";
	}
	
	@RequestMapping(value="/kakao/payReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String orderId = StringUtil.uniqueValue();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String itemCode = HttpUtil.get(request, "itemCode", "");
		String itemName = HttpUtil.get(request, "itemName", "");
		int quantity = HttpUtil.get(request, "quantity", 0);
		int totalAmount = HttpUtil.get(request, "totalAmount", 0);   //순수 총합결제금액 할인제외
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", 0);  //세금제외가격
		int vatAmount = HttpUtil.get(request, "vatAmount", 0);			//부가세
		
		logger.debug("[KakaoPayController] payReady : 11");
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemCode(itemCode);
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		logger.debug("[KakaoPayController] payReady : 12");
		KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
		logger.debug("[KakaoPayController] payReady : 13");
		if(kakaoPayReady != null)
		{
			logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
			
			kakaoPayOrder.setTid(kakaoPayReady.getTid());
			
			JsonObject json = new JsonObject();
			
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayReady.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
			
			ajaxResponse.setResponse(0, "success", json);
		}
		else
		{
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		return ajaxResponse;
	}
	
	
	
	@RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String pcUrl = HttpUtil.get(request, "pcUrl", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//펀딩에서 쓰는거
		int tierNum = HttpUtil.get(request, "tierNum", -1);
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq", -1);
		long price = HttpUtil.get(request, "price", -1);
		//공연예매에서 쓰는거
		
		long ctBbsSeq = HttpUtil.get(request, "ctBbsSeq", -1);
		String ctBbsTitle = HttpUtil.get(request, "ctBbsTitle", "실패");
		String venuePlace = HttpUtil.get(request, "venuePlace", "실패");
		String ctDate = HttpUtil.get(request, "ctDate", "실패");
		String ctAge = HttpUtil.get(request, "ctAge", "실패");
		
		logger.debug("===============================================");
		logger.debug("pcUrl : " + pcUrl);
		logger.debug("userId : " + userId);
		logger.debug("price : " + price);
		logger.debug("===============================================");
		//펀딩에서 쓰는거
		model.addAttribute("tierNum", tierNum);
		model.addAttribute("fdBbsSeq",fdBbsSeq);
		model.addAttribute("pcUrl", pcUrl);
		model.addAttribute("orderId", orderId);
		model.addAttribute("tId", tId);
		model.addAttribute("userId", userId);
		model.addAttribute("price", price);
		
		//예매에서 쓰는거
		model.addAttribute("userId", userId);
		model.addAttribute("ctBbsSeq", ctBbsSeq);
		model.addAttribute("ctBbsTitle", ctBbsTitle);
		model.addAttribute("venuePlace", venuePlace);
		model.addAttribute("ctDate", ctDate);
		model.addAttribute("ctAge", ctAge);
		
		
		
		return "/kakao/payPopUp";
	}
	
	//카카오 페이에서 env에 있는 주소를 통해서 연결시켜줌
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String pgToken = HttpUtil.get(request, "pg_token", "");
		
		model.addAttribute("pgToken", pgToken);
		
		return "/kakao/paySuccess";
	}
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String pgToken = HttpUtil.get(request, "pgToken", "");
		//펀딩에서 쓸꺼
		long fdBbsSeq = HttpUtil.get(request, "fdBbsSeq",-1);
		int tierNum = HttpUtil.get(request, "tierNum", -1);
		long price = HttpUtil.get(request, "price", -1);
		//예매에서 쓸꺼
		long ctBbsSeq = HttpUtil.get(request, "ctBbsSeq", -1);
		String ctBbsTitle = HttpUtil.get(request, "ctBbsTitle", "실패");
		String venuePlace = HttpUtil.get(request, "venuePlace", "실패");
		String ctDate = HttpUtil.get(request, "ctDate", "실패");
		String ctAge = HttpUtil.get(request, "ctAge", "실패");
	
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setTid(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		if(tierNum !=-1)
		{
			FdBoard fdBoard = fdBoardService.boardSelect(fdBbsSeq);
			String fdTitle = fdBoard.getFdBbsTitle();
			FdPm fdPm = new FdPm();
			fdPm.setPaymentNum(kakaoPayOrder.getPartnerOrderId());
			fdPm.setFdBbsSeq(fdBbsSeq);
			fdPm.setTierNum(tierNum);
			fdPm.setUserId(userId);
			int count = fdBoardService.fdPaymentInsert(fdPm, price);
			fdPm = fdBoardService.fdPmSelect(orderId);
			kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
			model.addAttribute("kakaoPayApprove", kakaoPayApprove);
			//펀딩에서 쓸꺼
			model.addAttribute("fdPm", fdPm);
			model.addAttribute("fdTitle", fdTitle);
			model.addAttribute ("price",price);
		}
		
		//예매에서 쓰는거
		if(ctBbsSeq != -1)
		{
			CtPm ctPm = new CtPm();
			ctPm.setPaymentNum(kakaoPayOrder.getPartnerOrderId());
			ctPm.setUserId(userId);
			ctPm.setCtBbsSeq(ctBbsSeq);
			int count = kakaoPayService.ctPaymentInsert(ctPm, price);
			ctPm = kakaoPayService.ctPmSelect(orderId);
			kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
			
			CtBoard ctBoard = new CtBoard();
			
			ctBoard = ctBoardService.boardSelectBbsSeq(ctBbsSeq);
			
			
			model.addAttribute("kakaoPayApprove", kakaoPayApprove);
			
			model.addAttribute("userId", userId);
			model.addAttribute("ctPm", ctPm);
			model.addAttribute("ctBoard", ctBoard);
			model.addAttribute("ctBbsTitle", ctBbsTitle);
			model.addAttribute("venuePlace", venuePlace);
			model.addAttribute("ctDate", ctDate);
			model.addAttribute("ctAge", ctAge);
			return "/kakao/payResult2";
		}
		
		return "/kakao/payResult";
	}
	
	
	

	@RequestMapping(value="/kakao/Email",method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> email(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userSelect(cookieUserId);
		String email = user.getUserEmail();
		
		String pmDate = HttpUtil.get(request, "pmDate");
		String ctBbsTitle = HttpUtil.get(request, "ctBbsTitle");
		String paymentNum = HttpUtil.get(request, "paymentNum");
		String ctPrice = HttpUtil.get(request, "ctPrice");
		
		
		
		
		logger.debug("안녕@@@@@@@@@@@" + paymentNum);
		
		
		System.out.println("이메일 요청이 들어옴!");
		System.out.println("이메일 전송 이메일" + email);
		
		
		mailService.joinEmail2(email, paymentNum, pmDate, ctBbsTitle, ctPrice);
		
		
		ajaxResponse.setResponse(0,"성공");
		
		
		
		return ajaxResponse;
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
