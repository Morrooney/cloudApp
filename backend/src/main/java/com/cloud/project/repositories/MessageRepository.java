package com.cloud.project.repositories;

import com.cloud.project.entities.*;
import com.cloud.project.entities.custom.MessageCount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message,Integer>
{

 @Query(value = "SELECT m FROM Message m WHERE (m.sender = ?1 OR m.receiver = ?1) and " +
         "(m.sender = ?2 OR m.receiver = ?2) ORDER BY m.messageTime DESC")
 List<Message> findBySenderAndReceiverOrderByMessageTime(User sender, User receiver);

 @Modifying
 @Query(value = "SELECT new com.cloud.project.entities.custom.MessageCount(m.sender, COUNT(m.sender)) " +
         "FROM Message m WHERE (m.receiver = ?1) and m.read = false GROUP BY m.sender")
 List<MessageCount> findByReceiverAndReadFalseOrderByMessageTime(User user);

 @Modifying
 @Query(value = "UPDATE Message m SET m.read = true WHERE (m.sender = ?1) AND (m.receiver = ?2) AND m.read = false")
 int updateMessagesRead(User sender, User receiver);
 Message findById(Long id);
}//MessageRepository
