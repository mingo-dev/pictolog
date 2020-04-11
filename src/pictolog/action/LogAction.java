package pictolog.action;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.LogDAO;
import pictolog.vo.Log;
import pictolog.vo.LogComment;
import pictolog.vo.LogMain;
import pictolog.vo.LogView;
import pictolog.vo.Member;
import pictolog.vo.Photo;

@SuppressWarnings("serial")
public class LogAction extends ActionSupport implements SessionAware {
	// Fields
	private Member member;
	private String member_id;
	private String log_id;
	private String tagKeyword;
	private Log log;
	private LogComment logComment;
	private List<Log> logList;
	private List<LogMain> logMainList;
	private List<LogView> logViewList;
	private List<Photo> photoList;
	private List<LogComment> logCommentList;
	private int totalRecordsCount;

	// File upload
	private String[] uploadFileName;
	private String[] uploadContentType;
	private File[] uploadList;

	@SuppressWarnings("unused")
	private Map<String, Object> session;
	private int countPerPage;
	private int currentPage; // 현재 페이지에대한 값은 프론트로부터 받아온다.(ex) 마우스 휠로 한페이지 넘어가면
								// 다음페이지로 카운트가 바뀌어서 액션 요청
	private int lastPage;
	private List<Member> followerList;
	private List<Member> followingList;

	
	public LogAction() {}
		
	// 로그 삭제
	public String deleteLog() {
		String saveFolder = "img/";
		HttpServletRequest request = ServletActionContext.getRequest();
		ServletContext servletContext = request.getSession().getServletContext();
		String basePath = servletContext.getRealPath(saveFolder);
		member = (Member)session.get("login");
		member_id = member.getMember_id();
		boolean result = new LogDAO().deleteLog(member_id, log_id, basePath);
		if (result == true) {
			return SUCCESS;
		} else {
			return INPUT;
		}
	} // deleteLog

	// 로그 공개설정
	public String makeLogPublic() {
		boolean result = new LogDAO().makeLogPublic(log);
		if (result == true) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}// makeLogPublic

	// 로그 비공개설정
	public String makeLogPrivate() {
		boolean result = new LogDAO().makeLogPrivate(log);
		if (result == true) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // makeLogPrivate


	/* Session */
	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	/* getter & setter */
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
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

	public String getTagKeyword() {
		return tagKeyword;
	}

	public void setTagKeyword(String tagKeyword) {
		this.tagKeyword = tagKeyword;
	}

	public Log getLog() {
		return log;
	}

	public void setLog(Log log) {
		this.log = log;
	}

	public LogComment getLogComment() {
		return logComment;
	}

	public void setLogComment(LogComment logComment) {
		this.logComment = logComment;
	}

	public List<Log> getLogList() {
		return logList;
	}

	public void setLogList(List<Log> logList) {
		this.logList = logList;
	}

	public List<Photo> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(List<Photo> photoList) {
		this.photoList = photoList;
	}

	public List<LogComment> getLogCommentList() {
		return logCommentList;
	}

	public void setLogCommentList(List<LogComment> logCommentList) {
		this.logCommentList = logCommentList;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public File[] getUploadList() {
		return uploadList;
	}

	public void setUploadList(File[] uploadList) {
		this.uploadList = uploadList;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public List<Member> getFollowerList() {
		return followerList;
	}

	public void setFollowerList(List<Member> followerList) {
		this.followerList = followerList;
	}

	public List<Member> getFollowingList() {
		return followingList;
	}

	public void setFollowingList(List<Member> followingList) {
		this.followingList = followingList;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getTotalRecordsCount() {
		return totalRecordsCount;
	}

	public void setTotalRecordsCount(int totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	public List<LogMain> getLogMainList() {
		return logMainList;
	}

	public void setLogMainList(List<LogMain> logMainList) {
		this.logMainList = logMainList;
	}

	public List<LogView> getLogViewList() {
		return logViewList;
	}

	public void setLogViewList(List<LogView> logViewList) {
		this.logViewList = logViewList;
	}
}
