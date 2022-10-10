package com.cloud.project.entities;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
@Getter
@Setter
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
@Entity
public class Message
{
 //-------------------------- features --------------------------
 @Id
 @Basic
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 @Column(name = "id",nullable = false)
 private Long id;

 @Basic
 @Column(name = "text",nullable = false)
 private String text;

 @Basic
 @Column(name = "read", nullable = false)
 private boolean read;

 @Basic
 @CreationTimestamp
 @JsonFormat(pattern = "dd/MM/yyyy' 'HH:mm:ss",shape = JsonFormat.Shape.STRING)
 @Column(name = "messageTime",nullable = false)
 private LocalDateTime messageTime; //this class represents both a date and a time

 //-------------------------- relationships --------------------------
 @ManyToOne
 @JoinColumn(name="sender", nullable=false)
 private User sender;

 @ManyToOne
 @JoinColumn(name="receiver", nullable=false)
 private User receiver;

 /*
 @OneToOne(mappedBy = "fileMessage")
 @JsonIgnore
 @ToString.Exclude
 private File file;
 */

}//Message
