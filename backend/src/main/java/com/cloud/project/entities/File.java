package com.cloud.project.entities;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;


@Getter
@Setter
@Builder
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class File
{
 //-------------------------- features --------------------------
 @Id
 @Basic
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 @Column(name = "id",nullable = false)
 private Long id;

 @Basic
 @Column(name = "file_path",nullable = false)
 private String filePath;

 @Basic
 @Column(name = "file_name",nullable = false)
 private String fileName;

 @Basic
 @Column(name = "owner",nullable = false)
 private String owner; //when the client take the request, you save is id.

 @Basic
 @Column(name = "type_file", nullable = false)
 private String typeFile;

 @Basic
 @CreationTimestamp
 @JsonFormat(pattern = "dd/MM/yyyy' 'HH:mm",shape = JsonFormat.Shape.STRING)
 @Column(name = "update_time")
 private LocalDateTime updateTime;

 //-------------------------- relationships --------------------------
 @ManyToOne
 @JoinColumn(name="thesis", nullable=false)
 @JsonIgnore
 //@EqualsAndHashCode.Exclude
 private Thesis thesis;

 /*
 @OneToOne(cascade = CascadeType.ALL)
 @JoinColumn(name = "file_message", referencedColumnName = "id")
 @JsonIgnore
 @ToString.Exclude
 private Message fileMessage; //owning side of the foreign relationship
 */

}//File
