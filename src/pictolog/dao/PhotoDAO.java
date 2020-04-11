package pictolog.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import pictolog.util.MybatisSqlSessionFactory;
import pictolog.vo.Photo;
import pictolog.vo.PhotoComment;
import pictolog.vo.PhotoLike;
import pictolog.vo.PhotoTag;

public class PhotoDAO {
	private SqlSessionFactory f = MybatisSqlSessionFactory.getSqlSesstionFactory();
	private SqlSession ss;

	// Photo
	/**
	 * 로그에서 사진을 추가한다.
	 * 
	 * @param photoList
	 *            : 추가할 사진을 담아오는 ArrayList, 실제로 사진은 1장만 담아온다.
	 * @author jiyoung
	 */
	public void insertPhoto(Photo photo) {
		ss = f.openSession();
		try {
			ss.insert("PhotoMapper.insertPhoto", photo);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}

	}

	/**
	 * 사진 정보를 가져오는 메서드. 모달이 열릴때 호출된다.
	 * 
	 * @param photo_id
	 *            정보를 가져올 사진의 아이디
	 * @return 아이디에 해당하는 사진 VO
	 * @author jiyoung
	 */
	public Photo selectPhoto(int photo_id) {
		Photo photo = null;
		List<PhotoComment> photoCommentList = null;
		List<PhotoTag> photoTagList = null;
		List<PhotoLike> photoLikeList = null;

		ss = f.openSession();
		try {
			photo = ss.selectOne("PhotoMapper.selectPhoto", photo_id);
			photoCommentList = ss.selectList("PhotoMapper.selectPhotoCommentList", photo_id);
			photoTagList = ss.selectList("PhotoMapper.selectPhotoTagList", photo_id);
			photoLikeList = ss.selectList("PhotoMapper.selectPhotoLikeList", photo_id);

			photo.setPhotoCommentList((ArrayList<PhotoComment>) photoCommentList);
			photo.setPhotoTagList((ArrayList<PhotoTag>) photoTagList);
			photo.setPhotoLike((ArrayList<PhotoLike>) photoLikeList);
		} finally {
			ss.close();
		}
		return photo;
	}

