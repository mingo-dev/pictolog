package pictolog.vo;
/**
 * 사진의 좋아요 정보를 저장하는 vo 
 * 로그에 대한 좋아요와 사진에 대한 좋아요를 구분하여 
 * 로그 좋아요 이외에 사진의 좋아요를 합산하여 좋아요가 많은 로그를 추천해 준다. 
 * 
 * @author Minsu
 *
 */
public class PhotoLike {
	private int photo_like_id;		// 사진 좋아요를 지칭하는 아이디 값 
	private String member_id;		// 좋아요를 누른 사용자 아이디 
	private int photo_id;			// 해당 좋아요 사진 아이디 

	public int getPhoto_like_id() {
		return photo_like_id;
	}

	public void setPhoto_like_id(int photo_like_id) {
		this.photo_like_id = photo_like_id;
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

}
