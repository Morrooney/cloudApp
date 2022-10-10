package com.cloud.project.repositories;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentRepository extends JpaRepository<Student,Integer>
{
 List<Student> findByName(String name);

 List<Student> findByEmailContains(@Param("studentEmail") String studentEmail); //for bug
 List<Student> findBySurname(String surname);
 List<Student> findByNameAndSurname(String name, String surname);
 Student findByEmail (String email);

 boolean existsByEmail(String email);
}//StudentRepository
