<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.io.InputStream"
	import="org.apache.ibatis.io.Resources"
	import="org.apache.ibatis.session.SqlSession"
	import="org.apache.ibatis.session.SqlSessionFactory"
	import="org.apache.ibatis.session.SqlSessionFactoryBuilder"
	import="java.util.List" import="java.lang.StackWalker.Option"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
table.t {
	width: 900px;
	font-family: verdana, arial, sans-serif;
	font-size: 18px;
	border-width: 1px;
	border-collapse: collapse;
	border-color: #999999;
}

table.t th {
	background-color: rgb(220, 220, 220);
	border-width: 1px;
	padding: 16px;
	border-style: solid;
	border-color: #999999;
}

table.t td {
	border-width: 1px;
	padding: 16px;
	border-style: solid;
	border-color: #999999;
}

table.t tr:nth-child(odd) {
	background: rgb(241, 241, 241);
}

table.t tr:nth-child(even) {
	background: rgb(220, 220, 220);
}

table.t tr:hover {
	background-color: rgb(200, 200, 200);
}

input[type="text"], input[type="number"], select {
	font-size: 16px;
	width: 400px;
	height: 30px;
	margin: 5px;
}

input[type="number"]::-webkit-inner-spin-button, input[type="number"]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

input[type="button"], input[type="submit"] {
	background-color: #1795bb;
	border-radius: 16px;
	border: none;
	color: white;
	padding: 6px 16px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s;
	transition-duration: 0.4s;
	cursor: pointer;
}

input[type="button"]:hover, input[type="submit"]:hover {
	background-color: #fff;
	color: #1795bb;
}

a {
	text-decoration: none;
}

a:visited {
	color: blue;
}

.text {
	font-size: 18px;
	margin-bottom: 20px;
}

label {
	width: 100px;
	text-align: right;
	display: inline-block;
	font-size: 22px;
}

.search {
	width: 600px;
	height: 250px;
	padding: 25px;
	border-width: 1px;
	border-color: #999999;
	border-style: solid;
	box-shadow: 10px 5px 10px rgba(0, 0, 0, 0.2);
}

#queryBox {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: white;
	padding-right: 70px;
	padding-left: 70px;
	padding-top: 20px;
	padding-bottom: 20px;
	border: 1px solid #ccc;
	z-index: 9999;
	border: 1px solid #ccc;
}

#overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 9998;
}

.close {
	width: 30px;
	height: 30px;
	background-color: white;
	position: absolute;
	top: 20px;
	right: 20px;
	text-align: center;
	font-size: 30px;
	line-height: 16px;
	cursor: pointer;
	line-height: 16px;
}
</style>
<title>学生信息</title>
<script>
	function showQueryBox() {
		var queryBox = document.getElementById("queryBox");
		var overlay = document.getElementById("overlay");
		queryBox.style.display = "block";
		overlay.style.display = "block";
	}
	function c(){
		var queryBox = document.getElementById("queryBox");
		var overlay = document.getElementById("overlay");
		queryBox.style.display = "none";
		overlay.style.display = "none";
	}
</script>
</head>
<body>
	<h1 align="center">学生信息</h1>
	<form align="center" class="text">
		<a href="#" onclick="showQueryBox()">查询</a> <a
			href="javascript:window.location.href='add.jsp';">增加同学</a>
	</form>
	<table border="1" align="center" class="t">
		<tr>
			<th><b>姓名：</b></th>
			<th><b>学号：</b></th>
			<th><b>班级：</b></th>
			<th><b>院系：</b></th>
			<th><b>操作：</b></th>
		</tr>
		<c:forEach items="${list}" var="s">
			<tr>
				<td>${s.stu_name}</td>
				<td>${s.stu_no}</td>
				<td>${s.class_name}</td>
				<td>${s.department}</td>
				<td><a
					href="javascript:window.location.href='update.jsp?stu_name=${s.stu_name}&class_name=${s.class_name}&stu_no=${s.stu_no}&stu_id=${s.stu_id}';">修改</a>
					<a
					href="javascript:window.location.href='deleteservlet?stu_id=${s.stu_id}';">删除</a></td>
			</tr>
		</c:forEach>
	</table>
	<div id="overlay"></div>
	<div id="queryBox">
		<h2>输入查询条件</h2>
		<div class="close"
			onclick="c()">×</div>
		<form action="find" class="search">
			<label>id：</label> <input name="id" type="number" id="id" /> <label>姓名：</label>
			<input name="name" type="text" id="name" /> <label>学号：</label> <input
				name="sno" type="number" id="sno" /> <label>班级：</label> <select
				name="class_id">
				<option value="不限班级">不限班级</option>
				<%
				String resource = "mybatis-config.xml";
				InputStream inputStream;
				SqlSession sqlSession = null;
				inputStream = Resources.getResourceAsStream(resource);
				SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
				sqlSession = sqlSessionFactory.openSession();
				List<Option> list = sqlSession.selectList("mapper.StudentMapper.getClass");
				sqlSession.close();
				request.setAttribute("list", list);
				%>
				<c:forEach items="${list}" var="options">
					<option value="${options.class_id}">${options.class_name}</option>
				</c:forEach>
			</select>
			<div>
				<input name="submit" type="submit" value="查询" /> <input
					type="button"
					onclick="c()"
					value="取消" />
			</div>

		</form>
	</div>
	<div align="center">
		<input type="button"
			onclick="javascript:window.location.href='servletmybatis'"
			value="所有学生" />
	</div>

</body>
</html>