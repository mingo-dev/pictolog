package pictolog.vo;

/**
 * 로그의 정보를 담고 있는 vo 사용자가 화면에서 사진을 업로드 하여 로그를 생성하는 경우 각각 생성된 사진 정보를 분석하여 로그를
 * 생성한다. 날짜, 사용자 아이디, 랜덤 함수 값으로 로그 태이블을 생성한다. 사진 vo가 생성된 이후에 사진 정보를 바탕으로 분석 된
 * 자료를 통해서 main_photo_name, log_tag_name_first, main_photo_name이 생성된다.
 * 
 * @author Minsu
 *
 */
public class Log {
	private String log_id; 				// 로그 아이디 primary key
	private String member_id; 			// 어떠한 사용자가 로그를 생성 했는지 가리킨다.
	private String log_text; 			// 로그에 대한 설명, default 값으로 null을 갖는다.
	private String main_photo_name; 	// main 화면에서 나타나는 로그이 대표 사진, 로그 내부에 있는 photo
	private String log_title;			// 로그 제목
	private int log_public; 			// 로그 공개 여부 (1:공개 0:비공개)
	private String log_regdate; 		// 로그 등록일 (sysdate)
	private int photo_total_like_count; // 로그 내부에 있는 사진들의 전체 좋아요 수를 합하여 저장한다. 포토
	private String log_tag_name_first; 	// 사진의 태그 중에서 중복도가 가장 높은 태그 하나

	private int log_like_count;			// 로그 좋아요 카운트 수

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

	public String getLog_text() {
		return log_text;
	}

	public void setLog_text(String log_text) {
		this.log_text = log_text;
	}

	public int getLog_like_count() {
		return log_like_count;
	}

	public void setLog_like_count(int log_like_count) {
		this.log_like_count = log_like_count;
	}

	public String getMain_photo_name() {
		return main_photo_name;
	}

	public void setMain_photo_name(String main_photo_name) {
		this.main_photo_name = main_photo_name;
	}

	public String getLog_title() {
		return log_title;
	}

	public void setLog_title(String log_title) {
		this.log_title = log_title;
	}

	public int getLog_public() {
		return log_public;
	}

	public void setLog_public(int log_public) {
		this.log_public = log_public;
	}

	public String getLog_regdate() {
		return log_regdate;
	}

	public void setLog_regdate(String log_regdate) {
		this.log_regdate = log_regdate;
	}

	public int getPhoto_total_like_count() {
		return photo_total_like_count;
	}

	public void setPhoto_total_like_count(int photo_total_like_count) {
		this.photo_total_like_count = photo_total_like_count;
	}

	public String getLog_tag_name_first() {
		return log_tag_name_first;
	}

	public void setLog_tag_name_first(String log_tag_name_first) {
		this.log_tag_name_first = log_tag_name_first;
	}

	@Override
	public String toString() {
		return "Log [log_id=" + log_id + ", member_id=" + member_id + ", log_text=" + log_text + ", main_photo_name="
				+ main_photo_name + ", log_title=" + log_title + ", log_public=" + log_public + ", log_regdate="
				+ log_regdate + ", photo_total_like_count=" + photo_total_like_count + ", log_tag_name_first="
				+ log_tag_name_first + ", log_like_count=" + log_like_count + "]";
	}
}
