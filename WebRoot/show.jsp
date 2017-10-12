<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
		<style type="text/css">
		h1,div{text-align: center;}
		table{
			margin: 0 auto;
			width: 50%;
			border-collapse: collapse;
		}
		table td,th{
			border: 1px solid black;
			padding: 2px;
			text-align:center;
		}
		a{
			margin: 0 auto;
			width:50%;
			text-decoration: none;
		}
	</style>
	</head>
  
	<body>
    	<h1>人员信息</h1>
    	 <c:if test="${not empty student }">
    	<table>
		<tr>
			<th>id</th>
			<th>姓名</th>
			<th>性别</th>
			<th>年龄</th>
			<th>所学专业</th>
			<th>年级</th>
			<th>操作一</th>
			<th>操作二</th>
		</tr>
			<tr>
				<td>${student.id }</td>
				<td>${student.name }</td>
				<td>${student.sex }</td>
				<td>${student.age }</td>
				<td>${student.major }</td>
				<td>${student.grade }</td>
				<td><a href="${pageContext.request.contextPath }/servlet/loadForChangeServlet?id=${student.id }">修改</a></td>
				<td><a href="${pageContext.request.contextPath }/servlet/deleteServlet?id=${student.id }">删除</a></td>
			</tr>
		
	</table><br/>
	</c:if >
	<c:if test="${empty student }">
	        <div><font color="red" size="+1">对不起！没有该学号对应的学生....</font></div>
	</c:if>
	<hr>
		<a href="${pageContext.request.contextPath }/index.jsp">返回首页</a>
	<hr>
	</body>
</html>
