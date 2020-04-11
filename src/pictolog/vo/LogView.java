package pictolog.vo;

import java.util.List;

/**
 * LogView.jsp 파일 로딩시 사용되는 VO Class Log를 상속받으며 Log Comment 와 Log Like 를
 * ArrayList로 가진다.
 * 
 * @author JISEONG
 */
public class LogView extends Log {

	private List<LogComment> logCommentList;
	private List<Photo> photoList;
	private List<LogTag> logTagList;
	
	private int logLikeCount;
	private boolean amILikedThisLog; 
	private String profile_photo;

	
	public LogView(){
		super();
	}
	
	public List<LogComment> getLogCommentList() {
		return logCommentList;
	}

	public void setLogCommentList(List<LogComment> logCommentList) {
		this.logCommentList = logCommentList;
	}

	public List<Photo> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(List<Photo> photoList) {
		this.photoList = photoList;
	}

	public int getLogLikeCount() {
		return logLikeCount;
	}

	public void setLogLikeCount(int logLikeCount) {
		this.logLikeCount = logLikeCount;
	}

	public boolean isAmILikedThisLog() {
		return amILikedThisLog;
	}

	public void setAmILikedThisLog(boolean amILikedThisLog) {
		this.amILikedThisLog = amILikedThisLog;
	}

	public List<LogTag> getLogTagList() {
		return logTagList;
	}

	public void setLogTagList(List<LogTag> logTagList) {
		this.logTagList = logTagList;
	}

	public String getProfile_photo() {
		return profile_photo;
	}

	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}
	
}
