
package pictolog.ajaxAction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.LogDAO;
import pictolog.dao.MemberDAO;
import pictolog.dao.PageDAO;
import pictolog.dao.PhotoDAO;
import pictolog.util.PageNavigator;
import pictolog.vo.Info;
import pictolog.vo.LogComment;
import pictolog.vo.LogLike;
import pictolog.vo.LogMain;
import pictolog.vo.LogTag;
import pictolog.vo.LogView;
import pictolog.vo.Member;
import pictolog.vo.Photo;

@SuppressWarnings("serial")
public class PageAjaxAction extends ActionSupport implements SessionAware {
	private Map<String, Object> session;

	private int currentPage;
	private int countPerPage;
	private int lastPage;
	private List<LogMain> logMainList;
	private List<LogView> logViewList;
	private List<Photo> photoList;

	private Member member;
	private String member_id;
	private List<Member> followingList;
	private List<Member> followerList;

	private int totalRecordsCount;

	private String searchTag;

	private List<Info> infoList;

	private int photo_id;

	// 메인 페이지에서 로그 데이터 불러오기
	public String mainPageLogLoad() {
		PageDAO dao = new PageDAO();
		System.out.println("현재페이지: " + currentPage);
		countPerPage = Integer.parseInt(getText("photo.countperpage"));
		Member member = (Member) session.get("login");
		// 전체 글 수 구하기
		int totalRecordsCount = dao.selectMainTotal(member.getMember_id());
		// PageNavigator 객체 생성
		PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);
		System.out.println("총 페이지 수 : " + pagenavi.getTotalPageCount());
		lastPage = pagenavi.getTotalPageCount();
		// 전체 레코드 중 현재 페이지에 해당하는 로그 불러오기(select)

