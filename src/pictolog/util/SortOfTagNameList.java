package pictolog.util;

import java.util.ArrayList;
/**
 * 많이 중복된 순으로 태그를 저장하는 클래스
 * @author jiyoung
 *
 */
public class SortOfTagNameList {
	
	public static ArrayList<String> execute(ArrayList<String> tagNameList, ArrayList<Integer> tagNumberList) {
	
		int indexBefore = 0; 
		int indexAfter = 0;
		int flag = 0; // 순서 변화 여부 (변화 있으면 1, 없으면 0)
		// 임시 변수
		int tempNumber = 0;
		String tempName = "";
		
		int tagNameListSize = tagNameList.size();
		for (int i = 0; i < tagNameListSize - 1; i++) {
			indexBefore = i;
			for (int j = i + 1; j < tagNameListSize; j++) {
				//더 큰 수가 있을 경우 자리 변동
				if (tagNumberList.get(i) < tagNumberList.get(j)) {
					flag = 1;
					tempNumber = tagNumberList.get(i);
					tagNumberList.set(i, tagNumberList.get(j));
					tagNumberList.set(j, tempNumber);
					indexAfter = j;
				} // if
			} // for
			if (flag == 1) {
				flag = 0;
				tempName = tagNameList.get(indexBefore);
				tagNameList.set(indexBefore, tagNameList.get(indexAfter));
				tagNameList.set(indexAfter, tempName);
			} // if
		} // for
		
		return tagNameList;
	}
}
