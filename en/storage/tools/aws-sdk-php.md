---
title: AWS SDK for PHP
description: In this tutorial, you will learn about the AWS SDK for PHP, how to install and configure it, and will also see some code snippets.
---

# AWS SDK for PHP


The [AWS SDK for PHP](https://aws.amazon.com/sdk-for-php/) is a software development kit for integration with AWS services.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-php-sdk](../../_includes/aws-tools/install-php-sdk.md)%}

## Setup {#setup}

1. In the `.aws` directory, create a file named `credentials`, copy the credentials you [got earlier](#before-you-begin), and paste them into it:

   ```
   [default]
   aws_access_key_id = <key_ID>
   aws_secret_access_key = <secret_key>
   ```

1. If using a LAMP image from {{ marketplace-name }}, add the `HOME` environment variable referring to your home folder to the Apache `httpd.conf` configuration file (`apache2.conf` for Debian and Ubuntu):

   ```
   SetEnv HOME <home_folder>
   ```
   
   For more information about the location and name of the Apache configuration file for different operating systems, see the [Apache HTTP Server Wiki](https://cwiki.apache.org/confluence/display/HTTPD/DistrosDefaultLayout).

You can use the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables instead of the `.aws/credentials` file.

Use the {{ objstorage-name }} address to access `{{ s3-storage-host }}`.

## Code snippets {#code-examples}

{% list tabs %}

- List of bucket names

  Make sure to include your project path in the `autoload.php` file's connection string:

  ```php
  <?php

  // We assume that the AWS SDK is installed via Composer

  require "<project_path>/vendor/autoload.php";
  use Aws\S3\S3Client;

  $s3 = new S3Client([
      "version" => "latest",
      "endpoint" => "https://storage.yandexcloud.net",
      "region" => "ru-central1",
  ]);

  $buckets = $s3->listBuckets();
  $bucket_count = 1;

  echo "<b>Well, here are your buckets:</b></br></br>";
  foreach ($buckets["Buckets"] as $bucket) {
      echo $bucket_count . ". " . $bucket["Name"] . "</br>";
      $bucket_count++;
  }

  ?>
  ```

{% endlist %}

See also the [code snippets](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/s3-examples.html) and [PHP API Reference Guide](https://docs.aws.amazon.com/aws-sdk-php/v3/api/index.html) in the AWS documentation.