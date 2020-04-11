package pictolog.action;

import java.io.File;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.drew.imaging.ImageProcessingException;
import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.PhotoDAO;
import pictolog.vo.Member;
import pictolog.util.ExifAnalysis;
import pictolog.util.LabelPhoto;
import pictolog.util.NewFileName;
import pictolog.util.UpdateLogTag;
import pictolog.util.PhotoResize;
import pictolog.vo.Photo;
import pictolog.vo.PhotoTag;

@SuppressWarnings("serial")
public class PhotoAction extends ActionSupport implements SessionAware {
	// Fields
	private Map<String, Object> session;
	private Photo photo;
	private Member member;
	private String member_id;
	private String log_id;
	private ArrayList<Photo> photoList;
	private ArrayList<PhotoTag> photoTagList;

	// File upload
	private String[] uploadListFileName;
	private String[] uploadListContentType;
	private File[] uploadList;

	// Methods
	public String addPhoto() throws ImageProcessingException, IOException, GeneralSecurityException {
		Member member = (Member) session.get("login");
		String member_id = member.getMember_id();
		
		
		// a. 사진 exif 분석 => ArrayList<Photo> photoList
		ArrayList<Photo> photoList = new ArrayList<>();
		// a-1. 임시 photoList 생성
		int uploadListSize = uploadList.length;
		for (int i = 0; i < uploadListSize; i++) {
			Photo photo = new Photo(i);
			photoList.add(photo);
		}

		// a-2. 사진 exif 분석
		photoList = new ExifAnalysis().getExifInformation(uploadList, photoList); // ImageProcessingException
		String uploadFileName = new NewFileName().execute(uploadListFileName[0]);
		photoList.get(0).setPhoto_name(uploadFileName);
		uploadListFileName[0] = uploadFileName;
		
		// log_id : front단에서 보내줘야 하는 정보
		photoList.get(0).setLog_id(log_id);

		// c. 이미지 resize & 서버에 사진 저장, resized된 resizeFileList 받아오기
		String basePath = getText("photo.uploadpath");
		uploadList = PhotoResize.execute(uploadList, basePath, member_id, photoList);

		// d. resized PhotoList에서 태그 받아오기, photoTag DB insert
		ArrayList<String> logIdList = new ArrayList<>();
		logIdList.add(log_id);
		photoTagList = LabelPhoto.execute(uploadList, logIdList, uploadListFileName); // IOException,
																	// GeneralSecurityException
		for (PhotoTag pt : photoTagList) {
			pt.setMember_id(member_id);// member_id ? member.getMember_id?
		} // for
		new PhotoDAO().insertPhotoTag(photoTagList);

		// e. 로그태그 Update
		new UpdateLogTag().execute(log_id);
		return SUCCESS;
	} // addPhoto
	
	public String a() {

		// 위치정보가 없는 사진에 대한 처리
		// 1) 알림
		// 2) 위치설정

		return SUCCESS;
	}

	// Session
	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	/* Getters & Setters */
	public Photo getPhoto() {
		return photo;
	}

	public void setPhoto(Photo photo) {
		this.photo = photo;
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

	public String getLog_id() {
		return log_id;
	}

	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}

	public ArrayList<Photo> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(ArrayList<Photo> photoList) {
		this.photoList = photoList;
	}

	public ArrayList<PhotoTag> getPhotoTagList() {
		return photoTagList;
	}

	public void setPhotoTagList(ArrayList<PhotoTag> photoTagList) {
		this.photoTagList = photoTagList;
	}

	public String[] getUploadListFileName() {
		return uploadListFileName;
	}

	public void setUploadListFileName(String[] uploadListFileName) {
		this.uploadListFileName = uploadListFileName;
	}

	public String[] getUploadListContentType() {
		return uploadListContentType;
	}

	public void setUploadListContentType(String[] uploadListContentType) {
		this.uploadListContentType = uploadListContentType;
	}

	public File[] getUploadList() {
		return uploadList;
	}

	public void setUploadList(File[] uploadList) {
		this.uploadList = uploadList;
	}

}
