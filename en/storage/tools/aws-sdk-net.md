---
title: AWS SDK for .NET
description: In this tutorial, you will learn about the AWS SDK for .NET, how to install and configure it, and will also see some code snippets.
---

# AWS SDK for .NET


The [AWS SDK for NET](https://aws.amazon.com/sdk-for-net/) is a software development kit for integration with AWS services.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-net-sdk](../../_includes/aws-tools/install-net-sdk.md)%}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-s3-url.md) %}

## Things to consider {#features}

* The AWS SDK for .NET incorrectly handles lifecycle configurations that contain no rule description (ID). Make sure to add a description to each lifecycle rule.
* To access {{ objstorage-name }}, for example, when working with the `AmazonS3Config` class, use the `{{ s3-dotnet-sdk-host }}` address.

## Code snippets {#net-sdk-examples}

To connect to {{ objstorage-name }}, use this code:

```csharp
AmazonS3Config configsS3 = new AmazonS3Config {
    ServiceURL = "https://{{ s3-dotnet-sdk-host }}"
};

AmazonS3Client s3client = new AmazonS3Client(configsS3);
```
