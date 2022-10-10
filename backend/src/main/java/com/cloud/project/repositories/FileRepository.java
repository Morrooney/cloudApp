package com.cloud.project.repositories;


import com.cloud.project.entities.File;
import com.cloud.project.entities.Thesis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FileRepository extends JpaRepository<File, Integer> // object-type id
{
 File findByFileName(String fileName);
 File findByThesis(Thesis thesis);
 File findById(Long id);
}//FileRepository
