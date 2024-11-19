package elearn_classes;

import java.sql.*;

public class CourseDAO {

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



    
}
