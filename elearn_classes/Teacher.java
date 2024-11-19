package elearn_classes;

import java.util.List;
import java.util.ArrayList;

public class Teacher {

    // Private Fields
    private int teacher_id;
    private String name; 
    private int age; 
    private String username; 
    private String password; 
    private String email;
    private String desc;
    private String photo;
    private int years_of_experience;
    private double min_price;
    private double max_price;
    private List<String> teacher_specializations;
    private List<String> specialization_courses;

    /**
     * Full Constructor
     * Initializes all fields, including specialization_courses.
     *
     * @param teacher_id               Unique identifier for the teacher.
     * @param name                     Full name of the teacher.
     * @param age                      Age of the teacher.
     * @param username                 Username for login.
     * @param password                 Password for login.
     * @param email                    Email address.
     * @param desc                     Description or bio.
     * @param photo                    URL to the teacher's photo.
     * @param years_of_experience      Number of years of teaching experience.
     * @param min_price                Minimum price for lessons.
     * @param max_price                Maximum price for lessons.
     * @param teacher_specializations  List of teacher's specializations.
     * @param specialization_courses   List of courses related to the teacher's specializations.
     */

    public Teacher(int teacher_id, String name, int age, String username, String password, String email, 
                   String desc, String photo, int years_of_experience, double min_price, double max_price, 
                   List<String> teacher_specializations, List<String> specialization_courses) {

        this.teacher_id = teacher_id;
        this.name = name;
        this.age = age;
        this.username = username;
        this.password = password;
        this.email = email;
        this.desc = desc;
        this.photo = photo;
        this.years_of_experience = years_of_experience;
        this.min_price = min_price;
        this.max_price = max_price;
        this.teacher_specializations = teacher_specializations;
        this.specialization_courses = (specialization_courses == null) ? new ArrayList<>() : specialization_courses;
    }

    // Getter and Setter Methods

    public int getTeacher_id() {
        return teacher_id;
    }

    public void setTeacher_id(int teacher_id) {
        this.teacher_id = teacher_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
        
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getYears_of_experience() {
        return years_of_experience;
    }

    public void setYears_of_experience(int years_of_experience) {
        this.years_of_experience = years_of_experience;
    }

    public double getMin_price() {
        return min_price;
    }

    public void setMin_price(double min_price) {
        this.min_price = min_price;
    }

    public double getMax_price() {
        return max_price;
    }

    public void setMax_price(double max_price) {
        this.max_price = max_price;
        
    }

    public List<String> getTeacher_specializations() {
        return teacher_specializations;
    }

    public void setTeacher_specializations(List<String> teacher_specializations) {
        this.teacher_specializations = teacher_specializations;
    }

    public List<String> getSpecialization_courses() {
        return specialization_courses;
    }

    public void setSpecialization_courses(List<String> specialization_courses) {
        this.specialization_courses = specialization_courses;
    }
}
