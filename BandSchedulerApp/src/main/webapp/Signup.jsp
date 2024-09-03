<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.6.16/dist/css/uikit.min.css" />
<link rel="stylesheet" href="css/login.css">
<title>新規登録</title>
</head>
<body>

<div class="uk-section uk-flex-middle" uk-height-viewport>
<br>
<h2> 　シー大軽音【Band Scheduler】</h2>


<div class="uk-container">
    <div class="uk-card uk-card-default uk-card-body uk-width-1-2@m uk-margin-auto">
        <h3 class="uk-card-title">新規登録</h3>
        
        <form action="signup-servlet" method="post" class="mt-4">
		<div class="uk-margin">
                <label for="username" class="uk-form-label">新しいバンドID：</label>
                <div class="uk-form-controls">
                <input class="uk-input" id="username" type="text" name="userId" required>
        </div>
            	</div>
         <div class="uk-margin">
                <label for="password">新しいパスワード：</label>
                <div class="uk-form-controls">
                <input class="uk-input" id="password" type="password" name="password" required>
            </div>
            </div>
            <div class="uk-margin">
            	<button class="uk-button uk-button-primary" type="submit">登録</button>
        	</div>
        </form>
        <br>
        <p>※注意事項</p>
        <p>バンドIDとパスワードはバンド内で共有してください。</p>
        <p>バンドIDに記号は使用しないでください。</p>
        
         <% 
		String errorMsg = (String)request.getAttribute("errorMsg");
		if (errorMsg != null) {
	%>
			<hr><p class="error-msg"><%= errorMsg %></p>
	<%
		} 
	%>
	<hr>
        <a href="Login.jsp" class="btn btn-link">ログイン画面に戻る</a>
    </div>
    </div>
    </div>
</body>
</html>
