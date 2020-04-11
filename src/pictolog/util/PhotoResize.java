
package pictolog.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import pictolog.dao.PhotoDAO;
import pictolog.vo.Photo;

public class PhotoResize {

	public PhotoResize() {
	}

	@SuppressWarnings("unused")
	public static File[] execute(File[] uploadList, String basePath, String member_id, ArrayList<Photo> photoList) {
		String tmpPath = "";
		int uploadListLength = uploadList.length;
		ArrayList<File> tempFileList = new ArrayList<File>();
		for (int j = 0; j < uploadListLength; j++) {
			tmpPath = basePath + member_id + "\\" + photoList.get(j).getLog_id();
			String fileName = photoList.get(j).getPhoto_name();
			
			// 파일 이름 사이 공백 있을 시 제거하여 파일이름으로 사용.
			fileName = fileName.replaceAll("\\p{Space}", "");
			
			
			String fileType = "";
			int lastIndex = fileName.lastIndexOf('.');
			if (lastIndex == -1) {// 확장자 없는 경우
				continue;
			} else {// 확장자 있는 경우에도 체크
				fileType = fileName.substring(lastIndex + 1);
				String lowerdFileType = fileType.toLowerCase();
				if (((lowerdFileType.equals("jpg")) || lowerdFileType.equals("jpeg"))) {
				} else {
					continue;
				}
			} // else

			int extPosition = fileName.indexOf(fileType);
			String newPath = "";
			if (extPosition != -1) {
				// String fullPath = tmpPath + "/" + tmpFileName;
				ImageIcon ic = resizeImage(uploadList[j], 1024, 1024);

				Image image = ic.getImage();

				BufferedImage bi = new BufferedImage(image.getWidth(null), image.getHeight(null),
						BufferedImage.TYPE_INT_RGB);

				Graphics2D g2 = bi.createGraphics();
				g2.drawImage(image, 0, 0, null);
				g2.dispose();

				// resized img 파일 명

				// 저장 폴더가 없는 경우 생성
				File dir = new File(tmpPath);
				if (!dir.isDirectory())
					dir.mkdirs();
				
				String relativePath = "";
				StringTokenizer st = new StringTokenizer(tmpPath, "\\");
				for(int x=1; st.hasMoreElements(); x++) {
					relativePath = st.nextToken();
				}
				// resized img의 경로
				newPath = tmpPath + "/" + fileName; 
				photoList.get(j).setPhoto_path(member_id+"/"+relativePath+"/"+fileName);
				photoList.get(j).setPhoto_name(fileName);
				// 파일 생성하여 이미지를 저장
				try {
					ImageIO.write(bi, fileType, new File(newPath));
				} catch (IOException e) {
					e.printStackTrace();
				}

			} // if

			// 새로 만들어진 경로에 대한 이미지 파일 목록으로 리턴해줌.
			File dirFile = new File(newPath);
			tempFileList.add(dirFile);

		} // for

		
		// photoList DB insert
		for(Photo photo : photoList) {
			new PhotoDAO().insertPhoto(photo);
		}
		File[] newList = new File[uploadListLength];
		for (int i = 0; i < newList.length; i++) {
			newList[i] = tempFileList.get(i);
		}
		System.out.println("PhotoResize 끝.");
		return newList;
	}

	public static ImageIcon resizeImage(File file, int maxWidth, int maxHeight) {

		BufferedImage src, dest;
		ImageIcon icon;

		try {
			src = ImageIO.read(file);

			int width = src.getWidth();
			int height = src.getHeight();

			if (width > maxWidth) {
				float widthRatio = maxWidth / (float) width;
				width = (int) (width * widthRatio);
				height = (int) (height * widthRatio);
			}
			if (height > maxHeight) {
				float heightRatio = maxHeight / (float) height;
				width = (int) (width * heightRatio);
				height = (int) (height * heightRatio);
			}

			dest = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = dest.createGraphics();
			AffineTransform at = AffineTransform.getScaleInstance((double) width / src.getWidth(),
					(double) height / src.getHeight());
			g.drawRenderedImage(src, at);

			icon = new ImageIcon(dest);
			return icon;
		} catch (Exception e) {
			System.out.println("This image can not be resized. Please check the path and type of file.");
			return null;
		}
	}

}
