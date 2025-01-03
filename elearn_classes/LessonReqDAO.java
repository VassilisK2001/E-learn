package elearn_classes;

import java.sql.*;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

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


    /**
 * Retrieves a list of lesson requests sent by a specific student.
 * 
 * This method fetches lesson requests from the database where the `student_id` matches the provided parameter. 
 * It joins the `lesson_request` table with the `teacher`, `student`, and `course` tables to include details 
 * about the teacher, student, course title, schedule date, and request status.
 * 
 * @param student_id The ID of the student whose lesson requests are to be retrieved.
 * @return A list of {@link LessonRequest} objects representing the lesson requests sent by the student.
 * @throws Exception If an error occurs while accessing the database or if no lesson requests are found for the student.
 * 
 * @throws Exception with the message "You have not sent any lesson requests yet" if the student has not sent any requests.
 * @throws Exception with an appropriate error message if there are issues connecting to or querying the database.
 */
    public List<LessonRequest> getLessonRequests(int student_id) throws Exception {

        Connection con = null;
        List<LessonRequest> lessons = new ArrayList<>();

        String sql = 
        "SELECT " +
        "    req.request_id, " +
        "    s.full_name AS student_name, " +
        "    t.full_name AS teacher_name, " +
        "    DATE(req.schedule_date) AS schedule_date, " +
        "    req.request_status, " +
        "    c.course_title " +
        "FROM " +
        "    lesson_request req " +
        "INNER JOIN " +
        "    teacher t " +
        "ON " +
        "    req.teacher_id = t.teacher_id " +
        "INNER JOIN " +
        "    student s " +
        "ON " +
        "    req.student_id = s.student_id " +
        "INNER JOIN " +
        "    course c " +
        "ON " +
        "    req.course_id = c.course_id " +
        "WHERE " +
        "    req.student_id = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,student_id);
            rs = stmt.executeQuery();

            while(rs.next()) {
                lessons.add(new LessonRequest(rs.getInt("req.request_id"), rs.getDate("schedule_date"), rs.getString("req.request_status"),
                rs.getString("c.course_title"), rs.getString("student_name"), rs.getString("teacher_name")));
            }

            rs.close();
            stmt.close();
            db.close();

            if (lessons.isEmpty()) {
                throw new Exception("You have not sent any lesson requests yet");
            }

            return lessons;

        } catch(Exception e) {
            throw new Exception("Error fetching student lesson requests: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }


    /**
 * Retrieves a list of lesson requests sent to a specific teacher. 
 * This method queries the `lesson_request` table and retrieves details of the requests, including 
 * student name, teacher name, course title, schedule date, and request status.
 *
 * The query returns all lesson requests where the specified teacher is the recipient (i.e., the `teacher_id` matches the input).
 * If there are no requests for the given teacher, an exception is thrown.
 *
 * @param teacher_id   The ID of the teacher for whom the lesson requests are being fetched.
 * @return            A list of `LessonRequest` objects representing the requests sent to the specified teacher.
 * @throws Exception  If an error occurs while querying the database or processing the results, an exception is thrown.
 *                    Additionally, if no lesson requests are found for the teacher, an exception is thrown.
 */
    public List<LessonRequest> getTeacherLessonRequests(int teacher_id) throws Exception {
        Connection con = null;
        List<LessonRequest> lesson_requests = new ArrayList<>();

        String sql = "SELECT " +
             "    req.request_id, " +
             "    DATE(req.schedule_date) AS schedule_date, " +
             "    req.request_status, " +
             "    c.course_title, " +
             "    s.full_name AS student_name, " +
             "    t.full_name AS teacher_name " +
             "FROM " +
             "    lesson_request req " +
             "INNER JOIN " +
             "    student s " +
             "ON " +
             "    req.student_id = s.student_id " +
             "INNER JOIN " +
             "    teacher t " +
             "ON " +
             "    req.teacher_id = t.teacher_id " +
             "INNER JOIN " +
             "    course c " +
             "ON " +
             "    req.course_id = c.course_id " +
             "WHERE " +
             "    t.teacher_id = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,teacher_id);
            rs = stmt.executeQuery();

            while(rs.next()) {
                lesson_requests.add(new LessonRequest(rs.getInt("req.request_id"), rs.getDate("schedule_date"),
                rs.getString("req.request_status"), rs.getString("c.course_title"), rs.getString("student_name"), rs.getString("teacher_name")));
            }

            rs.close();
            stmt.close();
            db.close();

            if (lesson_requests.isEmpty()) {
                throw new Exception("There are no students requesting a lesson yet");
            }
            return lesson_requests;
        } catch(Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing database: " + e.getMessage());
            }
        }
    }


    /**
 * Updates the status of a specific lesson request in the `lesson_request` table.
 * This method allows changing the request status (e.g., "pending", "accepted", "rejected") of a lesson request based on its unique request ID.
 * 
 * The method executes an `UPDATE` query that modifies the `request_status` for the lesson request identified by the given `lesson_request_id`.
 * 
 * @param lesson_request_id  The unique identifier of the lesson request whose status needs to be updated.
 * @param request_status     The new status to be set for the lesson request. It can be a value such as "pending", "accepted", or "rejected".
 * @throws Exception         If an error occurs while updating the lesson request in the database or while closing resources.
 */
    public void updateLessonRequestStatus(int lesson_request_id, String request_status) throws Exception {
        Connection con = null;

        String sql = 
        "UPDATE lesson_request " +
        "SET request_status = ? " +
        "WHERE request_id = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1,request_status);
            stmt.setInt(2,lesson_request_id);
            stmt.executeUpdate();

            stmt.close();
            db.close();
        } catch(Exception e) {
            throw new Exception("Error while updating lesson request: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }

    
}
