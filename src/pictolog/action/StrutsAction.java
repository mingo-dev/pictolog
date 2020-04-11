package pictolog.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.MemberDAO;
import pictolog.dao.PageDAO;
import pictolog.vo.Info;
import pictolog.vo.Member;

@SuppressWarnings("serial")
public class StrutsAction extends ActionSupport implements SessionAware {
	private Map<String, Object> session;

	private String log_id;
	private int photo_id;
	private int logListSize;

	private Member member;
	private String member_id;
	private List<Member> followingList;
	private List<Member> followerList;

	private String searchTag;
	
	private int info_id;
	private List<Info> infoList;
	
	
	// 로그 클릭시 log_id 받아서 일단 logView.jsp로 이동시켜줌
	public String logView() {
		if(info_id != 0) {
			new MemberDAO().updateInfo(info_id);
		}
		return SUCCESS;
	}

	// 계정 설정 페이지 이동
	public String memberSetting() {
		MemberDAO memberDAO = new MemberDAO();
		member = (Member) session.get("login");
		member_id = member.getMember_id();
		member = memberDAO.selectMember(member_id);
		session.put("login", member);
		logListSize = new PageDAO().selectPrivateSelfTotal(member_id);
		followingList = memberDAO.selectFollowingList(member_id);
		followerList = memberDAO.selectFollowerList(member_id);
		
		//알림 select
		infoList = new MemberDAO().selectInfoList(member_id);
		return SUCCESS;
	}

	// 멤버 아이디 값을 받아서 그대로 반환하는 메소드
	public String memberGo() {
		if(info_id != 0) {
			new MemberDAO().updateInfo(info_id);
		}
		return SUCCESS;
	}

	// 로그 태그키워드 검색
	public String searchResult() {
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	/* Getters & Setters */
	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	public int getLogListSize() {
		return logListSize;
	}

	public void setLogListSize(int logListSize) {
		this.logListSize = logListSize;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public List<Member> getFollowingList() {
		return followingList;
	}

	public void setFollowingList(List<Member> followingList) {
		this.followingList = followingList;
	}

	public List<Member> getFollowerList() {
		return followerList;
	}

	public void setFollowerList(List<Member> followerList) {
		this.followerList = followerList;
	}

	public String getSearchTag() {
		return searchTag;
	}

	public void setSearchTag(String searchTag) {
		this.searchTag = searchTag;
	}

	public int getInfo_id() {
		return info_id;
	}

	public void setInfo_id(int info_id) {
		this.info_id = info_id;
	}

	public int getPhoto_id() {
		return photo_id;
	}

	public void setPhoto_id(int photo_id) {
		this.photo_id = photo_id;
	}

	public List<Info> getInfoList() {
		return infoList;
	}

	public void setInfoList(List<Info> infoList) {
		this.infoList = infoList;
	}
	
}
