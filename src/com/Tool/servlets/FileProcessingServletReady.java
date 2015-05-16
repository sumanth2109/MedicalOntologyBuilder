package com.semantator.servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.semantator.service.FileProcessingService;

/**
 * Servlet implementation class FileProcessingServletReady
 */

public class FileProcessingServletReady extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR = "uploadFiles";   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileProcessingServletReady() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		mainPath = savePath+ File.separator +request.getParameter("selectedValue")+".txt";
		mainPathJSON =  savePath+ File.separator +request.getParameter("selectedValue")+".txtJSON";
		request.setAttribute("jsonpath", mainPathJSON);
		request.setAttribute("fileName", request.getParameter("selectedValue")+".txtJSON");


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
		List<String> list = fileProcessingService.getFileNames(savePath);
		Map<String, String> doctorFinalData = fileProcessingService
				.doctorData(doctor);
		request.setAttribute("fileNames", list);
		request.setAttribute("doctor", doctorFinalData);
		request.setAttribute("result","result");
		getServletContext().getRequestDispatcher("/welcome.jsp").forward(
				request, response);
	}

}
