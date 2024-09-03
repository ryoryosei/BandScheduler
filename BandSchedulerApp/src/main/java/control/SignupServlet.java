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


/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/signup-servlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		Connection con = null;
		String url = null;
	       try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
	         con = DriverManager.getConnection("jdbc:mysql://localhost/java", "user","pass");
	         //
	         System.out.println("database connected");
	        
	         //同じグループ名がないか確認
	         String sql0 = "select * from java.login where name = ? ;";
	         PreparedStatement st0 = con.prepareStatement(sql0);
	         st0.setString(1, userId);
	         
	         ResultSet rs = st0.executeQuery(); 
	         if (rs.next()) {
	        	 request.setAttribute("errorMsg", "そのグループ名はすでに存在します。他のグループ名を設定してください");
	        	 url = "Signup.jsp";
	        	 RequestDispatcher dispatcher = request.getRequestDispatcher(url);
	 			 dispatcher.forward(request, response);
	         }
	         
	         
	         
	         
	         
	         
	         String sql = "insert into login (name,password) values (?,?);";
	         PreparedStatement st = con.prepareStatement(sql);
	        st.setString(1,userId);
	        st.setString(2, password);
	        //
	        
	         st.executeUpdate();
	         url = "Login.jsp";
	       
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
	
	

