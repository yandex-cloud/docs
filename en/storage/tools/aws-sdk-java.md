---
title: AWS SDK for Java
description: In this article, you will learn what the AWS SDK for Java is, how to install and configure it, and will also see some code examples.
---

# AWS SDK for Java


The [AWS SDK for Java](https://aws.amazon.com/ru/sdk-for-java/) is an {{ objstorage-full-name }}-compatible software development kit for integration with AWS services.

You will use the AWS SDK for Java to create a bucket, upload objects to it, clean up its contents, and delete it.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% note warning %}

On December 31, 2025, the AWS SDK for Java version 1.x will reach end-of-support. We recommend that you migrate to the AWS SDK for Java version 2.x to keep receiving new features and security updates.

{% endnote %}

{% list tabs group=instructions %}

- AWS SDK v2.x {#sdk-v2}

    {% include [install-java-sdk-v2](../../_includes/aws-tools/install-java-sdk-v2.md) %}

- AWS SDK v1.x {#sdk-v1}
    
    {% include [install-java-sdk-v1](../../_includes/aws-tools/install-java-sdk.md) %}

{% endlist %}

## Configuration {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Updating an endpoint {#adapt-code}

{% list tabs group=instructions %}

- AWS SDK v2.x {#sdk-v2}

    1. In the `/src/main/java/org/example` directory, open the `DependencyFactory.java` file and modify the `DependencyFactory` class:

        ```java
        public class DependencyFactory {
            private DependencyFactory() {}
            public static S3Client s3Client() {
                return S3Client.builder()
                .endpointOverride(URI.create("https://{{ s3-storage-host }}"))
                .httpClientBuilder(ApacheHttpClient.builder())
                .build();
            }
        }
        ```

    1. [Run the code](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-run) as described in the AWS guide.

    See [this repository](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/javav2/example_code/s3/src/main/java/com/example/s3) for other examples of using the AWS SDK for Java.

- AWS SDK v1.x {#sdk-v1}
    
    In the `aws-java-sdk/samples/AmazonS3` directory, the SDK distribution archive contains the code you need to modify.

    To connect to {{ objstorage-name }}, replace the code in the example:

    ```java
    AmazonS3 s3 = AmazonS3ClientBuilder.standard()
        .withCredentials(new AWSStaticCredentialsProvider(credentials))
        .withRegion("us-west-2")
        .build();
    ```

    with

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

    See [this repository](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/java/example_code/s3/src/main/java/aws/example/s3) for other examples of using the AWS SDK for Java.

{% endlist %}