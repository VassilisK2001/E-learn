<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page errorPage="AppError.jsp" %>
<%@ page import="elearn_classes.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.file.Files"%>
<%@ page import="java.nio.file.Path"%>
<%@ page import="java.nio.file.StandardCopyOption"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.io.IOUtils"%>


<%
if((session.getAttribute("studentObj") == null && session.getAttribute("teacherObj") == null)) { 
    request.setAttribute("message","You are not authorized to access this page. Please sign in.");   
%>
            
<jsp:forward page="signin.jsp"/>

<% } 

// Set session timeout to 15 minutes
int sessionTimeoutSeconds = 15 * 60;
session.setMaxInactiveInterval(sessionTimeoutSeconds);

// Check if user role and retrieve object from session
Student student = null;
Teacher teacher = null;
boolean isStudent = false;
if (session.getAttribute("studentObj") != null) {
    student = (Student) session.getAttribute("studentObj");
    isStudent = true;
} else {
    teacher = (Teacher) session.getAttribute("teacherObj");
}

// Variables for validation and error messages
List<String> errorMessages = new ArrayList<String>();
int countErrors = 0;
String course_title = "";
String note_title = "";
String note_file = "";
java.sql.Timestamp upload_date = null;

// Initialize CourseDAO object
CourseDAO courseDAO = new CourseDAO();

// Inittialize NoteDAO object
NoteDAO noteDAO = new NoteDAO();

// Check if the form is multipart (contains file uploads)
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Learn - Upload Educational Material</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
    
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg mb-5">
        <div class="container-fluid">
            <a class="navbar-brand">
                <img src="<%=request.getContextPath()%>/elearn/logo.svg" alt="Logo" width="150" height="48">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link"><b>Signed in as <%=((isStudent) ? (student.getFullName()) : (teacher.getName()))%></b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/<%=((isStudent) ? "home_student.jsp" : "home_teacher.jsp")%>"><b>Home</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signout.jsp">
                            <span><b>Sign out<i class="fas fa-arrow-right-from-bracket ms-2"></i></b></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">

    <% if (isMultipart) {

        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();
            
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
            
        List<FileItem> fileItems = upload.parseRequest(request);

        for(FileItem item: fileItems)  {

            if(item.isFormField()) {

                // Process regular form fields
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");

                if (fieldName.equals("courseTitle")) {
                    try {
                        courseDAO.checkCourseExists(fieldValue);
                        course_title = fieldValue;
                    } catch(Exception e) {
                        countErrors++;
                        errorMessages.add(e.getMessage());
                    }
                }

                if (fieldName.equals("noteTitle")) {
                    note_title = fieldValue;
                }

            } else {

                if (countErrors == 0) {
                    
                    // Process file upload
                    String fieldName = item.getFieldName();
                    String fileName = item.getName();
                    note_file = fileName;
                    InputStream fileContent = item.getInputStream();
            
                    // Save the file to images directory in server
                    String uploadDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\ismgroup63\\elearn\\notes";
                
                    // Construct the destination file path
                    String filePath = uploadDirectory + File.separator + fileName;
                
                    // Copy the input stream to the destination file
                    OutputStream fileOut = new FileOutputStream(new File(filePath));
                    IOUtils.copy(fileContent, fileOut);

                    if (fileOut != null) {
                        fileOut.close();
                    }
                }   
            }
        }
    }

    if (countErrors != 0) { 
    %>

        <!-- Alert Box for General Error -->
        <div class="alert alert-danger" role="alert">
            <strong>The form you filled in has errors.</strong>
        </div>

        <!-- Card to display detailed errors -->
        <div class="card">
            <div class="card-header">
                <strong>New material Form Errors</strong>
            </div>
            <div class="card-body">
                <ol class="list-group list-group-numbered">
                    <% for (String errorMessage : errorMessages) { %>
                        <li class="list-group-item"><%= errorMessage %></li>
                    <% } %>
                </ol>
            </div>
        </div>

        <!-- Back Button to Signup form -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/upload_material.jsp" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Form
            </a>
        </div>

    <% } else {
        
        // Get the current date and time
        java.time.LocalDateTime currentDateTime = java.time.LocalDateTime.now();

        // Format the date and time as yyyy-MM-dd HH:mm:ss
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);

        // Assign the formatted date and time to upload_date
        upload_date = java.sql.Timestamp.valueOf(currentDateTime);


        // call method to insert new note to database
        if (isStudent) {
            noteDAO.insertStudentNote(note_title, upload_date, student, note_file, course_title);
        } else {
            noteDAO.insertTeacherNote(note_title, upload_date, teacher, note_file, course_title);
        }
        
    %>

        <!-- Success Box for successful upload -->
        <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
            <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
            <div>
                <strong>Your note has been uploaded successfully!</strong>
            </div>
        </div>

        <!-- Back Button -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/elearn/UI/<%=((isStudent) ? "home_student.jsp" : "home_teacher.jsp")%>" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Home
            </a>
        </div>

    <% }  %>
    </main>

    <!-- Footer -->
    <footer class="text-center text-lg-start mt-auto">
        <div class="text-center p-3">
            <b>© 2024 E-Learn. All rights reserved.</b>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>