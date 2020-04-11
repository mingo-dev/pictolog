package pictolog.ajaxAction;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.LogDAO;
import pictolog.dao.MemberDAO;
import pictolog.vo.Info;
import pictolog.vo.LogView;

@SuppressWarnings("serial")
public class LogViewAction extends ActionSupport {

	private String log_id;
	private int photo_id;
	private String member_id;
	private LogView logView;
	private List<Info> infoList;

	// 로그뷰 페이지에서 로그 데이터 불러오기
	public String readLogData() {
		LogDAO dao = new LogDAO();
		logView = dao.selectLog(log_id, member_id);
		//알림 select
		infoList = new MemberDAO().selectInfoList(member_id);
		if (logView != null) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}

	
	//Getters & Setters
	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public LogView getLogView() {
		return logView;
	}

	public void setLogView(LogView logView) {
		this.logView = logView;
	}


	public int getPhoto_id() {
		return photo_id;
	}


	public void setPhoto_id(int photo_id) {
		this.photo_id = photo_id;
	}


	public List<Info> getInfoList() {
		return infoList;
	}


	public void setInfoList(List<Info> infoList) {
		this.infoList = infoList;
	}
	
}
