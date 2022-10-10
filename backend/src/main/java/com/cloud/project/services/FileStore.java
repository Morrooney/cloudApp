package com.cloud.project.services;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.util.IOUtils;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Optional;

@AllArgsConstructor
@Service
public class FileStore {

    @Autowired
    private final AmazonS3 amazonS3;


    public void upload(String path, //is the path on the Amazon S3 bucket where the file will be stored.
                       String fileName, //is the actual name of the file being uploaded. It will be used as the key when downloading the file from S3.
                       Optional<Map<String, String>> optionalMetaData, //map contains the details of the file i.e file type and file size.
                       InputStream inputStream //contains the actual file that should be saved to Amazon S3.
                       )
    {
        /* The above code block loops through the optionalMetaData map adding all
         * of the file information to the S3 objectMetaData.
         */

        ObjectMetadata objectMetadata = new ObjectMetadata();
        optionalMetaData.ifPresent(map ->
        {
         if (!map.isEmpty())
         {
          map.forEach(objectMetadata::addUserMetadata);
         }
        });

        try
        {
         amazonS3.putObject(path, fileName, inputStream, objectMetadata); //saves the file to Amazon S3 bucket.
        }
        catch (AmazonServiceException e)
        {
         throw new IllegalStateException("Failed to upload the file", e);
        }
    }

    public byte[] download(String path, String key)
    {
     try
        {
         S3Object object = amazonS3.getObject(path, key);
         /* downloads the file from the path passed in and with the
          * file name similar to the key passed in the getObject method.
          */
         S3ObjectInputStream objectContent = object.getObjectContent();
         // gets an inputStream from the object returned from Amazon S3.
         return IOUtils.toByteArray(objectContent);
         //converts the input stream to byteArray that can be sent over Restful APIs.
        }
        catch (AmazonServiceException | IOException e)
        {
         throw new IllegalStateException("Failed to download the file", e);
        }
    }

}//FileStore