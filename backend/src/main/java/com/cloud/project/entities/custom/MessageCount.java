package com.cloud.project.entities.custom;

import com.cloud.project.entities.User;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
@ToString
public class MessageCount
{
 private User sender;
 private Long total;

 public MessageCount(User sender, Long total)
 {
  this.sender = sender;
  this.total = total;
 }
}
