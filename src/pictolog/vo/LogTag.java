package pictolog.vo;
/**
 * 사진 태그 정보를 분석한 후에 로그 태그가 선정 된다. 
 * 선정된 태그 상위 5개(주복이 많은 태그 순서 )로 로그 태그를 생성한다. 
 * 생성된 태그는 순위를 매겨 정렬한다. 

 * @author Minsu
 *
 */

public class LogTag {
	private int log_tag_id;			// 로그 태그 아이디 값
	private String log_tag_name;	// 사진에서 만들어진 태그 값이 저장 된다. 상위 3~5개 
	private String log_id;			// 태그가 붙은 로그를 지칭 
	private String member_id;		// 로그를 생성한 사용자 
	private int log_tag_rank;		// 로그 태그에서 우선 순위를 부여하여 순서대로 정렬한다. 

	public int getLog_tag_id() {
		return log_tag_id;
	}

	public void setLog_tag_id(int log_tag_id) {
		this.log_tag_id = log_tag_id;
	}

	public String getLog_tag_name() {
		return log_tag_name;
	}

	public void setLog_tag_name(String log_tag_name) {
		this.log_tag_name = log_tag_name;
	}

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

	public int getLog_tag_rank() {
		return log_tag_rank;
	}

	public void setLog_tag_rank(int log_tag_rank) {
		this.log_tag_rank = log_tag_rank;
	}

	@Override
	public String toString() {
		return "LogTag [log_tag_id=" + log_tag_id + ", log_tag_name=" + log_tag_name + ", log_id=" + log_id
				+ ", member_id=" + member_id + ", log_tag_rank=" + log_tag_rank + "]";
	}

	

}
