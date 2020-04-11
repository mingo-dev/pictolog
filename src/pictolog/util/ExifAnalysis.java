
package pictolog.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;

import pictolog.vo.Photo;
/**
 * 사진의 Exif 정보를 분석하여 장소와 시간 정보를 가져오기 위한 클래스
 * @author jiyoung
 *
 */
public class ExifAnalysis {

	public ArrayList<Photo> getExifInformation(File[] fileList, ArrayList<Photo> photoList) throws ImageProcessingException {
		Metadata metadata;

		try {
			int fileListSize = fileList.length;
			for (int i = 0; i < fileListSize; i++) {
				metadata = ImageMetadataReader.readMetadata(fileList[i]);
				// 날짜 정보 추출
				ExifSubIFDDirectory directory = metadata.getDirectory(ExifSubIFDDirectory.class);
				if (directory == null) {
					System.out.println("exif directory 없는 이미지 파일.");
					continue;
				} // if
				Date date = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);
				
				if(date ==null) {
					System.out.println("exif date 정보 없는 이미지 파일.");
					continue;
				}
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
				String exif_time = formatter.format(date);

				// gps 정보 추출
				GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
				if (gpsDirectory == null) {
					System.out.println("exif gpsDirectory 없는 이미지 파일.");
					continue;
				} // if
				/*
				 * System.out.println( file.getName() + " /GPS : " +
				 * gpsDirectory.getGeoLocation() + "  /DATE: " + exif_time);
				 */

				String exif_location = gpsDirectory.getGeoLocation() + "";

				photoList.get(i).setExif_location(exif_location);
				photoList.get(i).setExif_time(exif_time);

			} // for
		} catch (JpegProcessingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} // catch
		System.out.println("EXIF 분석 끝.");
		return photoList;
	} // getExifInformation

}
