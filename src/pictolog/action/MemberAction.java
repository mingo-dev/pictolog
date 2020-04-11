package pictolog.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.MemberDAO;
import pictolog.dao.PhotoDAO;
import pictolog.util.ProfilePhotoFileService;
import pictolog.util.SaveDuplicatedTagsByOrder;
import pictolog.vo.Member;

@SuppressWarnings("serial")
public class MemberAction extends ActionSupport implements SessionAware {
	// Fields
	private Map<String, Object> session;
	private Member member;
	private String member_id;
	private String email;
	private String password;
	private String profile_photo;
	private int age;
	private int gender;
	private String uploadFileName;
	private String uploadContentType;
	private File upload;

	private int logListSize;
	private List<Member> followingList;
	private List<Member> followerList;

	// 멤버
	@SuppressWarnings("deprecation")
	public String updateProfilePhoto(String member_id) {
		try {
			if (upload != null) {

				String saveFolder = "img/";
				HttpServletRequest request = ServletActionContext.getRequest();
				String basePath = request.getRealPath(saveFolder);
				System.out.println("basePath: " + basePath);
				ProfilePhotoFileService fs = new ProfilePhotoFileService();
				String savefile = fs.saveProfilePhotoFile(upload, basePath, uploadFileName, member.getMember_id());
				// member.getMember_id ? member_id?
				if (savefile != null) {
					member.setProfile_photo(saveFolder + member_id + "/" + savefile);
					new MemberDAO().updateProfilePhoto(member);
				} else {
					System.out.println("saveProfilePhotoFile returns null.");
					return ERROR;
				} // else
			} // if
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	// 부가기능 : login & logout
	public String login() {
		member = new MemberDAO().login(member);
		if (member != null) {
			System.out.println(member.getMember_id());
			session.put("login", member);
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // login

	public String logout() {
		MemberDAO dao = new MemberDAO();
		member = (Member) session.get("login");
		member_id = member.getMember_id();
		ArrayList<String> tagNameList = (ArrayList<String>) new PhotoDAO().selectPhotoTagListOfMember(member_id);
		tagNameList = SaveDuplicatedTagsByOrder.execute(tagNameList);
		dao.updateInterestingTag(tagNameList, member_id);

		session.clear();
		return SUCCESS;
	} // logout

	public String updateMember() {
		new MemberDAO().updateMember(member);
		return SUCCESS;
	}

	public String updateMemberSetting() {
		if (upload != null) {
			System.out.println("updateMemberSetting: " + upload);
			updateProfilePhoto(member.getMember_id());
		}
		boolean result = new MemberDAO().updateMember(member);
		if (result == true) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}// deleteFollowing

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

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public int getLogListSize() {
		return logListSize;
	}

	public void setLogListSize(int logListSize) {
		this.logListSize = logListSize;
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

}
