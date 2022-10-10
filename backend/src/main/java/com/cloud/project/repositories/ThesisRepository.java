package com.cloud.project.repositories;
;
import com.cloud.project.entities.Docent;
import com.cloud.project.entities.Student;
import com.cloud.project.entities.Thesis;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.awt.print.Pageable;
import java.util.List;
@Repository
public interface ThesisRepository extends JpaRepository<Thesis,Integer>
{
 Thesis findByTitle(String title);
 Thesis findById(Long id);
 boolean existsByTitle(String title);
 List<Thesis> findByType(String type);
 List<Thesis> findByTitleContaining(String author);

}//ThesisRepository
