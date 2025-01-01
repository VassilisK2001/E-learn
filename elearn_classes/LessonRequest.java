package elearn_classes;
import java.util.Date;

public class LessonRequest {

    // Private fields
    private int lesson_req_id;
    private Date schedule_date;
    private String request_status;
    private String course;
    private String sent_from;
    private String sent_to;

    // Constructor
    public LessonRequest(int lesson_req_id, Date schedule_date, String request_status, String course, String sent_from, String sent_to) {
        this.lesson_req_id = lesson_req_id;
        this.schedule_date = schedule_date;
        this.request_status = request_status;
        this.course = course;
        this.sent_from = sent_from;
        this.sent_to = sent_to;
    }

    // Getter and Setter methods

    // Get lesson_req_id
    public int getLesson_req_id() {
        return lesson_req_id;
    }

    // Set lesson_req_id
    public void setLesson_req_id(int lesson_req_id) {
        this.lesson_req_id = lesson_req_id;
    }

    // Get schedule_date
    public Date getSchedule_date() {
        return schedule_date;
    }

    // Set schedule_date
    public void setSchedule_date(Date schedule_date) {
        this.schedule_date = schedule_date;
    }

    // Get request_status
    public String getRequest_status() {
        return request_status;
    }

    // Set request_status
    public void setRequest_status(String request_status) {
        this.request_status = request_status;
    }

    // Get course
    public String getCourse() {
        return course;
    }

    // Set course
    public void setCourse(String course) {
        this.course = course;
    }

    // Get sent_from
    public String getSent_from() {
        return sent_from;
    }

    // Set sent_from
    public void setSent_from(String sent_from) {
        this.sent_from = sent_from;
    }

    // Get sent_to
    public String getSent_to() {
        return sent_to;
    }

    // Set sent_to
    public void setSent_to(String sent_to) {
        this.sent_to = sent_to;
    }

}

