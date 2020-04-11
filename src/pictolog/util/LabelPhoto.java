package pictolog.util;

/*
 * Copyright 2016 Google Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// [START import_libraries]
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.vision.v1.Vision;
import com.google.api.services.vision.v1.VisionScopes;
import com.google.api.services.vision.v1.model.AnnotateImageRequest;
import com.google.api.services.vision.v1.model.AnnotateImageResponse;
import com.google.api.services.vision.v1.model.BatchAnnotateImagesRequest;
import com.google.api.services.vision.v1.model.BatchAnnotateImagesResponse;
import com.google.api.services.vision.v1.model.EntityAnnotation;
import com.google.api.services.vision.v1.model.Feature;
import com.google.api.services.vision.v1.model.Image;
import com.google.common.collect.ImmutableList;

import pictolog.dao.PhotoDAO;
import pictolog.vo.Photo;
import pictolog.vo.PhotoTag;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;
// [END import_libraries]
import java.util.StringTokenizer;

/**
 * A sample application that uses the Vision API to label an image.
 */

public class LabelPhoto {
	/**
	 * Be sure to specify the name of your application. If the application name
	 * is {@code null} or blank, the application will log a warning. Suggested
	 * format is "MyCompany-ProductName/1.0".
	 */
	private static final String APPLICATION_NAME = "Google-VisionLabelSample/1.0";

	private static final int MAX_LABELS = 5;

	// [START run_application]
	/**
	 * Annotates an image using the Vision API.
	 */
	public static ArrayList<PhotoTag> execute(File[] uploadList, ArrayList<String> logIdList,
			String[] uploadListFileName) throws IOException, GeneralSecurityException {
		/*
		 * if (args.length != 1) {
		 * System.err.println("Missing imagePath argument.");
		 * System.err.println("Usage:");
		 * System.err.printf("\tjava %s imagePath\n",
		 * LabelApp.class.getCanonicalName()); System.exit(1); }
		 */
		ArrayList<PhotoTag> photoTagList = new ArrayList<PhotoTag>();
		ArrayList<Photo> photoList = new ArrayList<Photo>();
		ArrayList<Photo> tempPhotoList = new ArrayList<>();
		for(String log_id : logIdList) {		
			List<Photo> tempPhotoListOfLog = new PhotoDAO().selectPhotoList(log_id);
			for(Photo photo : tempPhotoListOfLog) {
				tempPhotoList.add(photo);				
			}
		}
		int tempPhotoListSize = tempPhotoList.size();
		int uploadListFileNameLength = uploadListFileName.length;
		for (int i = 0; i < uploadListFileNameLength; i++) {
			for (int j = 0; j < tempPhotoListSize; j++) {
				StringTokenizer mergeName = new StringTokenizer(uploadListFileName[i], " ");
				String fileName = "";
				while(mergeName.hasMoreTokens()) {
					fileName += mergeName.nextToken();
				}
				if (fileName.equals(tempPhotoList.get(j).getPhoto_name())) {
					photoList.add(tempPhotoList.get(j));
				} // if
			} // inner for
		} // outer for
		int l = photoList.size();
		LabelPhoto app = new LabelPhoto(getVisionService());
		for (int i = 0; i < l; i++) {
			Path imagePath = uploadList[i].toPath();
			ArrayList<PhotoTag> tagList = printLabels(System.out, imagePath, app.labelImage(imagePath, MAX_LABELS));
			if (tagList.size() != 0) {
				for (PhotoTag pt : tagList) {
					pt.setPhoto_id(photoList.get(i).getPhoto_id());
					pt.setLog_id(photoList.get(i).getLog_id());
					photoTagList.add(pt);
				} // inner for
			} // if
		} // outer for
		System.out.println("LabelPhoto 끝. ");
		return photoTagList;
	}

	/**
	 * Prints the labels received from the Vision API.
	 */
	public static ArrayList<PhotoTag> printLabels(PrintStream out, Path imagePath, List<EntityAnnotation> labels) {
		ArrayList<PhotoTag> photoTagList = new ArrayList<PhotoTag>();
		if (labels != null) {
			for (EntityAnnotation label : labels) {
				PhotoTag photoTag = new PhotoTag(label.getDescription());
				photoTagList.add(photoTag);
			} // for
		} // if
		return photoTagList;
	}
	// [END run_application]

	// [START authenticate]
	/**
	 * Connects to the Vision API using Application Default Credentials.
	 */
	public static Vision getVisionService() throws IOException, GeneralSecurityException {
		GoogleCredential credential = GoogleCredential.getApplicationDefault().createScoped(VisionScopes.all());
		JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
		return new Vision.Builder(GoogleNetHttpTransport.newTrustedTransport(), jsonFactory, credential)
				.setApplicationName(APPLICATION_NAME).build();
	}
	// [END authenticate]

	private final Vision vision;

	/**
	 * Constructs a {@link LabelPhoto} which connects to the Vision API.
	 */
	public LabelPhoto(Vision vision) {
		this.vision = vision;
	}

	/**
	 * Gets up to {@code maxResults} labels for an image stored at {@code path}.
	 */
	public List<EntityAnnotation> labelImage(Path path, int maxResults) throws IOException {
		// [START construct_request]
		byte[] data = Files.readAllBytes(path);

		AnnotateImageRequest request = new AnnotateImageRequest().setImage(new Image().encodeContent(data))
				.setFeatures(ImmutableList.of(new Feature().setType("LABEL_DETECTION").setMaxResults(maxResults)));
		Vision.Images.Annotate annotate = vision.images()
				.annotate(new BatchAnnotateImagesRequest().setRequests(ImmutableList.of(request)));
		// Due to a bug: requests to Vision API containing large images fail
		// when GZipped.
		annotate.setDisableGZipContent(true);
		// [END construct_request]

		// [START parse_response]
		BatchAnnotateImagesResponse batchResponse = annotate.execute();
		assert batchResponse.getResponses().size() == 1;
		AnnotateImageResponse response = batchResponse.getResponses().get(0);
		/*
		 * if (response.getLabelAnnotations() == null) { throw new
		 * IOException(response.getError() != null ?
		 * response.getError().getMessage() :
		 * "Unknown error getting image annotations"); }
		 */
		return response.getLabelAnnotations();
		// [END parse_response]
	}
}