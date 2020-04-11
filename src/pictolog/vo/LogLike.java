package pictolog.vo;
/**
 * 로그를 좋아하는 사람들의 아이값과 전체 카운트를 이용하여 좋아요 수를 나타낸다. 
 * 
 * @author Minsu
 *
 */

public class LogLike {
	private int log_like_id;	// 로그 좋아요를 만들기 위한 primary key
	private String member_id;	// '좋아요' 누른 사람 
	private String log_id;		// '좋아요'가 눌러진  해당 로그 

	public int getLog_like_id() {
		return log_like_id;
	}

	public void setLog_like_id(int log_like_id) {
		this.log_like_id = log_like_id;
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

}
