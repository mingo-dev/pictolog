package pictolog.vo;
/**
 * 업로드 된 사진을 분석하여 나온 정보중 태그 정보를 저장하는 vo 
 * 사진의 태그 정보는 중복확인을 통해 로그 태로그 선정이 된다. 
 * 로그 태그로 선정된 태그는 로그 아이디 값을 갖는다. 
 * tag_name으로 검색한다. 
 * 
 * @author Minsu
 *
 */

public class PhotoTag {
	private int photo_tag_id;		// 사진 태그를 지칭하는 아이디 
	private String photo_tag_name;	// 태그 정보  
	private String member_id;		// 태그를 가지고 있는 사용자 
	private int photo_id;			// 해당 태그가 지칭하는 사진 
	private String log_id;			// 해당 태그가 지칭하는 로그, 로그에 달리는 태그만 가지고 있다. 
	
	public PhotoTag() {}
	
	public PhotoTag(String photo_tag_name) {
		this.photo_tag_name = photo_tag_name;
	}
	
	public int getPhoto_tag_id() {
		return photo_tag_id;
	}

	public void setPhoto_tag_id(int photo_tag_id) {
		this.photo_tag_id = photo_tag_id;
	}

	public String getPhoto_tag_name() {
		return photo_tag_name;
	}

	public void setPhoto_tag_name(String photo_tag_name) {
		this.photo_tag_name = photo_tag_name;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getPhoto_id() {
		return photo_id;
	}

	public void setPhoto_id(int photo_id) {
		this.photo_id = photo_id;
	}

	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	@Override
	public String toString() {
		return "PhotoTag [photo_tag_id=" + photo_tag_id + ", photo_tag_name=" + photo_tag_name + ", member_id="
				+ member_id + ", photo_id=" + photo_id + ", log_id=" + log_id + "]";
	}

	
}
