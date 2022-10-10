package com.cloud.project.services;

import com.cloud.project.entities.*;
import com.cloud.project.repositories.*;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class FileService
{
    @Value("${aws.bucketName}")
    private String bucketName;
    @Autowired
    private FileStore fileStore;
    @Autowired
    private FileRepository fileRepository;
    @Autowired
    private ThesisRepository thesisRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private DocentRepository docentRepository;

    //@Autowired
    // private MessageRepository messageRepository;

    public File saveFile
    (
     MultipartFile file, String owner,
     Long thesisId
    )
    {
        //check if the file is empty
        if (file.isEmpty()) {
            throw new IllegalStateException("Cannot upload empty file");
        }
        //get file metadata

        Map<String, String> metadata = new HashMap<>();
        metadata.put("Content-Type", file.getContentType());
        metadata.put("Content-Length", String.valueOf(file.getSize()));

        //Save file in S3 and then save file in the database
        String path = String.format("%s", bucketName);
        String fileName = String.format("%s", file.getOriginalFilename());

        try {
            fileStore.upload(path, fileName, Optional.of(metadata), file.getInputStream());
        } catch (IOException e) {
            throw new IllegalStateException("Failed to upload file", e);
        }

        Thesis thesis = thesisRepository.findById(thesisId);

        //Message message = messageRepository.findById(messageId);

        File dbFile = File.builder()
                .fileName(fileName)
                .filePath(path)
                .owner(owner)
                .typeFile(file.getContentType())
                .thesis(thesis)
                //.fileMessage(message)
                .build();
        return fileRepository.save(dbFile);
    }


    public byte[] downloadFile(Long id)
    {
     File file = fileRepository.findById(id);
     return fileStore.download(file.getFilePath(), file.getFileName());
    }


    public List<File> getAllFiles() {
        List<File> files = new ArrayList<>();
        fileRepository.findAll().forEach(files::add);
        return files;
    }

}//FileService
