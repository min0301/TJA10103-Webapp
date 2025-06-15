<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.forum.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ForumService forumSvc = new ForumService();
    List<ForumVO> list = forumSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>所有討論區 - TJA101G3 論壇</title>
    <style>

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6; /* 柔和的淺灰色背景 */
            color: #333;
            line-height: 1.6;
        }

        /* 容器 - 根據表格內容和需求調整最大寬度 */
        .container {
            /* 根據圖片和內容，稍微增加 max-width 以提供更多空間 */
            max-width: 1300px; /* 從 1200px 增加到 1300px */
            margin: 20px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* 柔和的陰影 */
        }

        /* 標題與導航區塊 */
        .header-section {
            display: flex;
            justify-content: space-between; /* 標題和導航靠兩側對齊 */
            align-items: center;
            padding-bottom: 15px;
            margin-bottom: 25px;
            border-bottom: 2px solid #e0e0e0;
        }

        .header-section h3 {
            color: #2c3e50;
            font-size: 2em;
            margin: 0; /* 移除預設 margin */
            border-bottom: none; /* 移除重複的底線 */
            padding-bottom: 0;
        }

        .back-link {
            display: flex;
            align-items: center;
            gap: 8px; /* 圖片與文字間距 */
            color: #3498db;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .back-link img {
            vertical-align: middle; /* 圖片垂直對齊 */
        }

        /* 內容提示 */
        .content-note {
            text-align: center;
            margin-bottom: 20px;
            color: #7f8c8d;
            font-size: 1.1em;
        }

        /* 表格樣式 */
        table {
            width: 100%; /* 佔滿容器寬度 */
            border-collapse: collapse; /* 合併邊框 */
            margin-top: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* 表格輕微陰影 */
            border-radius: 8px; /* 圓角 */
            overflow: hidden; /* 確保圓角生效 */
            /* 阻止表格內容的自動換行，強制單行顯示。這會導致表格超出其父容器寬度，並出現滾動條。 */
            /* 如果不需要滾動條，則需要進一步調整列寬或允許部分內容換行 */
            /* white-space: nowrap; */ /* 慎用此屬性，它會強制所有文本不換行 */
        }

        th, td {
            border: 1px solid #e0e0e0; /* 淺灰色邊框 */
            padding: 12px 15px;
            text-align: left; /* 文字靠左對齊 */
            font-size: 0.95em;
            vertical-align: top; /* 垂直頂部對齊，防止多行文本時錯位 */
        }

        th {
            background-color: #34495e; /* 深藍色背景 */
            color: white;
            font-weight: bold;
            text-transform: uppercase; /* 大寫 */
            white-space: nowrap; /* 表頭文字不換行，確保整齊 */
        }

        /* 調整特定列的寬度，以防止文字換行 */
        /* 您可能需要根據實際內容長度微調這些值 */
        table th:nth-child(1), /* 討論區編號 */
        table td:nth-child(1) {
            width: 50px; /* 較小寬度 */
            min-width: 50px;
            text-align: center; /* 讓編號居中 */
            
        }

        table th:nth-child(2), /* 討論區名稱 */
        table td:nth-child(2) {
            width: 150px; /* 給予更多空間 */
            min-width: 150px;
            text-align: center; 
        }

        table th:nth-child(3), /* 討論區類別 */
        table td:nth-child(3) {
            width: 80px;
            min-width: 100px;
            text-align: center; 
        }

        table th:nth-child(4), /* 討論區描述 */
        table td:nth-child(4) {
            width: 300px; /* 增加描述的寬度，這是最容易換行的部分 */
            min-width: 300px;
            white-space: normal; /* 允許描述內容自然換行，如果仍需單行顯示，請刪除此行並使用 `white-space: nowrap;` */
            text-align: center; 
        }

        table th:nth-child(5), /* 創建時間 */
        table td:nth-child(5) {
            width: 90px;
            min-width: 90px;
            white-space: nowrap; /* 確保日期不換行 */
            text-align: center; 
        }

        table th:nth-child(6), /* 狀態更新時間 */
        table td:nth-child(6) {
            width: 90px;
            min-width: 90px;
            white-space: nowrap; /* 確保日期不換行 */
            text-align: center; 
        }

        table th:nth-child(7), /* 聊天室狀態 */
        table td:nth-child(7) {
            width: 80px;
            min-width: 80px;
            text-align: center; /* 讓狀態居中 */
            white-space: nowrap; /* 確保狀態不換行 */
        }

        /* 操作按鈕欄位 */
        table th:nth-child(8), /* 操作 (修改) */
        table td:nth-child(8),
        table th:nth-child(9), /* 操作 (刪除) */
        table td:nth-child(9) {
            width: 70px; /* 固定操作按鈕的寬度 */
            min-width: 70px;
            text-align: center;
            white-space: nowrap; /* 確保按鈕不換行 */
        }

        /* 表格列交替顏色 */
        tbody tr:nth-child(even) {
            background-color: #f9f9f9; /* 淺灰色 */
        }

        /* 表格行懸停效果 */
        tbody tr:hover {
            background-color: #e8f5e9; /* 淺綠色，提示可互動 */
            transform: scale(1.005); /* 輕微放大 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08); /* 更明顯的陰影 */
            transition: background-color 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
        }

        /* 圖片和按鈕的微調 */
        td img {
            vertical-align: middle;
        }

        /* 表單內按鈕樣式 - 保持與 select_page.jsp 一致 */
        form {
            margin-bottom: 0px;
            display: inline-block; /* 讓按鈕並排 */
        }

        input[type="submit"] {
            background-color: #007bff; /* 藍色按鈕 */
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background-color 0.2s ease;
            white-space: nowrap; /* 防止文字換行 */
        }

        input[type="submit"]:hover {
            background-color: #0056b3; /* 懸停變深 */
        }

        /* 針對刪除按鈕特別設定，使用紅色 */
        input[value="刪除"] {
            background-color: #dc3545; /* 紅色 */
        }

        input[value="刪除"]:hover {
            background-color: #c82333; /* 懸停變深 */
        }

        /* 分頁檔案的樣式，如果 page1.file 和 page2.file 有內容，需要另外調整 */
        .pagination-controls {
            text-align: center;
            margin-top: 20px;
        }
        /* 這裡可以根據 page1.file 和 page2.file 的具體內容添加樣式 */
        /* 例如，如果它們包含<a>標籤作為分頁連結，可以這樣寫：*/
        .pagination-controls a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            text-decoration: none;
            color: #3498db;
        }
        .pagination-controls a:hover {
            background-color: #e0f2f7;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h3>所有討論區列表</h3>
        <a href="select_page.jsp" class="back-link">
            <img src="<%=request.getContextPath()%>/resources/images/back1.gif" width="24" height="24" alt="回首頁">
            回首頁
        </a>
    </div>

    <p class="content-note">此頁面展示所有討論區的詳細資訊，並提供修改與刪除功能。</p>

    <table>
        <thead>
            <tr>
                <th>討論區編號</th>
                <th>討論區名稱</th>
                <th>討論區類別</th>
                <th>討論區描述</th>
                <th>創建時間</th>
                <th>狀態更新時間</th>
                <th>聊天室狀態</th>
                <th>操作</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <%@ include file="page1.file" %>
            <c:forEach var="forumVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
                <tr>
                    <td>${forumVO.forNo}</td>
                    <td>${forumVO.forName}</td>
                    <td>${forumVO.catName}</td>
                    <td>${forumVO.forDes}</td>
                    <td>${forumVO.forDate}</td>
                    <td>${forumVO.forUpdate}</td>
                    <td>${forumVO.fchatStatus == 0 ? "開啟" : "關閉"}</td>
                    <td>
                        <form method="post" action="<%=request.getContextPath()%>/back-end/forum/forum.do">
                            <input type="submit" value="修改">
                            <input type="hidden" name="forNo"  value="${forumVO.forNo}">
                            <input type="hidden" name="action"	value="getOne_For_Update">
                        </form>
                    </td>
                    <td>
                        <form method="post" action="<%=request.getContextPath()%>/back-end/forum/forum.do">
                            <input type="submit" value="刪除">
                            <input type="hidden" name="forNo"  value="${forumVO.forNo}">
                            <input type="hidden" name="action" value="delete">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination-controls">
        <%@ include file="page2.file" %>
    </div>
</div>

</body>
</html>