# AWS SDK for Java

[The AWS SDK for Java](https://aws.amazon.com/sdk-for-java/) is a set of tools for developers working with AWS services.

## Before you start {#preparations}

[!INCLUDE [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md)]

## Installation {#installation}

To install the AWS SDK for JAVA, follow the [instructions](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-install.html) on the manufacturer's website.

> [!NOTE]
>
>Install SDK 1.11.336 or higher.

## Setup {#setup}

[!INCLUDE [storage-sdk-setup](../_includes_service/storage-sdk-setup.md)]

## Code examples {#java-sdk-examples}

For sample code, see `aws-java-sdk/samples/AmazonS3` in the archive with the SDK distribution package.

To connect to [!KEYREF objstorage-name], the code in the example

```cpp
AmazonS3 s3 = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(credentials))
    .withRegion("us-west-2")
    .build();
```

should be replaced with

```cpp
AmazonS3 s3 = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(credentials))
    .withEndpointConfiguration(
        new AmazonS3ClientBuilder.EndpointConfiguration(
            "[!KEYREF s3-storage-host]","us-east-1"
        )
    )
    .build();
```

