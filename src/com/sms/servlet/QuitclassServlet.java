package com.sms.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.Entity.User;
import com.sms.Entity.Class;
import com.sms.dao.JoinDao;
import com.sms.dao.impl.JoinDaoImpl;
import com.sms.util.ConnectionFactory;

public class QuitclassServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public QuitclassServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html;charset=UTF-8");
		
		RequestDispatcher rd = null;
		String forward = null;

		HttpSession session = request.getSession();
		if (session.getAttribute("userid") == null) {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "请重新登录！");
			rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}
		Long userid = Long.parseLong((String) session.getAttribute("userid"));
		User user = new User();
		user.setId(userid);

		if (request.getParameter("classid") == null) {
			return;
		}
		Long classid = Long.parseLong(request.getParameter("classid"));
		Class class1 = new Class();
		class1.setId(classid);
		Connection conn = null;
		Boolean flag = false;
		JoinDao joindao = new JoinDaoImpl();
		try {
			conn = ConnectionFactory.getInstance().makeConnection();
			flag = joindao.delete(conn, class1, user);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e3) {
				e3.printStackTrace();
			}
		}
		if (flag) {
			request.setAttribute("msgtype", "success");
			request.setAttribute("msg", "退出成功!");
		} else {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "退出失败!");
		}
		forward = "board.jsp";
		rd = request.getRequestDispatcher(forward);
		rd.forward(request, response);
	}
}
