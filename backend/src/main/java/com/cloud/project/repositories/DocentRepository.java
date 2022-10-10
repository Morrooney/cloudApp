package com.cloud.project.repositories;

import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DocentRepository extends JpaRepository<Docent,Integer>
{
 List<Docent> findByEmailContains(@Param("docentEmail") String docentEmail); //use @Param for a bug of the framework
 boolean existsByEmail(String email);
 Docent findByEmail (String email);

}//Docent Repository
