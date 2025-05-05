---
title: AWS SDK for .NET
description: In this article, you will learn about the AWS SDK for .NET, how to install and configure it, and will also see some code examples.
---

# AWS SDK for .NET


The [AWS SDK for NET](https://aws.amazon.com/sdk-for-net/) is a software development kit for integration with AWS services.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-net-sdk](../../_includes/aws-tools/install-net-sdk.md)%}

## Configuration {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-s3-url.md) %}

## Features {#features}

* The AWS SDK for .NET incorrectly handles lifecycle configurations that contain no rule description (ID). Make sure to add a description to each lifecycle rule.
* To access {{ objstorage-name }}, e.g., when working with the `AmazonS3Config` class, use the `{{ s3-dotnet-sdk-host }}` address.

## Code examples {#net-sdk-examples}

To connect to {{ objstorage-name }}, use this code:

```csharp
AmazonS3Config configsS3 = new AmazonS3Config {
    ServiceURL = "https://{{ s3-dotnet-sdk-host }}"
};

AmazonS3Client s3client = new AmazonS3Client(configsS3);
```

Here is an example of a .NET AWS SDK based program that, when you run it, will create a bucket, upload an object into it, delete the object, and delete the bucket:

```csharp
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;

namespace Example
{
    public static class Program
    {
        public static async Task Main()
        {
            var testBucketName = "your-unique-bucket-name";
            var uploadObjectKey = "object-key";
            AmazonS3Client s3client = null;

            try
            {
                // Configuring your S3 client
                AmazonS3Config configsS3 = new AmazonS3Config {
                    ServiceURL = "https://{{ s3-dotnet-sdk-host }}",
                };
                s3client = new AmazonS3Client(configsS3);

                // Creating a bucket
                Console.WriteLine($"Creating bucket {testBucketName}");
                try 
                {
                    await s3client.PutBucketAsync(new PutBucketRequest
                    {
                        BucketName = testBucketName,
                        UseClientRegion = true
                    });
                    Console.WriteLine($"Bucket '{testBucketName}' created successfully.");
                }
                catch (AmazonS3Exception ex) when (ex.StatusCode == System.Net.HttpStatusCode.Conflict)
                {
                    Console.WriteLine($"Bucket '{testBucketName}' already exists. Continuing with existing bucket.");
                }

                // Uploading an object
                Console.WriteLine($"Uploading object to bucket '{testBucketName}'.");
                try
                {
                    await s3client.PutObjectAsync(new Amazon.S3.Model.PutObjectRequest
                    {
                        BucketName = testBucketName,
                        Key = uploadObjectKey,
                        ContentBody = "Hello World!"
                    });
                    Console.WriteLine("Object was uploaded successfully.");
                }
                catch (AmazonS3Exception ex)
                {
                    Console.WriteLine($"Error uploading object: {ex.Message}");
                    throw; // Re-throw to be caught by outer try-catch
                }

                // Deleting the object
                Console.WriteLine($"Deleting object with key '{uploadObjectKey}'");
                try
                {
                    await s3client.DeleteObjectAsync(new Amazon.S3.Model.DeleteObjectRequest
                    {
                        BucketName = testBucketName,
                        Key = uploadObjectKey
                    });
                    Console.WriteLine($"Object with key '{uploadObjectKey}' was deleted successfully");
                }
                catch (AmazonS3Exception ex)
                {
                    Console.WriteLine($"Error deleting object: {ex.Message}");
                    throw; // Re-throw to be caught by outer try-catch
                }
                
                // Deleting the bucket
                Console.WriteLine($"Deleting bucket with name '{testBucketName}'");
                try
                {
                    await s3client.DeleteBucketAsync(new Amazon.S3.Model.DeleteBucketRequest
                    {
                        BucketName = testBucketName
                    });
                    Console.WriteLine($"Bucket '{testBucketName}' was deleted successfully");
                }
                catch (AmazonS3Exception ex)
                {
                    Console.WriteLine($"Error deleting bucket: {ex.Message}");
                    // If you need to forcibly delete a non-empty bucket, you can add the code here
                    throw; // Re-throw to be caught by outer try-catch
                }
            }
            catch (AmazonS3Exception ex)
            {
                Console.WriteLine($"Amazon S3 Error: {ex.ErrorCode}, Message: {ex.Message}");
                Console.WriteLine($"Status code: {ex.StatusCode}, Request ID: {ex.RequestId}");
            }
            catch (AmazonServiceException ex)
            {
                Console.WriteLine($"Amazon Service Error: {ex.ErrorCode}, Message: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"General error: {ex.Message}");
                Console.WriteLine(ex.StackTrace);
            }
            finally
            {
                // Disposing of resources correctly
                s3client?.Dispose();
            }
        }
    }
}
```

## See also {#see-also}

* [Examples of employing AWS SDK for .NET in AWS articles](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/csharp_code_examples.html)