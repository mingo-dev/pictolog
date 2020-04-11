package pictolog.ajaxAction;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.LogDAO;
import pictolog.dao.MemberDAO;
import pictolog.vo.Info;
import pictolog.vo.LogComment;
import pictolog.vo.LogTag;
import pictolog.vo.LogView;

@SuppressWarnings("serial")
public class LogAjaxAction extends ActionSupport {
	private LogView logView;
	private LogComment logComment;
	private String member_id;
	private String log_id;
	private LogTag logTag;
		
	// 로그 데이터 불러오기
	public String readLogData() {
		LogDAO dao = new LogDAO();
		logView = dao.selectLog(log_id, member_id);
		if (logView != null) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // readLogData
	
	// 로그 댓글 등록
	public String addLogComment() {
		LogDAO dao = new LogDAO();
		boolean result = dao.insertLogComment(logComment);
		
		//알림 insert
		Info info = new Info(logComment.getLog_id(), "logComment");//알림 받을 사용자 대신 로그 아이디 입력
		info.setMember_id_you(logComment.getMember_id());
		info.setLocation("logView.action?log_id="+logComment.getLog_id());
		new MemberDAO().insertInfo(info);
		
		if (result == true) {
			List<LogComment> logCommentList = dao.selectLogCommentList(logComment.getLog_id());
			logView = new LogView();
			logView.setLogCommentList(logCommentList);
			return SUCCESS;
		} else {
			return ERROR;
		}			
	} // addLogComment

	// 로그 댓글 삭제
	public String deleteLogComment() {
		System.out.println(logComment);
		LogDAO dao = new LogDAO();
		boolean result = dao.deleteLogComment(logComment);
		if (result == true) {
			List<LogComment> logCommentList = dao.selectLogCommentList(logComment.getLog_id());
			logView = new LogView();
			logView.setLogCommentList(logCommentList);
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // deleteLogComment
	
	// 로그 좋아요
	public String doLogLike() {
		logView = new LogDAO().doLogLike(log_id, member_id);
		
		//알림 insert 
		Info info = new Info(log_id, "logLike");
		info.setLocation("logView.action?log_id="+log_id);
		info.setMember_id_you(member_id);
		
		new MemberDAO().insertInfo(info);
		
		return SUCCESS;
	} // likeLog

	// 로그 좋아요 취소
	public String cancelLogLike() {
		logView  = new LogDAO().cancelLogLike(log_id, member_id);
		return SUCCESS;
	} // disLikeLog
	
	// 로그 타이틀 업데이트
	public String updateLogTitle() {
		boolean result = new LogDAO().updateLogTitle(logView);
		if(result == true) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}
	
	// 로그 태그 업데이트
	public String updateLogTag() {
		System.out.println(logTag);
		new LogDAO().updateLogTag(logTag);
		return SUCCESS;
	}
	
	/* getter & setter */
	public LogView getLogView() {
		return logView;
	}

	public void setLogView(LogView logView) {
		this.logView = logView;
	}

	public LogComment getLogComment() {
		return logComment;
	}

	public void setLogComment(LogComment logComment) {
		this.logComment = logComment;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	public LogTag getLogTag() {
		return logTag;
	}

	public void setLogTag(LogTag logTag) {
		this.logTag = logTag;
	}
}
