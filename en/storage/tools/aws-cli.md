---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# AWS Command Line Interface (AWS CLI)

[AWS CLI](https://aws.amazon.com/cli/) is a command line interface designed for AWS services. To learn [how to run commands](https://docs.aws.amazon.com/cli/latest/reference/), see the official Amazon documentation.

To work with {{ objstorage-full-name }} via the AWS CLI, you can use the following sets of commands:

- [s3api](https://docs.aws.amazon.com/cli/latest/reference/s3api/index.html): Commands corresponding to operations in the REST API. Before you start, review the [list of supported operations](../s3/api-ref/index.md).
- [s3](https://docs.aws.amazon.com/cli/latest/reference/s3/index.html): Additional commands that make it easier to work with a large number of objects.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

{% include [install-aws-cli](../../_includes/aws-tools/install-aws-cli.md) %}

## Configuration {#setup}

To configure the AWS CLI, use the `aws configure` command. The command requests values for the following parameters:

1. `AWS Access Key ID`: Enter the ID of the key that you received when generating the static key.

1. `AWS Secret Access Key`: Enter the secret key that you received when generating the static key.

1. `Default region name`: Enter `ru-central1`.

   {% note info %}

   To work with Yandex Object Storage, always specify the `ru-central1` region. A different region value may lead to an authorization error.

   {% endnote %}

1. Leave the other parameter values unchanged.

### Configuration files {#config-files}

The `aws configure` command saves your settings to the following files:

- Your static key to the `.aws/credentials` file in the format:

    ```
    [default]
                aws_access_key_id = id
                aws_secret_access_key = secretKey
    ```

- The default region to the `.aws/config` file in the format:

    ```
    [default]
                region=ru-central1
    ```

## Specifics {#specifics}

When using the AWS CLI to work with {{ objstorage-name }}, keep the following in mind:

- The AWS CLI treats {{ objstorage-name }} like a hierarchical file system and object keys look like file paths.
- When running the `aws` command to work with {{ objstorage-name }}, the `--endpoint-url` parameter is required because the client is configured to work with the Amazon servers by default.
- When using macOS, in some cases you need to run the command:

    ```
    export PYTHONPATH=/Library/Python/2.7/site-packages; aws --endpoint-url=https://{{ s3-storage-host }} s3 ls
    ```

## Examples of operations {#aws-cli-examples}

{% note info %}

To enable debug output in the console, use the `--debug` key.

{% endnote %}

### Creating a bucket {#creating-bucket}

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 mb s3://bucket-name
   ```

{% note info %}

When creating a bucket, follow the [naming conventions](../concepts/bucket.md#naming).

{% endnote %}

### Uploading objects {#uploading-objects}

You can upload objects using one of the following methods:

- Upload all objects from a local directory:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
   ```
- Upload objects specified in the `--include` filter and skip objects specified in the `--exclude` filter:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 cp --recursive --exclude "*" --include "*.log" \
       local_files/ s3://bucket-name/path_style_prefix/
   ```
- Upload objects one by one, running the following command for each object:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
   ```

### Getting a list of objects {#getting-objects-list}

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 ls --recursive s3://bucket-name
   ```

### Deleting objects {#deleting-objects}

You can delete objects using one of the following methods:

- Delete all objects with the specified prefix:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 rm s3://bucket-name/path_style_prefix/ --recursive
   ```
- Delete objects specified in the `--include` filter and skip objects specified in the `--exclude` filter:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 rm s3://bucket-name/path_style_prefix/ --recursive \
       --exclude "*" --include "*.log"
   ```
- Delete objects one by one, running the following command for each object:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 rm s3://bucket-name/path_style_prefix/textfile.txt
   ```

### Retrieving an object {#retrieving-objects}

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
       s3 cp s3://bucket-name/textfile.txt textfile.txt
   ```

