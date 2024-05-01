package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import Entity.student;
import Service.searchService;
import Service.Impl.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet("/servletmybatis")
public class servletmybatis extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public servletmybatis() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			String resource = "mybatis-config.xml";
			InputStream inputStream; 
			SqlSession sqlSession = null;
			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			sqlSession = sqlSessionFactory.openSession();
			List<student> list = sqlSession.selectList("mapper.StudentMapper.getStudent");
			sqlSession.close();
			request.setAttribute("list", list);
			request.getRequestDispatcher("/student1.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
