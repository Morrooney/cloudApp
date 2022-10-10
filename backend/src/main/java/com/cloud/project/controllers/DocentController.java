package com.cloud.project.controllers;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Student;
import com.cloud.project.entities.Thesis;
import com.cloud.project.services.DocentService;

import com.cloud.project.support.exceptions.*;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("${base-url}/Docent")
public class DocentController
{
 @Autowired
 private DocentService docentService;


 /**
  * GET OPERATION
  **/
 @Operation(method="loginDocent", summary = " docentLogin")
 @GetMapping(path = "/login")
 public ResponseEntity docentLogin(@RequestParam(value = "email") String email, @RequestParam(value = "password") String password)
 {
  try
  {
   return ResponseEntity.ok(docentService.docentLogin(email,password));
  }
  catch (WrongPassword e1)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Wrong password");
  }
  catch (DocentNotExsist e2)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Docent not exist");
  }
  catch (DocentNotRegistry e3)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Docent not registry");
  }
 }

 /**
  * POST OPERATION
  **/
 @Operation(method="loginDocent", summary = " docentLogin")
 @PostMapping(path = "/registration")
 public ResponseEntity docentRegistration(@RequestParam(value = "email") String email, @RequestParam(value = "password") String password)
 {
  try
  {
   return ResponseEntity.ok(docentService.registryDocent(email,password));
  }
  catch (DocentNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("docente non nel database");
  }
  catch(DocentAlreadyRegistered e2)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("docente già registrato");
  }
 }



 /**
  * POST OPERATION
  **/
 @Operation(method="addStudent", summary = "add a new Student in the page")
 @PostMapping(path = "/newStudent")
 public ResponseEntity addStudent(@RequestBody @Valid Student student, BindingResult bindingResult)
 {
  if (bindingResult.hasErrors()) return ResponseEntity.badRequest().build();
  try
  {
   return ResponseEntity.ok(docentService.addStudent(student));
  }
  catch (ExistingStudent e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Existing Student");
  }
 }

 /**
  * POST OPERATION
  **/
 @Operation(method="addDocent", summary = "add a new Docent in the page")
 @PostMapping(path = "/newDocent")
 public ResponseEntity addDocent(@RequestBody @Valid Docent docent, BindingResult bindingResult)
 {
  if (bindingResult.hasErrors()) return ResponseEntity.badRequest().build();
  try
  {
   return ResponseEntity.ok(docentService.addDocent(docent));
  }
  catch (ExistingDocent e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Existing Docent");
  }
 }

 /**
  * POST OPERATION
  **/
 @Operation(method="addThesis", summary = "add a new Thesis")
 @PostMapping(path = "/newThesis")
 public ResponseEntity addThesis(@RequestParam(value = "student_email") String studentEmail,
                                 @RequestParam(value = "docent_email") String docentEmail,
                                 @RequestParam(value = "thesis_title") String thesisTitle,
                                 @RequestParam(value = "thesis_type") String thesisType)
 {
  try
  {
   return ResponseEntity.ok(docentService.addThesis(studentEmail,docentEmail,thesisTitle,thesisType));
  }
  catch (ExistingThesis e1)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Existing Thesis");
  }
  catch (StudentNotFoundException e2)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Student not found");
  }
  catch(DocentNotFoundException e3)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Docent not found");
  }
 }

 /**
  * GET OPERATION
  **/
 @Operation(method="showDocentThesis", summary = "show all Docent thesis")
 @GetMapping(path = "/docentThesis")
 public ResponseEntity showDocentThesis(@RequestParam(value="docent_email") String docentEmail)
 {
  try
  {
   return ResponseEntity
           .ok()
           .header("content-type" ,"application/json; charset=utf-8")
           .body((docentService.showThesis(docentEmail)));
  }
  catch (DocentNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Docent not found");
  }
 }

 /**
  * POST OPERATION
  **/
 @Operation(method="addSupervisor", summary = "add thesis supervisors")
 @PostMapping(path = "/addSupervisor")
 public ResponseEntity addSupervisor
 (
  @RequestParam(value = "thesis_id") Long thesisId,
  @RequestParam(value = "supervisor_email") String supervisorEmail,
  @RequestParam(value = "docent_email") String docentEmail
 )
 {
  try
  {
   return ResponseEntity.ok(docentService.addSupervisor(docentEmail,supervisorEmail,thesisId));
  }
  catch (NotThesisMainSupervisor e1)
  {
   System.out.println("Entra qui");
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("You aren't the thesis main supervisor");
  }
 }

 /**
  * GET OPERATION
  **/
 @Operation(method="showDocent", summary = "show docent by email")
 @GetMapping(path = "/showDocent")
 public ResponseEntity showDocent(@RequestParam(value = "docent_email") String docentEmail)
 {
  try
  {
   return ResponseEntity.ok(docentService.showDocent(docentEmail));
  }
  catch (DocentNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Docent not found");
  }
 }

 /**
  * GET OPERATION
  **/
 @Operation(method="searchDocents", summary = "search docent by email")
 @GetMapping(path = "/searchDocents")
 public ResponseEntity searchDocents(@RequestParam(value = "docent_email") String docentEmail)
 {
  return ResponseEntity.ok(docentService.searchDocents(docentEmail));
 }



 /*
 @Operation(method="deleteStudent", summary = "delete student from platform")
 @PostMapping(path = "/deleteStudent")
 public ResponseEntity deleteStudent(@RequestParam(value = "student email") String studentEmail)
 {
  try
  {
   docentService.removeStudent(studentEmail);
   return ResponseEntity.status(HttpStatus.OK).body("Student successfully removed");
  }
  catch (StudentNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Student not found");
  }
 }
 */
}
