package com.cloud.project.services;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Student;
import com.cloud.project.entities.Thesis;
import com.cloud.project.repositories.DocentRepository;
import com.cloud.project.repositories.MessageRepository;
import com.cloud.project.repositories.StudentRepository;
import com.cloud.project.repositories.ThesisRepository;
import com.cloud.project.support.exceptions.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DocentService
{
 @Autowired
 StudentRepository studentRepository;

 //@Autowired
 //MessageRepository messageRepository;
 @Autowired
 ThesisRepository thesisRepository;
 @Autowired
 DocentRepository docentRepository;


 @Transactional(readOnly = false)
 public void removeStudent(String studentEmail) throws StudentNotFoundException
 {
  Student student = studentRepository.findByEmail(studentEmail);
  if(student == null) throw new StudentNotFoundException();
  studentRepository.delete(student);
  }//addClient

 @Transactional(readOnly = true)
 public List<Thesis> showThesis(String docentEmail) throws DocentNotFoundException
 {
  Docent docent = docentRepository.findByEmail(docentEmail);
  if(docent == null) throw new DocentNotFoundException();
  List<Thesis> allThesis = docent.getThesis();
  allThesis.addAll(docent.getThesisAsMainSupervisor());
  return  allThesis;
 }

 @Transactional(readOnly =true)
 public Docent docentLogin(String email, String password)
 throws WrongPassword, DocentNotExsist, DocentNotRegistry
 {
  Docent docent = docentRepository.findByEmail(email);
  if(docent == null) throw new DocentNotExsist();
  if(docent.getPassword() == null) throw new DocentNotRegistry();
  if(!docent.getPassword().equals(password)) throw new WrongPassword();
  return docent;
 }

 @Transactional(readOnly = false)
 public Docent registryDocent(String email, String password)
 throws DocentNotFoundException, DocentAlreadyRegistered
 {
  Docent docent = docentRepository.findByEmail(email);
  if(docent == null) throw new DocentNotFoundException();
  if(docent.getPassword() != null) throw new DocentAlreadyRegistered();
  docent.setPassword(password);
  return docentRepository.save(docent);
 }

 @Transactional(readOnly = false)
 public Thesis addThesis(String studentEmail, String docentEmail, String title,String type)
 throws ExistingThesis, StudentNotFoundException, DocentNotFoundException
 {
  boolean existingThesis = thesisRepository.existsByTitle(title);
  if(existingThesis) throw new ExistingThesis();
  Student studentInDb = studentRepository.findByEmail(studentEmail);
  if(studentInDb == null) throw new StudentNotFoundException();
  Docent docentInDb = docentRepository.findByEmail(docentEmail);
  if(docentInDb == null)  throw new DocentNotFoundException();
  Thesis thesis = Thesis.builder()
          .title(title)
          .type(type)
          .thesisStudent(studentInDb)
          .mainSupervisor(docentInDb)
          .build();
  Thesis thesisInDB = thesisRepository.save(thesis);
  return thesisInDB;
 }

 @Transactional(readOnly = false)
 public Student addStudent(Student student) throws ExistingStudent
 {
  boolean existingStudent = studentRepository.existsByEmail(student.getEmail());
  if(existingStudent) throw new ExistingStudent();
  Student studentInDb = studentRepository.save(student);
  return studentInDb;
 }

 @Transactional(readOnly = true)
 public List<Docent> searchDocents(String docentEmail)
 {
  return docentRepository.findByEmailContains(docentEmail);
 }

 @Transactional(readOnly = false)
 public Docent addDocent(Docent docent) throws ExistingDocent
 {
  boolean existingDocent = docentRepository.existsByEmail(docent.getEmail());
  if(existingDocent) throw new ExistingDocent();
  Docent docentInDb = docentRepository.save(docent);
  return docentInDb;
 }

 @Transactional(readOnly = false)
 public Thesis addSupervisor(String docentEmail,String supervisorEmail, Long thesisID)
 throws NotThesisMainSupervisor
 {
  Thesis thesisInDb = thesisRepository.findById(thesisID);
  Docent mainSupervisor = thesisInDb.getMainSupervisor();
  if(!mainSupervisor.getEmail().equals(docentEmail)) throw new NotThesisMainSupervisor();
  Docent supervisor = docentRepository.findByEmail(supervisorEmail);
  supervisor.getThesis().add(thesisInDb);
  docentRepository.save(supervisor);
  return thesisInDb;
 }

 @Transactional(readOnly = true)
 public Docent showDocent(String docentEmail) throws DocentNotFoundException
 {

  Docent docent = docentRepository.findByEmail(docentEmail);
  if(docent == null) throw new DocentNotFoundException();
  return docent;
 }



}//DocentService
