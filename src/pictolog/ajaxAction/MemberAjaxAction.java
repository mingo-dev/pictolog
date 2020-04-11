
package pictolog.ajaxAction;

import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.MemberDAO;
import pictolog.util.SendMail;
import pictolog.vo.Info;
import pictolog.vo.Member;

@SuppressWarnings("serial")
public class MemberAjaxAction extends ActionSupport implements SessionAware {
	// Fields
	private Member member;
	private List<Member> followingList;
	private List<Member> followerList;
	private Map<String, Object> session;
	private boolean check;
	private List<Info> infoList;
	// 멤버
	public String join() {
		System.out.println(member.toString());
		member.setProfile_photo("img/noImage.jpg");
		boolean result = new MemberDAO().insertMember(member);
		new MemberDAO().createInterestingTag(member.getMember_id());
		if (result == true) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}

	// 부가기능 : join & login시 사용하는 기능들
	// 가입시 아이디 ajax로 중복 체크
	public String idCheck() {
		String foundId = new MemberDAO().idCheck(member.getMember_id());
		member.setMember_id(foundId);
		return SUCCESS;
	}

	// 가입시 이메일 ajax로 중복 체크
	public String emailCheck() {
		String email = new MemberDAO().emailCheck(member.getEmail());
		member.setEmail(email);
		return SUCCESS;
	}

	public String findId() {
		String member_id = new MemberDAO().findId(member.getEmail());
		if (member_id != null) {
			member.setMember_id(member_id);
			return SUCCESS;
		} else {
			return ERROR;
		}
	}

	public String findPassword() {
		String member_id = member.getMember_id();
		String email = member.getEmail();
		String password = new MemberDAO().findPassword(email, member_id);
		if (password != null) {
			try {
				new SendMail(email, password, member_id);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			return SUCCESS;
			// 받아온 비밀번호를 멤버의 이메일로 보내기.
		} else {
			return ERROR;
		}
	}

	// 부가기능 : following & follower
	public String insertFollowing() {
		Member follower_me = (Member) session.get("login");
		Member following_you = member;
		boolean result = new MemberDAO().insertFollowing(follower_me, following_you);
		
		//알림 insert
		Info info = new Info(following_you.getMember_id(), "follow");
		info.setMember_id_you(follower_me.getMember_id());
		info.setLocation("memberPageView.action?member_id="+follower_me.getMember_id());
		new MemberDAO().insertInfo(info);
		
		if (result == true) {
			followerList = new MemberDAO().selectFollowerList(member.getMember_id());
			System.out.println("insert/팔로워리스트 길이:" + followerList.size());
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // insertFollowing

	public String deleteFollowing() {
		Member follower_me = (Member) session.get("login");
		Member following_you = member;
		boolean result = new MemberDAO().deleteFollowing(follower_me, following_you);
		if (result == true) {
			followerList = new MemberDAO().selectFollowerList(member.getMember_id());
			System.out.println("delete/팔로워리스트 길이:" + followerList.size());
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // deleteFollowing

	public String checkFollowing() {
		Member login_member = (Member) session.get("login");
		String login_member_id = login_member.getMember_id();
		String check_member_id = member.getMember_id();
		check = new MemberDAO().checkFollowing(login_member_id, check_member_id);
		return SUCCESS;
	}// checkFollowing

	public String selectFollowingList() {
		Member login_member = (Member) session.get("login");
		String member_id = login_member.getMember_id();
		followingList = new MemberDAO().selectFollowingList(member_id);
		return SUCCESS;
	}// selectFollowingList

	public String selectFollowerList() {
		Member login_member = (Member) session.get("login");
		String member_id = login_member.getMember_id();
		followerList = new MemberDAO().selectFollowerList(member_id);
		return SUCCESS;
	}// selectFollowerList
	
	public String selectInfoList() {
		Member login_member = (Member) session.get("login");
		String member_id = login_member.getMember_id();
		infoList = new MemberDAO().selectInfoList(member_id);
		return SUCCESS;
	}// selectFollowerList

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	// Getters & Setters
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
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

	public boolean isCheck() {
		return check;
	}

	public void setCheck(boolean check) {
		this.check = check;
	}

	public List<Info> getInfoList() {
		return infoList;
	}

	public void setInfoList(List<Info> infoList) {
		this.infoList = infoList;
	}
	
}