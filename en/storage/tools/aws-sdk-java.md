---
title: AWS SDK for Java
description: In this tutorial, you will learn what the AWS SDK for Java is, how to install and configure it, and will also see some code snippets.
---

# AWS SDK for Java


The [AWS SDK for Java](https://aws.amazon.com/ru/sdk-for-java/) is a software development kit for integration with AWS services.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-java-sdk](../../_includes/aws-tools/install-java-sdk.md)%}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}


## Code snippets {#java-sdk-examples}

The sample code is located in the `aws-java-sdk/samples/AmazonS3` folder in the SDK distribution archive.

To connect to {{ objstorage-name }}, replace the code in the sample:

```java
AmazonS3 s3 = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(credentials))
    .withRegion("us-west-2")
    .build();
```

to

```java
AmazonS3 s3 = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(credentials))
    .withEndpointConfiguration(
        new AmazonS3ClientBuilder.EndpointConfiguration(
            "{{ s3-storage-host }}","{{ region-id }}"
        )
    )
    .build();
```

