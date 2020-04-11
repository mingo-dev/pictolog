package pictolog.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import pictolog.util.MybatisSqlSessionFactory;
import pictolog.vo.LogMain;
import pictolog.vo.LogView;
import pictolog.vo.Photo;

public class PageDAO {

	private SqlSessionFactory f = MybatisSqlSessionFactory.getSqlSesstionFactory();
	private SqlSession ss;
	
	
	/**
	 * 메인페이지에서 불러올 로그의 전체 갯수를 반환한다.
	 * @param member_id : 로그인한 사용자의 멤버 아이디
	 * @return 로그인한 사용자의 메인페이지에 불러올 로그의 전체 갯수
	 * @author jiyoung
	 */
	public int selectMainTotal(String member_id) {
		int result = 0;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectMainTotal", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		return result;
	}

	/**
	 * 메인 페이지에 불러올 로그를 페이징 처리하여 가져온다.
	 * @param startRecord : 불러올 페이지의 첫번째 로그
	 * @param countPerPage : 한 페이지 당 불러올 로그 갯수
	 * @param member_id : 로그인한 사용자의 멤버 아이디
	 * @return 로그인 한 사용자의 메인 페이지의 현재 페이지에 해당하는 로그들
	 * @author jiyoung
	 */
	public List<LogMain> selectMainLogList(int startRecord, int countPerPage, String member_id) {
		List<LogMain> resultList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			resultList = ss.selectList("PageMapper.selectMainLogList", member_id, bound);
			
			for(LogMain logMain : resultList) {
				logMain.setLog_profile_photo(ss.selectOne("MemberMapper.findProfilePhoto", logMain.getMember_id()));
				logMain.setLog_comment_list(ss.selectList("LogMapper.selectLogCommentList",logMain.getLog_id()));
				logMain.setLog_like_list(ss.selectList("LogMapper.selectLogLikeList",logMain.getLog_id()));
				logMain.setLog_tag_list(ss.selectList("LogMapper.selectLogTagList", logMain.getLog_id()));
				logMain.setFollower_list(ss.selectList("MemberMapper.selectFollowerList", logMain.getMember_id()));
				logMain.setFollowing_list(ss.selectList("MemberMapper.selectFollowingList", logMain.getMember_id()));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.commit();
			ss.close();
		}

		return resultList;
	} // mainLogList

	//멤버뷰 로딩
	public int selectPrivateSelfTotal(String member_id) {
		int result = -1;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectPrivateSelfTotal", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		return result;
	}
	
	public List<LogMain> selectPrivateSelfLogList(int startRecord, int countPerPage, String member_id) {
		List<LogMain> logMainList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			logMainList = ss.selectList("PageMapper.selectPrivateSelfLogList", member_id, bound);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}

