<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forum.model.*"%>
<%-- 此頁展示單一討論區資料 --%>

<%
// 確保 forumVO 物件存在於 request scope 中
ForumVO forumVO = (ForumVO) request.getAttribute("forumVO");
// 如果 forumVO 為 null，可以考慮導向錯誤頁面或顯示訊息
if (forumVO == null) {
    // 範例：導向錯誤頁面
    // response.sendRedirect(request.getContextPath() + "/error.jsp");
    // return;
    // 範例：顯示訊息
    // request.setAttribute("errorMsgs", Arrays.asList("查無此討論區資料。"));
    // RequestDispatcher failureView = request.getRequestDispatcher("/error.jsp");
    // failureView.forward(request, response);
}
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>討論區資料 - TJA101G3 論壇</title>
    <style>
        /* Global Styles - Consistent with previous pages */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6; /* Soft light gray background */
            color: #333;
            line-height: 1.6;
        }

        /* Container - Consistent with previous pages */
        .container {
            max-width: 1200px; /* Adjusted to fit the wider table */
            margin: 20px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* Soft shadow */
        }

        /* Header Section - Consistent with listAllForum.jsp */
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            margin-bottom: 25px;
            border-bottom: 2px solid #e0e0e0;
        }

        .header-section h3 {
            color: #2c3e50;
            font-size: 2em;
            margin: 0;
            border-bottom: none;
            padding-bottom: 0;
        }

        .back-link {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #3498db;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .back-link img {
            vertical-align: middle;
        }

        /* Content Note */
        .content-note {
            text-align: center;
            margin-bottom: 20px;
            color: #7f8c8d;
            font-size: 1.1em;
        }

        /* Table Styles - Consistent with listAllForum.jsp */
        table {
            width: 100%; /* Occupy full container width */
            border-collapse: collapse; /* Collapse borders */
            margin-top: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* Slight table shadow */
            border-radius: 8px; /* Rounded corners */
            overflow: hidden; /* Ensures rounded corners are visible */
        }

        /* --- MODIFICATION START --- */
        /* Center content in all table header and data cells */
        th, td {
            border: 1px solid #e0e0e0; /* Light gray border */
            padding: 12px 15px;
            text-align: center; /* Set all text to center */
            font-size: 0.95em;
        }
        /* --- MODIFICATION END --- */


        th {
            background-color: #34495e; /* Dark blue background */
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* Table row alternating colors (less noticeable for single row, but maintains consistency) */
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Table row hover effect (less noticeable for single row, but maintains consistency) */
        tbody tr:hover {
            background-color: #e8f5e9;
            transform: scale(1.005);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            transition: background-color 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h3>討論區資料</h3>
        <a href="<%=request.getContextPath()%>/back-end/forum/select_page.jsp" class="back-link">
            <img src="<%=request.getContextPath()%>/resources/images/back1.gif" width="24" height="24" alt="回首頁">
            回首頁
        </a>
    </div>

    <p class="content-note">此頁面顯示單一討論區的詳細資訊。</p>

    <table>
        <thead>
            <tr>
                <th>討論區編號</th>
                <th>討論區名稱</th>
                <th>類別編號</th>
                <th>討論區描述</th>
                <th>創建時間</th>
                <th>狀態更新時間</th>
                <th>聊天室狀態</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%=forumVO.getForNo()%></td>
                <td><%=forumVO.getForName()%></td>
                <td><%=forumVO.getCatNo()%></td>
                <td><%=forumVO.getForDes()%></td>
                <td><%=forumVO.getForDate()%></td>
                <td><%=forumVO.getForUpdate()%></td> 
                <td><%=forumVO.getFchatStatus() == 0 ? "開啟" : "關閉"%></td>
            </tr>
        </tbody>
    </table>
</div>

</body>
</html>