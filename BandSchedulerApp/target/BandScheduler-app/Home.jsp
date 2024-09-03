<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ホーム画面</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <div class="text-center mb-4">
                    <h2>新しく予定を登録する</h2>
                    <button class="btn btn-primary" onclick="location.href='Days.jsp'">登録</button>
                </div>
                <div class="text-center mb-4">
                    <h2>予定を確認する</h2>
                    <button class="btn btn-success" onclick="location.href='When.jsp'">確認</button>
                </div>
                
                <div class="text-center mb-4">
                    <h2>予定を削除する</h2>
                    <button class="btn btn-danger" onclick="location.href='Delete.jsp'">削除</button>
                </div>
                
                <% 
                    String errorMsg = (String) request.getAttribute("errorMsg");
                    if (errorMsg != null) {
                %>
                    <div class="alert alert-danger text-center" role="alert">
                        <%= errorMsg %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
