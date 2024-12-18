package elearn_classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {


     /**
     * Authenticates a teacher based on email, username, and password.
     *
     * @param email    The teacher's email.
     * @param username The teacher's username.
     * @param password The teacher's password.
     * @return The Teacher object if authentication is successful, or null if not.
     * @throws Exception If credentials are invalid or there is a database error.
     */

    public Teacher authenticate(String email, String username, String password) throws Exception {

        Connection con = null;

        String sql = "SELECT * FROM teacher WHERE email= ? AND username= ? AND password= ?";

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
                Teacher teacher = new Teacher(
                    rs.getInt("teacher_id"),
                    rs.getString("full_name"),
                    rs.getInt("age"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("description"),
                    rs.getString("photo_url"),
                    rs.getInt("years_of_experience"),
                    rs.getDouble("min_price"),
                    rs.getDouble("max_price"),
                    retrieveSpecializations(rs.getInt("teacher_id")),
                    retrieveSpecializationCourses(rs.getInt("teacher_id"))
                );

                rs.close();
                stmt.close();
                db.close();

                return teacher;
            } else {
                throw new Exception("Wrong username or password");
            }
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        }finally {
            try{
                db.close();
            } catch(Exception e){

            }
        }  
    }

    /**
     * Retrieves the teacher's specializations based on the teacher ID.
     *
     * @param teacherId The ID of the teacher.
     * @return A list of specializations.
     * @throws Exception If credentials are invalid or there is a database error.
     */

    public List<String> retrieveSpecializations(int teacher_id) throws Exception {

        Connection con = null;
        List<String> specializations = new ArrayList<String>();

        String sql = "SELECT course_cat_title FROM teacher_course_category " +
                     "JOIN course_category ON teacher_course_category.course_cat_id = course_category.course_cat_id " +
                     "WHERE teacher_course_category.teacher_id = ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, teacher_id);
            rs = stmt.executeQuery();

            while(rs.next()){
                specializations.add(rs.getString("course_cat_title"));
            }

            rs.close();
            stmt.close();
            db.close();

            return specializations;

        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e){

            }
        }
    }

    /**
     * Retrieves the teacher's courses based on the teacher ID.
     *
     * @param teacherId The ID of the teacher.
     * @return A list of courses related to the teacher.
     * @throws Exception If credentials are invalid or there is a database error.
     */

    public List<String> retrieveSpecializationCourses(int teacher_id) throws Exception {

        Connection con = null;
        List<String> specialization_courses = new ArrayList<String>();

        String sql = "SELECT course_title FROM course " +
                     "JOIN teacher_course ON course.course_id = teacher_course.course_id " +
                     "WHERE teacher_course.teacher_id = ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, teacher_id);
            rs = stmt.executeQuery();

            while(rs.next()) {
                specialization_courses.add(rs.getString("course_title"));
            }

            rs.close();
            stmt.close();
            db.close();

            return specialization_courses;
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try{
                db.close();
            } catch(Exception e) {

            }
        }
    }

       /**
     * Checks if a teacher with the given username or password already exists in the database.
     *
     * @param username The username to check for existence.
     * @param password The password to check for existence.
     * @throws Exception If a teacher with the given username or password exists, or if there is a database error.
     */
    public void checkTeacherExists(String username, String password) throws Exception {

        Connection con = null;

        String sql = "SELECT * FROM teacher WHERE username= ? OR password= ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if(rs.next()) {
                throw new Exception("Teacher with this username or password already exists");
            }

            rs.close();
            stmt.close();
            db.close();
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
     * Inserts a new teacher into the database.
     *
     * @param teacher The Teacher object containing the teacher's information.
     * @throws Exception If credentials are invalid or there is a database error.
     */
    public void insertTeacher(String fullname, String username, String password, String email, int age, String teacherDescription,
    String photo, double minPrice, double maxPrice, int experience, List<String> teacherSpecializations, List<String> specializationCourses) throws Exception {

        Connection con = null;

        String insertTeacherSQL = "INSERT INTO teacher (full_name, username, password, email, age, description, photo_url, " +
        "min_price, max_price, years_of_experience) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String insertSpecializationSQL = "INSERT INTO teacher_course_category (teacher_id, course_cat_id) VALUES (?, ?)";

        String insertCourseSQL = "INSERT INTO teacher_course (teacher_id, course_id) VALUES (?, ?)";

        DB db = new DB();
        CourseDAO courseDAO = new CourseDAO();
        PreparedStatement teacherStmt = null;
        PreparedStatement specializationStmt = null;
        PreparedStatement courseStmt = null;
        ResultSet generatedKeys = null;

        try {
            con = db.getConnection();
            teacherStmt = con.prepareStatement(insertTeacherSQL, Statement.RETURN_GENERATED_KEYS);
            // Insert teacher into the `teacher` table
            teacherStmt.setString(1, fullname);
            teacherStmt.setString(2, username);
            teacherStmt.setString(3, password);
            teacherStmt.setString(4, email); 
            teacherStmt.setInt(5, age);
            teacherStmt.setString(6, teacherDescription);
            teacherStmt.setString(7, photo);
            teacherStmt.setDouble(9, minPrice);
            teacherStmt.setDouble(10, maxPrice);
            teacherStmt.setInt(8, experience);
            teacherStmt.executeUpdate();

            // Retrieve the generated teacher ID
            try {
                generatedKeys = teacherStmt.getGeneratedKeys();
                if(generatedKeys.next()) {
                    int teacherID = generatedKeys.getInt(1);

                    // Insert teacher's specializations into the `teacher_course_category` table
                    try {
                        specializationStmt = con.prepareStatement(insertSpecializationSQL);
                        for(String specialization: teacherSpecializations){
                            specializationStmt.setInt(1, teacherID);
                            specializationStmt.setInt(2, courseDAO.getCourseCategoryId(specialization)); // Helper method to get course category ID
                            specializationStmt.addBatch();
                        }
                        specializationStmt.executeBatch();

                    } catch(Exception e){
                        throw new Exception(e.getMessage());
                    } 

                    // Insert teacher's courses into the `teacher_course` table
                    try {
                        courseStmt = con.prepareStatement(insertCourseSQL);
                        for(String course: specializationCourses) {
                            courseStmt.setInt(1, teacherID);
                            courseStmt.setInt(2, courseDAO.getCourseId(course));
                            courseStmt.addBatch();
                        }
                        courseStmt.executeBatch();
                    } catch(Exception e) {
                        throw new Exception(e.getMessage());
                    }  
                }
            } catch(Exception e) {
                throw new Exception(e.getMessage());
            }    
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                generatedKeys.close();
                courseStmt.close();
                specializationStmt.close();
                teacherStmt.close();
                db.close();
            } catch(Exception e) {

            }
        }
    }

}
