<%@ page pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="css/home.css">
<br>
<h2>　シー大軽音【Band Scheduler】</h2>
<hr>
	<%-- ユーザID の表示 --%>
	<%
		String userId = (String) session.getAttribute("userId");
		if (userId == null){
			request.setAttribute("errorMsg", "セッションが切断されました。再ログインしてください");
			RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
			dispatcher.forward(request, response);
		}
	%>
			グループ名：<%=userId %>
<hr>
｜<a href="Home.jsp">ホームへ</a>｜<a href="Login.jsp">ログアウト</a>｜
<hr>
