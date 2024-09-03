package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class ConfirmServlet
 */
@WebServlet("/confirm-servlet")




public class ConfirmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
		 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmServlet() {
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
		
		
		
		//グループ名取得（セッション）
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("userId");
			if (userId == null) {
				request.setAttribute("errorMsg","セッションが切断されました。再ログインしてください。");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
				dispatcher.forward(request, response);
			}
		//
			
		//monthを取得
			String month = request.getParameter("month");
			
			request.setAttribute("month",month);
			
			
		//データベース処理
			Connection con = null;
			String url = null;
		       try {
		    	 Class.forName("com.mysql.cj.jdbc.Driver");
		         con = DriverManager.getConnection("jdbc:mysql://localhost/", "user","pass");
		         
		         
		       //データベースが存在するかどうか
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
		     
		         
		         
		         
		         con = DriverManager.getConnection("jdbc:mysql://localhost/"+userId, "user","pass");
		    //全てのテーブル名を取得
		         String sqlss = "show tables from `"+ userId +"`"; 
	        	 PreparedStatement ss = con.prepareStatement(sqlss);
	        	 ResultSet resultss = ss.executeQuery();
	        	 
	        	 
	        //三次元配列
	        	 ArrayList<ArrayList<ArrayList<String>>> tableList = new ArrayList<>();
	        	 
	        	 boolean existflag = false; //登録されているかどうか
	        	 boolean tableflag = false;
	        	 while(resultss.next()) {
	        		 String tableName = resultss.getString("Tables_in_"+userId);
	        		 
	        		 
	        //二次元配列
	        		 ArrayList<ArrayList<String>> dayList = new ArrayList<>();
	        		 
	        //ユーザーごとにある月のテーブルを取得
			         String sqls = "select * from `"+ tableName +"` where month = ? order by cast(day as unsigned);"; 
			         PreparedStatement s = con.prepareStatement(sqls);
			         s.setString(1,month);
			            
		        	 ResultSet results = s.executeQuery();
		        	 

		        	 
		        	 
		        	 
		    //各dayのリスト
		        	 while(results.next()) {
		        		 existflag = true;
		        		 tableflag = true;
		        		 
		        		 ArrayList<String> dayData = new ArrayList<>();
		        		 dayData.add(tableName);
		        		 dayData.add(results.getString("day"));
		        		 dayData.add(results.getString("first"));
		        		 dayData.add(results.getString("second"));
		        		 dayData.add(results.getString("third"));
		        		 dayData.add(results.getString("forth"));
		        		 dayData.add(results.getString("fifth"));
		        		 dayData.add(results.getString("eight"));
		        		 dayData.add(results.getString("nine"));
		        		 dayData.add(results.getString("last"));
		        		 
		        		 
		        		 dayList.add(dayData);
		        	
		        	 }
	        		 if(tableflag) {
	        			 tableList.add(dayList);
	        		 }
		        	 tableflag = false;
		        	
	        	 }
	        	 
	        	 
	        	//登録されていない月を選択したときエラーを表示
	        	 if(existflag) {
	        		 
	        	 } else {
	        		 request.setAttribute("errorMsg","その月はまだ誰も登録していません");
	        		 RequestDispatcher dispatcher = request.getRequestDispatcher("When.jsp");
	 				 dispatcher.forward(request, response);
	        	 }
	        	 //
	        
		         
		         
	             url = "Confirm.jsp";
		         
		         

                 
                 
	             request.setAttribute("tableList",tableList);
	             
                
		         
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
