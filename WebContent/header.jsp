<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%
	String username = (String) session.getAttribute("username");
	String useremail = (String) session.getAttribute("useremail");
	String userid = (String) session.getAttribute("userid");

	JoinDao joindao = new JoinDaoImpl();
	User user = new User();
	user.setEmail(useremail);
	user.setId(Long.parseLong(userid));
	user.setName(username);

	Connection conn = null;
	conn = ConnectionFactory.getInstance().makeConnection();
	conn.setAutoCommit(false);
	List<Join> joinlist = joindao.getfromuser(conn, user);
	List<Class> classlist = joindao.getclass(conn, user);
%>
<link href="css/header.css" rel="stylesheet" type="text/css" />
<link href="css/board.css" rel="stylesheet" type="text/css" />
<div class="modal fade" id="classmanagement" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">管理班级</h4>
			</div>
			<div class="modal-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>班级名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="class1" items="<%=classlist%>">
							<tr>
								<td>${class1.name}</td>
								<td><a href="<%=request.getContextPath()%>/c/${class1.id}"
									class="btn btn-primary" role="button">进入班级</a> <a
									href="<%=request.getContextPath()%>/QuitclassServlet?classid=${class1.id}"
									class="btn btn-danger" role="button">退出班级</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<div class="modal fade" id="createclass" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">创建班级</h4>
			</div>
			<div class="modal-body">
				<form action="<%=request.getContextPath()%>/CreateclassServlet"
					method="post" name="LoginForm">
					<input type="text" name="inputclassname" class="form-control"
						placeholder="班级名称" required autofocus>
					<div class="line-large"></div>
					<button class="btn btn-primary" type="submit" name="submit"
						onclick="return check(this);">确认提交</button>
					<button class="btn btn-default" type="reset" name="reset">重置</button>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<div class="modal fade" id="joinclass" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">加入班级</h4>
			</div>
			<div class="modal-body">
				<form action="<%=request.getContextPath()%>/SearchclassServlet"
					method="post" name="LoginForm">
					<div>
						<input type="text" name="inputuseremail" class="form-control"
							placeholder="班级ID或班级名称" required autofocus>
						<button class="btn" type="submit" name="submit"
							onclick="return check(this);">搜索</button>

					</div>
				</form>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>班級名稱</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>13计算机</td>
							<td><a href="#" class="btn btn-primary" role="button">进入班级</a>
								<a href="#" class="btn btn-danger" role="button">退出班级</a></td>
						</tr>
						<tr>
							<td>Sachin</td>
							<td>Mumbai</td>
						</tr>
						<tr>
							<td>Uma</td>
							<td>Pune</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<div class="modal fade" id="userset" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">用户设置</h4>
			</div>
			<div class="modal-body">
				<h4>信息修改</h4>
				<div style="width: 200px; margin-left: auto; margin-right: auto;">

					<form action="<%=request.getContextPath()%>/UserinfoServlet"
						method="post" name="LoginForm">
						<input type="text" name="inputuserphone" class="form-control"
							placeholder="电话" required autofocus>
						<div class="line-large"></div>
						<input type="text" name="inputuseraddr" class="form-control"
							placeholder="地址" required autofocus>
						<div class="line-large"></div>
						<input type="password" name="inputuserpassword"
							class="form-control" placeholder="密码" required>
						<div class="line-large"></div>
						<button class="btn btn-primary" type="submit" name="submit"
							onclick="return check(this);">确认提交</button>
						<button class="btn btn-default" type="reset" name="reset">重置</button>
					</form>
				</div>
				<h4>密码修改</h4>
				<div style="width: 200px; margin-left: auto; margin-right: auto;">


					<form action="<%=request.getContextPath()%>/PasswordServlet"
						method="post" name="LoginForm">
						<input type="password" name="inputuserpassword"
							class="form-control" placeholder="旧密码" required>
						<div class="line-large"></div>
						<input type="password" name="inputnewpassword"
							class="form-control" placeholder="新密码" required>
						<div class="line-large"></div>
						<input type="password" name="inputrenewpassword"
							class="form-control" placeholder="确认新密码" required>
						<div class="line-large"></div>
						<button class="btn btn-primary" type="submit" name="submit"
							onclick="return check(this);">确认提交</button>
						<button class="btn btn-default" type="reset" name="reset">重置</button>
					</form>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<div class="modal fade" id="systemset" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">系统设置</h4>
			</div>
			<div class="modal-body"></div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">班级列表
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<c:forEach var="class1" items="<%=classlist%>">
							<li><a href="<%=request.getContextPath()%>/c/${class1.id}">
									${class1.name} </a></li>
						</c:forEach>
						<li class="divider"></li>
						<li><a href="" data-toggle="modal"
							data-target="#classmanagement">管理班级</a></li>
						<li><a href="" data-toggle="modal" data-target="#createclass">创建班级</a></li>
						<li><a href="<%=request.getContextPath()%>/joinclass.jsp">加入班级</a></li>
					</ul></li>
			</ul>
			<form class="navbar-form navbar-left" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
			</form>

			<a class="header-logo" href="<%=request.getContextPath()%>/board.jsp"
				title="返回主页"><img alt="logo" src="<%=request.getContextPath()%>/images/logo100.png"> </a>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="">+</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><span
						class="glyphicon glyphicon-user" aria-hidden="true"></span> <%=session.getAttribute("username")%>
						<span class="caret"></span> </a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#" data-toggle="modal" data-target="#userset">用户管理</a></li>
						<li><a href="#" data-toggle="modal" data-target="#systemset">系统设置</a></li>
						<li class="divider"></li>
						<li><a href="<%=request.getContextPath()%>/logout.jsp">退出系统</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>