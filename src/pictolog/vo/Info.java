package pictolog.vo;

public class Info {
	private int info_id;
	private String member_id_me; //알림 받는 사람
	private String member_id_you;
	private int info_check;
	private String location;
	private String info_type;

	
	//Constructor
	public Info() {
		super();
	}

	public Info(String member_id_me, String info_type) {
		super();
		this.member_id_me = member_id_me;
		this.info_type = info_type;
	}

	//Getters & Setters
	public int getInfo_id() {
		return info_id;
	}

	public void setInfo_id(int info_id) {
		this.info_id = info_id;
	}

	
	public String getMember_id_me() {
		return member_id_me;
	}

	public void setMember_id_me(String member_id_me) {
		this.member_id_me = member_id_me;
	}

	public String getMember_id_you() {
		return member_id_you;
	}

	public void setMember_id_you(String member_id_you) {
		this.member_id_you = member_id_you;
	}

	public int getInfo_check() {
		return info_check;
	}

	public void setInfo_check(int info_check) {
		this.info_check = info_check;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getInfo_type() {
		return info_type;
	}

	public void setInfo_type(String info_type) {
		this.info_type = info_type;
	}
	
	//toString
	@Override
	public String toString() {
		return "Info [info_id=" + info_id + ", member_id_me=" + member_id_me + ", member_id_you=" + member_id_you
				+ ", info_check=" + info_check + ", location=" + location + ", info_type=" + info_type + "]";
	}
	
}
