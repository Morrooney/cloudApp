package com.cloud.project.services;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.File;
import com.cloud.project.entities.Student;
import com.cloud.project.entities.Thesis;
import com.cloud.project.repositories.ThesisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ThesisService
{
 @Autowired
 private ThesisRepository thesisRepository;

 @Transactional(readOnly = true)
 public Thesis showThesis(Long thesisId){return thesisRepository.findById(thesisId);}

 @Transactional(readOnly = true)
 public List<Docent> showSupervisors(Thesis thesis)
 {
  return thesis.getSupervisors();
 }

 @Transactional
 public Docent showMainSupervisors(Thesis thesis){ return thesis.getMainSupervisor();}
 @Transactional(readOnly = true)
 public List<File> getThesisFile(Long thesisId)
 {
  Thesis thesis = thesisRepository.findById(thesisId);
  return thesis.getThesisFile();
 }

 @Transactional(readOnly = true)
 public Student showStudent(Thesis thesis)
 {
  return thesis.getThesisStudent();
 }


}//ThesisService
