<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="css/days.css" rel="stylesheet" type="text/css">
<title>他バンドから予定を持ってくる</title>
</head>
<body>
	<%@include file="header.jsp"%><br>
	
	<div class="container mt-5">
        <div class="text-center">
            <p class="lead">コピー元の情報を入力してください</p>
        </div>
        
        <form action="bring-servlet" method="post" class="form-container">
            <div class="form-group">
                <label for="band">バンドID</label>
                    <input type="text" id="band" name="band" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="name">名前</label>
                    <input type="text" id="name" name="name" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="month">月</label>
                <select name="month" id="month" class="custom-select" required>
                    <option value="">選択してください</option>
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
            </div>
            
            <div class="text-center mt-4">
                <input type="submit" value="次へ" class="btn btn-primary btn-lg">
            </div>
            
            <div class="text-center mt-4">
	            <% 
	                String errorMsg = (String) request.getAttribute("errorMsg");
	                if (errorMsg != null) {
	            %>
	                <p class="text-danger"><%= errorMsg %></p>
	            <% } %>
	        </div>
	    </form>
</body>
</html>