<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.6.16/dist/css/uikit.min.css" />
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<br>
<h2> 　シー大軽音【Band Scheduler】</h2>
<hr>
	

<div class="uk-container uk-margin-large-top">
    <div class="uk-card uk-card-default uk-card-body uk-width-1-2@m uk-margin-auto">
        <h3 class="uk-card-title">ログイン</h3>
        <form action="login-servlet" method="post">
            <div class="uk-margin">
                <label for="username" class="uk-form-label">ユーザー名</label>
                <div class="uk-form-controls">
                    <input class="uk-input" id="username" type="text" name="userId" required>
                </div>
            </div>
            <div class="uk-margin">
                <label for="password" class="uk-form-label">パスワード</label>
                <div class="uk-form-controls">
                    <input class="uk-input" id="password" type="password" name="password" required>
                </div>
            </div>
            <div class="uk-margin">
                <button class="uk-button uk-button-primary" type="submit">ログイン</button>
            </div>
        </form>
        
        <a href="Signup.jsp">新規登録はこちら</a>
        
    </div>
</div>


	<% 
		String errorMsg = (String)request.getAttribute("errorMsg");
		if (errorMsg != null) {
	%>
			<p class="error-msg"><%= errorMsg %></p>
	<%
		} 
	%>

<script src="https://cdn.jsdelivr.net/npm/uikit@3.9.7/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.9.7/dist/js/uikit-icons.min.js"></script>
</body>
</html>
