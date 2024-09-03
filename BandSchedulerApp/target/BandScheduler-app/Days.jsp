<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>期間の入力</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="css/days.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@include file="header.jsp"%><br>
    
    <div class="container mt-5">
        <div class="text-center">
            <p class="lead">どの期間の予定を入力しますか</p>
        </div>
        
        <form action="days-servlet" method="post" class="form-container">
            <div class="form-group">
                <label for="month">月</label>
                <select name="month" id="month" class="custom-select" required>
                    <option value="">選択してください</option>
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="dayStart">開始日</label>
                <select name="dayStart" id="dayStart" class="custom-select" required>
                    <option value="">選択してください</option>
                    <% for (int i = 1; i <= 31; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>

            <p class="text-center">から</p>

            <div class="form-group">
                <label for="dayEnd">終了日</label>
                <select name="dayEnd" id="dayEnd" class="custom-select" required>
                    <option value="">選択してください</option>
                    <% for (int i = 1; i <= 31; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>

            <div class="text-center mt-4">
                <input type="submit" value="次へ" class="btn btn-primary btn-lg">
            </div>
        </form>
        
        <div class="text-center mt-4">
            <% 
                String errorMsg = (String) request.getAttribute("errorMsg");
                if (errorMsg != null) {
            %>
                <p class="text-danger"><%= errorMsg %></p>
            <% } %>
        </div>
    </div>
</body>
</html>
