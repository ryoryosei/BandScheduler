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
 * Servlet implementation class FormServlet
 */
@WebServlet("/form-servlet")
public class FormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FormServlet() {
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
		
		
		
		
		
	//グループ名取得（セッション）
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			request.setAttribute("errorMsg","セッションが切断されました。再ログインしてください。");
			RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
			dispatcher.forward(request, response);
		}
		//
		
		
		
		
		
	//名前と日程取得
		String name = request.getParameter("name");
		String month =request.getParameter("month");
		String[] day = request.getParameterValues("day");
		String[] first = request.getParameterValues("first");
		String[] second = request.getParameterValues("second");
		String[] third = request.getParameterValues("third");
		String[] forth = request.getParameterValues("forth");
		String[] fifth = request.getParameterValues("fifth");
		String[] eight = request.getParameterValues("eight");
		String[] nine = request.getParameterValues("nine");
		String[] last = request.getParameterValues("last");
		//
		
		
		
		
		
		
	//データベース処理
		Connection con = null;
		String url = null;
	       try {
	    	 Class.forName("com.mysql.cj.jdbc.Driver");
	         con = DriverManager.getConnection("jdbc:mysql://localhost/java", "user","pass");
	         //System.out.println("database connected");
	         
	         
	         
	//グループのデータベースがあるかどうか
	         String sql01 = "show databases like '"+ userId +"';";
	         PreparedStatement st01 = con.prepareStatement(sql01);
	         ResultSet result = st01.executeQuery(sql01);
	         
	         if(result.next()) {
	        	 
	        	 //データベースあるから何もしない
	        	 
	         
	         } else {
	        	 
	        	//グループのデータベースを作成
	 	         String sql = "create database `"+ userId +"`";
	 	         PreparedStatement st = con.prepareStatement(sql);
	 	         st.executeUpdate(sql);
	 	         //
	 	         
	         }
	         //
	         
	         
	         
	 //ユーザーのテーブルがあるかどうか
	         con = DriverManager.getConnection("jdbc:mysql://localhost/"+ userId , "user","pass");
	         String sql02 = "show tables like ? ;";
	         PreparedStatement st02 = con.prepareStatement(sql02);
	         st02.setString(1,name);
	         ResultSet result2 = st02.executeQuery();
	         
	         if(result2.next()) {
	        	 
	        	 //ユーザーのテーブルあるから何もしない
	        	 
	        	 
	         } else {
	        	 
	        	//メンバーのテーブル作成
		         String sql2 = "create table `"+ userId +"`.`"+ name +"` ("
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
		         
		         PreparedStatement st2 = con.prepareStatement(sql2);
		         
		         st2.executeUpdate(sql2);
		         //
	         }
	         //
	        
	         
	              
	         int Start = Integer.parseInt(day[0]);
	         int End = Integer.parseInt(day[day.length-1]);
	        
	         
	 //入力内容をDBに保存
	         for( int i = 0 ; i <= End-Start ; i++ ) {
	        	 
	        	 //すでにその日月のデータが存在するかどうか
	        	 String sql03 = "select * from `"+ name +"` where month = ? and day = ?;"; 
	        	 PreparedStatement st03 = con.prepareStatement(sql03);
	        	 st03.setString(1, month);
	        	 st03.setString(2,day[i]);
	        	
	        	 
	        	 ResultSet result3 = st03.executeQuery();
	        	 
	        	 if(result3.next()) {
	        		 
	        		 //その日月のデータは存在するので値を更新する
	        		 String sql003 = "update `"+ userId +"`.`"+ name +"`"
	        		 		+ " set first = ?, second = ?, third = ?, forth = ?,"
	        		 		+ " fifth = ?, eight = ?, nine = ?, last = ?"
	        		 		+ " where month = ? and day = ?" ;
	        		 PreparedStatement st003 = con.prepareStatement(sql003);
	        		 st003.setString(1,first[i]);
	        		 st003.setString(2,second[i]);
	        		 st003.setString(3,third[i]);
	        		 st003.setString(4,forth[i]);
	        		 st003.setString(5,fifth[i]);
	        		 st003.setString(6,eight[i]);
	        		 st003.setString(7,nine[i]);
	        		 st003.setString(8,last[i]);
	        		 st003.setString(9,month);
	        		 st003.setString(10,day[i]);
	        		 
	        		 st003.executeUpdate();
	        		 
	        	 } else {
	        		 
	        		 //その日月の新しくデータを挿入
	        		 String sql3 = "insert into `"+ userId +"`.`"+ name +"` ("
	 		         		+ "month,day,first,second,third,forth,fifth,eight,nine,last ) "
	 		         		+ "values "
	 		         		+ "("+ month +","+ day[i] +",'" + first[i] +"','"+ second[i] +"','"+ third[i] +"','"+ forth[i] +"','"+ fifth[i] +"','"+ eight[i] +"','"+ nine[i] +"','"+ last[i] +"');";
	 		         PreparedStatement st3 = con.prepareStatement(sql3);
	 		         st3.executeUpdate(sql3);
	 		         
	        	 }
		         
	         }
	         
	  
        	 
        	 
        	 
	         
	         request.setAttribute("errorMsg","登録しました");
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
