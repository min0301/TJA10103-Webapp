package com.forum.controller;

import java.io.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import com.forum.model.*;

public class ForumServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("forNo");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入討論區編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/forum/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer forNo = null;
				try {
					forNo = Integer.valueOf(str);
				} catch (Exception e) {
					errorMsgs.add("討論區編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/forum/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ForumService forumSvc = new ForumService();
				ForumVO forumVO = forumSvc.getOneForum(forNo);
				if (forumVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/forum/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("forumVO", forumVO); // 資料庫取出的forumVO物件,存入req
				String url = "/front-end/forum/listOneForum.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneForum.jsp
				successView.forward(req, res);
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllForum.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數****************************************/
				Integer forNo = Integer.valueOf(req.getParameter("forNo"));
				
				/***************************2.開始查詢資料****************************************/
				ForumService forumSvc = new ForumService();
				ForumVO forumVO = forumSvc.getOneForum(forNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("forumVO", forumVO);         // 資料庫取出的forumVO物件,存入req
				String url = "/back-end/forum/updateForum.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_forum_input.jsp
				successView.forward(req, res);
		}
		
		
		if ("update".equals(action)) { // 來自update_forum_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
Integer forNo = Integer.valueOf(req.getParameter("forNo").trim());

				
String forName = req.getParameter("forName");
				if (forName == null || forName.trim().length() == 0) {
					errorMsgs.add("討論區名稱: 請勿空白");
				}
				
				Integer catNo = null;
				try {
catNo = Integer.valueOf(req.getParameter("catNo").trim());
				}catch (NumberFormatException e) {
					catNo = 1;
					errorMsgs.add("討論區類別請填數字.");
				}


String forDes = req.getParameter("forDes");
				if (forDes == null || forDes.trim().length() == 0) {
					errorMsgs.add("討論區描述: 請勿空白");
				}
				
				Integer fchatStatus = null;
				try {
fchatStatus = Integer.valueOf(req.getParameter("fchatStatus").trim());
					if(fchatStatus != 0 && fchatStatus != 1) {
						throw new NumberFormatException("聊天室狀態請填0或是1.");
					}
				}catch (NumberFormatException e) {
					fchatStatus = 1;
					errorMsgs.add("聊天室狀態請填0或是1.");
				}


				ForumVO forumVO = new ForumVO();
				forumVO.setForNo(forNo);
				forumVO.setForName(forName);
				forumVO.setCatNo(catNo);
				forumVO.setForDes(forDes);
				forumVO.setFchatStatus(fchatStatus);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
req.setAttribute("forumVO", forumVO); // 含有輸入格式錯誤的forunVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/forum/updateForum.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ForumService forumSvc = new ForumService();
				forumSvc.updateForum(forNo,forName, catNo, forDes, fchatStatus);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				forumVO = forumSvc.getOneForum(forNo);
				req.setAttribute("forumVO", forumVO); // 資料庫update成功後,正確的的forumVO物件,存入req
				String url = "/front-end/forum/listOneForum.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneForum.jsp
				successView.forward(req, res);
		}

        if ("insert".equals(action)) { // 來自addForum.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
String forName = req.getParameter("forName");
				if (forName == null || forName.trim().length() == 0) {
					errorMsgs.add("討論區名稱: 請勿空白");
				}
				
				Integer catNo = null;
				try {
catNo = Integer.valueOf(req.getParameter("catNo").trim());
				}  catch (NumberFormatException e) {
					catNo = 1;
					errorMsgs.add("討論區類別請填數字.");
				}
				
String forDes = req.getParameter("forDes").trim();
				if (forDes == null || forDes.trim().length() == 0) {
					errorMsgs.add("討論區描述空白");
				}

				ForumVO forumVO = new ForumVO();
				forumVO.setForName(forName);
				forumVO.setCatNo(catNo);
				forumVO.setForDes(forDes);


				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
req.setAttribute("forumVO", forumVO); // 含有輸入格式錯誤的forumVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("addForum.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ForumService forumSvc = new ForumService();
				forumVO = forumSvc.addForum(forName, catNo, forDes);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/forum/listAllForum.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllForum.jsp
				successView.forward(req, res);				
		}
		
		
		if ("delete".equals(action)) { // 來自listAllForum.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
				/***************************1.接收請求參數***************************************/
				Integer forNo = Integer.valueOf(req.getParameter("forNo"));
				
				/***************************2.開始刪除資料***************************************/
				ForumService forumSvc = new ForumService();
				forumSvc.deleteForum(forNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/forum/listAllForum.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
		}
	}
}
