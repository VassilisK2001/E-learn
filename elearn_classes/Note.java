package elearn_classes;
import java.util.Date;

public class Note {
    // Fields
    private int note_id;
    private String title;
    private String file_url;
    private Date upload_date;
    private String uploader_type;
    private String uploader_name;
    private String course_title;

    // Constructor
    public Note(int note_id, String title, String file_url, Date upload_date, 
                String uploader_type, String uploader_name, String course_title) {
        this.note_id = note_id;
        this.title = title;
        this.file_url = file_url;
        this.upload_date = upload_date;
        this.uploader_type = uploader_type;
        this.uploader_name = uploader_name;
        this.course_title = course_title;
    }

    // Getters and Setters
    public int getNote_id() {
        return note_id;
    }

    public void setNote_id(int note_id) {
        this.note_id = note_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }

    public Date getUpload_date() {
        return upload_date;
    }

    public void setUpload_date(Date upload_date) {
        this.upload_date = upload_date;
    }

    public String getUploader_type() {
        return uploader_type;
    }

    public void setUploader_type(String uploader_type) {
        this.uploader_type = uploader_type;
    }

    public String getUploader_name() {
        return uploader_name;
    }

    public void setUploader_name(String uploader_name) {
        this.uploader_name = uploader_name;
    }

    public String getCourse_title() {
        return course_title;
    }

    public void setCourse_title(String course_title) {
        this.course_title = course_title;
    }

}
