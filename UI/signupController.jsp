<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="elearn_classes.*" %>
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
// Variables for validation and error messages
List<String> errorMessages = new ArrayList<String>();
String photo = "";
String fullname = "";
int age = 0;
String username = "";
String email = "";
String password = "";
String role = "";
String interestSubjects = "";
List<String> subjects = new ArrayList<String>();
String studentDescription = "";
String teacherDescription = "";
int experience = 0;
String specializations = "";
List<String> teacherSpecializations = new ArrayList<String>(); 
String courses = "";
List<String> specializationCourses = new ArrayList<String>(); 
double minPrice = 0;
boolean validMinPrice = false;
double maxPrice = 0 ;
boolean validMaxPrice = false;
boolean priceErrorAdded = false;
int countErrors = 0;

// Check if the form is multipart (contains file uploads)
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
%>


<%!

// Helper method to count words in a string
public static int countWords(String value){
    String[] words = value.split("[\\s.,]+");
    int wordCount = words.length;
    return wordCount;
}

// Helper method to check if a string matches a given pattern
public static boolean matches(String epattern, String parValue){
    Pattern pattern = Pattern.compile(epattern);
    Matcher m = pattern.matcher(parValue);
    if(!m.matches()){
        return false;
    }else {
        return true;
    }
}

// Method to check if a string can be converted to an integer
public static boolean isInteger(String str) {
    try {
        // Attempt to parse the string as an integer
        Integer.parseInt(str);
        return true;  // If parsing succeeds, it's a valid integer
    } catch (NumberFormatException e) {
        return false; // If parsing fails, it's not a valid integer
    }
}

// Method to check if a string can be converted to a double
public static boolean isDouble(String str) {
    if (str == null || str.trim().isEmpty()) {
        return false; // Null or empty strings cannot be converted to double
    }
    try {
        Double.parseDouble(str);
        return true; // Conversion succeeded
    } catch (NumberFormatException e) {
        return false; // Conversion failed
    }
}

public static int countDecimals(double number) {
    // Convert the double to a string
    String text = String.valueOf(number);

    // Check if it contains a decimal point
    if (text.contains(".")) {
        // Split the number into the integer and decimal parts
        String[] parts = text.split("\\.");
        
        // Get the decimal part and remove trailing zeros
        String decimalPart = parts[1].replaceAll("0+$", "");
        
        // Return the length of the decimal part
        return decimalPart.length();
    }

    // No decimal point means 0 decimal places
    return 0;
}

