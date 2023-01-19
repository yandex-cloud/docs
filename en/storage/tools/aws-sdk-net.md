# AWS SDK for .NET

The [AWS SDK for NET](https://aws.amazon.com/sdk-for-net/) is a set of tools for developers working with AWS services.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

{% include [install-net-sdk](../../_includes/aws-tools/install-net-sdk.md)%}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-s3-url.md) %}

## Code samples {#net-sdk-examples}

To connect to {{ objstorage-name }}, use the code

```csharp
AmazonS3Config configsS3 = new AmazonS3Config {
    ServiceURL = "https://s3.yandexcloud.net"
};

AmazonS3Client s3client = new AmazonS3Client(configsS3);
```
