<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
		<p>学生删除</p>
		<form action="deleteservlet">
			<table border="1" class="imagetable">
				<tr>
					<th>学号</th>
					<td><input name="sno" type="text" id="sno" /></td>
				</tr>
			</table>
			<input name="submit" type="submit" value="确定" /> <input name="reset"
				type="reset" value="重置"> <input type="button"
				onclick="javascript:window.location.href='servletmybatis';"
				value="返回" />
		</form>
	</div>
</body>
</html>