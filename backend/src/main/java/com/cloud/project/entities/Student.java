package com.cloud.project.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
public class Student extends User
{
 //-------------------------- features --------------------------

 @Basic
 @Column(name = "degree_course", nullable = false)
 private String degreeCourse ;

 @Basic
 @Column(name = "registration_number", nullable = false , length = 6)
 private String registrationNumber; //matricola

 //-------------------------- relationships --------------------------


 @OneToOne(mappedBy = "thesisStudent")
 @JsonIgnore
 @ToString.Exclude
 private Thesis thesis;

}//Student
