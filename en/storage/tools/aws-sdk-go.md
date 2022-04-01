# AWS SDK for Go

[The AWS SDK for Go](https://aws.amazon.com/ru/sdk-for-go/) is a set of tools for developers working with AWS services.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

{% include [install-go-sdk](../../_includes/aws-tools/install-go-sdk.md)%}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Code samples {#code-examples}

List of bucket names:

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

	// Create custom endpoint resolver for returning correct URL for S3 storage in ru-central1 region
	customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
		if service == s3.ServiceID && region == "ru-central1" {
			return aws.Endpoint{
				PartitionID:   "yc",
				URL:           "https://storage.yandexcloud.net",
				SigningRegion: "ru-central1",
			}, nil
		}
		return aws.Endpoint{}, fmt.Errorf("unknown endpoint requested")
	})

	// Loading configuration from ~/.aws/*
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
	if err != nil {
		log.Fatal(err)
	}

	// Creating S3 client
	client := s3.NewFromConfig(cfg)

	// Get buckets list
	result, err := client.ListBuckets(context.TODO(), &s3.ListBucketsInput{})
	if err != nil {
		log.Fatal(err)
	}

	for _, bucket := range result.Buckets {
		log.Printf("backet=%s creation time=%s", aws.ToString(bucket.Name), bucket.CreationDate.Format("2006-01-02 15:04:05 Monday"))
	}
}
```

List of objects in bucket:

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
	// Get bucket name from command line arguments
	bucketName := flag.String("b", "", "The name of the bucket")
	flag.Parse()

	if *bucketName == "" {
		fmt.Println("You must supply the name of a bucket (-b BUCKET)")
		return
	}


	// Create custom endpoint resolver for returning correct URL for S3 storage in ru-central1 region
	customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
		if service == s3.ServiceID && region == "ru-central1" {
			return aws.Endpoint{
				PartitionID:   "yc",
				URL:           "https://storage.yandexcloud.net",
				SigningRegion: "ru-central1",
			}, nil
		}
		return aws.Endpoint{}, fmt.Errorf("unknown endpoint requested")
	})

	// Load configuration from ~/.aws/*
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
	if err != nil {
		log.Fatal(err)
	}

	// Create S3 client
	client := s3.NewFromConfig(cfg)

	// Get objects list from bucket
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


See also the [code samples](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/gov2/s3) and [Go SDK API Reference Guide](https://pkg.go.dev/github.com/aws/aws-sdk-go-v2/service/s3).

