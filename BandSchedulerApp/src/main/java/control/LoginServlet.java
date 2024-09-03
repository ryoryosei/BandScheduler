package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * ログイン処理を行うサーブレット
 * @author M.Takahashi
 */
@WebServlet("/login-servlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
	
		
		//データベース処理
		Connection con = null;
		String url = null;
	       try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
	         con = DriverManager.getConnection("jdbc:mysql://localhost/java", "user","pass");
	         //
	         String sql = "select * from java.login where name = ? and password = ?;";
	         PreparedStatement st = con.prepareStatement(sql);
	        st.setString(1,userId);
	        st.setString(2, password);
	        
	         ResultSet result = st.executeQuery();
	         
	         if(result.next()) {
	        	 HttpSession session = request.getSession();
	 			 session.setMaxInactiveInterval(100000);
	 			 
	 			 session.setAttribute("userId", userId);
	        	 url="Home.jsp";
	         } else {
	        	 request.setAttribute("errorMsg","グループIDまたはパスワードに誤りがあります。");
	        	 url = "Login.jsp";
	         }
	       
	       } catch (ClassNotFoundException e) {
		    	//   
	    	   System.out.println("Driver not found");
		    	   e.printStackTrace();
	       } catch (SQLException ex) {
	    	   ex.printStackTrace();
	    	   request.setAttribute("errorMsg", "データベース接続に失敗しました。");	
	    	   url = "Login.jsp";
	       }
	       
	       RequestDispatcher dispatcher = request.getRequestDispatcher(url);
			dispatcher.forward(request, response);
	}
}
