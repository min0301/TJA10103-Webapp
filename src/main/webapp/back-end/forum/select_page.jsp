<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TJA101G3 論壇：首頁</title>
    <style>
        /* 全局樣式 */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6; /* 柔和的淺灰色背景 */
            color: #333;
            line-height: 1.6;
        }

        /* 容器 */
        .container {
            max-width: 960px;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* 柔和的陰影 */
        }

        /* 標題 */
        .page-header {
            text-align: center;
            padding-bottom: 20px;
            margin-bottom: 30px;
            border-bottom: 2px solid #e0e0e0;
        }

        .page-header h1 {
            color: #2c3e50; /* 深藍色 */
            font-size: 2.5em;
            margin-bottom: 5px;
        }

        .page-header h4 {
            color: #7f8c8d; /* 較淺的灰色 */
            font-size: 1.1em;
            margin-top: 5px;
        }

        /* 區塊標題 */
        h3 {
            color: #34495e; /* 比主標題稍淺的藍色 */
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-top: 30px;
            margin-bottom: 20px;
            font-size: 1.6em;
        }

        /* 列表樣式 */
        ul {
            list-style: none; /* 移除預設點 */
            padding: 0;
            margin: 0;
        }

        li {
            background-color: #fdfefe;
            border: 1px solid #eee;
            margin-bottom: 10px;
            padding: 15px 20px;
            border-radius: 5px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        li:hover {
            transform: translateY(-3px); /* 輕微上浮效果 */
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }

        /* 連結樣式 */
        a {
            color: #3498db; /* 亮藍色 */
            text-decoration: none;
            transition: color 0.2s ease;
        }

        a:hover {
            color: #2980b9; /* 懸停變深 */
            text-decoration: underline;
        }

        /* 表單樣式 */
        form {
            display: flex;
            align-items: center;
            gap: 10px; /* 表單元素間距 */
            flex-wrap: wrap; /* 響應式換行 */
        }

        input[type="text"],
        select {
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            flex-grow: 1; /* 讓輸入框和選擇框盡可能佔滿空間 */
            min-width: 150px; /* 最小寬度 */
        }

        input[type="submit"] {
            background-color: #28a745; /* 綠色按鈕 */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.2s ease;
        }

        input[type="submit"]:hover {
            background-color: #218838; /* 懸停變深 */
        }

        /* 錯誤訊息 */
        .error-section {
            background-color: #ffebee; /* 柔和的紅色背景 */
            border: 1px solid #ef9a9a;
            color: #d32f2f; /* 深紅色字體 */
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .error-section ul {
            margin-top: 10px;
            list-style: disc inside; /* 顯示點 */
            color: #d32f2f;
        }
        .error-section li {
            background-color: transparent;
            border: none;
            padding: 2px 0;
            margin-bottom: 0;
            transform: none;
            box-shadow: none;
        }

        /* 提示段落 */
        .intro-text {
            text-align: center;
            margin-bottom: 30px;
            color: #555;
            font-size: 1.1em;
        }
    </style>
</head>
<body>

<div class="container">
    <header class="page-header">
        <h1>TJA101G3 論壇</h1>
        <h4>(MVC 架構)</h4>
    </header>

    <p class="intro-text">這是 TJA101G3 論壇的首頁，提供討論區的查詢與管理功能。</p>

    <%-- 錯誤表列 --%>
    <c:if test="${not empty errorMsgs}">
        <div class="error-section">
            <p><strong>請修正以下錯誤：</strong></p>
            <ul>
                <c:forEach var="message" items="${errorMsgs}">
                    <li>${message}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <h3>資料查詢</h3>
    <ul>
        <li>
            <a href='listAllForum.jsp'>列出所有討論區</a>
        </li>

        <li>
            <form method="post" action="forum.do">
                <label for="forNoInput">輸入討論區編號 (如: 1):</label>
                <input type="text" id="forNoInput" name="forNo" placeholder="請輸入編號">
                <input type="hidden" name="action" value="getOne_For_Display">
                <input type="submit" value="查詢">
            </form>
        </li>

        <jsp:useBean id="forumSvc" scope="page" class="com.forum.model.ForumService" />

        <li>
            <form method="post" action="forum.do">
                <label for="forNoSelect">選擇討論區編號:</label>
                <select id="forNoSelect" name="forNo">
                    <c:forEach var="forumVO" items="${forumSvc.all}">
                        <option value="${forumVO.forNo}">${forumVO.forNo}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="action" value="getOne_For_Display">
                <input type="submit" value="查詢">
            </form>
        </li>

        <li>
            <form method="post" action="forum.do">
                <label for="forNameSelect">選擇討論區名稱:</label>
                <select id="forNameSelect" name="forNo">
                    <c:forEach var="forumVO" items="${forumSvc.all}">
                        <option value="${forumVO.forNo}">${forumVO.forName}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="action" value="getOne_For_Display">
                <input type="submit" value="查詢">
            </form>
        </li>
    </ul>

    <h3>討論區管理</h3>
    <ul>
        <li>
            <a href='<%=request.getContextPath()%>/front-end/forum/addForum.jsp'>新增討論區</a>
        </li>
    </ul>
</div>

</body>
</html>