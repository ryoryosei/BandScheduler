<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<title>削除する月の入力</title>
</head>
<body>
	<%@include file="header.jsp"%>
    <div class="container mt-5">
    	<% 
                String errorMsg = (String)request.getAttribute("errorMsg");
                if (errorMsg != null) {
            %>
                    <p class="alert alert-danger"><%= errorMsg %></p>
            <%
                } 
            %>
            
       <form action="delete-servlet" method="post" class="mt-3">
    	<div class="form-group">
                <label for="name">名前：</label>
                <input type="text" id="name" name="name" class="form-control" required>
        	</div>
            <hr>
            
            
        <div class="mt-4">
            <p class="lead">削除する月を選択してください</p>
     
            
                <div class="form-group">
                    <label for="monthSelect">月を選択</label>
                    <select class="form-control" id="monthSelect" name="month" required>
                        <option value="">選択してください</option>
                        <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                        <% } %>
                    </select>
                </div>
                <div class="text-center mt-4">
                    <input type="submit" value="次へ" class="btn btn-primary btn-lg">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
