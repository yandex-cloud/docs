# AWS SDK for Java

The [AWS SDK for Java](https://aws.amazon.com/sdk-for-java/) is a set of tools for developers working with AWS services.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

{% include [install-java-sdk](../../_includes/aws-tools/install-java-sdk.md)%}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}


## Code samples {#java-sdk-examples}

For a code sample, see `aws-java-sdk/samples/AmazonS3` in the archive with the SDK distribution package.

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

