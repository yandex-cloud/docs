---
title: AWS SDK for Go
description: In this article, you will learn what the AWS SDK for Go is, how to install and configure it, and will also see some code examples.
---

# AWS SDK for Go


The [AWS SDK for Go](https://docs.aws.amazon.com/sdk-for-go/) is a software development kit for integration with AWS services in Go.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-go-sdk](../../_includes/aws-tools/install-go-sdk.md)%}

## Configuration {#setup}

### Configuring a directory for authentication data

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

{% include [storage-sdk-setup-storage-env-variables](../_includes_service/storage-sdk-setup-storage-env-variables.md) %}

## Code snippets {#go-code-examples}

[AWS SDK v.1](https://github.com/aws/aws-sdk-go) for Go entered maintenance mode in July 2024. We recommend migrating to [AWS SDK v.2](https://github.com/aws/aws-sdk-go-v2).

#### Getting a list of bucket names {#list-buckets}

{% list tabs group=interface_relevance %}

- AWS SDK v.2 {#contemporary}

  ```go
  package main

  import (
      "context"
      "log"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {

      // Loading the configuration from ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO())
      if err != nil {
          log.Fatal(err)
      }

      // Creating a client to access the S3 storage
      client := s3.NewFromConfig(cfg)

      // Requesting a list of buckets
      result, err := client.ListBuckets(context.TODO(), &s3.ListBucketsInput{})
      if err != nil {
          log.Fatal(err)
      }

      for _, bucket := range result.Buckets {
          log.Printf("bucket=%s creation time=%s", aws.ToString(bucket.Name), bucket.CreationDate.Local().Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

- AWS SDK v.1 {#deprecated}

  ```go
  package main

  import (
      "context"
      "fmt"
      "log"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {

      // Creating a custom endpoint resolver to return the correct URL for S3 and {{ region-id }}
      customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
          if service == s3.ServiceID && region == "{{ region-id }}" {
              return aws.Endpoint{
                  PartitionID:   "yc",
                  URL:           "https://{{ s3-storage-host }}",
                  SigningRegion: "{{ region-id }}",
              }, nil
          }
          return aws.Endpoint{}, fmt.Errorf("unknown endpoint requested")
      })

      // Loading the configuration from ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
      if err != nil {
          log.Fatal(err)
      }

      // Creating a client to access the S3 storage
      client := s3.NewFromConfig(cfg)

      // Requesting a list of buckets
      result, err := client.ListBuckets(context.TODO(), &s3.ListBucketsInput{})
      if err != nil {
          log.Fatal(err)
      }

      for _, bucket := range result.Buckets {
          log.Printf("bucket=%s creation time=%s", aws.ToString(bucket.Name), bucket.CreationDate.Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

{% endlist %}

#### Getting a list of bucket objects {#list-buckets}

To get a list of objects in a bucket, provide its name in the `-b` command line parameter.

{% list tabs group=interface_relevance %}

- AWS SDK v.2 {#contemporary}

  ```go
  package main

  import (
      "context"
      "flag"
      "fmt"
      "log"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {
      // Getting the bucket name from the command line argument
      bucketName := flag.String("b", "", "The name of the bucket")
      flag.Parse()

      if *bucketName == "" {
          fmt.Println("You must supply the name of a bucket (-b BUCKET)")
          return
      }

      // Loading the configuration from ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO())
      if err != nil {
          log.Fatal(err)
      }

      // Creating a client to access the S3 storage
      client := s3.NewFromConfig(cfg)

      // Requesting a list of all bucket files
      result, err := client.ListObjectsV2(context.TODO(), &s3.ListObjectsV2Input{
          Bucket: aws.String(*bucketName),
      })
      if err != nil {
          log.Fatal(err)
      }

      for _, object := range result.Contents {
          log.Printf("object=%s size=%d Bytes last modified=%s", aws.ToString(object.Key), aws.ToInt64(object.Size), object.LastModified.Local().Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

- AWS SDK v.1 {#deprecated}

  ```go
  package main

  import (
      "context"
      "fmt"
      "log"
      "flag"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {
      // Getting the bucket name from the command line argument
      bucketName := flag.String("b", "", "The name of the bucket")
      flag.Parse()

      if *bucketName == "" {
          fmt.Println("You must supply the name of a bucket (-b BUCKET)")
          return
      }

      // Creating a custom endpoint resolver to return the correct URL for S3 and {{ region-id }}
      customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
          if service == s3.ServiceID && region == "{{ region-id }}" {
              return aws.Endpoint{
                  PartitionID:   "yc",
                  URL:           "https://{{ s3-storage-host }}",
                  SigningRegion: "{{ region-id }}",
              }, nil
          }
          return aws.Endpoint{}, fmt.Errorf("unknown endpoint requested")
      })

      // Loading the configuration from ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
      if err != nil {
          log.Fatal(err)
      }

      // Creating a client to access the S3 storage
      client := s3.NewFromConfig(cfg)

      // Requesting a list of all bucket files
      result, err := client.ListObjectsV2(context.TODO(), &s3.ListObjectsV2Input{
          Bucket: aws.String(*bucketName),
      })
      if err != nil {
          log.Fatal(err)
      }

      for _, object := range result.Contents {
          log.Printf("object=%s size=%d Bytes last modified=%s", aws.ToString(object.Key), object.Size, object.LastModified.Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

{% endlist %}

See also the [code samples](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/gov2/s3) and [Go SDK API Reference Guide](https://pkg.go.dev/github.com/aws/aws-sdk-go-v2/service/s3).