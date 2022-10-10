package com.cloud.project.controllers;

import com.cloud.project.entities.File;

import com.cloud.project.repositories.FileRepository;
import com.cloud.project.services.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;



@RestController
@RequestMapping("${base-url}/api/v1/file")
@CrossOrigin("*")
public class FileController
{
    @Autowired
    FileService fileService;

    @Autowired
    FileRepository fileRepository;

    /*
    @GetMapping
    public ResponseEntity<List<File>> getFiles() {
        return new ResponseEntity<>(fileService.getAllFiles(), HttpStatus.OK);
    }*/

    @PostMapping(
            path = "/update",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    public ResponseEntity<File> saveFile
    (
     @RequestParam("file") MultipartFile file,
     @RequestParam("owner")String owner,
     @RequestParam("thesis") Long thesisId
    )
    {
        return new ResponseEntity<>(fileService.saveFile(file,owner,thesisId), HttpStatus.OK);
    }


    @GetMapping(value = "/download/{file_id}", produces = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<ByteArrayResource> downloadFile(@PathVariable("file_id") Long id)
    {
     byte[] data =  fileService.downloadFile(id);
     File file = fileRepository.findById(id);
     String fileName = file.getFileName();
     ByteArrayResource resource = new ByteArrayResource(data);
     return ResponseEntity
             .ok()
             .contentLength(data.length)
             .header(HttpHeaders.CONTENT_TYPE, file.getTypeFile())
             .header("Access-Control-Expose-Headers", "Content-Disposition")
             .header("Content-disposition","attachment; filename=\"" +fileName+"\"")
             .body(resource);
    }
}
