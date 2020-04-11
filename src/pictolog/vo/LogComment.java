package pictolog.vo;
/**
 * 로그의 댓글 정보를 저장하는 vo
 * 사용자가 댓글을 적는 경우  log id 값을 받아서 database에 저장한다. 
 * 로그댓글 아이디, 지칭하는 로그, 댓글 내용, 로그를 작성한 사용자, 작성 날짜를 변수로 받는다.   
 * 사용자에게 보여지는 댓글은 날짜 순서로 정렬 한다. 
 * 
 * @author Minsu
 *
 */

public class LogComment {
	private int log_comm_id;		// 로그 댓글 아이디 
	private String log_comm_text;	// 댓글 내용 
	private String member_id;		// 댓글 작성자 아이디
	private String log_id;			// 댓글이 달린 로그 
	private String log_comm_regdate;// 댓글 입력 날짜

	public int getLog_comm_id() {
		return log_comm_id;
	}

	public void setLog_comm_id(int log_comm_id) {
		this.log_comm_id = log_comm_id;
	}

	public String getLog_comm_text() {
		return log_comm_text;
	}

	public void setLog_comm_text(String log_comm_text) {
		this.log_comm_text = log_comm_text;
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

	public String getLog_comm_regdate() {
		return log_comm_regdate;
	}

	public void setLog_comm_regdate(String log_comm_regdate) {
		this.log_comm_regdate = log_comm_regdate;
	}

	@Override
	public String toString() {
		return "LogComment [log_comm_id=" + log_comm_id + ", log_comm_text=" + log_comm_text + ", member_id="
				+ member_id + ", log_id=" + log_id + ", log_comm_regdate=" + log_comm_regdate + "]";
	}

}
