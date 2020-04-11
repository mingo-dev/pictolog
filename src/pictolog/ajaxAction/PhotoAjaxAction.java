
package pictolog.ajaxAction;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.MemberDAO;
import pictolog.dao.PhotoDAO;
import pictolog.vo.Info;
import pictolog.vo.Photo;
import pictolog.vo.PhotoComment;
import pictolog.vo.PhotoLike;
import pictolog.vo.PhotoTag;

@SuppressWarnings("serial")
public class PhotoAjaxAction extends ActionSupport {
	private Photo photo;
	private List<PhotoComment> photoCommentList;
	private PhotoComment photoComment;
	private PhotoLike photoLike;
	private PhotoTag photoTag;

	// Photo
	// Methods
	public String selectPhoto() {
		PhotoDAO dao = new PhotoDAO();
		photo = dao.selectPhoto(photo.getPhoto_id());
		if (photo != null) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	}// selectPhoto

	public String deletePhoto() {
		String saveFolder = "img/";
		HttpServletRequest request = ServletActionContext.getRequest();
		ServletContext servletContext = request.getSession().getServletContext();
		String basePath = servletContext.getRealPath(saveFolder);
		boolean result = new PhotoDAO().deletePhoto(photo.getPhoto_id(),basePath);

		if (result) {
			return SUCCESS;
		} else {
			return INPUT;
		}
	} // deletePhoto

	public String alterPhotoLocation() {
		photo = new PhotoDAO().alterPhotoLocation(photo);
		if (photo != null) {
			System.out.println("마커 위치 변경 저장 성공.");
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // alterPhotoLocation
	
		// PhotoComment

	public String insertPhotoComment() {
		PhotoDAO dao = new PhotoDAO();
		dao.insertPhotoComment(photoComment);
		photoCommentList = dao.selectPhotoCommentList(photoComment.getPhoto_id());
		// photoComment에서 photo_id가져와도되고, photo에서 가져와도 된다.
		
		//알림 insert
		Info info = new Info(photoComment.getPhoto_id()+"", "photoComment");
		int photo_id = photoComment.getPhoto_id();
		String log_id = new PhotoDAO().selectLogId(photo_id);
		info.setLocation("logView.action?log_id="+log_id+"&photo_id="+photo_id);
		info.setMember_id_you(photoComment.getMember_id());
		
		new MemberDAO().insertInfo(info);
		
		return SUCCESS;
	}

	public String deletePhotoComment() {
		PhotoDAO dao = new PhotoDAO();
		dao.deletePhotoComment(photoComment.getPhoto_comm_id());
		photoCommentList = dao.selectPhotoCommentList(photoComment.getPhoto_id());
		return SUCCESS;
	}

	// PhotoLike
	public String doPhotoLike() {
		PhotoDAO dao = new PhotoDAO();
		dao.doPhotoLike(photoLike);
		photo = dao.selectPhotoLike(photoLike);
		photo.setPhoto_like_count(photo.getPhotoLike().size());
		
		//알림 insert
		Info info = new Info(photoLike.getPhoto_id()+"", "photoLike");
		int photo_id = photoLike.getPhoto_id();
		String log_id = new PhotoDAO().selectLogId(photo_id);
		info.setLocation("logView.action?log_id="+log_id+"&photo_id="+photo_id);
		info.setMember_id_you(photoLike.getMember_id());
		
		new MemberDAO().insertInfo(info);
		
		return SUCCESS;
	}

	public String cancelPhotoLike() {
		PhotoDAO dao = new PhotoDAO();
		dao.cancelPhotoLike(photoLike);
		photo = dao.selectPhotoLike(photoLike);
		photo.setPhoto_like_count(photo.getPhotoLike().size());
		return SUCCESS;
	}

	// PhotoTag
	public String updatePhotoTag() {
		PhotoDAO dao = new PhotoDAO();
		dao.updatePhotoTag(photoTag);
		return SUCCESS;
	} // updatePhotoTag

	// Getters & Setters
	public Photo getPhoto() {
		return photo;
	}

	public void setPhoto(Photo photo) {
		this.photo = photo;
	}

	public List<PhotoComment> getPhotoCommentList() {
		return photoCommentList;
	}

	public void setPhotoCommentList(List<PhotoComment> photoCommentList) {
		this.photoCommentList = photoCommentList;
	}

	public PhotoComment getPhotoComment() {
		return photoComment;
	}

	public void setPhotoComment(PhotoComment photoComment) {
		this.photoComment = photoComment;
	}

	public PhotoLike getPhotoLike() {
		return photoLike;
	}

	public void setPhotoLike(PhotoLike photoLike) {
		this.photoLike = photoLike;
	}

	public PhotoTag getPhotoTag() {
		return photoTag;
	}

	public void setPhotoTag(PhotoTag photoTag) {
		this.photoTag = photoTag;
	}
}