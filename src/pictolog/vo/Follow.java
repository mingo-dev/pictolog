package pictolog.vo;
/**
 * 사용자 팔로우 팔로잉 정보를 저장하는 vo
 * 메인 페이지 로딩 시 기본적으로 제공되는 추천 로그와 사용자가 선택한 팔로우를 화면에 띄우기 위해 사용 된다. 
 * 내가 팔로우 하는 사람(follower_me)를 화면에 띄운다. 
 * 현재 나를 팔로우 하는 사람을 저장하는 변수는 follwing_you
 * 
 * @author Minsu
 *
 */

public class Follow {
	private int follow_id; 			// 팔로우 primary key.
	private String follower_me;		// 나를 팔로우 하는 사람, 나한테 팔로우 찍은 사람 
	private String following_you;	// 내가 팔로우 하는 사람 , 내가 그사람의 정보를 보기 위해서 팔로우를 한것 

	public int getFollow_id() {
		return follow_id;
	}

	public void setFollow_id(int follow_id) {
		this.follow_id = follow_id;
	}

	public String getFollower_me() {
		return follower_me;
	}

	public void setFollower_me(String follower_me) {
		this.follower_me = follower_me;
	}

	public String getFollowing_you() {
		return following_you;
	}

	public void setFollowing_you(String following_you) {
		this.following_you = following_you;
	}

}
