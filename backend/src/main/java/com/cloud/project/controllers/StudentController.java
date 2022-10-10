package com.cloud.project.controllers;

import com.cloud.project.services.StudentService;
import com.cloud.project.support.exceptions.*;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("${base-url}/Student")
public class StudentController
{
 @Autowired
 private StudentService studentService;


 /**
  * GET OPERATION
  **/
 @Operation(method="loginDocent", summary = " docentLogin")
 @GetMapping(path = "/login")
 public ResponseEntity studentLogin(@RequestParam(value = "email") String email, @RequestParam(value = "password") String password)
 {
  try
  {
   return ResponseEntity.ok(studentService.studentLogin(email,password));
  }
  catch (WrongPassword e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Wrong password");
  }
  catch (StudentNotExsist e2)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Student not exist");
  }
  catch (StudentNotRegistry e3)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Student not registry");
  }
 }

 /**
  * POST OPERATION
  **/
 @Operation(method="loginStudent", summary = " studentLogin")
 @PostMapping(path = "/registration")
 public ResponseEntity studentRegistration(@RequestParam(value = "email") String email, @RequestParam(value = "password") String password)
 {
  try
  {
   return ResponseEntity.ok(studentService.registryStudent(email,password));
  }
  catch (StudentNotFoundException e1)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Studente non nel database");
  }
  catch (StudentAlreadyRegistered e2)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Studente già registrato");
  }
 }



 /**
  * GET OPERATION
 **/
 @Operation(method="showStudent", summary = "show student by email")
 @GetMapping(path = "/showStudent")
 public ResponseEntity showStudent(@RequestParam(value = "student_email") String studentEmail)
 {
  try
  {
   return ResponseEntity.ok(studentService.showStudent(studentEmail));
  }
  catch (StudentNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Student not found");
  }
 }

 /**
  * GET OPERATION
  **/

 @Operation(method="searchStudents", summary = "search students by email")
 @GetMapping(path = "/searchStudents")
 public ResponseEntity searchStudents(@RequestParam(value = "student_email") String studentEmail)
 {
  return ResponseEntity.ok(studentService.searchStudent(studentEmail));
 }

 /**
  * GET OPERATION
  **/
 @Operation(method="showStudentThesis", summary = "show student thesis")
 @GetMapping(path = "/studentThesis")
 public ResponseEntity showStudentThesis(@RequestParam(value="student_email") String studentEmail)
 {
  try
  {
   return ResponseEntity
           .ok()
           .header("content-type" ,"application/json; charset=utf-8")
           .body(studentService.showThesis(studentEmail));
  }
  catch (StudentNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Student not found");
  }
 }
}
