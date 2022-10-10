package com.cloud.project.controllers;

import com.cloud.project.services.ThesisService;
import com.cloud.project.support.exceptions.DocentNotFoundException;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("${base-url}/Thesis")
public class ThesisController
{
 @Autowired
 private ThesisService thesisService;

 /**
  * GET OPERATION
  **/
 @Operation(method="showThesisFiles", summary = "show all thesis files")
 @GetMapping(path = "/files")
 public ResponseEntity showDocentThesis(@RequestParam(value="thesis_id") Long thesisId)
 {
  return ResponseEntity.ok(thesisService.getThesisFile(thesisId));
 }

 /**
  * GET OPERATION
  **/
 @Operation(method="showThesisFiles", summary = "show all thesis files")
 @GetMapping(path = "/details")
 public ResponseEntity showDocentThesisDetails(@RequestParam(value="thesis_id") Long thesisId)
 {
  return ResponseEntity.ok(thesisService.showThesis(thesisId));
 }

}