// Method to convert a comma separated String into a list
public static List<String> convertStringToList(String input) {
        List<String> result = new ArrayList<String>();

        // Split the string by commas
        String[] items = input.split(",");

        // Iterate through the array and apply filtering logic
        for (String item : items) {
            result.add(item);
        }
        return result;
}
%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/elearn/css/slider_styles.css">
</head>
<body class="d-flex flex-column min-vh-100">
    <!-- Header -->
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
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/index.jsp"><b>About</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/elearn/UI/signup.jsp"><b>Sign Up</b></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/elearn/UI/signin.jsp"><b>Sign In</b></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-5 flex-grow-1">

    <% if (isMultipart) {

        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();
            
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
            
        List<FileItem> fileItems = upload.parseRequest(request);

        for(FileItem item: fileItems) {
            if(item.isFormField()) {

                // Process regular form fields
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");

                if (fieldName.equals("fullname")) {
                    if ((countWords(fieldValue) != 2) || (!matches("^[\\p{L}]{3,30} [\\p{L}]{3,30}$", fieldValue))) {
                        countErrors ++;
                        errorMessages.add("Your <b>full name</b> must include both a first name and a last name, each containing 3 to 60 alphabetic characters without any special symbols or numbers.");
                    } else {
                        fullname = fieldValue;
                    }
                } 

                if (fieldName.equals("age")) {
                    if (isInteger(fieldValue)) {
                        age = Integer.parseInt(fieldValue);
                        if (age < 18) {
                            countErrors ++;
                            errorMessages.add("Your <b>age</b> must be at least 18 years old to create an account.");
                        } else if (age > 100) {
                            countErrors ++;
                            errorMessages.add("Please enter a valid <b>age</b>.");
                        }
                    } else {
                        countErrors ++;
                        errorMessages.add("Please enter a valid <b>age</b.");
                    }
                }

                if (fieldName.equals("username")) {
                    if (!matches("^(?=(.*[A-Za-z]){3,})\\S{5,19}$",fieldValue)) {
                        countErrors ++;
                        errorMessages.add("Your <b>username</b> must be at least 5 and maximum 20 characters long (latin characters only), include at least 3 letters and not have whitespaces.");
                    } else {
                        username = fieldValue;
                    }
                }

                if (fieldName.equals("email")) {
                    email = fieldValue;
                }

                if (fieldName.equals("password")) {
                    if(!matches("^.{5,20}$", fieldValue)) {
                        countErrors ++;
                        errorMessages.add("Your <b>password</b> needs to be at least 5 and no more than 20 characters long and include only latin characters.");
                    } else {
                        password = fieldValue;
                    }
                }

                if (fieldName.equals("role")) {
                    if(fieldValue.equals("student")) {
                        role = "student";
                    } else {
                        role = "teacher";
                    }
                }

                if (role.equals("student")) {

                    if (fieldName.equals("subjectsOfInterestTags")) {
                    interestSubjects = fieldValue;
                    subjects = convertStringToList(interestSubjects);
                    if(subjects.size() > 6) {
                        countErrors++;
                        errorMessages.add("You can select up to <b>6 subjects of interest</b>.");
                    } 
                    }

                    if (fieldName.equals("description")) {
                        if (countWords(fieldValue) < 5 || countWords(fieldValue) > 20) {
                            countErrors ++;
                            errorMessages.add("Your <b>description</b> needs to be between 5 and 20 words.");
                        } else {
                            studentDescription = fieldValue;
                        }
                    }
                } else {

                    if (fieldName.equals("experience")) {
                        if(isInteger(fieldValue)) {
                            experience = Integer.parseInt(fieldValue);
                            if(experience < 0 || experience > 50) {
                                countErrors ++;
                                errorMessages.add("<b>Years of experience</b> needs to be between 0 and 50 years.");
                            }
                        } else {
                            countErrors ++;
                            errorMessages.add("<b>Years of experience</b> needs to be a valid number.");
                        }
                    }

                    if (fieldName.equals("teacherSpecializationsTags")) {
                        specializations = fieldValue;
                        teacherSpecializations = convertStringToList(specializations);
                        if (teacherSpecializations.size() > 6) {
                            countErrors++;
                            errorMessages.add("You can select up to <b>6 teacher specializations</b>.");
                        }  
                    }

                    if (fieldName.equals("specializationCoursesTags")) {
                        if (fieldValue == null || fieldValue.isEmpty()) {
                            countErrors ++;
                            errorMessages.add("You have to choose at least 1 <b>specialization course</b>.");
                        } else {
                            courses = fieldValue;
                            specializationCourses = convertStringToList(courses); 
                            if (specializationCourses.size() > 6) {
                                countErrors++;
                                errorMessages.add("You can select up to <b>6 specialization courses</b>.");
                            }
                        }  
                    }

                    if (fieldName.equals("minPrice")) {
                        if(isDouble(fieldValue)) {
                            minPrice = Double.parseDouble(fieldValue);
                            if (minPrice < 0 || minPrice > 100 || countDecimals(minPrice) > 2) {
                                countErrors ++;
                                errorMessages.add("<b>Minimum price</b> needs to be a number greater than 0 and less than 100, containing up to two decimals.");
                            } else {
                                 validMinPrice = true;
                            }
                        } else {
                            countErrors ++;
                            errorMessages.add("<b>Minimum price</b> charged for your services needs to be a valid number");
                        }
                    }

                    if (fieldName.equals("maxPrice")) {
                        if(isDouble(fieldValue)) {
                            maxPrice = Double.parseDouble(fieldValue);
                            if (maxPrice < 0 || maxPrice > 100 || countDecimals(maxPrice) > 2) {
                                countErrors ++;
                                errorMessages.add("<b>Maximum price</b> needs to be a number greater than 0 and less than 100, containing up to two decimals.");
                            } else {
                                 validMaxPrice = true;
                            }
                        } else {
                            countErrors ++;
                            errorMessages.add("<b>Maximum price</b> charged for your services needs to be a valid number");
                        }
                    }

                    if (validMinPrice && validMaxPrice) {
                        if (maxPrice <= minPrice  && !priceErrorAdded) {
                            countErrors ++;
                            priceErrorAdded = true;
                            errorMessages.add("<b>Maximum price</b> charged for your services must be greater than <b>minimum price</b>.");
                        }
                    }

                    if (fieldName.equals("teacherDescription")) {
                        if (countWords(fieldValue) < 5 || countWords(fieldValue) > 20) {
                            countErrors ++;
                            errorMessages.add("Your <b>description</b> needs to be between 5 and 20 words.");
                        } else {
                            teacherDescription = fieldValue;
                        }
                    }
                }   
            } else {

                // Process file upload
                String fieldName = item.getFieldName();
                String fileName = item.getName();
                photo = fileName;
                InputStream fileContent = item.getInputStream();
            
                // Save the file to images directory in server
                String uploadDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\ismgroup63\\elearn\\images";
            
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

    if (countErrors != 0) { 
    %>

    <!-- Alert Box for General Error -->
    <div class="alert alert-danger" role="alert">
        <strong>Your signup form has errors.</strong>
    </div>

    <!-- Card to display detailed errors -->
    <div class="card">
        <div class="card-header">
            <strong>Sign Up Form Errors</strong>
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
        <a href="<%=request.getContextPath()%>/elearn/UI/signup.jsp" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back to Form
        </a>
    </div>

    <% } else { 
        
        if (role.equals("student")) {

            StudentDAO studentDAO = new StudentDAO();

            try {
                // Call method to check if student exists
                studentDAO.checkStudentExists(username, password);

            } catch(Exception e) {
                request.setAttribute("message", e.getMessage());
            %>

            <!-- Redirect to signup form if student exists -->
            <jsp:forward page = "signup.jsp" />

            <% 
            } 
            studentDAO.insertStudent(fullname, age, username, password, email, studentDescription, photo, subjects);

        } else {

            TeacherDAO teacherDAO = new TeacherDAO();

            try {
                // Call method to check if teacher exists
                teacherDAO.checkTeacherExists(username, password);
            } catch(Exception e) {
                request.setAttribute("message", e.getMessage());
            %>

            <!-- Redirect to signup form if teacher exists-->
            <jsp:forward page = "signup.jsp" />

            <%
            }
            teacherDAO.insertTeacher(fullname, username, password, email, age, teacherDescription, photo, minPrice, maxPrice, experience, teacherSpecializations, specializationCourses);
        }  %>
        

     <!-- Success Box with Bootstrap success class -->
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
        <div>
            <strong>You have successfully signed up!</strong>
        </div>
    </div>

    <!-- User Details Box -->
    <div class="card">
        <div class="card-header">
            <strong>User Details</strong>
        </div>
        <div class="card-body">
            <ul class="list-group list-group-flush">
                <!-- Display the user's image -->
                <li class="list-group-item">
                    <strong>Profile Image:</strong><br>
                    <img src="<%= request.getContextPath() %>/elearn/images/<%= photo %>" class="img-thumbnail" style="width: 200px; height: 200px; object-fit: contain;;">
                </li>
                <li class="list-group-item"><strong>Full Name:</strong> <%= fullname %></li>
                <li class="list-group-item"><strong>Age:</strong> <%= age %></li>
                <li class="list-group-item"><strong>Username:</strong> <%= username %></li>
                <li class="list-group-item"><strong>Email:</strong> <%= email %></li>
                <li class="list-group-item"><strong>Role:</strong> <%= role %></li>
                <% if (role.equals("student")) {  %>
                <li class="list-group-item"><strong>Subjects of Interest:</strong>
                    <div>
                        <% for (String subject : subjects) { %>
                            <span class="badge bg-secondary me-2"><%= subject %></span>
                        <% } %>
                    </div> 
                </li>
                <li class="list-group-item"><strong>Description:</strong> <%= studentDescription %></li>
                <% } else { %>
                <li class="list-group-item"><strong>Description:</strong> <%= teacherDescription %></li>
                <li class="list-group-item"><strong>Experience:</strong> <%= experience %> years</li>
                <li class="list-group-item"><strong>Specializations:</strong>
                    <div>
                        <% for (String specialization : teacherSpecializations) { %>
                            <span class="badge bg-secondary me-2"><%= specialization %></span>
                        <% } %>
                    </div> 
                </li>
                    
                <li class="list-group-item"><strong>Specialization Courses:</strong>
                    <div>
                        <% for (String course : specializationCourses) { %>
                            <span class="badge bg-secondary me-2"><%= course %></span>
                        <% } %>
                    </div>
                </li>
                    
                <li class="list-group-item"><strong>Price Range:</strong> &euro;<%= minPrice %> - &euro;<%= maxPrice %></li>
            </ul>
                <% } %>
        </div>
    </div>

    <!-- Button to redirect to signin page -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/elearn/UI/signin.jsp" class="btn btn-outline-primary">
            Go to Sign In page <i class="fas fa-arrow-right me-2"></i>
        </a>
    </div>
    
    <% }  %> 
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-0"><b>© 2024 E-Learn. All rights reserved.</b></p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=request.getContextPath()%>/elearn/js/signup.js"></script>
</body>
</html>