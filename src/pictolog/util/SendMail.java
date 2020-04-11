package pictolog.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {

	public SendMail(String email, String password, String member_id) throws MessagingException {
		// 메일 관련 정보
		String host = "smtp.gmail.com";
		String hostEmail = "azznggu@gmail.com";
		String hostPassword = "azznggu1224";
		// 메일 내용
		String recipient = email;
		String subject = "[PicToLog] 패스워드 찾기 발송 메일입니다.";
		String body = " "+member_id+"님의 비밀번호는 " +password +"입니다.";

		// properties 설정
		Properties props = new Properties();
		props.put("mail.smtps.auth", "true");
		// 메일 세션
		Session session = Session.getDefaultInstance(props);
		MimeMessage msg = new MimeMessage(session);
		
		// 메일 관련
		msg.setSubject(subject);
		msg.setText(body);
		msg.setFrom(new InternetAddress(hostEmail));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

		// 발송 처리
		Transport transport = session.getTransport("smtps");
		transport.connect(host, hostEmail, hostPassword);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	} // sendMail
}
