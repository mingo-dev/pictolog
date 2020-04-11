package pictolog.vo;

/**
 *  User의 기본 정보를 저장하는  vo
 *  사용자가 입력한 정보를 받아서 db에 저장한다. 
 *  개인 프로필 정보를 열람하는 경우 log, photo와 함께 사용 되어진다. 
 *  개인 정보를 수정하는 경우 사용자에게 정보를 입력 받아서 database에 저장된 내용을 수정한다. 
 *  
 * @author Minsu
 *
 */

public class Member {
	private String member_id; 			// 사용자 아이디  primary key
	private String email;				// 사용자 email
	private String password;			// 사용자 비밀번호 
	private String profile_photo;		// 사용자 프로필 사진 
	private int age;					// 사용자 나이 
	private int gender;					// 사용자 성별 

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getProfile_photo() {
		return profile_photo;
	}

	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "Member [member_id=" + member_id + ", email=" + email + ", password=" + password + ", profile_photo="
				+ profile_photo + ", age=" + age + ", gender=" + gender + "]";
	}

}
