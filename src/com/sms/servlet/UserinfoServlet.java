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
import com.sms.Entity.Userdata;

import com.sms.dao.UserdataDao;

import com.sms.dao.impl.UserdataDaoImpl;
import com.sms.util.ConnectionFactory;

public class UserinfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserinfoServlet() {
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

		if (request.getParameter("inputuserphone") == null
				|| request.getParameter("inputuseraddr") == null) {
			return;
		}
		String userephone = request.getParameter("inputuserephone");
		String useraddr = request.getParameter("inputuseraddr");
		Userdata userdata = new Userdata();
		userdata.setAddress(useraddr);
		userdata.setUserid(userid);
		userdata.setPhone(userephone);
		Connection conn = null;
		Boolean flag = false;

		UserdataDao userdatadao = new UserdataDaoImpl();
		try {
			conn = ConnectionFactory.getInstance().makeConnection();
			flag = userdatadao.save(conn, userdata);
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
			request.setAttribute("msg", "修改个人信息成功!");
		} else {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "修改个人信息失败!");
		}
		forward = "board.jsp";
		rd = request.getRequestDispatcher(forward);
		rd.forward(request, response);
	}

}
