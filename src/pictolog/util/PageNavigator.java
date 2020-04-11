package pictolog.util;

public class PageNavigator {
	// 페이지 관련 정보
	private int countPerPage; // 페이지당 글목록 수
	private int currentPage; // 현재 페이지 (최근 글이 1부터 시작)
	private int totalRecordsCount; // 전체 글 수
	private int totalPageCount; // 전체 페이지 수
	private int startRecord; // 전체 레코드 중 현재 페이지 첫 글의 위치
	
	/*
	 * 생성자
	 */
	public PageNavigator(){
		
	}//constructor
	
	public PageNavigator(int countPerPage, int currentPage, int totalRecordsCount) {
		// 페이지당 글 수, 그룹당 페이지 수, 현재 페이지, 전체 글 수를 전달받음
		this.countPerPage = countPerPage;
		this.totalRecordsCount = totalRecordsCount;

		// 전체 페이지 수
		totalPageCount = (totalRecordsCount + countPerPage - 1) / countPerPage;

		// 전달된 현재 페이지가 1보다 작으면 현재페이지를 1페이지로 지정
		if (currentPage < 1)
			currentPage = 1;
		
		// 전달된 현재 페이지가 마지막 페이지보다 크면 현재페이지를 마지막 페이지로 지정
		if (currentPage > totalPageCount) 
			currentPage = totalPageCount;

		this.currentPage = currentPage;
		
		// 전체 레코드 중 현재 페이지 첫 글의 위치
		startRecord = (currentPage - 1) * countPerPage;
	}
	
	/*
	 * Getters and Setters
	 */
	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRecordsCount() {
		return totalRecordsCount;
	}

	public void setTotalRecordsCount(int totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getStartRecord() {
		return startRecord;
	}

	public void setStartRecord(int startRecord) {
		this.startRecord = startRecord;
	}

	
}
