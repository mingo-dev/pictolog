package pictolog.vo;
/**
 * 관심 태그는 한사람당 10개.
 * 아이디가 생성되는 경우 우선 10개의 interestingTag가 생성 된다. 
 * 기본적으로 flag는 0으로 선언되며 로그가 생성될때 중복되는 상위 10개의 태그 정보를 저장한다. 
 * 메인 화면에서 사용자의 상위 10개의 태그를 이용하여 추천해 준다. 
 * 사용자가 현재 가장 많이 가지고 있는 태그를 나타낸다. 
 * 
 * @author Minsu
 *
 */
public class InterestingTag {
	private String interesting_tag_id;		// interesting 태그 를 지칭하는 아이디 값, primary key 선언 
	private String interesting_tag_name;	// 태그 이름 
	private String member_id;				// 사용자 아이디 
	private int interesting_tag_flag;		// 태그 존재 여부, 좋아하는 태그가 있는 경우 1, 없는 경우는 0 
	private int interesting_tag_rank;		// 태그 중복 갯수를 확인 하여 등수를 매긴다. 
	
	
	public String getInteresting_tag_id() {
		return interesting_tag_id;
	}
	
	public void setInteresting_tag_id(String interesting_tag_id) {
		this.interesting_tag_id = interesting_tag_id;
	}
	
	public String getInteresting_tag_name() {
		return interesting_tag_name;
	}
	
	public void setInteresting_tag_name(String interesting_tag_name) {
		this.interesting_tag_name = interesting_tag_name;
	}
	
	public String getMember_id() {
		return member_id;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public int getInteresting_tag_flag() {
		return interesting_tag_flag;
	}
	
	public void setInteresting_tag_flag(int interesting_tag_flag) {
		this.interesting_tag_flag = interesting_tag_flag;
	}

	public int getInteresting_tag_rank() {
		return interesting_tag_rank;
	}

	public void setInteresting_tag_rank(int interesting_tag_rank) {
		this.interesting_tag_rank = interesting_tag_rank;
	}

	@Override
	public String toString() {
		return "InterestingTag [interesting_tag_id=" + interesting_tag_id + ", interesting_tag_name="
				+ interesting_tag_name + ", member_id=" + member_id + ", interesting_tag_flag=" + interesting_tag_flag
				+ ", interesting_tag_rank=" + interesting_tag_rank + "]";
	}

	

}
