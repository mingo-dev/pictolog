package pictolog.util;

import java.util.ArrayList;

import pictolog.dao.LogDAO;
import pictolog.dao.PhotoDAO;
import pictolog.vo.LogTag;
/**
 * 로그에 새로운 사진이 추가 되었을 경우 전체 태그를 다시 불러와 로그 태그를 다시 생성한다.
 * @author jiyoung
 *
 */
public class UpdateLogTag {

	public void execute(String log_id) {
		
		ArrayList<String> tagNameList = (ArrayList<String>) new PhotoDAO().selectPhotoTagList(log_id);
		
		tagNameList = SaveDuplicatedTagsByOrder.execute(tagNameList);
		
		ArrayList<LogTag> logTagList = new ArrayList<>();

		int tagNameListSize = tagNameList.size();
		if (tagNameListSize > 5) {
			for (int j = 0; j < 5; j++) {
				LogTag logTag = new LogTag();
				logTag.setLog_tag_name(tagNameList.get(j));
				logTag.setLog_id(log_id);
				logTag.setLog_tag_rank(j);
				logTagList.add(logTag);
			}
		} else {
			for (int j = 0; j < tagNameListSize; j++) {
				LogTag logTag = new LogTag();
				logTag.setLog_tag_name(tagNameList.get(j));
				logTag.setLog_id(log_id);
				logTag.setLog_tag_rank(j);
				logTagList.add(logTag);
			}
		}
		new LogDAO().updateLogTagList(logTagList);
		
	}
	
}
