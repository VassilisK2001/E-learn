package elearn_classes;

import java.util.List;

public class Student {
    private int studentId;
    private String fullName;
    private int age;
    private String username;
    private String password;
    private String email;
    private String description;
    private String photoUrl;
    private List<String> interestSubjects;

    // Constructor
    public Student(int studentId, String fullName, int age, String username, String password, String email,
                   String description, String photoUrl, List<String> interestSubjects) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.age = age;
        this.username = username;
        this.password = password;
        this.email = email;
        this.description = description;
        this.photoUrl = photoUrl;
        this.interestSubjects = interestSubjects;
    }

    // Getters
    public int getStudentId() {
        return studentId;
    }

    public String getFullName() {
        return fullName;
    }

    public int getAge() {
        return age;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getDescription() {
        return description;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public List<String> getInterestSubjects() {
        return interestSubjects;
    }

    // Setters
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public void setInterestSubjects(List<String> interestSubjects) {
        this.interestSubjects = interestSubjects;
    }

}
