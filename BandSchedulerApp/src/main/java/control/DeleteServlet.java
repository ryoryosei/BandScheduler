package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/delete-servlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteServlet() {
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

		String name = request.getParameter("name");
		String month = request.getParameter("month");
		
		
		//グループ名取得（セッション）
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			request.setAttribute("errorMsg","セッションが切断されました。再ログインしてください。");
			RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
			dispatcher.forward(request, response);
		}
		//
		
		
	//データベース処理
		Connection con = null;
		String url = null;
	       try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
	         con = DriverManager.getConnection("jdbc:mysql://localhost/"+userId+"?useUnicode=true&characterEncoding=UTF-8", "user","pass");
	         
	         String sql = "delete from `"+ name +"` where month=?";
	         PreparedStatement s = con.prepareStatement(sql);
	         s.setString(1,month);
	       
	         
	         int rs = s.executeUpdate();
	         
	         if(rs == 0) {
	        	request.setAttribute("errorMsg","その月は登録されていません");
	 			RequestDispatcher dispatcher = request.getRequestDispatcher("Delete.jsp");
	 			dispatcher.forward(request, response);
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
	       
	       url = "Home.jsp";
	       request.setAttribute("errorMsg","削除されました");
	       
	       RequestDispatcher dispatcher = request.getRequestDispatcher(url);
			dispatcher.forward(request, response);
		
	}

}