	/**
	 * 해당 로그들이 가진 사진을 전부 가져온다.
	 * 
	 * @param logIdList
	 *            : 로그 아이디를 담은 ArrayList
	 * @return 해당 로그들이 가진 사진들의 VO
	 * @author jiyoung
	 */
	public ArrayList<Photo> selectPhotoList(String log_id) {
		ArrayList<Photo> photoList = new ArrayList<Photo>();
		List<Photo> photoListOfLog = null;
		ss = f.openSession();
		try {
			photoListOfLog = ss.selectList("PhotoMapper.selectPhotoList", log_id);
			for (Photo p : photoListOfLog) {
				photoList.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photoList;
	} // selectPhotoList

	/**
	 * 사진의 위치를 변경한다.
	 * 
	 * @param photo
	 *            변경할 사진의 VO
	 * @return 위치 변경의 성공 여부
	 * @author jiyoung
	 */
	public Photo alterPhotoLocation(Photo photo) {
		Photo result = null;

		ss = f.openSession();
		try {
			int cnt = ss.update("PhotoMapper.alterPhotoLocation", photo);
			if (cnt != 0) {
				result = ss.selectOne("PhotoMapper.selectPhoto", photo.getPhoto_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return result;
	} // alterPhotoLocation

	/**
	 * 로그에서 사진을 삭제한다.
	 * 
	 * @param photo_id
	 *            : 삭제할 사진의 아이디
	 * @return 사진 삭제의 성공 여부
	 * @author jiyoung
	 */
	public boolean deletePhoto(int photo_id, String basePath) {
		boolean result = false;
		ss = f.openSession();
		try {
			String photoPath = ss.selectOne("PhotoMapper.selectPhotoPath", photo_id);
			int cnt = ss.delete("PhotoMapper.deletePhoto", photo_id);
			if (cnt != 0) {
				try {
					File file = new File(basePath + photoPath);
					if (file.isFile()) {
						result = file.delete();
					} // if
				} catch (Exception ex) {
					ex.printStackTrace();
				} // catch
			} // outer if
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		} // finally
		return result;
	}// deletePhoto

	// PhotoComment
	/**
	 * 사진 댓글을 DB에 저장한다.
	 * 
	 * @param photoComment
	 *            : 사진 댓글 VO
	 * @author jiyoung
	 */
	public void insertPhotoComment(PhotoComment photoComment) {
		ss = f.openSession();
		try {
			ss.insert("PhotoMapper.insertPhotoComment", photoComment);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // insertPhotoComment

	/**
	 * 해당 사진의 코멘트를 전부 가져온다.
	 * 
	 * @param photo_id
	 *            해당 사진의 아이디
	 * @return 해당 사진의 로멘트 VO ArrayList
	 * @author jiyoung
	 */
	public List<PhotoComment> selectPhotoCommentList(int photo_id) {
		List<PhotoComment> photoCommentList = null;
		ss = f.openSession();
		try {
			photoCommentList = ss.selectList("PhotoMapper.selectPhotoCommentList", photo_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photoCommentList;
	} // insertPhotoComment

	/**
	 * 사진에 달린 댓글을 지운다.
	 * 
	 * @param photo_comm_id
	 *            해당 댓글의 아이디
	 * @author jiyoung
	 */
	public void deletePhotoComment(int photo_comm_id) {
		ss = f.openSession();
		try {
			ss.delete("PhotoMapper.deletePhotoComment", photo_comm_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // deletePhotoComment

	// PhotoTag
	/**
	 * Cloud Vision을 통해 나온 사진과 관련된 태그들의 리스트를 PHOTO_TAG 테이블에 저장한다.
	 * 
	 * @param ArrayList<PhotoTag>
	 *            photoTagList : member_id, log_id, photo_id가 담긴 PhotoTag의 리스트
	 * @return void
	 * @author JONGPARK
	 **/
	public void insertPhotoTag(ArrayList<PhotoTag> photoTagList) {
		ss = f.openSession();
		try {
			for (PhotoTag pt : photoTagList) {
				ss.insert("PhotoMapper.insertPhotoTag", pt);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}// insertPhotoTag

	/**
	 * 해당 로그가 가진 사진의 태그 리스트를 전부 가져온다. 로그의 주제 태그를 선정하기 위한 메소드
	 * 
	 * @param log_id
	 *            사진 태그를 불러올 로그 아이디
	 * @return 해당 로그가 가진 태그 리스트
	 * @author jiyoung
	 */
	public List<String> selectPhotoTagList(String log_id) {
		List<String> photoTagList = null;
		ss = f.openSession();
		try {
			photoTagList = ss.selectList("PhotoMapper.selectPhotoTagList", log_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photoTagList;
	}

	/**
	 * 해당 멤버 아이디로 멤버의 포토 태그를 조회한다.
	 * 
	 * @param String
	 *            member_id : 멤버 아이디
	 * @return 해당 멤버 아이디로 조회한 포토 태그 리스트
	 * @author JONGPARK
	 **/
	public List<String> selectPhotoTagListOfMember(String member_id) {
		List<String> tagNameList = null;
		ss = f.openSession();
		try {
			tagNameList = ss.selectList("PhotoMapper.selectPhotoTagListOfMember", member_id);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return tagNameList;
	} // selectPhotoTagOfMember

	/**
	 * 해당 로그의 태그를 업데이트 한다.
	 * 
	 * @param photoTag
	 *            사진이 가진 태그
	 * @author JISEONG
	 */
	public void updatePhotoTag(PhotoTag photoTag) {
		ss = f.openSession();
		try {
			ss.update("PhotoMapper.updatePhotoTag", photoTag);
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	}

	// PhotoLike
	/**
	 * 사진 좋아요
	 * 
	 * @param photoLike
	 *            사진 좋아요 VO
	 * @author jiyoung
	 */
	public void doPhotoLike(PhotoLike photoLike) {
		ss = f.openSession();
		try {
			int result = ss.insert("PhotoMapper.insertPhotoLike", photoLike);
			System.out.println(result);
			ss.update("PhotoMapper.addPhotoLikeCount", photoLike.getPhoto_id());
			ss.update("LogMapper.addLogLikeCount", photoLike.getPhoto_id());
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // doPhotoLike

	/**
	 * 사진 좋아요 취소
	 * 
	 * @param photoLike
	 *            사진 좋아요 VO
	 * @author jiyoung
	 */
	public void cancelPhotoLike(PhotoLike photoLike) {
		ss = f.openSession();
		try {
			ss.insert("PhotoMapper.deletePhotoLike", photoLike.getPhoto_id());
			ss.update("PhotoMapper.substractPhotoLikeCount", photoLike.getPhoto_id());
			ss.update("LogMapper.substractLogLikeCount", photoLike.getPhoto_id());
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
	} // cancelPhotoLike

	/**
	 * 사진의 좋아요 정보를 가져옴
	 * 
	 * @param photoLike
	 * @return photo
	 * @author JISEONG
	 */
	public Photo selectPhotoLike(PhotoLike photoLike) {
		Photo photo = new Photo();
		ss = f.openSession();
		try {
			List<PhotoLike> photoLikeList = ss.selectList("PhotoMapper.selectPhotoLikeList", photoLike.getPhoto_id());
			photo.setPhotoLike(photoLikeList);
			photo.setPhoto_like_count(photoLikeList.size());
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		return photo;
	}

	//'알림'에서 해당 photo가 포함된 로그로 이동하기 위해 로그 아이디 불러오는 메소드
	public String selectLogId(int photo_id) {
		String log_id = null;
		ss = f.openSession();
		try {
			log_id = ss.selectOne("PhotoMapper.selectLogId", photo_id);
		} catch(Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			ss.commit();
			ss.close();
		}
		
		return log_id;
	}
}