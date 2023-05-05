# AWS SDK for Go

The [AWS SDK for Go](https://aws.amazon.com/ru/sdk-for-go/) is a set of tools for developers working with AWS services in Go.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installing {#installation}

{% include [install-go-sdk](../../_includes/aws-tools/install-go-sdk.md)%}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Code samples {#go-code-examples}

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

	// Creating a custom endpoint resolver for returning correct URL for S3 storage in the {{ region-id }} region
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

	// Loading configuration from ~/.aws/*
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
	if err != nil {
		log.Fatal(err)
	}

	// Creating the S3 client
	client := s3.NewFromConfig(cfg)

	// Getting the list of buckets
	result, err := client.ListBuckets(context.TODO(), &s3.ListBucketsInput{})
	if err != nil {
		log.Fatal(err)
	}

	for _, bucket := range result.Buckets {
		log.Printf("bucket=%s creation time=%s", aws.ToString(bucket.Name), bucket.CreationDate.Format("2006-01-02 15:04:05 Monday"))
	}
}
```

 Getting a list of objects in a bucket:

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
	// Getting the bucket name from command line arguments
	bucketName := flag.String("b", "", "The name of the bucket")
	flag.Parse()

	if *bucketName == "" {
		fmt.Println("You must supply the name of a bucket (-b BUCKET)")
		return
	}


	// Creating a custom endpoint resolver for returning the correct URL for S3 storage in the {{ region-id }} region
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

	// Loading configuration from ~/.aws/*
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
	if err != nil {
		log.Fatal(err)
	}

	// Creating the S3 client
	client := s3.NewFromConfig(cfg)

	// Getting the list of buckets
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
