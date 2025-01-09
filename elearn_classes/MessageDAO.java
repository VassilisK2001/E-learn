package elearn_classes;

import java.sql.*;
import java.util.*;

public class MessageDAO {

    public void insertStudentMessage(boolean isReplied, String sender_type, int sender_student_id, int recipient_teacher_id, java.sql.Timestamp sent_date,
    String subject, String body) throws Exception {
        Connection con = null;
        String sql =
        "INSERT INTO message (reply_to, is_replied, sender_type, sender_teacher_id, sender_student_id, recipient_teacher_id, recipient_student_id, sent_date, message_subject, message_body, is_read) " +
        "VALUES (NULL, ?, ?, NULL, ?, ?, NULL, ?, ?, ?, 0);";

        DB db = new DB();
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,  isReplied ? 1 : 0);
            stmt.setString(2,"student");
            stmt.setInt(3, sender_student_id);
            stmt.setInt(4, recipient_teacher_id);
            stmt.setTimestamp(5, sent_date);
            stmt.setString(6, subject);
            stmt.setString(7, body);
            stmt.executeUpdate();

            stmt.close();
            db.close();
        } catch(Exception e) {
            throw new Exception("Error inserting student message into database: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing database: " + e.getMessage());
            }
        }

    }

    public void insertTeacherReply(int reply_to_id, boolean isReplied ,int sender_teacher_id, int recipient_student_id, java.sql.Timestamp sent_date, String subject, 
    String body) throws Exception {
        Connection con = null;
        String sql = 
        "INSERT INTO message (reply_to, is_replied, sender_type, sender_teacher_id, sender_student_id, recipient_teacher_id, recipient_student_id, sent_date, message_subject, message_body, is_read) " +
        "VALUES (?, ?, ?, ?, NULL, NULL, ?, ?, ?, ?, 0);";

        DB db = new DB();
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,reply_to_id);
            stmt.setInt(2, isReplied ? 1 : 0);
            stmt.setString(3, "teacher");
            stmt.setInt(4, sender_teacher_id);
            stmt.setInt(5,recipient_student_id);
            stmt.setTimestamp(6,sent_date);
            stmt.setString(7,subject);
            stmt.setString(8,body);
            stmt.executeUpdate();

            stmt.close();
            db.close();
        } catch(Exception e) {
            throw new Exception("Error inserting teacher message into database: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing databasse: " + e.getMessage());
            }
        }

    }

    public Map<Student, List<Message>> getTeacherConversarions(int teacherId) throws Exception {
        Connection con = null;
        Map<Student, List<Message>> conversations = new HashMap<>();

        StudentDAO studentDAO = new StudentDAO();

        String query = "SELECT * FROM message " +
        "WHERE (sender_teacher_id = ? OR recipient_teacher_id = ?) " +
        "ORDER BY sent_date DESC";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(query);
            stmt.setInt(1,teacherId);
            stmt.setInt(2,teacherId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("message_id"));
                message.setReplyToMessageId(rs.getInt("reply_to"));
                message.setSenderType(rs.getString("sender_type"));
                message.setSenderId((rs.getString("sender_type")).equals("student") ? rs.getInt("sender_student_id") : rs.getInt("sender_teacher_id"));
                message.setRecipientId(rs.getString("sender_type").equals("student") ? rs.getInt("recipient_teacher_id") : rs.getInt("recipient_student_id"));
                message.setReplied(rs.getBoolean("is_replied"));
                message.setIsRead(rs.getBoolean("is_read"));

                // Retrieve the sent_date as a Timestamp
                Timestamp timestamp = rs.getTimestamp("sent_date");
                message.setMessageDate(timestamp.toLocalDateTime());

                message.setMessageSubject(rs.getString("message_subject"));
                message.setMessageContent(rs.getString("message_body"));

                // Fetch the student object based on the sender or recipient
                int studentId = (message.getSenderType().equals("student")) ? message.getSenderId() : message.getRecipientId();
                Student student = studentDAO.getStudentDetails(studentId); 

                // Add the message to the correct student's conversation
                if (!conversations.containsKey(student)) {
                    conversations.put(student, new ArrayList<>());
                }
                conversations.get(student).add(message);
            }

            rs.close();
            stmt.close();
            db.close();

            return conversations;
        } catch(Exception e) {
            throw new Exception("Error fetching teacher conversations: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }

    public Message findOriginalMessage(List<Message> messages, Integer replyToMessageId) {
        Message message = null;
        if (replyToMessageId != null) {
            for (Message msg : messages) {
                if (msg.getMessageId() == replyToMessageId) {
                    message = msg; // Return the original message
                }
            }
        }
        return message; // Return null if no match is found
    }

    public void updateIsReplied(int reply_to_message_id) throws Exception {
        Connection con = null;
        String sql = 
        "UPDATE message " +
        "SET is_replied = 1 " +
        "WHERE message_id = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,reply_to_message_id);
            stmt.executeUpdate();

            stmt.close();
            db.close();
        } catch(Exception e) {
            throw new Exception("Error updating message table: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing the database: " + e.getMessage());
            }
        }
    }

    public void updateIsReadMessage(int message_id) throws Exception {
        Connection con = null;
        String sql = 
        "UPDATE message " +
        "SET is_read = 1 " +
        "WHERE message_id = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,message_id);
            stmt.executeUpdate();

            stmt.close();
            db.close();
        } catch(Exception e) {
            throw new Exception("Error updating message table: " + e.getMessage());
        } finally {
            try {
                db.close();
            } catch(Exception e) {
                throw new Exception("Error closing database: " + e.getMessage());
            }
        }
    }

    public void hasUnreadMessages(int teacher_id) throws Exception {
        Connection con = null;
        String sql = "SELECT * FROM message WHERE recipient_teacher_id = ?;";

        DB db = new DB();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1,teacher_id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                throw new Exception("You have unread messages");
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
                throw new Exception("Error closing database: " + e.getMessage());
            }
        }
    }

    
}
