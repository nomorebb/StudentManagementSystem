<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
session.removeAttribute("useremail"); 
session.removeAttribute("userid"); 
session.removeAttribute("username"); 
session.invalidate(); 
request.setAttribute("msgtype", "success");
request.setAttribute("msg", "退出成功!");
RequestDispatcher rd = null;
rd = request.getRequestDispatcher("index.jsp");
rd.forward(request, response);

//out.print("<script type='text/javascript'>alert('用户即将退出，确定后退出该页面。');window.location.href='index.jsp'</script>"); 
%> 