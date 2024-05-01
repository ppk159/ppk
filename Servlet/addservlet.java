package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import Entity.student;

/**
 * Servlet implementation class addservlet
 */
@WebServlet("/addservlet")
public class addservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public addservlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Integer sno = Integer.parseInt(request.getParameter("sno"));
		String name = request.getParameter("name");
		int class_id = Integer.parseInt(request.getParameter("class_id"));
		String resource = "search.xml";
		InputStream inputStream;
		SqlSession sqlSession = null;
		inputStream = Resources.getResourceAsStream(resource);
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		sqlSession = sqlSessionFactory.openSession();
		student s = new student(null, name, sno, class_id);
		List<student> list = sqlSession.selectList("mapper.SearchStudent.insertStudent", s);
		sqlSession.close();
		request.setAttribute("list", list);
		request.getRequestDispatcher("servletmybatis").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
