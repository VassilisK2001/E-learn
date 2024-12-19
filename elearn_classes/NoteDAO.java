package elearn_classes;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class NoteDAO {

    
/**
 * Searches for notes in the database based on the specified criteria.
 *
 * @param course_title   The title of the course to filter the notes.
 * @param start_year     The starting year of the date range for note entry.
 * @param end_year       The ending year of the date range for note entry.
 * @param uploader_type  The type of uploader ("student", "teacher", or "all").
 * @return A list of notes matching the specified criteria.
 * @throws Exception If an error occurs while retrieving the notes or accessing the database.
 */
    public List<Note> searchNotes(String course_title, int start_year, int end_year, String uploader_type) throws Exception {

        Connection con = null;
        List<Note> available_notes = new ArrayList<>();
        String sql = null;

        if(uploader_type.equals("student")) {

            sql= 
               "SELECT "
            +    "n.note_id, n.note_title, DATE(n.note_entry_date) AS upload_date, n.note_file_url, s.full_name AS uploader_name, " 
            +    "'student' AS uploader_type, c.course_title "
            + "FROM "
            +    "note n "
            + "INNER JOIN "
            +    "student s "
            + "ON "
            +    "n.student_id = s.student_id "
            + "LEFT JOIN "
            +    "course c "
            + "ON "
            +    "n.course_id = c.course_id "
            + "WHERE "
            +    "c.course_title = ? "
            + "AND "
            +    "YEAR(n.note_entry_date) BETWEEN ? AND ?;";   
        } else if(uploader_type.equals("teacher")) {

            sql= 
               "SELECT "
            +    "n.note_id, n.note_title, DATE(n.note_entry_date) AS upload_date, n.note_file_url, t.full_name AS uploader_name, " 
            +    "'teacher' AS uploader_type, c.course_title "
            + "FROM "
            +    "note n "
            + "INNER JOIN "
            +    "teacher t "  
            + "ON "
            +    "n.teacher_id = t.teacher_id "  
            + "LEFT JOIN "
            +    "course c "
            + "ON "
            +    "n.course_id = c.course_id "
            + "WHERE "
            +    "c.course_title = ? "
            + "AND "
            +    "YEAR(n.note_entry_date) BETWEEN ? AND ?;"; 
            
        } else {

            sql = 
            "SELECT "
            +   "n.note_id, n.note_title, DATE(n.note_entry_date) AS upload_date, n.note_file_url, "
            +   "COALESCE(s.full_name, t.full_name) AS uploader_name, "
            +   "CASE "
            +       "WHEN n.student_id IS NOT NULL THEN 'student' "
            +       "WHEN n.teacher_id IS NOT NULL THEN 'teacher' "
            +       "ELSE NULL END AS uploader_type, "
            +   "c.course_title "
            + "FROM "
            +   "note n "
            + "LEFT JOIN " 
            +   "student s " 
            + "ON "  
            +   "n.student_id = s.student_id "
            + "LEFT JOIN " 
            +   "teacher t " 
            + "ON "  
            +   "n.teacher_id = t.teacher_id "
            + "LEFT JOIN " 
            +   "course c " 
            + "ON "  
            +   "n.course_id = c.course_id "
            + "WHERE " 
            +   "c.course_title = ? "
            + "AND " 
            +   "YEAR(n.note_entry_date) BETWEEN ? AND ?;";
        }

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1,course_title);
            stmt.setInt(2,start_year);
            stmt.setInt(3,end_year);
            rs = stmt.executeQuery();

            while(rs.next()) {
                available_notes.add(new Note(rs.getInt("n.note_id"), rs.getString("n.note_title"), 
                rs.getString("n.note_file_url"), rs.getDate("upload_date"), rs.getString("uploader_type"),
                rs.getString("uploader_name"), rs.getString("c.course_title")));
            }

            rs.close();
            stmt.close();
            db.close();

            return available_notes;
        } catch(Exception e) {
            throw new Exception("Error retrieving available notes: " + e.getMessage());
        } finally {
            try{
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }

    }
    
}
