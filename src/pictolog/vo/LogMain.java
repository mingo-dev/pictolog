package pictolog.vo;

import java.util.List;

/**
 * LogView.jsp 파일 로딩시 사용되는 VO Class Log를 상속받으며 Log Comment 와 Log Like 를
 * ArrayList로 가진다.
 * 
 * @author JISEONG
 */
public class LogMain extends Log {

	private String log_profile_photo; // member profile 사진
	private List<LogLike> log_like_list; // 로그 좋아요
	private List<LogComment> log_comment_list; // 로그의 댓글
	private List<LogTag> log_tag_list; // 사진에서 분석한 로그 태그
	private List<Member> following_list; // 내가 팔로잉 하는 사람들 리스트
	private List<Member> follower_list; // 나를 팔로우하는 사람들 리스트
	private List<Photo> photoList;
	
	public LogMain(){
		super();
	}
	
	public String getLog_profile_photo() {
		return log_profile_photo;
	}

	public void setLog_profile_photo(String log_profile_photo) {
		this.log_profile_photo = log_profile_photo;
	}

	public List<LogLike> getLog_like_list() {
		return log_like_list;
	}

	public void setLog_like_list(List<LogLike> log_like_list) {
		this.log_like_list = log_like_list;
	}

	public List<LogComment> getLog_comment_list() {
		return log_comment_list;
	}

	public void setLog_comment_list(List<LogComment> log_comment_list) {
		this.log_comment_list = log_comment_list;
	}

	public List<LogTag> getLog_tag_list() {
		return log_tag_list;
	}

	public void setLog_tag_list(List<LogTag> log_tag_list) {
		this.log_tag_list = log_tag_list;
	}

	public List<Member> getFollowing_list() {
		return following_list;
	}

	public void setFollowing_list(List<Member> following_list) {
		this.following_list = following_list;
	}

	public List<Member> getFollower_list() {
		return follower_list;
	}

	public void setFollower_list(List<Member> follower_list) {
		this.follower_list = follower_list;
	}

	public List<Photo> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(List<Photo> photoList) {
		this.photoList = photoList;
	}

	@Override
	public String toString() {
		return "LogMain [log_profile_photo=" + log_profile_photo + ", log_like_list=" + log_like_list
				+ ", log_comment_list=" + log_comment_list + ", log_tag_list=" + log_tag_list + ", following_list="
				+ following_list + ", follower_list=" + follower_list + ", photoList=" + photoList + "]";
	}

	
	
	

}
