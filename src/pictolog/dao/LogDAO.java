package pictolog.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import pictolog.util.MybatisSqlSessionFactory;
import pictolog.vo.Log;
import pictolog.vo.LogComment;
import pictolog.vo.LogLike;
import pictolog.vo.LogTag;
import pictolog.vo.LogView;
import pictolog.vo.Member;
import pictolog.vo.Photo;

public class LogDAO {

	private SqlSessionFactory f = MybatisSqlSessionFactory.getSqlSesstionFactory();
	private SqlSession ss;

	// Log
	public void insertLog(ArrayList<String> logIdList, String member_id) {
		ss = f.openSession();
		try {
			for (String log_id : logIdList) {
				Log log = new Log();
				log.setLog_id(log_id);
				log.setMember_id(member_id);
				ss.insert("LogMapper.insertLog", log);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // insertLog

	/**
	 * 특정 로그를 상세보기 요청 시 해당 로그의 정보를 반환한다.
	 * 
	 * @param String
	 *            log_id : 확인하려는 로그의 아이디
	 * @return Log : 조회된 해당 로그 객체
	 * @author JONGPARK
	 * 
	 * @see selectLogCommentList /selectPhotoList 기능 통합 & LogLike 조회 기능 추가
	 * @author JISEONG
	 **/
	public LogView selectLog(String log_id, String member_id) {
		System.out.println(log_id);
		System.out.println(member_id);

		LogView result = new LogView();
		ss = f.openSession();
		try {
			result = ss.selectOne("LogMapper.selectLog", log_id);

			List<LogTag> logTagList = ss.selectList("LogMapper.selectLogTagList", log_id);
			result.setLogTagList(logTagList);

			List<LogComment> logCommentList = ss.selectList("LogMapper.selectLogCommentList", log_id);
			result.setLogCommentList(logCommentList);

			List<Photo> photoList = ss.selectList("PhotoMapper.selectPhotoList", log_id);
			result.setPhotoList(photoList);

			List<LogLike> logLikeList = ss.selectList("LogMapper.selectLogLikeList", log_id);
			result.setLogLikeCount(logLikeList.size());
			for (LogLike logLike : logLikeList) {
				if (logLike.getMember_id().equals(member_id)) {
					result.setAmILikedThisLog(true);
					break;
				} // if
			} // for

			Member logMember = ss.selectOne("MemberMapper.selectMember", result.getMember_id());
			result.setProfile_photo(logMember.getProfile_photo());

			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	}

	/**
	 * '처음 로그가 생길 때'!!, 타이틀등의 정보를 만들고 업데이트 한다.
	 * 
	 * @param String
	 *            log_id : 업데이트하려는 로그의 아이디
	 * @return 업데이트 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean updateLog(Log log) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.update("LogMapper.updateLog", log);
			if (cnt != 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // updateLog

	public boolean updateLogTitle(LogView logView) {
		boolean result = false;
		ss = f.openSession();
		try {
			ss.update("LogMapper.updateLogTitle", logView);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	}

	/**
	 * 특정 로그를 삭제한다
	 * 
	 * @param String
	 *            log_id : 삭제하려는 로그의 아이디
	 * @return 삭제 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean deleteLog(String member_id, String log_id, String basePath) {
		boolean result = false;
		ss = f.openSession();
		try {
			String logPath = basePath + member_id + "/" + log_id;
			int cnt = ss.delete("LogMapper.deleteLog", log_id);
			if (cnt != 0) {
				File file = new File(logPath);
				File[] fileList = file.listFiles();
				for (int i = 0; i < fileList.length; i++) {
					if (fileList[i].isFile()) {
						fileList[i].delete();
					}
				} // for
				file.delete();
				result = true;
			} // outer if
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		} // finally
		return result;
	} // deleteLog

	/**
	 * 로그를 공개로 설정한다.
	 * 
	 * @param Log
	 *            log : 공개하려는 로그
	 * @return 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean makeLogPublic(Log log) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.update("LogMapper.makeLogPublic", log);
			if (cnt != 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // makeLogPublic

	/**
	 * 로그를 비공개로 설정한다.
	 * 
	 * @param Log
	 *            log : 비공개하려는 로그
	 * @return 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean makeLogPrivate(Log log) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.update("LogMapper.makeLogPublic", log);
			if (cnt != 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // makeLogPrivate

	// LogComment
	/**
	 * 로그에서 댓글 입력 시 LOG_COMMENT 테이블에 추가한다.
	 * 
	 * @param LogComment
	 *            logComment : 추가된 로그 댓글
	 * @return insert 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean insertLogComment(LogComment logComment) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.insert("LogMapper.insertLogComment", logComment);
			if (cnt != 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	}

	/**
	 * 특정 로그의 댓글들을 모두 조회하여 가져온다.
	 * 
	 * @param String
	 *            log_id : 확인하려는 로그의 아이디
	 * @return List<LogComment> : 조회된 해당 로그댓글 리스트
	 * @author JONGPARK
	 * 
	 * @see DEADCODE : selectLog에 해당 메서드 내용 추가 : 추후 사용 여부 확인하여 삭제할 것!!
	 * @author JISEONG
	 **/
	public List<LogComment> selectLogCommentList(String log_id) {
		List<LogComment> logCommentList = null;
		ss = f.openSession();
		try {
			logCommentList = ss.selectList("LogMapper.selectLogCommentList", log_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return logCommentList;

	} // selectLogCommentList

	/**
	 * 로그에서 댓글 삭제 요청 시 LOG_COMMENT 테이블에서 삭제한다.
	 * 
	 * @param LogComment
	 *            logComment : 삭제하려는 로그 댓글
	 * @return delete 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean deleteLogComment(LogComment logComment) {
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.delete("LogMapper.deleteLogComment", logComment);
			if (cnt != 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}

		return result;
	} // deleteLogComment

	// LogTag
	/**
	 * LabelLog 작업 시 (구체적으로는??) 로그태그들의 리스트를 LOG_TAG 테이블에 저장한다.
	 * 
	 * @param ArrayList<LogTag>
	 *            logTagList : member_id, photo_id가 담긴 PhotoTag의 리스트
	 * @return void
	 * @author JONGPARK
	 **/
	public void insertLogTag(ArrayList<LogTag> logTagList) {
		ss = f.openSession();
		try {
			for (LogTag log_tag : logTagList) {
				ss.insert("LogMapper.insertLogTag", log_tag);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}// insertLogTag

	public List<LogTag> selectLogTagList(String log_id) {
		List<LogTag> logTagList = null;
		ss = f.openSession();
		try {
			logTagList = ss.selectList("LogMapper.selectLogTagList", log_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}

		return logTagList;
	}

	/**
	 * 로그가 생성된 이후 사용자가 로그 태그를 수정한다.
	 * 
	 * @param LogTag
	 *            logTag : 수정하려는 로그 태그 객체
	 * @return 업데이트 성공 시 true
	 * @author JONGPARK
	 **/
	public boolean updateLogTag(LogTag logTag) {
		System.out.println("updateLogTag");
		boolean result = false;
		ss = f.openSession();
		try {
			int cnt = ss.update("LogMapper.updateLogTag", logTag);
			if (cnt != 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // updateLogTag

	/**
	 * 사진을 새로 등록할 때 로그 태그 리스트를 업데이트 한다.
	 * 
	 * @param ArrayList<LogTag>
	 *            logTagList : 새로운 로그 태그 ArrayList
	 * @author jiyoung
	 **/
	public void updateLogTagList(ArrayList<LogTag> logTagList) {
		ss = f.openSession();
		try {
			for (LogTag log_tag : logTagList) {
				ss.update("LogMapper.updateLogTagList", log_tag);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // updateLogTagList

	// LogLike
	/**
	 * 로그 좋아요 눌렀을 때 LOG_Like 테이블에 추가한다.
	 * 
	 * @param String
	 *            log_id : 좋아요 눌린 로그의 아이디
	 * @param String
	 *            member_id : 좋아요 누른 멤버의 아이디
	 * @return 현재 로그의 좋아요 수
	 * @author JONGPARK
	 * 
	 * @see 내용 변경 : 로그 좋아요 리스트를 받은 후 리스트의 사이즈를 반납하도록 변경
	 * @author JISEONG
	 **/
	public LogView doLogLike(String log_id, String member_id) {
		LogView result = new LogView();
		ss = f.openSession();

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("log_id", log_id);
		map.put("member_id", member_id);

		try {
			ss.insert("LogMapper.insertLogLike", map);
			List<LogLike> logLikeList = ss.selectList("LogMapper.selectLogLikeList", log_id);
			result.setLogLikeCount(logLikeList.size());
			for (LogLike logLike : logLikeList) {
				if (logLike.getMember_id().equals(member_id)) {
					result.setAmILikedThisLog(true);
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // likeLog

	public List<LogLike> selectLogLikeList(String log_id) {
		List<LogLike> logLikeList = null;
		ss = f.openSession();
		try {
			logLikeList = ss.selectList("LogMapper.selectLogLikeList", log_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return logLikeList;
	}

	/**
	 * 로그 좋아요 취소를 눌렀을 때 LOG_Like 테이블에서 삭제한다.
	 * 
	 * @param String
	 *            log_id : 좋아요취소가 눌린 로그의 아이디
	 * @param String
	 *            member_id : 좋아요취소 누른 멤버의 아이디
	 * @return 현재 로그의 좋아요 수
	 * @author JONGPARK
	 * 
	 * @see 내용 변경 : 로그 좋아요 리스트를 받은 후 리스트의 사이즈를 반납하도록 변경
	 * @author JISEONG
	 **/
	public LogView cancelLogLike(String log_id, String member_id) {
		LogView result = new LogView();
		ss = f.openSession();

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("log_id", log_id);
		map.put("member_id", member_id);

		try {
			ss.delete("LogMapper.deleteLogLike", map);
			List<LogLike> logLikeList = ss.selectList("LogMapper.selectLogLikeList", log_id);
			result.setLogLikeCount(logLikeList.size());
			for (LogLike logLike : logLikeList) {
				if (logLike.getMember_id().equals(member_id)) {
					result.setAmILikedThisLog(true);
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	}// dislikeLog

}
