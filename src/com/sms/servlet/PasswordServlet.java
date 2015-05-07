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
import com.sms.dao.UserDao;
import com.sms.dao.impl.UserDaoImpl;
import com.sms.service.CheckUserService;
import com.sms.util.ConnectionFactory;

public class PasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CheckUserService cus = new CheckUserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PasswordServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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

		String userpassword = request.getParameter("inputuserpassword");
		String newpassword = request.getParameter("inputnewpassword");
		String renewpassword = request.getParameter("inputrenewpassword");

		if (!cus.passwordcheck(user, userpassword)) {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "密码错误!");
			rd = request.getRequestDispatcher("board.jsp");
			rd.forward(request, response);
			return;
		}

		if (!newpassword.equals(renewpassword)) {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "两次密码不一致!");
			rd = request.getRequestDispatcher("board.jsp");
			rd.forward(request, response);
			return;
		}

		user.setPassword(newpassword);

		Connection conn = null;
		Boolean flag = false;

		UserDao userdao = new UserDaoImpl();
		try {
			conn = ConnectionFactory.getInstance().makeConnection();
			flag = userdao.updatepassword(conn, user.getId(), user);
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
			request.setAttribute("msg", "修改密码成功!");
		} else {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "修改密码失败!");
		}
		forward = "board.jsp";
		rd = request.getRequestDispatcher(forward);
		rd.forward(request, response);
	}

}
