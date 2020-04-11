package pictolog.util;

import java.util.StringTokenizer;

public class NewFileName {
	/*
	 * fileName에 "_"이 있으면 그 앞까지만 이름으로 저장
	 * 이름이 너무 길면 DB에 안들어감
	 */
	public String execute(String uploadFileName) {
		String newFileName = "";
		
		StringTokenizer st = new StringTokenizer(uploadFileName, ".");
		String ext = st.nextToken();
		ext = st.nextToken();
		int random = (int) (Math.random()*100);
		st = new StringTokenizer(uploadFileName, "_");
		int count = 0;
		
		//_ 없는 경우 count를 1로 증가시킨다.
		while(st.hasMoreTokens()) {
			st.nextToken();
			count++;
		}
		
		st = new StringTokenizer(uploadFileName, "_");
		newFileName =  st.nextToken();
		if(count == 1) {
		} else {
			newFileName += random+"."+ext;
		}
		
		return newFileName;
	}
}
