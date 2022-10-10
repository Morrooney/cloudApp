package com.cloud.project.controllers;

import com.cloud.project.services.MessageService;
import com.cloud.project.support.exceptions.*;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;


import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("${base-url}/Message")
public class MessageController
{
 @Autowired
 private MessageService messageService;


 /**
  * GET OPERATION
 **/
 @Operation(method="showAllMessage", summary = "show all Message beetween Docent and Student")
 @GetMapping(path = "/showAllMessagesConversation")
 public ResponseEntity showAllMessages(@RequestParam(value="user1_email") String senderEmail,@RequestParam(value="user2_email") String receiverEmail)
 {
  try
  {
   return ResponseEntity.ok()
           .header("content-type" ,"application/json; charset=utf-8")
           .body(messageService.showAllMessage(senderEmail,receiverEmail));
  }
  catch(UserNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User not found");
  }
 }

 /**
  * GET OPERATION
  **/
 @Operation(method="showNotify", summary = "show all Message")
 @GetMapping(path = "/notifyMessage")
 public ResponseEntity showNotify( @RequestParam(value="receiver_email") String receiverEmail)
 {
  try
  {
   return ResponseEntity.ok()
           .header("content-type" ,"application/json; charset=utf-8")
           .body(messageService.showNotify(receiverEmail));
  }
  catch(UserNotFoundException e)
  {
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User not found");
  }
 }


 /**
  * POST OPERATION
 **/

 @Operation(method="sendMessage", summary = "send a new Message")
 @PostMapping(path = "/send")
 public ResponseEntity sendMessage
 (
         @RequestBody String text,
         @RequestParam(value= "sender_email") String senderEmail, @RequestParam(value= "receiver_email") String receiverEmail
  )
 {
  try
  {
   String textWithoutQuotes = text.replaceAll("\"","");
   return ResponseEntity.ok()
           .header("content-type" ,"application/json; charset=utf-8")
           .body(messageService.sendMessage(senderEmail, receiverEmail,textWithoutQuotes));
  }

  catch(UserNotFoundException e1)
  {
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User not found");
  }
  catch(EmpityMessage e2)
  {
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("The message is empity");
  }
 }

}
