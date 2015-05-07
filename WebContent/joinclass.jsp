<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="common/Session_Check.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.sms.util.ConnectionFactory"%>
<%@ page import="com.sms.dao.JoinDao"%>
<%@ page import="com.sms.dao.impl.JoinDaoImpl"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.sms.Entity.User"%>
<%@ page import="com.sms.Entity.Class"%>
<%@ page import="com.sms.Entity.Join"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sms.dao.ClassDao"%>
<%@ page import="com.sms.dao.impl.ClassDaoImpl"%>
<%
session.removeAttribute("classid"); 

	String username = (String) session.getAttribute("username");
	String useremail = (String) session.getAttribute("useremail");
	String userid = (String) session.getAttribute("userid");

	JoinDao joindao = new JoinDaoImpl();
	ClassDao classdao = new ClassDaoImpl();
	User user = new User();
	user.setEmail(useremail);
	user.setId(Long.parseLong(userid));
	user.setName(username);

	Connection conn = null;
	conn = ConnectionFactory.getInstance().makeConnection();
	conn.setAutoCommit(false);
	List<Join> joinlist = joindao.getfromuser(conn, user);
	List<Class> classlist = classdao.getall(conn,user);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap-theme.min.css" rel="stylesheet"
	type="text/css" />
<link href="css/header.css" rel="stylesheet" type="text/css" />
<link href="css/board.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="images/favicon.png" />
<title>SMS！</title>
</head>
<body>
<jsp:include page="/header.jsp" flush="true" />

<div class="container">
		<c:if test="${msg != null && msgtype == 'error'}">
			<div class="alert alert-danger" role="alert">
				<a href="#" class="close" data-dismiss="alert">&times;</a> <span
					class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
				<c:out value="${msg}"></c:out>
			</div>
		</c:if>
		<c:if test="${msg != null && msgtype == 'success'}">
			<div class="alert alert-success" role="alert">
				<a href="#" class="close" data-dismiss="alert">&times;</a> <span
					class="glyphicon glyphicon-ok" aria-hidden="true"></span>
				<c:out value="${msg}"></c:out>
			</div>
		</c:if>
		<div class="col-sm-12">
			<h3>所有班级</h3>
			<%
				for (int i = 0; i < classlist.size(); i++) {
						out.print("<div class=\"col-sm-5 col-md-3\"><div class=\"thumbnail\"><div class=\"caption\"><span class=\"badge alert-info pull-right\">");
						out.print(classlist.get(i).getId());
						out.print("</span><h4>");
						out.print(classlist.get(i).getName());
						out.print("</h4><p><a href=\"");
						out.print(request.getContextPath());
						out.print("/JoinclassServlet?classid=");
						out.print(classlist.get(i).getId());
						out.print("\" class=\"btn btn-primary  btn-block\" role=\"button\">加入</a></p></div></div></div>");
				}
			%>


			<!-- 			<div class="col-sm-5 col-md-3">
				<div class="thumbnail">
					<div class="caption">
						<span class="badge alert-info pull-right">17</span>
						<h4>14计算机系统结构</h4>
						<p>
							<a href="#" class="btn btn-primary btn-block" role="button">进入班级</a>
							<a href="#" class="btn btn-default btn-block" role="button">管理班级</a>
						</p>
					</div>
				</div>
			</div> -->


		</div>
	</div>


	<script src="js/jquery-2.1.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>