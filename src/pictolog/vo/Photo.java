package pictolog.vo;

import java.util.List;

/**
 * 로그를 만들기 위해서 필요한 사진 정보 vo
 * 사용자가 업로드한 사진을 받아서 google api 로 분석, 
 * 각각의 사진을 분석하여 사진 태그, 정보 저장, 분석을 진행한다. 
 * 분석된 정보를 바탕으로 로그를 생성하는데 사용된다. 
 * 
 * @author Minsu
 *
 */
public class Photo {
	private int photo_id;			// 사용자 업로드 사진 아이디 
	private String exif_location;	// 사진의 위치 정보 
	private String exif_time;		// 사진 촬영 날짜
	private int photo_like_count;	// 사진의 좋아요 갯수 
	private String log_id;			// 이 사진이 포함된 로그
	private String photo_name;		// 사진의 이름 
	private String photo_regdate;	// 사진이 업로드 된 날짜
	private String photo_path;		// 저장된 경로
	
	private List<PhotoComment> photoCommentList;	// 사진이 가지고 있는 댓글의 리스트
	private List<PhotoTag> photoTagList; 			// 사진이 가지고 있는 태그의 리스트
	private List<PhotoLike> photoLike;				// 사진을 좋아요 한 아이디 리스트
	
	public Photo() {
		super();
	}
	
	public Photo(int photo_id) {
		this.photo_id = photo_id;
	}
	
	public Photo(int photo_id, String photo_name) {
		this.photo_id = photo_id;
		this.photo_name = photo_name;
	}

	public int getPhoto_id() {
		return photo_id;
	}

	public void setPhoto_id(int photo_id) {
		this.photo_id = photo_id;
	}

	public String getExif_location() {
		return exif_location;
	}

	public void setExif_location(String exif_location) {
		this.exif_location = exif_location;
	}

	public String getExif_time() {
		return exif_time;
	}

	public void setExif_time(String exif_time) {
		this.exif_time = exif_time;
	}

	public int getPhoto_like_count() {
		return photo_like_count;
	}

	public void setPhoto_like_count(int photo_like_count) {
		this.photo_like_count = photo_like_count;
	}

	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

	public String getPhoto_regdate() {
		return photo_regdate;
	}

	public void setPhoto_regdate(String photo_regdate) {
		this.photo_regdate = photo_regdate;
	}

	public String getPhoto_path() {
		return photo_path;
	}

	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}

	public List<PhotoComment> getPhotoCommentList() {
		return photoCommentList;
	}

	public void setPhotoCommentList(List<PhotoComment> photoCommentList) {
		this.photoCommentList = photoCommentList;
	}

	public List<PhotoTag> getPhotoTagList() {
		return photoTagList;
	}

	public void setPhotoTagList(List<PhotoTag> photoTagList) {
		this.photoTagList = photoTagList;
	}

	public List<PhotoLike> getPhotoLike() {
		return photoLike;
	}

	public void setPhotoLike(List<PhotoLike> photoLike) {
		this.photoLike = photoLike;
	}

	@Override
	public String toString() {
		return "Photo [photo_id=" + photo_id + ", exif_location=" + exif_location + ", exif_time=" + exif_time
				+ ", photo_like_count=" + photo_like_count + ", log_id=" + log_id + ", photo_name=" + photo_name
				+ ", photo_regdate=" + photo_regdate + ", photo_path=" + photo_path + ", photoCommentList="
				+ photoCommentList + ", photoTagList=" + photoTagList + ", photoLike=" + photoLike + "]";
	}

	
}
