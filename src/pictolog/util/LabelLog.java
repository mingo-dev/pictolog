package pictolog.util;

import java.util.ArrayList;

import pictolog.dao.LogDAO;
import pictolog.vo.Log;
import pictolog.vo.LogTag;
import pictolog.vo.PhotoTag;

/**
 * 로그의 주제 태그를 선정하고, title을 만드는 클래스
 * 
 * @author jiyoung
 *
 */
public class LabelLog {
	/**
	 * 
	 * @param photoTagList
	 *            분석할 로그들이 가진 태그의 전체 리스트
	 * @param logList
	 *            분석할 로그들의 아이디
	 * @param member_id
	 *            로그인 한 사용자의 아이디
	 */

	public boolean excute(ArrayList<PhotoTag> photoTagList, ArrayList<Log> logList, String member_id) {
		boolean result = false;
		int logIdListSize = logList.size();
		// 1. 로그 별로 태그를 나눈다.
		for (int i = 0; i < logIdListSize; i++) {
			String log_id = logList.get(i).getLog_id();
			ArrayList<PhotoTag> photoTagOfLogList = createPhotoTagOfLogList(photoTagList, log_id);
			String log_tag_name_first = "";
			ArrayList<String> tagNameList = new ArrayList<String>();

			if (photoTagOfLogList.size() != 0) {
				for (PhotoTag pt : photoTagOfLogList) {
					tagNameList.add(pt.getPhoto_tag_name());
				} // for
				log_tag_name_first = tagNameList.get(0);
			} // if
			
			// a. 5개 이하의 중복되는 태그List(중복되지 않아도 저장)
			tagNameList = SaveDuplicatedTagsByOrder.execute(tagNameList);
			
			// LogTag DB insert
			ArrayList<LogTag> logTagList = new ArrayList<>();
			int tagNameListSize = tagNameList.size();
			String log_title = member_id;
			
			// 임시 타이틀 생성(타이틀 예시)
			int random = (int)(Math.random()*5)+1;
			System.out.println("타이틀 case random: "+ random);
			switch(random) {
			case 1 :
				log_title += "'s one joyful day";
				break;
			case 2 :
				log_title += "'s happy daily life";
				break;
			case 3 :
				log_title += "'s exciting day";
				break;
			case 4 :
				log_title += "'s thrilling day";
				break;
			case 5 :
				log_title += "'s one fine day";
				break;
			default :
				log_title += "'s daily log";
				break;
			}
			
			// b. Title 생성
			if (tagNameList.size() != 0) {// b-1. 중복 단어 있는 경우
				log_tag_name_first = tagNameList.get(0);

				for (int j = 0; j < tagNameListSize; j++) {
					LogTag logTag = new LogTag();
					logTag.setLog_tag_name(tagNameList.get(j));
					logTag.setLog_id(log_id);
					logTag.setMember_id(member_id);
					logTag.setLog_tag_rank(j);
					logTagList.add(logTag);
				}
				logTagList = insertLogTagList(logTagList);
			} else {// b-2. 중복단어 없는 경우
				
			}

			// c. log update (log_title, main_photo_name, log_tag_name_first)
			logList.get(i).setLog_title(log_title);
			logList.get(i).setLog_tag_name_first(log_tag_name_first);
			result = new LogDAO().updateLog(logList.get(i));
		} // outer for
		System.out.println("LabelLog 끝.");
		return result;
	} // execute

	/**
	 * 해당 로그가 가진 태그만 분별하여 저장한 ArrayList를 반환한다.
	 * 
	 * @param photoTagList
	 *            전체 태그 ArrayList
	 * @param log_id
	 *            해당 로그
	 * @return 해당 로그의 사진들이 가진 태그들의 ArrayList
	 * @author jiyoung
	 */
	public ArrayList<PhotoTag> createPhotoTagOfLogList(ArrayList<PhotoTag> photoTagList, String log_id) {
		ArrayList<PhotoTag> photoTagOfLogList = new ArrayList<>();
		int photoTagListSize = photoTagList.size();
		for (int j = 0; j < photoTagListSize; j++) {
			if (log_id.equals(photoTagList.get(j).getLog_id())) {
				photoTagOfLogList.add(photoTagList.get(j));
			}
		}
		return photoTagOfLogList;
	}

	/**
	 * 5개 이하의 로그 태그를 DB에 저장한다.
	 * 
	 * @param logTagList
	 *            저장할 로그 태그 리스트
	 * @return 5개 이하의 로그 태그 리스트
	 * @author jiyoung
	 */
	public ArrayList<LogTag> insertLogTagList(ArrayList<LogTag> logTagList) {
		int logTagListSize = logTagList.size();
		if (logTagListSize > 5) {
			for (int j = 5; j < logTagListSize; j++) {
				logTagList.remove(5); //list remove할때마다 사이즈가 줄기때문에 index 5에 해당하는 삭제를 5번하면 됨.
			}
		} 
		new LogDAO().insertLogTag(logTagList);

		return logTagList;
	}

}
