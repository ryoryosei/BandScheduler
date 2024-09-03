<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<title>新規登録</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">新規登録</h2>
        <form action="signup-servlet" method="post" class="mt-4">
            <div class="form-group">
                <label for="userId">新しいグループID：</label>
                <input type="text" class="form-control" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="password">新しいパスワード：</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">登録</button>
        </form>
        <hr>
        <a href="Login.jsp" class="btn btn-link">ログイン画面に戻る</a>
    </div>
</body>
</html>
