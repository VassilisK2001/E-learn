package elearn_classes;

import java.sql.*;
import java.util.Date;

public class LessonReqDAO {

    /**
     * Inserts a lesson request into the database. This method adds a new entry in the `lesson_request` table 
     * with details such as the student ID, teacher ID, requested schedule date, request status, and the course ID.
     * 
     * @param schedule_date   The scheduled date for the lesson as a java.util.Date.
     * @param request_status  The status of the lesson request (e.g., "pending", "approved").
     * @param course_title    The title of the course related to the lesson request.
     * @param sent_from_id    The ID of the user who is sending the request (usually the student).
     * @param sent_to_id      The ID of the user who is receiving the request (usually the teacher).
     * @throws Exception      If an error occurs while inserting the lesson request into the database or closing resources.
     */
    public void insertLessonReq(Date schedule_date, String request_status, String course_title, int sent_from_id, int sent_to_id) throws Exception {
        Connection con = null;
        CourseDAO courseDAO = new CourseDAO();

        // Convert java.util.Date to java.sql.Date
        java.sql.Date sqlDate = new java.sql.Date(schedule_date.getTime());

        String sql = "INSERT INTO lesson_request (student_id, teacher_id, schedule_date, request_status, course_id) VALUES (?,?,?,?,?);";

        DB db = new DB();
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, sent_from_id);
            stmt.setInt(2, sent_to_id);
            stmt.setDate(3, sqlDate); // Use java.sql.Date here
            stmt.setString(4, request_status);
            stmt.setInt(5, courseDAO.getCourseId(course_title));
            stmt.executeUpdate();

        } catch (Exception e) {
            throw new Exception("Error inserting lesson request into database: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                db.close();
            } catch (Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }

    /**
     * Checks if a lesson request already exists in the database for the given criteria.
     * 
     * @param teacher_id      The ID of the teacher.
     * @param student_id      The ID of the student.
     * @param course_title    The title of the course.
     * @param schedule_date   The scheduled date of the lesson as a java.util.Date.
     * @throws Exception      If the request already exists or if an error occurs while checking.
     */
    public void checkRequestExists(int teacher_id, int student_id, String course_title, Date schedule_date) throws Exception {
        Connection con = null;
        CourseDAO courseDAO = new CourseDAO();

        // Convert java.util.Date to java.sql.Date
        java.sql.Date sqlDate = new java.sql.Date(schedule_date.getTime());

        String sql = 
        "SELECT * " +
        "FROM lesson_request " +
        "WHERE teacher_id = ? " +
        "AND student_id = ? " +
        "AND course_id = ? " +
        "AND schedule_date = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, teacher_id);
            stmt.setInt(2, student_id);
            stmt.setInt(3, courseDAO.getCourseId(course_title));
            stmt.setDate(4, sqlDate); // Use java.sql.Date here
            rs = stmt.executeQuery();

            if (rs.next()) {
                throw new Exception("Request already sent.");
            }

        } catch (Exception e) {
            throw new Exception("Error checking lesson request: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                db.close();
            } catch (Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }
}
