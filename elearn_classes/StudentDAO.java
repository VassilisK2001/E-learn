package elearn_classes;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class StudentDAO {

    /**
     * Authenticates a student based on email, username, and password.
     *
     * @param email    The student's email.
     * @param username The student's username.
     * @param password The student's password.
     * @return The Student object if authentication is successful, or null if not.
     * @throws Exception If credentials are invalid or there is a database error.
     */

     public Student authenticate(String email, String username, String password) throws Exception {

        Connection con = null;

        String sql = "SELECT * FROM student WHERE email= ? AND username= ? AND password= ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, username);
            stmt.setString(3, password);
            rs = stmt.executeQuery();

            if(rs.next()) {
                Student student = new Student(
                    rs.getInt("student_id"),
                    rs.getString("full_name"),
                    rs.getInt("age"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("description"),
                    rs.getString("photo_url"),
                    getSubjectsInterest(rs.getInt("student_id"))
                );

                rs.close();
                stmt.close();
                db.close();

                return student;
            } else {
                throw new Exception("Wrong username or password");
            }
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {

            }
        }
    }


    /**
     * Retrieves the titles of course categories that a student has shown interest in.
     *
     * @param studentId The ID of the student whose interests are to be retrieved.
     * @return A list of course category titles the student is interested in.
     * @throws Exception If there is an error in retrieving data from the database.
     */
    public List<String> getSubjectsInterest(int studentId) throws Exception {
        Connection con = null;
        List<String> interestSubjects = new ArrayList<>();

        String sql = "SELECT course_cat_title " +
                     "FROM student_interest " +
                     "JOIN course_category ON student_interest.course_cat_id = course_category.course_cat_id " +
                     "WHERE student_interest.student_id = ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                interestSubjects.add(rs.getString("course_cat_title"));
            }

            rs.close();
            stmt.close();
            db.close();

            return interestSubjects;
        } catch (Exception e) {
            throw new Exception("Error retrieving subjects of interest: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                
            }
        }
    }

        /**
     * Checks if a student with the given username or password already exists in the database.
     *
     * @param username The username to check for existence.
     * @param password The password to check for existence.
     * @throws Exception If a student with the given username or password exists, or if there is a database error.
     */
    public void checkStudentExists(String username, String password) throws Exception {
        Connection con = null;

        String sql = "SELECT * FROM student WHERE username= ? OR password= ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                throw new Exception("Student with this username or password already exists");
            }
            rs.close();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {

            }
        }
    }

    /**
     * Inserts a new student into the database.
     *
     * @param student The Student object containing the student's information.
     * @throws Exception If there is an error in inserting data into the database.
     */

    public void insertStudent(String fullname, int age, String username, String password, String email, 
    String studentDescription, String photo, List<String> subjects) throws Exception {
        Connection con = null;

        String insertStudentSQL = "INSERT INTO student (full_name, username, password, email, age, description, photo_url) " +
                              "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String insertInterestSQL = "INSERT INTO student_interest (student_id, course_cat_id) VALUES (?, ?)";

        DB db = new DB();
        PreparedStatement studentStmt = null;
        PreparedStatement interestStmt = null;
        ResultSet generatedKeys = null;
        CourseDAO courseDAO = new CourseDAO();

        try {
            con = db.getConnection();

            // Insert student details
            studentStmt = con.prepareStatement(insertStudentSQL, Statement.RETURN_GENERATED_KEYS);
            studentStmt.setString(1, fullname);
            studentStmt.setString(2, username);
            studentStmt.setString(3, password);
            studentStmt.setString(4, email); 
            studentStmt.setInt(5, age);
            studentStmt.setString(6, studentDescription);
            studentStmt.setString(7, photo);
            studentStmt.executeUpdate();

            // Retrieve the generated student ID
            generatedKeys = studentStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int studentID = generatedKeys.getInt(1);

                // Insert student interest
                try {
                    interestStmt = con.prepareStatement(insertInterestSQL);
                    for(String interest: subjects) {
                        interestStmt.setInt(1, studentID);
                        interestStmt.setInt(2, courseDAO.getCourseCategoryId(interest));
                        interestStmt.addBatch();
                    }
                    interestStmt.executeBatch();
                } catch(Exception e) {
                    throw new Exception(e.getMessage());

                }
            } 
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                generatedKeys.close();
                interestStmt.close(); 
                studentStmt.close();
                db.close();
            } catch(Exception e) {
                throw new Exception("Error with database");

            }
        }
    }

}
