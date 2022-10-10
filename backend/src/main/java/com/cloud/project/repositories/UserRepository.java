package com.cloud.project.repositories;

import com.cloud.project.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User,Integer>
{
 User findById(Long id);
 User findByEmail(String email);
}
