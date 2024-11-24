<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>

<%
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");
String role = request.getParameter("role");

if (role.equals("student")) {

    try {
        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.authenticate(email, username, password);
        session.setAttribute("studentObj", student);

        // Redirect to the student's page if credentials are valid
        response.sendRedirect("home_student.jsp");
    } catch (Exception e) {
        request.setAttribute("message", e.getMessage());
    %>

    <!-- Redirect to signin form if student credentials are not valid -->
    <jsp:forward page = "signin.jsp" />

    <% } 

} else {

    try {
        TeacherDAO teacherDAO = new TeacherDAO();
        Teacher teacher = teacherDAO.authenticate(email, username, password);
        session.setAttribute("teacherObj", teacher);

            // Redirect to the teacher's page if credentials are valid
        response.sendRedirect("home_teacher.jsp");
    } catch (Exception e) {
        request.setAttribute("message", e.getMessage());
    %>

    <!-- Redirect to signin form if teacher credentials are not valid -->
    <jsp:forward page = "signin.jsp" />

    <% }
}
%>