		logMainList = dao.selectMainLogList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
				member.getMember_id());

		// 알림 select
		infoList = new MemberDAO().selectInfoList(member_id);

		if (logMainList != null) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}// mainPageLogLoad

	// 멤버뷰 로딩
	public String memberPageView() {
		MemberDAO memberDAO = new MemberDAO();
		LogDAO logDAO = new LogDAO();
		PageDAO pageDAO = new PageDAO();
		countPerPage = Integer.parseInt(getText("photo.countperpage"));
		member_id = member.getMember_id();
		Member login_member = (Member) session.get("login");
		// a. 내가 내 페이지 보는 경우
		if (login_member.getMember_id().equals(member_id)) {
			// 공개, 비공개 다 가져오기
			totalRecordsCount = pageDAO.selectPrivateSelfTotal(member_id);// 전체글수구하기
			PageNavigator pagenavi = new PageNavigator(countPerPage, 1, totalRecordsCount);// PageNavigator객체생성
			// 현재 페이지에 해당하는 글 목록 읽기(전체 레코드 중)
			logMainList = pageDAO.selectPrivateSelfLogList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
					member_id);

			// b. 내가 남 페이지 보는 경우
		} else {
			// 공개된 것만 가져오기
			totalRecordsCount = pageDAO.selectPrivateOtherTotal(member_id);// 전체글수구하기
			PageNavigator pagenavi = new PageNavigator(countPerPage, 1, totalRecordsCount);// PageNavigator객체생성
			// 현재 페이지에 해당하는 글 목록 읽기(전체 레코드 중)

			logMainList = pageDAO.selectPrivateOtherLogList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
					member_id);
			System.out.println(logMainList.toString());

		}
		// c. 공통
		// c1. member_id의 member Vo(member_id, member.profile_photo)
		member = memberDAO.selectMember(member_id);
		// c2. member_id의 followingList
		followingList = memberDAO.selectFollowingList(member_id);
		// c3. member_id의 followerList
		followerList = memberDAO.selectFollowerList(member_id);

		// c4. log_tag_list, log_comment_list, log_like_list
		int logMainListSize = logMainList.size();
		for (int i = 0; i < logMainListSize; i++) {
			String log_id = logMainList.get(i).getLog_id();
			List<LogTag> log_tag_list = logDAO.selectLogTagList(log_id);
			List<LogComment> log_comment_list = logDAO.selectLogCommentList(log_id);
			List<LogLike> log_like_list = logDAO.selectLogLikeList(log_id);
			logMainList.get(i).setLog_tag_list(log_tag_list);
			logMainList.get(i).setLog_comment_list(log_comment_list);
			logMainList.get(i).setLog_like_list(log_like_list);
		}

		// 알림 select
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	} // memberPageView

	public String memberPageLogAjax() {
		LogDAO logDAO = new LogDAO();
		PageDAO pageDAO = new PageDAO();
		logMainList = new ArrayList<LogMain>();
		countPerPage = Integer.parseInt(getText("photo.countperpage"));
		member_id = member.getMember_id();
		Member login_member = (Member) session.get("login");
		// a. 내가 내 페이지 보는 경우
		if (login_member.getMember_id().equals(member_id)) {
			// 공개, 비공개 다 가져오기
			totalRecordsCount = pageDAO.selectPrivateSelfTotal(member_id);// 전체글수구하기
			PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);// PageNavigator객체생성
			if (pagenavi.getTotalPageCount() < currentPage) {
				return SUCCESS;
			}
			// 현재 페이지에 해당하는 글 목록 읽기(전체 레코드 중)
			logMainList = pageDAO.selectPrivateSelfLogList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
					member_id);

			// b. 내가 남 페이지 보는 경우
		} else {
			// 공개된 것만 가져오기
			totalRecordsCount = pageDAO.selectPrivateOtherTotal(member_id);// 전체글수구하기
			PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);// PageNavigator객체생성
			if (pagenavi.getTotalPageCount() < currentPage) {
				return SUCCESS;
			}
			// 현재 페이지에 해당하는 글 목록 읽기(전체 레코드 중)
			logMainList = pageDAO.selectPrivateOtherLogList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
					member_id);

		}
		// c4. log_tag_list, log_comment_list, log_like_list
		int logMainListSize = logMainList.size();
		for (int i = 0; i < logMainListSize; i++) {
			String log_id = logMainList.get(i).getLog_id();
			List<LogTag> log_tag_list = logDAO.selectLogTagList(log_id);
			List<LogComment> log_comment_list = logDAO.selectLogCommentList(log_id);
			List<LogLike> log_like_list = logDAO.selectLogLikeList(log_id);
			logMainList.get(i).setLog_tag_list(log_tag_list);
			logMainList.get(i).setLog_comment_list(log_comment_list);
			logMainList.get(i).setLog_like_list(log_like_list);
		}

		// 알림 select
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	}

	public String memberPagePhotoAjax() {
		LogDAO logDAO = new LogDAO();
		PageDAO pageDAO = new PageDAO();
		PhotoDAO photoDAO = new PhotoDAO();
		logViewList = new ArrayList<LogView>();
		countPerPage = Integer.parseInt(getText("photo.countperpage"));
		member_id = member.getMember_id();
		Member login_member = (Member) session.get("login");
		// a. 내가 내 페이지 보는 경우
		if (login_member.getMember_id().equals(member_id)) {
			// 공개, 비공개 다 가져오기
			totalRecordsCount = pageDAO.selectPrivateSelfTotal(member_id);// 전체글수구하기
			PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);// PageNavigator객체생성
			if (pagenavi.getTotalPageCount() < currentPage) {
				return SUCCESS;
			}
			// 현재 페이지에 해당하는 글 목록 읽기(전체 레코드 중)
			logViewList = pageDAO.selectPrivateSelfPhotoList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
					member_id);

			// b. 내가 남 페이지 보는 경우
		} else {
			// 공개된 것만 가져오기
			totalRecordsCount = pageDAO.selectPrivateOtherTotal(member_id);// 전체글수구하기
			PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);// PageNavigator객체생성
			if (pagenavi.getTotalPageCount() < currentPage) {
				return SUCCESS;
			}
			// 현재 페이지에 해당하는 글 목록 읽기(전체 레코드 중)
			logViewList = pageDAO.selectPrivateOtherPhotoList(pagenavi.getStartRecord(), pagenavi.getCountPerPage(),
					member_id);

		}
		// c4. log_tag_list, log_comment_list, log_like_list
		int logViewListSize = logViewList.size();
		for (int i = 0; i < logViewListSize; i++) {
			String log_id = logViewList.get(i).getLog_id();
			List<Photo> photoList = photoDAO.selectPhotoList(log_id);
			logViewList.get(i).setPhotoList(photoList);
			List<LogTag> logTagList = logDAO.selectLogTagList(log_id);
			logViewList.get(i).setLogTagList(logTagList);
		}

		// 알림 select
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	}

	// log_tag 중에서 검색, logMainList 반환
	public String searchLogByTag() {
		PageDAO pageDAO = new PageDAO();
		countPerPage = Integer.parseInt(getText("photo.countperpage"));
		totalRecordsCount = pageDAO.selectLogTotalByTag(searchTag);

		PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);
		lastPage = pagenavi.getTotalPageCount();
		logMainList = pageDAO.selectLogMainListByTag(searchTag, pagenavi.getStartRecord(), countPerPage);

		// 알림 select
		Member login_member = (Member) session.get("login");
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	}

	// photo_tag 중에서 검색, PhotoList 반환
	public String searchPhotoByTag() {
		PageDAO pageDAO = new PageDAO();
		countPerPage = Integer.parseInt(getText("searchedphotos.countperpage"));
		totalRecordsCount = pageDAO.selectPhotoTotalByTag(searchTag);

		PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);
		lastPage = pagenavi.getTotalPageCount();
		photoList = pageDAO.selectPhotoListByTag(searchTag, pagenavi.getStartRecord(), countPerPage);
		System.out.println("photoList " + photoList.toString());

		// 알림 select
		Member login_member = (Member) session.get("login");
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	}

	// log_tag 중에서 검색, logMainList 반환 (멤버뷰페이지내에서 검색)
	public String searchLogByTagForMemberView() {
		PageDAO pageDAO = new PageDAO();
		countPerPage = Integer.parseInt(getText("photo.countperpage"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("member_id", member_id);
		map.put("searchTag", searchTag);
		totalRecordsCount = pageDAO.selectLogTotalByTagForMemberView(map);

		PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);
		logMainList = pageDAO.selectLogMainListByTagForMemberView(map, pagenavi.getStartRecord(), countPerPage);
		System.out.println(logMainList.toString());

		// 알림 select
		Member login_member = (Member) session.get("login");
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	}

	// photo_tag 중에서 검색, PhotoList 반환 (멤버뷰페이지내에서 검색)
	public String searchPhotoByTagForMemberView() {
		System.out.println("멤버 검색 :" + member_id + " 그리고" + searchTag);
		PageDAO pageDAO = new PageDAO();
		countPerPage = Integer.parseInt(getText("searchedphotos.countperpage"));
		HashMap<String, Object> map = new HashMap<>();
		map.put("member_id", member_id);
		map.put("searchTag", searchTag);
		totalRecordsCount = pageDAO.selectPhotoTotalByTagForMemberView(map);

		PageNavigator pagenavi = new PageNavigator(countPerPage, currentPage, totalRecordsCount);
		lastPage = pagenavi.getTotalPageCount();
		photoList = pageDAO.selectPhotoListByTagForMemberView(map, pagenavi.getStartRecord(), countPerPage);
		System.out.println("photoList " + photoList.toString());

		// 알림 select
		Member login_member = (Member) session.get("login");
		infoList = new MemberDAO().selectInfoList(login_member.getMember_id());

		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	// Getters & Setters

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public List<LogMain> getLogMainList() {
		return logMainList;
	}

	public void setLogMainList(List<LogMain> logMainList) {
		this.logMainList = logMainList;
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

	public int getTotalRecordsCount() {
		return totalRecordsCount;
	}

	public void setTotalRecordsCount(int totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	public List<LogView> getLogViewList() {
		return logViewList;
	}

	public void setLogViewList(List<LogView> logViewList) {
		this.logViewList = logViewList;
	}

	public String getSearchTag() {
		return searchTag;
	}

	public void setSearchTag(String searchTag) {
		this.searchTag = searchTag;
	}

	public List<Photo> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(List<Photo> photoList) {
		this.photoList = photoList;
	}

	public List<Info> getInfoList() {
		return infoList;
	}

	public void setInfoList(List<Info> infoList) {
		this.infoList = infoList;
	}

}