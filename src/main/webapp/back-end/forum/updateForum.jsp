<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forum.model.*"%>

<%
    // 見com.forum.controller.ForumServlet.java第163行存入req的forumVO物件 (此為從資料庫取出的forumVO, 也可以是輸入格式有錯誤時的forumVO物件)
    ForumVO forumVO = (ForumVO) request.getAttribute("forumVO");
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>討論區修改 - TJA101G3 論壇</title>
    <style>
        /* 全局樣式 - 保持與前兩個頁面一致 */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6; /* 柔和的淺灰色背景 */
            color: #333;
            line-height: 1.6;
        }

        /* 容器 - 保持與前兩個頁面一致 */
        .container {
            max-width: 800px; /* 根據表單內容調整寬度 */
            margin: 20px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* 柔和的陰影 */
        }

        /* 標題與導航區塊 - 保持與 listAllForum.jsp 一致 */
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

        /* 區塊標題 - 保持與 select_page.jsp 一致 */
        h3 {
            color: #34495e;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-top: 30px;
            margin-bottom: 20px;
            font-size: 1.6em;
        }

        /* 錯誤訊息 - 保持與 select_page.jsp 一致 */
        .error-section {
            background-color: #ffebee;
            border: 1px solid #ef9a9a;
            color: #d32f2f;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .error-section ul {
            margin-top: 10px;
            list-style: disc inside;
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

        /* 表單樣式 */
        .form-table { /* 使用 class 取代 table 標籤直接樣式，避免衝突 */
            width: 100%;
            border-collapse: separate; /* 保持單獨的單元格邊界 */
            border-spacing: 0 10px; /* 行之間的間距 */
            margin-bottom: 20px;
        }

        .form-table td {
            padding: 8px 0; /* 調整單元格內邊距 */
            vertical-align: middle; /* 垂直居中 */
        }

        .label-column {
            width: 150px;
            text-align: right;
            padding-right: 20px; /* 增加標籤與輸入框之間的間距 */
            color: #555;
            font-weight: bold;
        }

        .input-column {
            width: auto;
            text-align: left;
        }

        /* 輸入框和選擇框樣式 */
        input[type="text"],
        textarea,
        select {
            width: calc(100% - 24px); /* 考慮 padding 和 border */
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box; /* 確保 padding 和 border 不增加總寬度 */
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="text"]:focus,
        textarea:focus,
        select:focus {
            border-color: #007bff; /* 聚焦時邊框變藍 */
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25); /* 輕微藍色陰影 */
            outline: none; /* 移除瀏覽器預設外框 */
        }

        textarea {
            resize: vertical; /* 只允許垂直調整大小 */
            min-height: 80px; /* 最小高度 */
        }

        /* 必填星號樣式 */
        .required-star {
            color: red;
            font-weight: bold;
            margin-left: 5px; /* 星號與文字間距 */
        }

        /* 提交按鈕樣式 - 保持與前兩個頁面一致 */
        input[type="submit"] {
            background-color: #28a745; /* 綠色按鈕 */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.2s ease, transform 0.1s ease;
            display: block; /* 讓按鈕獨佔一行 */
            margin: 20px auto 0; /* 居中並留出上方間距 */
        }

        input[type="submit"]:hover {
            background-color: #218838; /* 懸停變深 */
            transform: translateY(-1px); /* 輕微上浮效果 */
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h3>討論區修改</h3>
        <a href="select_page.jsp" class="back-link">
            <img src="<%=request.getContextPath()%>/resources/images/back1.gif" width="24" height="24" alt="回首頁">
            回首頁
        </a>
    </div>

    <h3>資料修改：</h3>

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

    <form method="post" action="forum.do" name="form1">
        <table class="form-table">
            <tr>
                <td class="label-column">討論區編號:<span class="required-star">*</span></td>
                <td class="input-column"><%=forumVO.getForNo()%></td>
            </tr>
            <tr>
                <td class="label-column">討論區名稱:</td>
                <td class="input-column">
                    <input type="TEXT" name="forName" value="<%=forumVO.getForName()%>" placeholder="請輸入討論區名稱"/>
                </td>
            </tr>
            <tr>
                <td class="label-column">討論區類別:</td>
                <%-- 假設您最終會使用下拉選單來選擇討論區類別，目前保留文字輸入框 --%>
                <td class="input-column">
                    <input type="TEXT" name="catNo" value="<%=forumVO.getCatNo()%>" placeholder="請輸入討論區類別編號"/>
                    <%-- 如果未來想啟用下拉選單，可以參考以下範例（需要ForumCategoryService和ForumCategoryVO）：
                    <jsp:useBean id="forumCategorySvc" scope="page" class="com.forum.model.ForumCategoryService" />
                    <select name="catNo">
                        <c:forEach var="forumCategoryVO" items="${forumCategorySvc.all}">
                            <option value="${forumCategoryVO.catNo}" ${forumVO.catNo == forumCategoryVO.catNo ? 'selected' : ''}>
                                ${forumCategoryVO.catName}
                            </option>
                        </c:forEach>
                    </select>
                    --%>
                </td>
            </tr>
            <tr>
                <td class="label-column">討論區描述:</td>
                <td class="input-column">
                    <textarea name="forDes" rows="5" cols="40" placeholder="請輸入討論區描述"><%=forumVO.getForDes()%></textarea>
                </td>
            </tr>
            <tr>
                <td class="label-column">創建時間:<span class="required-star">*</span></td>
                <td class="input-column">
                    <%=forumVO.getForDate()%>
                    <input type="hidden" name="forDate" value="<%=forumVO.getForDate()%>" />
                </td>
            </tr>
            <tr>
                <td class="label-column">狀態更新時間:<span class="required-star">*</span></td>
                <td class="input-column">
                    <%=forumVO.getForUpdate()%>
                    <input type="hidden" name="fchatUpdate" value="<%=forumVO.getForUpdate()%>" />
                </td>
            </tr>
            <tr>
                <td class="label-column">聊天室狀態:</td>
                <td class="input-column">
                    <select name="fchatStatus">
                        <option value="0" <%=forumVO.getFchatStatus() == 0 ? "selected" : ""%>>開啟</option>
                        <option value="1" <%=forumVO.getFchatStatus() == 1 ? "selected" : ""%>>關閉</option>
                    </select>
                </td>
            </tr>
        </table>
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="forNo" value="<%=forumVO.getForNo()%>">
        <input type="submit" value="送出修改">
    </form>
</div>

</body>
</html>