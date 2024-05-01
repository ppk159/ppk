package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

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

@WebServlet("/find")
public class find extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public find() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id1 = request.getParameter("id");
		String stu_name = request.getParameter("name");
		String sno = request.getParameter("sno");
		String id2 = request.getParameter("class_id");
		String resource = "search.xml";
		InputStream inputStream;
		SqlSession sqlSession = null;
		inputStream = Resources.getResourceAsStream(resource);
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		sqlSession = sqlSessionFactory.openSession();
		Integer stu_id=null, class_id=null, stu_no=null;
		if (id1!= null&&id1!="") {
			stu_id = Integer.parseInt(request.getParameter("id"));
		}
		if (!id2.equals("不限班级")) {
			class_id = Integer.parseInt(request.getParameter("class_id"));
		}
		if(sno!=null&&sno!="") {
			stu_no = Integer.parseInt(request.getParameter("sno"));
		}
		student s = new student(stu_id, stu_name, stu_no, class_id);
		List<student> list = sqlSession.selectList("mapper.SearchStudent.searchStudent", s);
		sqlSession.close();
		request.setAttribute("list", list);
		request.getRequestDispatcher("/student1.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