		return logMainList;
	} // selectPrivateLogList
	
	public int selectPrivateOtherTotal(String member_id) {
		int result = -1;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectPrivateOtherTotal", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		return result;
	}
	
	public List<LogMain> selectPrivateOtherLogList(int startRecord, int countPerPage, String member_id) {
		List<LogMain> logMainList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			logMainList = ss.selectList("PageMapper.selectPrivateOtherLogList", member_id, bound);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}

		return logMainList;
	}
	
	public List<LogView> selectPrivateSelfPhotoList(int startRecord, int countPerPage, String member_id) {
		List<LogView> logViewList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			logViewList = ss.selectList("PageMapper.selectPrivateSelfPhotoList", member_id, bound);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}

		return logViewList;
	} // selectPrivateLogList

	public List<LogView> selectPrivateOtherPhotoList(int startRecord, int countPerPage, String member_id) {
		List<LogView> logViewList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			logViewList = ss.selectList("PageMapper.selectPrivateOtherPhotoList", member_id, bound);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}

		return logViewList;
	}
	
	//검색
	public int selectLogTotalByTag(String tagKeyword) {
		int result = -1;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectLogTotalByTag", tagKeyword);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // searchLogByKeyword
	
	public List<LogMain> selectLogMainListByTag(String tagKeyword, int startRecord, int countPerPage) {
		List<LogMain> logMainList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			logMainList = ss.selectList("PageMapper.selectLogMainListByTag", tagKeyword, bound);
			for (LogMain logMain : logMainList) {
				logMain.setLog_profile_photo(ss.selectOne("MemberMapper.findProfilePhoto", logMain.getMember_id()));
				logMain.setLog_comment_list(ss.selectList("LogMapper.selectLogCommentList", logMain.getLog_id()));
				logMain.setLog_like_count(ss.selectOne("LogMapper.selectLogLikeCount", logMain.getLog_id()));
				logMain.setLog_tag_list(ss.selectList("LogMapper.selectLogTagList", logMain.getLog_id()));
				logMain.setPhotoList(ss.selectList("PhotoMapper.selectPhotoList", logMain.getLog_id()));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}

		return logMainList;
	} // searchLogByKeyword
	
	public int selectPhotoTotalByTag(String tagName) {
		int result = -1;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectPhotoTotalByTag", tagName);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	}
	
	public List<Photo> selectPhotoListByTag(String tagName, int startRecord, int countPerPage) {
		List<Photo> photoList = null;
		ss = f.openSession();
		try {
			RowBounds bound = new RowBounds(startRecord, countPerPage);
			photoList = ss.selectList("PageMapper.selectPhotoListByTag", tagName, bound);
			for (Photo photo : photoList) {
				photo.setPhotoCommentList(ss.selectList("PhotoMapper.selectPhotoCommentList", photo.getPhoto_id()));
				photo.setPhotoTagList(ss.selectList("PhotoMapper.selectPhotoTagList", photo.getPhoto_id()));
			}
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photoList;
	}
	
	//개인페이지 (멤버뷰용)
	public int selectLogTotalByTagForMemberView(HashMap<String, Object> map) {
		int result = -1;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectLogTotalByTagForMemberView", map);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // searchLogByKeyword
	
	public List<LogMain> selectLogMainListByTagForMemberView(HashMap<String, Object> map, int startRecord, int countPerPage) {
		List<LogMain> logMainList = null;
		ss = f.openSession();
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		try {
			logMainList = ss.selectList("PageMapper.selectLogMainListByTagForMemberView", map, bound);
			for (LogMain logMain : logMainList) {
				logMain.setLog_profile_photo(ss.selectOne("MemberMapper.findProfilePhoto", logMain.getMember_id()));
				logMain.setLog_comment_list(ss.selectList("LogMapper.selectLogCommentList", logMain.getLog_id()));
				logMain.setLog_like_list(ss.selectList("LogMapper.selectLogLikeList",logMain.getLog_id()));
				logMain.setLog_tag_list(ss.selectList("LogMapper.selectLogTagList", logMain.getLog_id()));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}

		return logMainList;
	} // searchLogByKeyword
	
	public int selectPhotoTotalByTagForMemberView(HashMap<String, Object> map) {
		int result = -1;
		ss = f.openSession();
		try {
			result = ss.selectOne("PageMapper.selectPhotoTotalByTagForMemberView", map);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	}
	
	public List<Photo> selectPhotoListByTagForMemberView(HashMap<String, Object> map, int startRecord, int countPerPage) {
		List<Photo> photoList = null;
		ss = f.openSession();
		try {
			RowBounds bound = new RowBounds(startRecord, countPerPage);
			photoList = ss.selectList("PageMapper.selectPhotoListByTagForMemberView", map, bound);
			for (Photo photo : photoList) {
				photo.setPhotoCommentList(ss.selectList("PhotoMapper.selectPhotoCommentList", photo.getPhoto_id()));
				photo.setPhotoTagList(ss.selectList("PhotoMapper.selectPhotoTagList", photo.getPhoto_id()));
			}
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photoList;
	}
}
