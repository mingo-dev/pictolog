package pictolog.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class ProfilePhotoFileService {

	/**
	 * File 객체, 저장할 경로, 파일명을 전달받아 서버에 파일 저장
	 * 
	 * @param file
	 *            서버에 임시로 업로드된 파일 객체
	 * @param basePath
	 *            저장할 경로
	 * @param filename
	 *            서버에 임시로 업로드된 파일의 이름
	 * @param 변경
	 *            저장된 파일의 이름
	 * @param IOException
	 */

	public String saveProfilePhotoFile(File file, String basePath, String filename, String member_id)
			throws IOException {
		// 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (file == null || file.length() <= 0) {
			return null;
		}

		// 저장 디렉토리가 없는 경우 생성
		File dir = new File(basePath+"\\"+member_id);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}

		// 저장할 파일명을 지정
		String savedFilename;
		savedFilename = "profile_" + member_id + "_" + filename;

		// 원본 파일의 확장자
		String ext;
		int lastIndex = filename.lastIndexOf('.');
		if (lastIndex == -1) {
			ext = "";
		} else {
			ext = "." + filename.substring(lastIndex + 1);
		}
		// 저장할 전체 경로
		String serverFullPath = null;
		File serverFile = null;

		// 같은 이름의 파일이 있는 경우의 처리 (뒤에 랜덤값 붙임)
		while (true) {
			// serverFilename = strDate + ext;
			serverFullPath = basePath + member_id + "\\" + savedFilename;
			serverFile = new File(serverFullPath);
			if (!serverFile.isFile()) {
				break;
			} // 같은 이름의 파일이 없으면 나감.
			int random = (int) (Math.random() * 100000);
			savedFilename = savedFilename + "_" + random + ext;
		}

		// 파일 저장
		FileInputStream in = new FileInputStream(file);
		FileOutputStream out = new FileOutputStream(serverFile);

		int bytesRead = 0;
		byte[] buffer = new byte[1024];
		while ((bytesRead = in.read(buffer, 0, 1024)) != -1) {
			out.write(buffer, 0, bytesRead);
		}

		System.out.println("file saved!!");
		out.close();
		in.close();

		// 실제 저장된 파일의 이름을 리턴
		return savedFilename;
	}

}
