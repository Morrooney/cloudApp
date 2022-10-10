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
public class Docent extends User
{
 //-------------------------- features --------------------------

 @Basic
 @Column(name = "card_number", nullable = false)
 private String cardNumber;

 //-------------------------- relationships --------------------------

 /*
  * remember when you use the mappedBy,
  * you must indicate the object attribute
  * name not the db column name
  */

 @ManyToMany(cascade = CascadeType.ALL)
 @JoinTable
 (
  name = "thesis_supervisors",
  joinColumns = @JoinColumn(name = "docent_id"),
  inverseJoinColumns = @JoinColumn(name = "thesis_id")
 )

 @JsonIgnore
 @ToString.Exclude
 @EqualsAndHashCode.Exclude
 private List<Thesis> thesis;

 @OneToMany(mappedBy = "mainSupervisor")
 @JsonIgnore
 @ToString.Exclude
 @EqualsAndHashCode.Exclude
 private List<Thesis> thesisAsMainSupervisor;

}//Docent
