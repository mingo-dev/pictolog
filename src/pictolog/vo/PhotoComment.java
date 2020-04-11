package pictolog.vo;
/**
 * 개별 사진에 달리는 댓글 vo 
 * 사진에 달린 댓글의 정보를 받아서 db에 저장하는 vo이다. 
 * 지칭하는 사진 값, 입력한 사용자, 댓글 내용, 댓글이 달린 날짜 등이 저장 된다. 
 * 
 * @author Minsu
 *
 */
public class PhotoComment {
	private int photo_comm_id;			// 사진에 등록된 댓글 아이디 
	private String photo_comm_text;		// 사진 댓글 내용
	private String member_id;			// 사진을 등록한 사용자 아이디 
	private int photo_id;				// 댓글이 달린 사진 아이디 
	private String photo_comm_regdate;	// 사진 댓글이 달린 날짜

	public int getPhoto_comm_id() {
		return photo_comm_id;
	}

	public void setPhoto_comm_id(int photo_comm_id) {
		this.photo_comm_id = photo_comm_id;
	}

	public String getPhoto_comm_text() {
		return photo_comm_text;
	}

	public void setPhoto_comm_text(String photo_comm_text) {
		this.photo_comm_text = photo_comm_text;
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

	public String getPhoto_comm_regdate() {
		return photo_comm_regdate;
	}

	public void setPhoto_comm_regdate(String photo_comm_regdate) {
		this.photo_comm_regdate = photo_comm_regdate;
	}

	@Override
	public String toString() {
		return "PhotoComment [photo_comm_id=" + photo_comm_id + ", photo_comm_text=" + photo_comm_text + ", member_id="
				+ member_id + ", photo_id=" + photo_id + ", photo_comm_regdate=" + photo_comm_regdate + "]";
	}
	
	
}
