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
 * Servlet implementation class BringServlet
 */
@WebServlet("/bring-servlet")
public class BringServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BringServlet() {
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
		
		
		request.setCharacterEncoding("UTF-8");
		
		String band = request.getParameter("band");
		String name = request.getParameter("name");
		String month = request.getParameter("month");
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		Connection con = null;
		String url = null;
	       try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
	         con = DriverManager.getConnection("jdbc:mysql://localhost/" , "user","pass");
	         
	       //コピー先のデータベースが存在するかどうか
	         String sql0 = "show databases like '"+ userId +"';";
	         PreparedStatement st0 = con.prepareStatement(sql0);
	         ResultSet result0 = st0.executeQuery(sql0);
	         if (result0.next()) {
	        	 //データベースが存在するからなにもしない
	         } else {
	        	 //データベースが存在しない
	        	 String sql01 = "create database `"+ userId +"`";
	 	         PreparedStatement st01 = con.prepareStatement(sql01);
	 	         st01.executeUpdate(sql01);
	         }
	         
	         
	         //データベースが存在するかどうか
	         String sql = "show databases like '" + band +"';";
	         PreparedStatement st = con.prepareStatement(sql);
	         ResultSet result = st.executeQuery(sql);
	         
	         if (result.next()) {
	        	 //データベースが存在するから何もしない
	         } else {
	        	 //データベースが存在しない
	        	 request.setAttribute("errorMsg", "そのバンド名は存在しません。");
	        	 url = "Bring.jsp";
	        	 RequestDispatcher dispatcher = request.getRequestDispatcher(url);
	 			 dispatcher.forward(request, response);
	         }
	         
	         
	         //テーブルが存在するかどうか
	         con = DriverManager.getConnection("jdbc:mysql://localhost/"+ band , "user","pass");
	         String sql2 = "show tables like ?";
	         PreparedStatement st2 = con.prepareStatement(sql2);
	         st2.setString(1, name);
	         ResultSet result2 = st2.executeQuery();
	         
	         if (result2.next()) {
	        	 //ユーザのテーブルが存在するから何もしない
	         } else {
	        	 //ユーザのテーブルが存在しない
	        	 request.setAttribute("errorMsg","その名前は存在しません。");
	        	 url = "Bring.jsp";
	        	 RequestDispatcher dispatcher = request.getRequestDispatcher(url);
	 			 dispatcher.forward(request, response);
	         }
	         
	         
	         //月が存在するかどうか
	         String sql3 = "select * from `"+ band + "`.`"+ name +"` where month = ?;";
	         PreparedStatement st3 = con.prepareStatement(sql3);
	         st3.setString(1, month);
	         ResultSet result3 = st3.executeQuery();
	         
	         if (result3.next()) {
	        	 //その月のデータが存在する
	         } else {
	        	 //その月のデータが存在しない
	        	 request.setAttribute("errorMsg","その月は登録されていません。");
	        	 url = "Bring.jsp";
	        	 RequestDispatcher dispatcher = request.getRequestDispatcher(url);
	 			 dispatcher.forward(request, response);
	         }
	         
	         
	         //データベースをuserIdに変更
	         con = DriverManager.getConnection("jdbc:mysql://localhost/"+ userId , "user","pass");
	         
	         //コピー先に同じ名前のテーブルが存在するかどうか
	         String sql4 = "show tables like ?;";
	         PreparedStatement st4 = con.prepareStatement(sql4);
	         st4.setString(1, name);
	         ResultSet result4 = st4.executeQuery();
	         
	         if (result4.next()) {
	        	 
	        	 //テーブルが存在しているため空にする
	        	 String sql5 ="truncate table `"+ userId +"`.`"+ name +"`";
	        	 PreparedStatement st5 = con.prepareStatement(sql5);
	        	 st5.executeUpdate();
	        	 
	         } else {
	        	 
	        	 //テーブルがないため、作成
	        	 String sql6 = "create table `"+ userId +"`.`"+ name +"` ("
		         		 + "month varchar(20) not null ,"
		        		 + "day varchar(20) not null , "
		        		 + "first varchar(20) , "
		        		 + "second varchar(20) , "
		        		 + "third varchar(20) , "
		        		 + "forth varchar(20) , "
		        		 + "fifth varchar(20) , "
		        		 + "eight varchar(20) , "
		        		 + "nine varchar(20) , "
		        		 + "last varchar(20) , "
		        		 + "primary key (month,day) "
		        		 + ");";
		         
		         PreparedStatement st6 = con.prepareStatement(sql6);
		         
		         st6.executeUpdate();
	         }
	         
	         //データをコピー
	         String sql7 = "insert into `"+ userId +"`.`"+ name +"`"
	        		 +" (month,day,first,second,third,forth,fifth,eight,nine,last) "
	        		 + "(select * from `"+ band +"`.`"+ name +"` where month = ?)";
	         PreparedStatement st7 = con.prepareStatement(sql7);
	         st7.setString(1, month);
	         st7.executeUpdate();
	         
	         
	         request.setAttribute("errorMsg","コピーされました");
	         url = "Home.jsp";
	         
	         
	         
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
