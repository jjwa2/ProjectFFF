package com.icia.web.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.icia.web.model.FdPm;
import com.icia.web.util.HttpUtil;

@Component
@Service("mailSendService")
public class MailSendService {

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int authNumber;
	
	
	
		public void makeRandomNumber() {
			// 난수의 범위 111111 ~ 999999 (6자리 난수)
			Random r = new Random();
			int checkNum = r.nextInt(888888) + 111111;
			System.out.println("인증번호 : " + checkNum);
			authNumber = checkNum;
			  
		}
		
		
				//이메일 보낼 양식! 
		public String joinEmail(String email) 
		{
			makeRandomNumber();
			
			String setFrom = "fff1436@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목 
			String content = 			
					"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
	                "<br><br>" + 
				    "인증 번호는 " + authNumber + "입니다." + 
				    "<br>" + 
				    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
			
			
			mailSend(setFrom, toMail, title, content);
			return Integer.toString(authNumber);
		   
		}
		
		
		public void joinEmail2(String email, String paymentNum,String pmDate,String ctBbsTitle,String ctPrice)
		{
			String setFrom = "fff1436@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "[FFF] 공연예매 티켓 이메일 입니다."; // 이메일 제목 
			String content = 
					
				"<body style=\"background-color: white; color: black; font-family: 'PretendardVariable';\">"
				+ "<div class=\"payBar\" style=\"width: 100%; height: 20px; background-color: #157347;\"></div> "
				+ "<div class=\"container\"> "
				+ "<div class=\"payBarTicketNum\" style=\"margin-top: 20px; margin-left: 20px; font-size: 30px;\">#결제완료</div>"
				+ "<div class=\"payBarTicketNum1\" style=\"margin-left: 20px; margin-top: 20px; font-size: 15px;\">예매번호 :"+paymentNum+"</div>"
				+ "<div class=\"payBarTicketNotice\" style=\"margin-left: 20px; font-size: 15px;\">*현재 결제완료 페이지를 공연장 입구에서 담당직원에게 보여주세요.</div>"
				+ "<div class=\"payBarTicketNum\" style=\"margin-top: 20px; margin-left: 20px; font-size: 30px;\">#결제정보</div>"
				+ "<table class=\"table table-bordered\" style=\"width: 50%; margin-top: 20px; margin-left: 20px;\">"
				+ "<tbody>"
				+ "<tr>"
				+ "<th style=\"background-color: black; margin-top: 20px; margin-left: 20px; color: white;\">공연제목</th>"
				+ "<td style=\"color: black;\">"+ ctBbsTitle +"</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<th style=\"background-color: black; margin-top: 20px; margin-left: 20px; color: white;\">결제일시</th>"
				+ "<td style=\"color: black;\">" + pmDate +"</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<th style=\"background-color: black; margin-top: 20px; margin-left: 20px; color: white;\">티켓 금액</th>"
				+ "<td style=\"color: black;\">"+ ctPrice +"원</td>"
				+ "</tr>"
				+ "</tbody>"
				+ "</table>"
				+ "</div>"
				+ "<div class=\"payFoot\" style=\"margin-top: 26.1px; width: 100%; height: 20px; background-color: #157347;\"></div>"
				+ "</body>";

					
			mailSend(setFrom, toMail, title, content);
			
		}
		
		//이메일 전송 메소드
		public void mailSend(String setFrom, String toMail, String title, String content) 
		{ 
			MimeMessage message = mailSender.createMimeMessage();
			// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
			try 
			{
				MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
				helper.setText(content,true);
				mailSender.send(message);
			} 
			catch (MessagingException e)
			{
				e.printStackTrace();
			}
		}
		
		public void joinEmail3(String email, String userId)
		{
			String setFrom = "fff1436@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "[FFF] 아이디찾기  결과입니다."; // 이메일 제목 
			String content = 
					"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
	                "<br><br>" + 
				    "회원님의 아이디는 " + userId + " 입니다." + 
				    "<br>" + 
				    "타인에게 회원정보를 누설하지 마세요." + "<br>"+ 
				    "<a href=\"http://fff.icia.co.kr:8088\">홈페이지 바로가기</a>"; //이메일 내용 삽입
			
			
			mailSend(setFrom, toMail, title, content);
			
		}
		
		public void joinEmail4(String email, String userPwd)
		{
			String setFrom = "fff1436@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력 
			String toMail = email;
			String title = "[FFF] 비밀번호 찾기  결과입니다."; // 이메일 제목 
			String content = 
					"홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 ! 
	                "<br><br>" + 
				    "회원님의 비밀번호는 " + userPwd + " 입니다." + 
				    "<br>" + 
				    "타인에게 회원정보를 누설하지 마세요." + "<br>"+ 
				    "<a href=\"http://fff.icia.co.kr:8088\">홈페이지 바로가기</a>"; //이메일 내용 삽입
			
			
			mailSend(setFrom, toMail, title, content);
			
		}
		
	
}
