package com.cloud.project.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.util.List;
@Getter
@Setter
@EqualsAndHashCode
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Thesis
{
 //-------------------------- features --------------------------
 @Id
 @Basic
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 @Column(name = "id",nullable = false)
 private Long id;

 @Basic
 @Column(name = "title",nullable = false)
 private String title;

 @Basic
 @Column(name = "type",nullable = false)
 private String type;

 //-------------------------- relationships --------------------------
 @OneToMany(mappedBy="thesis")
 @JsonIgnore
 @ToString.Exclude
 private List<File> thesisFile;

 @OneToOne(cascade = CascadeType.ALL)
 @JoinColumn(name = "thesis_student", referencedColumnName = "id")
 @ToString.Exclude
 private Student thesisStudent; //owning side of the foreign relationship


 @ManyToOne
 @JoinColumn(name="main_supervisor", nullable=false)
 @ToString.Exclude
 private Docent mainSupervisor;

 @ManyToMany(mappedBy = "thesis",cascade = CascadeType.ALL)
 //@JsonIgnore
 @ToString.Exclude
 private List<Docent> supervisors;

}//Thesis
