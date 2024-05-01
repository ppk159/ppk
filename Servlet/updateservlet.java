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

/**
 * Servlet implementation class updateservlet
 */
@WebServlet("/updateservlet")
public class updateservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public updateservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String stu_name=request.getParameter("stu_name");
		int stu_no=Integer.parseInt(request.getParameter("stu_no"));
		int class_id=Integer.parseInt(request.getParameter("class_id"));
		int stu_id = Integer.valueOf(request.getParameter("stu_id"));
		String resource="search.xml";
		InputStream inputStream;
		SqlSession sqlSession=null;
		inputStream=Resources.getResourceAsStream(resource);
		SqlSessionFactory sqlSessionFactory=new SqlSessionFactoryBuilder().build(inputStream);
		sqlSession=sqlSessionFactory.openSession();
		student s=new student(stu_id, stu_name, stu_no, class_id);
		List<student> list = sqlSession.selectList("mapper.SearchStudent.updateStudent",s);
		sqlSession.close();
		request.setAttribute("list", list);
		request.getRequestDispatcher("servletmybatis").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
