package com.semantator.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semantator.service.FileProcessingService;

/**
 * Servlet implementation class JsonWriter
 */

public class JsonWriter extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR = "uploadFiles"; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JsonWriter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	//	System.out.println("GET");
	//	PrintWriter out = response.getWriter();
		String appPath = request.getServletContext().getRealPath("");
		String savePath = appPath + File.separator + SAVE_DIR;
		FileProcessingService fileProcessingService = new FileProcessingService();
		List<String> list = fileProcessingService.getFileNames(savePath);
		
		request.setAttribute("fileNames", list);
		request.getRequestDispatcher("/welcome.jsp").forward(
				request, response);
		//out.write(list.toString());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("pathValue :"+request.getParameter("pathValue"));
		System.out.println(request.getParameter("test"));
		FileProcessingService fileProcessingService = new FileProcessingService();
		fileProcessingService.writeJSON(request.getParameter("pathValue"), request.getParameter("test"));
		request.setAttribute("result","open");
		//response.sendRedirect("./index.jsp");
	}

}
