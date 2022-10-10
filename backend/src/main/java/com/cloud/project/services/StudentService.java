package com.cloud.project.services;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Student;
import com.cloud.project.entities.Thesis;
import com.cloud.project.repositories.StudentRepository;
import com.cloud.project.support.exceptions.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudentService
{
 @Autowired
 private StudentRepository studentRepository;


 @Transactional(readOnly = true)
 public List<Student> findByName(String name) {return studentRepository.findByName(name);}

 @Transactional(readOnly = true)
 public List<Student> findBySurname(String surname) {return studentRepository.findBySurname(surname);}

 @Transactional(readOnly = true)
 public List<Student> findByNameAndSurname(String name, String surname) {return studentRepository.findByNameAndSurname(name,surname);}

 @Transactional(readOnly =true)
 public Student studentLogin(String email, String password)
 throws WrongPassword, StudentNotExsist, StudentNotRegistry
 {
  Student student = studentRepository.findByEmail(email);
  if(student == null) throw new StudentNotExsist();
  if(student.getPassword() == null) throw new StudentNotRegistry();
  if(!student.getPassword().equals(password)) throw new WrongPassword();
  return student;
 }

 @Transactional(readOnly = false)
 public Student registryStudent(String email, String password)
 throws StudentNotFoundException, StudentAlreadyRegistered
 {
  Student student = studentRepository.findByEmail(email);
  if(student == null) throw new StudentNotFoundException();
  if(student.getPassword() != null) throw new StudentAlreadyRegistered();
  student.setPassword(password);
  return studentRepository.save(student);
 }

 @Transactional(readOnly = true)
 public Thesis showThesis(String studentEmail) throws StudentNotFoundException
 {
  Student student = studentRepository.findByEmail(studentEmail);
  if(student == null) throw new StudentNotFoundException();
  return student.getThesis();
 }
 @Transactional(readOnly = true)
 public Student showStudent(String email) throws StudentNotFoundException
 {
  Student student = studentRepository.findByEmail(email);
  if(student == null) throw new StudentNotFoundException();
  return studentRepository.findByEmail(email);
 }

 @Transactional(readOnly = true)
 public List<Student> searchStudent(String studentEmail)
 {
  return studentRepository.findByEmailContains(studentEmail);
 }

 @Transactional(readOnly = true)
 public boolean existsByEmail(String email){return studentRepository.existsByEmail(email);}


 @Transactional(readOnly = false)
 public void setEmail(Student student, String email) throws RuntimeException
 {
  if(!studentRepository.existsByEmail(student.getEmail()) ) throw new RuntimeException("Cliente inesistente");
  if(!studentRepository.existsByEmail(email)) throw new RuntimeException("Email già esistente");
  Student studentInDB = studentRepository.findByEmail(student.getEmail());
  studentInDB.setEmail(email);
  studentRepository.save(studentInDB);
  /*You can simply use this function with save() JPAfunction, but the object sent as parameter must contain
  an existing id in the database otherwise it will not work, because save() when we send an object without id,
  it adds directly a row in database, but if we send an object with an existing id, it changes the columns
  already found in the database.*/
 }



}//StudentService
