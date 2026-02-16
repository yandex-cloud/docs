---
title: AWS SDK for C++
description: In this article, you will learn what the AWS SDK for C++ is, how to install and configure it, and will also see some code examples.
author: alehay
---

# AWS SDK for C++


The [AWS SDK for C++](https://aws.amazon.com/ru/sdk-for-cpp/) is a software development kit for integration with AWS services.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-cpp-sdk](../../_includes/aws-tools/install-cpp-sdk.md)%}

## Configuration {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Code examples {#cpp-sdk-examples}

[See C++ code examples](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/cpp/example_code/s3) from the developer to interface with S3.

Below is an example of a simple program that illustrates the differences in settings for {{ objstorage-full-name }}.

### CmakeLists

```cmake
cmake_minimum_required(VERSION 3.8)
project("s3-examples")
set(CMAKE_CXX_STANDARD 20)

if(NOT BUILD_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ON)
endif()

find_package(AWSSDK REQUIRED COMPONENTS s3 sts)

add_executable(EXAMPLE EXAMPLE_FILE_S3.cpp)

target_link_libraries(EXAMPLE ${AWSSDK_LINK_LIBRARIES}
${AWSSDK_PLATFORM_DEPS})
```

### File EXAMPLE_FILE_S3.cpp

```cpp
#include <aws/core/Aws.h>
#include <aws/core/auth/AWSCredentialsProvider.h>
#include <aws/s3/S3Client.h>
#include <aws/s3/model/Bucket.h>
#include <aws/s3/model/CreateBucketConfiguration.h>
#include <aws/s3/model/CreateBucketRequest.h>
#include <aws/s3/model/DeleteBucketRequest.h>
#include <aws/s3/model/ListObjectsRequest.h>
#include <aws/s3/model/PutObjectRequest.h>
#include <sys/stat.h>

#include <fstream>
#include <iostream>


// Finds the bucket and outputs its contents in the console
bool FindTheBucket(const Aws::S3::S3Client& s3Client, const Aws::String& bucketName)
{
    Aws::S3::Model::ListBucketsOutcome outcome = s3Client.ListBuckets();
    Aws::S3::Model::ListObjectsRequest request;

    if (outcome.IsSuccess()) {
        std::cout << "Looking for a bucket named '" << bucketName << "'..." << std::endl;

        Aws::Vector<Aws::S3::Model::Bucket> bucket_list = outcome.GetResult().GetBuckets();
        for (Aws::S3::Model::Bucket const& bucket : bucket_list) {
            if (bucket.GetName() == bucketName) {
                request.WithBucket(bucketName);
                std::cout << "Found the bucket." << std::endl << std::endl;

                auto outcome_obj = s3Client.ListObjects(request);
                std::cout << "Objects in bucket '" << bucketName << "':" << std::endl;

                Aws::Vector<Aws::S3::Model::Object> objects = outcome_obj.GetResult().GetContents();
                for (Aws::S3::Model::Object& object : objects) {
                    std::cout << object.GetKey() << std::endl;
                }
                return true;
            }
        }

        std::cout << "Could not find the bucket." << std::endl << std::endl;
        return true;
    } else {
        std::cout << "ListBuckets error: " << outcome.GetError().GetMessage() << std::endl;
    }
    return false;
}

int main(int argc, char* argv[])
{
    Aws::SDKOptions options;
    Aws::InitAPI(options);
    {

        // Settings section for using the AWS SDK with Object Storage
        Aws::Client::ClientConfiguration config;
        config.region = Aws::String("{{ region-id }}");
        config.endpointOverride = Aws::String("{{ s3-storage-host }}");

        Aws::String bucket_name = "bucket_name";
        // Initializing a connection
        Aws::S3::S3Client s3_client(config);

        FindTheBucket(s3_client, bucket_name);
    }
    Aws::ShutdownAPI(options);

    return 0;
}
```