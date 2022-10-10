package com.cloud.project.configs;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AmazonConfig
{
 @Value("${amazon.aws.access-key}")
 private String accessKeyId;

 @Value("${amazon.aws.secret-key}")
 private String accessKeySecret;

 @Value("${amazon.aws.region}")
 private String s3RegionName;
 @Bean
 public AmazonS3 s3()
 {
  AWSCredentials awsCredentials =
     new BasicAWSCredentials(accessKeyId,accessKeySecret);
  return AmazonS3ClientBuilder
     .standard()
     .withRegion(s3RegionName)
     .withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
     .build();

 }

 /*
 * First, we need to create a client connection to access the Amazon S3 web service.
 * We'll use the AmazonS3 interface for this purpose:
 * */
}
