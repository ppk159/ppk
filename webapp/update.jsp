<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.io.InputStream"
	import="org.apache.ibatis.io.Resources"
	import="org.apache.ibatis.session.SqlSession"
	import="org.apache.ibatis.session.SqlSessionFactory"
	import="org.apache.ibatis.session.SqlSessionFactoryBuilder"
	import="java.util.List" import="java.lang.StackWalker.Option"
	import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.search {
	width: 600px;
	height: 250px;
	padding: 25px;
	border-width: 1px;
	border-color: #999999;
	border-style: solid;
	box-shadow: 10px 5px 10px rgba(0, 0, 0, 0.2);
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

input[type="button"], input[type="submit"], input[type="reset"] {
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

input[type="button"]:hover, input[type="submit"]:hover, input[type="reset"]:hover
	{
	background-color: #fff;
	color: #1795bb;
}

label {
	width: 100px;
	text-align: right;
	display: inline-block;
	font-size: 22px;
}
</style>
</head>
<body>
	<div align="center">
		<h1>学生修改</h1>
		<%
		String class_name = request.getParameter("class_name");
		String stu_name = request.getParameter("stu_name");
		int stu_no = Integer.valueOf(request.getParameter("stu_no"));
		int id = Integer.valueOf(request.getParameter("stu_id"));
		%>
		<form action="updateservlet" class="search">
			<input type="hidden" name="stu_id" value="<%=id%>"> <label>姓名</label>
			<input name="stu_name" type="text" id="stu_name"
				value="<%=stu_name%>" /> <label>学号</label> <input name="stu_no"
				type="number" id="stu_no" value="<%=stu_no%>"
				oninput="if(value>2147483647)value=2147483647;if(value<0)value=0" />
			<label>班级</label> <select name="class_id">
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
					<c:set var="name" value="<%=class_name%>"></c:set>
					<c:choose>
						<c:when test="${options.class_name==name}">
							<option value="${options.class_id}" selected>${options.class_name}</option>
						</c:when>
						<c:otherwise>
							<option value="${options.class_id}">${options.class_name}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<div>
				<input name="submit" type="submit" value="保存" /> <input
					type="button"
					onclick="javascript:window.location.href='servletmybatis';"
					value="取消" />
			</div>
		</form>
	</div>
</body>
</html>