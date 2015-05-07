<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/Session_CheckLogin.jsp"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.sms.util.ConnectionFactory"%>
<%@ page import="com.sms.dao.UserDao"%>
<%@ page import="com.sms.dao.impl.UserDaoImpl"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.sms.Entity.User"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>SMS!——班务管理系统</title>
</head>
<body>
	<jsp:include page="/header.jsp" flush="true" />
	<%-- <%
	String a = "321";
	UserDao userDao = new UserDaoImpl();
	User user = new User();
	user.setEmail("jack@123.com");
	user.setPassword("123");
		Connection conn = null;
	conn = ConnectionFactory.getInstance().makeConnection();
	conn.setAutoCommit(false);
	ResultSet resultSet = userDao.get(conn, user);
	List<User> users = new ArrayList<User>();
	while (resultSet.next()) {
		user.setName(resultSet.getString("name"));
		user.setId(resultSet.getLong("id"));
		users.add(user);
	}
	
	%> --%>
<%-- <c:forEach var="user" items="<%=users %>">
  <c:out value="${user.name}"/>
  <c:out value="${user.id}"/>
</c:forEach> --%>

	<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>