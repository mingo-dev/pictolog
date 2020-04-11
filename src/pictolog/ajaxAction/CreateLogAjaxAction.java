package pictolog.ajaxAction;

import java.io.File;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.drew.imaging.ImageProcessingException;
import com.opensymphony.xwork2.ActionSupport;

import pictolog.dao.LogDAO;
import pictolog.dao.PhotoDAO;
import pictolog.util.ExifAnalysis;
import pictolog.util.LabelLog;
import pictolog.util.LabelPhoto;
import pictolog.util.NewFileName;
import pictolog.util.PhotoResize;
import pictolog.vo.Log;
import pictolog.vo.Member;
import pictolog.vo.Photo;
import pictolog.vo.PhotoTag;

@SuppressWarnings("serial")
public class CreateLogAjaxAction extends ActionSupport implements SessionAware {
	private Map<String, Object> session;
	private Member member;
	private String member_id;

	// File upload
	private String[] uploadsFileName;
	private String[] uploadsContentType;
	private File[] uploads;

	public String execute() throws IOException, GeneralSecurityException, ImageProcessingException {
		ArrayList<Photo> photoList = new ArrayList<Photo>();
		ArrayList<String> logIdList = new ArrayList<String>();
		ArrayList<PhotoTag> photoTagList = new ArrayList<PhotoTag>();
		member = (Member) session.get("login");
		System.out.println(uploadsFileName);
		member_id = member.getMember_id();

		// a. 사진 exif 분석 => ArrayList<Photo> photoList
		// a-1. 임시 photoList 생성
		int uploadListSize = uploads.length;
		for (int i = 0; i < uploadListSize; i++) {
			// 파일이름을 Photo의 이름으로 설정.(fileName "_"있으면 그 앞까지만 이름으로 저장
			String uploadFileName = new NewFileName().execute(uploadsFileName[i]);
			Photo photo = new Photo(i, uploadFileName);
			photoList.add(photo);
			uploadsFileName[i] = uploadFileName;
		}
		
		// a-2. 사진 exif 분석
		photoList = new ExifAnalysis().getExifInformation(uploads, photoList);
		for (int i = 0; i < photoList.size(); i++) {

			// log_id_id 설정, 우선 날짜 형식으로 임시로 값을 저장해둠. yyyy-MM-dd hh:mm:ss
			String log_id_id = photoList.get(i).getExif_time();
			if (log_id_id == null) {
				log_id_id = "notExistTimePhoto";
			}
			// 날짜형식으로 저장된 Log_id_id를 " "를 경계로 구분하여 날짜와 member_id를 합친형태의 새로운 값을
			// 저장한다.
			StringTokenizer st = new StringTokenizer(log_id_id, " ");
			
			log_id_id = st.nextToken() + "_" + member_id; // ex) 2016-10-17_user
			// logIdList가 비어있을 경우에는 현재의 log_id_id를 추가.
			if (logIdList.size() == 0) {
				logIdList.add(log_id_id);
			} else {
				// logIdList가 비어있지 않을 경우에는 log_id_id가 이미 있는지 중복 확인
				int flag = 0;
				for (int j = 0; j < logIdList.size(); j++) {
					// 중복되는 경우에는 continue.
					if (logIdList.get(j).equals(log_id_id)) {
						flag =1;
						// 중복되지 않을 경우에는 logIdList에 추가
					} else {

					} // else
				} // inner for
				
				if(flag==0) {
					logIdList.add(log_id_id);
				}
			} // else

			// photoList의 각각에 log_id_id를 설정
			photoList.get(i).setLog_id(log_id_id);
		} // outter for

		// a-1. 중복 없는 로그 아이디 생성, ArrayList<String> logIdList

		int random = (int) (Math.random() * 10000);
		for (int i = 0; i < logIdList.size(); i++) {

			String final_log_id = logIdList.get(i) + "_" + random;
			for (int j = 0; j < photoList.size(); j++) {
				if (photoList.get(j).getLog_id().equals(logIdList.get(i))) {
					photoList.get(j).setLog_id(final_log_id);
				} // if
			} // inner for
			logIdList.set(i, final_log_id);
		} // outer for
		
		// b. 로그테이블에 로그_id insert (photo테이블에 로그 id 넣기 위함)
		new LogDAO().insertLog(logIdList, member_id);
		
		// c. 이미지 resize & 서버에 사진 저장, resized된 resizeFileList 받아오기
		//String basePath = getText("photo.uploadpath");
		String saveFolder = "img/";
		HttpServletRequest request = ServletActionContext.getRequest();
	    ServletContext servletContext = request.getSession().getServletContext();
	    String basePath = servletContext.getRealPath(saveFolder);
	    System.out.println(basePath);
		uploads = PhotoResize.execute(uploads, basePath, member_id, photoList);
		System.out.println("photoResize 후 시간: "+new Date().toString());
		
		// d. resized PhotoList에서 태그 받아오기, photoTag DB insert
		photoTagList = LabelPhoto.execute(uploads, logIdList, uploadsFileName); // IOException
		System.out.println("LabelPhoto 후 시간: "+new Date().toString());
		// GeneralSecurityException
		if(photoTagList.size()!=0) {
			for (PhotoTag pt : photoTagList) {
				pt.setMember_id(member_id);// member_id ? member.getMember_id?
			} // for
		new PhotoDAO().insertPhotoTag(photoTagList);
		} //if
		
		// e. 로그태그 LabelLog(->logTag insert) , title 생성(-> log update)
		int photoListSize = photoList.size();
		ArrayList<Log> logList = new ArrayList<Log>();
		int logIdListSize = logIdList.size();
		for (int i = 0; i < logIdListSize; i++) {
			Log log = new Log();
			log.setLog_id(logIdList.get(i));
			for (int j = 0; j < photoListSize; j++) {
				if (logIdList.get(i).equals(photoList.get(j).getLog_id())) {
					log.setMain_photo_name(photoList.get(j).getPhoto_path());
					break;
				}
			}
			logList.add(log);
		}
		boolean result = new LabelLog().excute(photoTagList, logList, member_id);
		System.out.println("LabelLog 후 시간: "+new Date().toString());
		if(result ==true) {
			return SUCCESS;
		} else {
			return ERROR;
		}
	} // createLog

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	/* getter & setter */
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

	public File[] getUploads() {
		return uploads;
	}

	public void setUploads(File[] uploads) {
		this.uploads = uploads;
	}

	public String[] getUploadsFileName() {
		return uploadsFileName;
	}

	public void setUploadsFileName(String[] uploadsFileName) {
		this.uploadsFileName = uploadsFileName;
	}
	
	public String[] getUploadsContentType() {
		return uploadsContentType;
	}

	public void setUploadsContentType(String[] uploadsContentType) {
		this.uploadsContentType = uploadsContentType;
	}
}
