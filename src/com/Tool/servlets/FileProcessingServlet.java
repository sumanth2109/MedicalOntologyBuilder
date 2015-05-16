package com.semantator.servlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.semantator.service.FileProcessingService;

@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
// 50MB
public class FileProcessingServlet extends HttpServlet {

	/**
	 * Name of the directory where uploaded files will be saved, relative to the
	 * web application directory.
	 */
	private static final String SAVE_DIR = "uploadFiles";
	private static final String date_today = getCurrentTimeStamp();

	/**
	 * handles file upload
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// gets absolute path of the web application
		String appPath = request.getServletContext().getRealPath("");
		File fJSON = new File(getServletContext().getRealPath("data.json"));

		// constructs path of the directory to save uploaded file
		String savePath = appPath + File.separator + SAVE_DIR;
		String mainPath = null, mainPathJSON = null;
		// creates the save directory if it does not exists
		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		String fileName = null;
		for (Part part : request.getParts()) {
			fileName = extractFileName(part);

			part.write(savePath + File.separator + date_today + fileName);
			mainPath = savePath + File.separator + date_today + fileName;
			
			mainPathJSON = savePath + File.separator + date_today +fileName+ "JSON";
			request.setAttribute("jsonpath", mainPathJSON);
			request.setAttribute("fileName", date_today+fileName+"JSON");
			 //System.out.println(mainPathJSON);
		}

		List<String> doctor = new ArrayList<String>();
		List<String> patient = new ArrayList<String>();
		// read some text in the text variable
		File file = new File(mainPath);
		FileReader fr = new FileReader(file);
		BufferedReader br = new BufferedReader(fr);
		String line;

		while ((line = br.readLine()) != null) {
			if (line.contains(":")) {
				// String[] temp = line.split(":");
				doctor.add(line);
			}

		}
		br.close();
		fr.close();

		// creating service class object
		FileProcessingService fileProcessingService = new FileProcessingService();
		
		fileProcessingService.copyJSON(fJSON, mainPathJSON);
		Map<String, String> doctorFinalData = fileProcessingService
				.doctorData(doctor);
		List<String> list = fileProcessingService.getFileNames(savePath);
		request.setAttribute("fileNames", list);
		request.setAttribute("doctor", doctorFinalData);
		request.setAttribute("result","result");
		getServletContext().getRequestDispatcher("/welcome.jsp").forward(
				request, response);
	}

	/**
	 * Extracts file name from HTTP header content-disposition
	 */
	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}

	public static String getCurrentTimeStamp() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");// -HH-mm-ss
		Date now = new Date();
		String strDate = sdfDate.format(now);
		return strDate;
	}
}