package pictolog.util;

import java.util.ArrayList;
/**
 * 중복된 태그를 중복이 많이 된 순서대로 저장하는 클래스
 * @author jiyoung
 *
 */
public class SaveDuplicatedTagsByOrder {

	public static ArrayList<String> execute(ArrayList<String> tagNameList) {
		ArrayList<String> duplicatedTagNameList = new ArrayList<>();
		ArrayList<Integer> duplicatedTagNumberList = new ArrayList<>();
		//a. 중복된 태그(duplicatedTagNameList)와
		//중복된 숫자(duplicatedTagNumberList)를 저장한다.
		//중복되지 않아도 중복도 0으로 일단 저장
		while (tagNameList.size() != 0) {
			int numberOfSameTag = 0;
			for (int j = 1; j < tagNameList.size(); j++) {
				if (tagNameList.get(0).equals(tagNameList.get(j))) {
					numberOfSameTag++;
				}
			}
			duplicatedTagNameList.add(tagNameList.get(0));
			duplicatedTagNumberList.add(numberOfSameTag);
			tagNameList.remove(0);
		}

		// 태그 갯수대로 정렬
		if (duplicatedTagNameList.size() > 1) {
			duplicatedTagNameList = SortOfTagNameList.execute(duplicatedTagNameList, duplicatedTagNumberList);
		}
		
		return duplicatedTagNameList;
	}
}
