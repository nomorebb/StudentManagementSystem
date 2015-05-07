package com.sms.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.Entity.Class;
import com.sms.Entity.Inform;
import com.sms.Entity.User;
import com.sms.dao.InformDao;
import com.sms.dao.InformviewDao;
import com.sms.dao.impl.InformDaoImpl;
import com.sms.dao.impl.InformviewDaoImpl;
import com.sms.util.ConnectionFactory;

public class AddinformServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddinformServlet() {
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

		String title = request.getParameter("inputtitle");
		String content = request.getParameter("inputcontent");
		Inform inform = new Inform();
		inform.setTitle(title);
		inform.setContent(content);



		RequestDispatcher rd = null;
		String forward = null;

		HttpSession session = request.getSession();
		if (session.getAttribute("userid") == null) {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "请重新登录！");
			rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}
		Long classid = Long.parseLong((String) session.getAttribute("classid"));
		Class class1 = new Class();
		class1.setId(classid);
		
		Long userid = Long.parseLong((String) session.getAttribute("userid"));
		User user = new User();
		user.setId(userid);

		Connection conn = null;
		Boolean flag = false;
		InformDao informdao = new InformDaoImpl();
		InformviewDao informviewdao = new InformviewDaoImpl();
		try {
			conn = ConnectionFactory.getInstance().makeConnection();
			inform.setAuthorid(userid);
			if (informdao.save(conn, inform)) {
				inform = informdao.get(conn, inform);
				flag = informviewdao.save(conn, class1, inform);
			}
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
			request.setAttribute("msg", "添加通知成功!");
		} else {
			request.setAttribute("msgtype", "error");
			request.setAttribute("msg", "添加通知失败!");
		}
		forward = "c/" + classid;
		rd = request.getRequestDispatcher(forward);
		rd.forward(request, response);

	}
}
