package com.cloud.project.services;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Message;
import com.cloud.project.entities.Student;
import com.cloud.project.entities.User;
import com.cloud.project.entities.custom.MessageCount;
import com.cloud.project.repositories.DocentRepository;
import com.cloud.project.repositories.MessageRepository;
import com.cloud.project.repositories.StudentRepository;
import com.cloud.project.repositories.UserRepository;
import com.cloud.project.support.exceptions.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class MessageService
{
 @Autowired
 private MessageRepository messageRepository;
 @Autowired
 private StudentRepository studentRepository;
 @Autowired
 private DocentRepository docentRepository;

 @Autowired
 private UserRepository userRepository;

 @Transactional(readOnly = true)
 public List<MessageCount> showNotify(String receiverEmail) throws UserNotFoundException
 {
  User receiver = userRepository.findByEmail(receiverEmail);
  if(receiver == null) throw new UserNotFoundException();
  return messageRepository.findByReceiverAndReadFalseOrderByMessageTime(receiver);
 }


 @Transactional(readOnly = false)
 public List<Message> showAllMessage(String user1Email, String user2Email)
 throws UserNotFoundException
 {
  User user1 = userRepository.findByEmail(user1Email);
  User user2 = userRepository.findByEmail(user2Email);
  if(user1 == null || user2 == null) throw new UserNotFoundException();
  List<Message> messages = messageRepository.findBySenderAndReceiverOrderByMessageTime(user1,user2);
  messageRepository.updateMessagesRead(user2,user1);
  return messages;
 }

 @Transactional(readOnly = false)
 public Message sendMessage(String senderEmail, String receiverEmail, String text)
 throws EmpityMessage, UserNotFoundException
 {
  User sender = userRepository.findByEmail(senderEmail);
  User receiver = userRepository.findByEmail(receiverEmail);
  if(sender == null || receiver == null) throw new UserNotFoundException();
  if(text == null || text.isEmpty()) throw new EmpityMessage();
  Message message = Message.builder()
             .read(false)
             .sender(sender)
             .receiver(receiver)
             .text(text)
             .build();
  Message messageInDb = messageRepository.save(message);
  return messageInDb;
 }
}
