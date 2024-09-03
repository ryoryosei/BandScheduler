package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class DaysServlet
 */
@WebServlet("/days-servlet")
public class DaysServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DaysServlet() {
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
		String month = request.getParameter("month");
		String dayStart = request.getParameter("dayStart");
		String dayEnd = request.getParameter("dayEnd");
		
		
		////例外処理
		int Start = Integer.parseInt(dayStart);
		int End = Integer.parseInt(dayEnd);
		if(Start > End) {
        	request.setAttribute("errorMsg","ちゃんと選択してください");
 			RequestDispatcher dispatcher = request.getRequestDispatcher("Days.jsp");
 			dispatcher.forward(request, response);
         }
		////
		
		request.setAttribute("month",month);
		request.setAttribute("dayStart", dayStart);
		request.setAttribute("dayEnd", dayEnd);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("scheduleForm.jsp");
		dispatcher.forward(request, response);
	}

}
