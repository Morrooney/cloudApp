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
@Inheritance(strategy = InheritanceType.JOINED)

@Table(name = "person")
@Entity(name = "user")
public class User
{
 //-------------------------- features --------------------------

    @Id
    @Basic
    @GeneratedValue(strategy=GenerationType.TABLE)
    @Column(name = "id",nullable = false)
    private Long id;


    @Basic
    @Column(name = "name", nullable = false)
    private String name;

    @Basic
    @Column(name = "surname", nullable = false)
    private String surname;

    @Basic
    @Column(name = "department", nullable = false)
    private String department;

    @Basic
    @Column(name = "email", nullable = false)
    private String email;

    @Basic
    @JsonIgnore
    @Column(name = "password",nullable = true)
    private String password;

    //-------------------------- relationships --------------------------

    @OneToMany(mappedBy="sender")
    @JsonIgnore
    @ToString.Exclude
    private List<Message> sendedMessages;

    @OneToMany(mappedBy="receiver")
    @JsonIgnore
    @ToString.Exclude
    private List<Message> receivedMessages;

}
