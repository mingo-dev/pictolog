package pictolog.dummy;

import java.util.List;
import java.util.StringTokenizer;

import pictolog.vo.Photo;

public class Dummy {

	public static void main(String[] args) {
		DummyDAO dao = new DummyDAO();
		/*List<String> logIdList = dao.selectAllLogIdList();
		for(String e : logIdList) {
			dao.insertLogTag(e);
		}*/
		
		List<Photo> photoList = dao.selectAllPhotoList();
		
		int photoListSize = photoList.size();
		for(int i = 0; i < photoListSize; i++) {
			Photo photo = photoList.get(i);
			String log_id = photo.getLog_id();
			StringTokenizer st = new StringTokenizer(log_id, "_");
			String bo = st.nextToken();
			if(bo.equals("notExistTimePhoto")) {
				double random = Math.random()*9;
				double latitude = 33 + Math.round(random*10000000d)/10000000d;
				random = Math.random()*7;
				double longtitude = 124 + Math.round(random*10000000d)/10000000d;
				
				String location = latitude+", "+longtitude;
				
				photo.setExif_location(location);
				
				dao.updateGPS(photo);
			} else {}
		}
		System.out.println("끝");
	}

}
