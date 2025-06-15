<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>頁面不見啦～ - 404 錯誤</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        .container {
            background-color: #fff;
            margin: 0 auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }
        h1 {
            color: #d9534f;
            font-size: 4em;
            margin-bottom: 10px;
        }
        h2 {
            color: #5cb85c;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2em;
            line-height: 1.6;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
                ul {
            list-style-type: none; 
            padding: 0;
            margin: 0;
            text-align: left; 
            display: inline-block; 
        }
        ul li {
            margin-bottom: 10px; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>404</h1>
        <h2>哎呀！頁面不見啦...</h2>
        <p>您要找的頁面可能已被移除、名稱已更改，或者暫時無法使用。</p>
        <p>您可以嘗試：</p>
        <ul>
            <li>檢查網址是否有輸入錯誤</li>
            <li>返回<a href="/TJA101G3/back-end/forum/select_page.jsp">網站首頁</a></li>
            <li>使用網站的搜尋功能尋找您需要的內容</li>
        </ul>
        <p>如果您認為這是一個錯誤，請聯絡網站管理員</p>
        <%
        %>
    </div>
</body>
</html>