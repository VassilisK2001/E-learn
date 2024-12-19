package elearn_classes;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class CourseDAO {

    /**
    * Retrieves a list of course category titles from the database.
    *
    * @return A list of course category titles.
    * @throws Exception If there is an error in retrieving course category titles from the database.
    */
    public List<String> getCourseCategoryTitles() throws Exception {
        Connection con = null;
        List<String> courseCategories = new ArrayList<>();

        String sql = "SELECT course_cat_title FROM course_category";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();

            while(rs.next()) {
                courseCategories.add(rs.getString("course_cat_title"));
            }
            rs.close();
            stmt.close();
            db.close();

            return courseCategories;
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {

            }
        }
    }


    /**
     * Retrieves a list of course titles from the database.
     *
     * @return A list of course titles.
     * @throws Exception If there is an error in retrieving course titles from the database.
     */
    public List<String> getCourseTitles() throws Exception {
        Connection con = null;
        List<String> courses = new ArrayList<>();

        String sql = "SELECT course_title FROM course";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();

            while(rs.next()) {
                courses.add(rs.getString("course_title"));
            }
            rs.close();
            stmt.close();
            db.close();

            return courses;
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {

            }
        }
    }




    /**
     * Helper method to get the course category ID from the database.
     *
     * @param categoryName The name of the course category.
     * @return The course category ID.
     * @throws Exception If credentials are invalid or there is a database error.
     */
    public int getCourseCategoryId(String categoryName) throws Exception {

        Connection con = null;
        int course_cat_ID = 0;

        String sql = "SELECT course_cat_id FROM course_category WHERE course_cat_title = ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql); 
            stmt.setString(1, categoryName);
            rs = stmt.executeQuery();

            if(rs.next()) {
                course_cat_ID = rs.getInt("course_cat_id");
            }
            rs.close();
            stmt.close();
            db.close();
            return course_cat_ID;
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
     * Helper method to get the course ID from the database.
     *
     * @param courseName The name of the course.
     * @return The course ID.
     * @throws Exception If credentials are invalid or there is a database error.
     */
    public int getCourseId(String courseName) throws Exception {

        Connection con = null;
        int course_id = 0;
        String sql = "SELECT course_id FROM course WHERE course_title = ?";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, courseName);
            rs = stmt.executeQuery();

            if(rs.next()) {
                course_id = rs.getInt("course_id");
            }
            rs.close();
            stmt.close();
            db.close();
            return course_id;
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
 * Checks if a course with the given title exists in the database.
 *
 * @param course_title The title of the course to check.
 * @throws Exception If the course title does not exist in the database or if a database error occurs.
 */
    public void checkCourseExists(String course_title) throws Exception {

        Connection con = null;

        String sql = "SELECT * FROM course WHERE course_title = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1,course_title);
            rs = stmt.executeQuery();

            if(!rs.next()) {
                throw new Exception("Please enter a valid course title from the list.");
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
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }   
}
