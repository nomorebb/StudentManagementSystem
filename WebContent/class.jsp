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
<%@ page import="com.sms.Entity.Inform"%>
<%@ page import="com.sms.dao.InformDao"%>
<%@ page import="com.sms.dao.impl.InformDaoImpl"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Collections"%>

<%
	String classid = request.getParameter("id");
	if (classid == null) {
		request.setAttribute("msgtype", "error");
		request.setAttribute("msg", "进入错误页面！");
		RequestDispatcher rd = request.getRequestDispatcher("board.jsp");
		rd.forward(request, response);
		return;
	}
	
	session.setAttribute("classid", classid);

	Connection conn = null;
	conn = ConnectionFactory.getInstance().makeConnection();
	conn.setAutoCommit(false);

	Class class1 = new Class();
	class1.setId(Long.parseLong(classid));

	ClassDao classdao = new ClassDaoImpl();
	JoinDao joindao = new JoinDaoImpl();
	InformDao informdao = new InformDaoImpl();

	class1 = classdao.get(conn, class1);

	List<User> adminuserlist = joindao.getuser(conn, class1, 1);
	List<User> userlist = joindao.getuser(conn, class1, 2);
	List<Inform> informlist = informdao.getinform(conn, class1);
	Collections.reverse(informlist);

	SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/bootstrap-theme.min.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/header.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/class.css"
	rel="stylesheet" type="text/css" />
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/images/favicon.png" />
<title>SMS!</title>
</head>
<body>
	<jsp:include page="/header.jsp" flush="true" />
	<div class="container main-container">
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
		<div class="col-xs-9">
			<div role="tabpanel">

				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#panel-1"
						aria-controls="panel-1" role="tab" data-toggle="tab">通知</a></li>
					<li role="presentation"><a href="#panel-2"
						aria-controls="panel-2" role="tab" data-toggle="tab">课程表</a></li>
					<li role="presentation"><a href="#panel-3"
						aria-controls="panel-3" role="tab" data-toggle="tab">讨论区</a></li>
					<li role="presentation"><a href="#panel-4"
						aria-controls="panel-4" role="tab" data-toggle="tab">照片墙</a></li>
				</ul>

				<!-- Tab panes -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="panel-1">
						<div class="row masonry-container">

							<%
								for (int i = 0; i < informlist.size(); i++) {
									out.print("<div class=\"col-md-4 col-sm-6 item\"><div class=\"thumbnail\"><div class=\"caption\"><h3>");
									out.print(informlist.get(i).getTitle());
									out.print("</h3><div><small><span class=\"glyphicon glyphicon-time\" aria-hidden=\"true\"></span>");
									out.print(time.format(informlist.get(i).getDatetime()));
									out.print("</small></div><hr /><p>");
									out.print(informlist.get(i).getContent());
									out.print("</p><hr /><p><a href=\"#\" class=\"btn btn-primary\" role=\"button\">打开通知</a> <a href=\"#\" class=\"btn btn-default\" role=\"button\">确认已读</a></p></div></div></div>");
								}
							%>


							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>奖学金发放方式收集</h3>
										<div>
											<small><span class="glyphicon glyphicon-time"
												aria-hidden="true"></span>2015-5-5 16:20</small>
										</div>
										<hr />
										<p>有两种方式，一种是冲入一卡通，一种是发放至本人工行卡。时间比较急，请尽快确认。如果希望发放至工行卡的同学，请私聊我提供本人工行卡卡号。</p>
										<hr />
										<p>
											<a href="#" class="btn btn-primary" role="button">打开通知</a> <a
												href="#" class="btn btn-default" role="button">确认已读</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>论文查重提交通知</h3>
										<div>
											<small><span class="glyphicon glyphicon-time"
												aria-hidden="true"></span>2015-5-5 16:20</small>
										</div>
										<hr />
										<p>还没提交论文的同学，请再检查一次自己的论文，借鉴的部分重新组织一下，代码如果是自己写的没问题，如果是抄的就改为图片格式。</p>
										<hr />
										<p>
											<a href="#" class="btn btn-primary" role="button">打开通知</a> <a
												href="#" class="btn btn-default" role="button">确认已读</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>体质测试补测</h3>
										<div>
											<small><span class="glyphicon glyphicon-time"
												aria-hidden="true"></span>2015-5-5 16:20</small>
										</div>
										<hr />
										<p>2015年毕业班学生体质测试补测时间定于5月9日（星期六），上午测室内项目，时间为9：00—11：00，下午测室外项目，时间为2：00-4：00，补测人员名单及成绩已放群共享，请各班班委发给同学们核对，并通知同学们按时参加测试。
											注：毕业班毕业前最后一次补测名单已发群共享，请留意</p>
										<hr />
										<p>
											<a href="#" class="btn btn-primary" role="button">打开通知</a> <a
												href="#" class="btn btn-default" role="button">确认已读</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>学工系统启用通知</h3>
										<div>
											<small><span class="glyphicon glyphicon-time"
												aria-hidden="true"></span>2015-5-5 16:20</small>
										</div>
										<hr />
										<p>亲爱的同学您好，本学期学校将全面启动学工系统，大部分日常工作包括评奖评优、勤工助学、党团建设、心理健康、公寓管理、日常考勤、火车票优惠卡、假期留宿等工作，都将通过学工系统来完成，请同学们在校园网环境下（外网不能访问），抽空完善下个人信息，方便今后的信息化建设（截止时间为2015年3月20日）。学工系统登陆方式，首先登陆统一身份认证网址：rz.wzu.edu.cn
											提示：学生帐名为学号。学生初始化密码默认为身份证号码后6位，如遇字母均为大写。2014级新生密码为微哨密码。如有遗忘，请点击右侧“找回账号或密码”找回。进入到统一身份认证平台之后，选择学工系统，即可进入。</p>
										<hr />
										<p>
											<a href="#" class="btn btn-primary" role="button">打开通知</a> <a
												href="#" class="btn btn-default" role="button">确认已读</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>奖学金发放方式收集</h3>
										<div>
											<small><span class="glyphicon glyphicon-time"
												aria-hidden="true"></span>2015-5-5 16:20</small>
										</div>
										<hr />
										<p>有两种方式，一种是冲入一卡通，一种是发放至本人工行卡。时间比较急，请尽快确认。如果希望发放至工行卡的同学，请私聊我提供本人工行卡卡号。</p>
										<hr />
										<p>
											<a href="#" class="btn btn-primary" role="button">打开通知</a> <a
												href="#" class="btn btn-default" role="button">确认已读</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>奖学金发放方式收集</h3>
										<div>
											<small><span class="glyphicon glyphicon-time"
												aria-hidden="true"></span>2015-5-5 16:20</small>
										</div>
										<hr />
										<p>有两种方式，一种是冲入一卡通，一种是发放至本人工行卡。时间比较急，请尽快确认。如果希望发放至工行卡的同学，请私聊我提供本人工行卡卡号。</p>
										<hr />
										<p>
											<a href="#" class="btn btn-primary" role="button">打开通知</a> <a
												href="#" class="btn btn-default" role="button">确认已读</a>
										</p>
									</div>
								</div>
							</div>

						</div>
						<!--/.masonry-container  -->
					</div>
					<!--/.tab-panel -->

					<div role="tabpanel" class="tab-pane" id="panel-2">

						<div class="row masonry-container">

							<table class="table table-hover text-center">
								<thead>
									<tr>
										<th>时间</th>
										<th>周一</th>
										<th>周二</th>
										<th>周三</th>
										<th>周四</th>
										<th>周五</th>
										<th>周六</th>
										<th>周日</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1-2</td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>桌面应用程序开发技术</p>
												<p>王明</p>
												<p>南1-A419</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>3-4</td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>5-6</td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>7-8</td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td><div class="span3">
												<p>软件质量与测试基础</p>
												<p>黄素珍</p>
												<p>南5-A303</p>
											</div></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>9-10</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>


						</div>
						<!--/.masonry-container  -->

					</div>
					<!--/.tab-panel -->

					<div role="tabpanel" class="tab-pane" id="panel-3">
						<div class="row masonry-container">

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/nature" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/nature" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/nature" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/nature" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/nature" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>

						</div>
						<!--/.masonry-container  -->
					</div>
					<!--/.tab-panel -->

					<div role="tabpanel" class="tab-pane" id="panel-4">
						<div class="row masonry-container">

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/cats" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/cats" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/cats" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/cats" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>
							<!--/.item  -->

							<div class="col-md-4 col-sm-6 item">
								<div class="thumbnail">
									<img src="http://lorempixel.com/200/200/cats" alt="">
									<div class="caption">
										<h3>Thumbnail label</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Corrupti, illum voluptates consectetur consequatur
											ducimus. Necessitatibus, nobis consequatur hic eaque laborum
											laudantium. Adipisci, explicabo, asperiores molestias
											deleniti unde dolore enim quas.</p>
										<p>
											<a href="#" class="btn btn-primary" role="button">Button</a>
											<a href="#" class="btn btn-default" role="button">Button</a>
										</p>
									</div>
								</div>
							</div>

						</div>
						<!--/.masonry-container  -->
					</div>
					<!--/.tab-panel -->

				</div>
				<!--/.tab-content -->

			</div>
			<!--/.tab-panel  -->
		</div>
		<div class="col-xs-3 ">
			<div>
				<h3><%=class1.getName()%></h3>
				<p>班级公告，请同学们好好学习！</p>
				<p>班主任电话：15248505690</p>
				<p>班长电话：13958202580</p>
				<p>请假电话：13736903690</p>
			</div>
			<div>
				<a href="" class="btn btn-primary  btn-block" role="button"
					data-toggle="modal" data-target="#addinform"><span
					class="glyphicon glyphicon-send" aria-hidden="true"></span> 添加通知</a>
			</div>
			<h3>成员列表</h3>
			<div class="span3">
				<h4>管理员</h4>
				<%
					for (int i = 0; i < adminuserlist.size(); i++) {
						out.print("<a href=\"#\" class=\"list-group-item\" role=\"button\"><span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span> ");
						out.print(adminuserlist.get(i).getName());
						out.print("</a>");
					}
				%>
				<a href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 沈君政</a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 班主任</a>
			</div>
			<div class="span3">
				<h4>成员</h4>
				<%
					for (int i = 0; i < userlist.size(); i++) {
						out.print("<a href=\"#\" class=\"list-group-item\" role=\"button\"><span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span>");
						out.print(userlist.get(i).getName());
						out.print("</a>");
					}
				%>
				<a href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 戴敏 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 金源琪 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 李晓丽 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 林施 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 林霞 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 裘柯斌 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 王倩 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 谢贝露 </a> <a
					href="#" class="list-group-item" role="button"><span
					class="glyphicon glyphicon-user" aria-hidden="true"></span> 张田璐 </a>
			</div>
		</div>
	</div>
	<!-- /.container -->

	<div class="modal fade" id="addinform" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加通知</h4>
				</div>
				<div class="modal-body">
					<form action="<%=request.getContextPath()%>/AddinformServlet"
						method="post" name="LoginForm">
						<input type="text" name="inputtitle" class="form-control"
							placeholder="标题" required autofocus>
						<div class="line-large"></div>
						<textarea rows="10" name="inputcontent" class="form-control"
							placeholder="内容" required autofocus></textarea>
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

	<script src="<%=request.getContextPath()%>/js/jquery-1.11.0.min.js"
		type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"
		type="text/javascript"></script>
</body>
</html>