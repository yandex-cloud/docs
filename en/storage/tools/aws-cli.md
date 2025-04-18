---
title: AWS Command Line Interface (AWS CLI)
description: In this article, you will learn about the AWS Command Line Interface (AWS CLI), how to install and configure it, explore some of its features when working with {{ objstorage-name }} and example operations.
---

# AWS Command Line Interface (AWS CLI)


The [AWS CLI](https://aws.amazon.com/cli/) is a command line interface designed for AWS services. To learn [how to run commands](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html), see the official Amazon documentation.

To work with {{ objstorage-name }} via the AWS CLI, you can use the following commands:
* [s3api](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/index.html): Commands corresponding to operations in the REST API. Before you start, look through the [list of supported operations](../s3/api-ref/index.md).
* [s3](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html): Additional commands that make it easier to work with a large number of objects.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-aws-cli](../../_includes/aws-tools/install-aws-cli.md) %}

## Configuration {#setup}

To configure the AWS CLI, run the `aws configure` command in your terminal. The command will request values for the following parameters:
1. `AWS Access Key ID`: Static key ID [you got previously](#before-you-begin).
1. `AWS Secret Access Key`: Static key contents [you got previously](#before-you-begin).
1. `Default region name`: `{{ region-id }}`.

    To work with {{ objstorage-name }}, always specify the `{{ region-id }}`. A different region value may lead to an authorization error.

1. Leave the other parameters unchanged.

### Configuration files {#config-files}

The `aws configure` command saves the static key and the region.
* The static key in `.aws/credentials` has the following format:

  ```ini
  [default]
  aws_access_key_id = <static_key_ID>
  aws_secret_access_key = <static_key_contents>
  ```

* The default region in `.aws/config` has the following format:

  ```ini
  [default]
  region = {{ region-id }}
  ```


{% include [store-aws-key-in-lockbox](../../_includes/storage/store-aws-key-in-lockbox.md) %}


### Setting up an additional profile

You can create multiple AWS CLI profiles with the following command:

  ```bash
  aws configure --profile <profile_name>
  ```

The profile data will be saved to the `.aws/credentials` and `.aws/config` files as follows:
* `credentials`:

  ```ini
  [default]
  aws_access_key_id = <ID_of_static_key_1>
  aws_secret_access_key = <contents_of_static_key_1>
  [<name_of_profile_2>]
  aws_access_key_id = <ID_of_static_key_2>
  aws_secret_access_key = <contents_of_static_key_2>
  ...
  [<name_of_profile_n>]
  aws_access_key_id = <ID_of_static_key_n>
  aws_secret_access_key = <contents_of_static_key_n>
  ```

* `config`:

  ```ini
  [default]
  region = {{ region-id }}
  [profile <name_of_profile_2>]
  region = {{ region-id }}
  ...
  [profile <name_of_profile_n>]
  region = us-east-1
  ```

  Where `default` is the default profile.

To switch between profiles, the AWS CLI commands use the `--profile` option, e.g.:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    --profile <name_of_profile_2> \
    s3 mb s3://<bucket_name>
  ```

## Features {#specifics}

Take note of these AWS CLI features when used with {{ objstorage-name }}:

* The AWS CLI treats {{ objstorage-name }} as a hierarchical file system and object keys look like file paths.
* By default, the client is configured to work with Amazon servers. Therefore, when running the `aws` command to work with {{ objstorage-name }}, make sure to use the `--endpoint-url` parameter. To avoid adding the parameter manually each time you run the command, you can use a configuration file or an alias.
    * In the `.aws/config` configuration file, add the `endpoint_url` parameter (this is supported by the AWS CLI versions 1.29.0, 2.13.0, and higher):

       ```text
       endpoint_url = https://{{ s3-storage-host }}
       ```

       This enables you to invoke commands without explicitly specifying an endpoint. For example, you can specify `aws s3 ls` instead of `aws --endpoint-url=https://{{ s3-storage-host }} s3 ls`. For more information, see the [AWS CLI](https://docs.aws.amazon.com/sdkref/latest/guide/feature-ss-endpoints.html) documentation.

    * Create an alias using the following command:

      ```bash
      alias {{ storage-aws-cli-alias }}='aws s3 --endpoint-url=https://{{ s3-storage-host }}'
      ```

      To create an alias each time you open the terminal, add the `alias` command to the configuration file, which can be either `~/.bashrc` or `~/.zshrc`, depending on the type of shell you are using.

      When using this alias, the following commands are equivalent:

      ```bash
      aws s3 --endpoint-url=https://{{ s3-storage-host }} ls
      ```

      ```bash
      {{ storage-aws-cli-alias }} ls
      ```

## Examples of operations {#aws-cli-examples}

{% note info %}

To enable debug output in the console, use the `--debug` key.

{% endnote %}

### Creating a bucket {#creating-bucket}

```bash
aws s3 mb s3://bucket-name
```

Result:

```text
make_bucket: bucket-name
```

{% note info %}

When creating a bucket, follow the [naming conventions](../concepts/bucket.md#naming).

{% endnote %}

### Uploading objects {#uploading-objects}

You can upload all objects within a directory, use a filter, or upload objects one at a time.
* Upload all objects from a local directory:

  ```bash
  aws s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
  ```

  Result:

  ```text
  upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
  upload: ./textfile2.txt to s3://bucket-name/path_style_prefix/textfile2.txt
  upload: ./prefix/textfile3.txt to s3://bucket-name/path_style_prefix/prefix/textfile3.txt
  ```

* Upload objects specified in the `--include` filter and skip objects specified in the `--exclude` filter:

  ```bash
  aws s3 cp --recursive --exclude "*" --include "*.log" \
    local_files/ s3://bucket-name/path_style_prefix/
  ```

  Result:

  ```text
  upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
  ```

* Upload objects one by one, running the following command for each object:

  ```bash
  aws s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
  ```

  Result:

  ```text
  upload: ./testfile.txt to s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Getting a list of objects {#getting-objects-list}

```bash
aws s3 ls --recursive s3://bucket-name
```

Result:
```text
2022-09-05 17:10:34      10023 other/test1.png
2022-09-05 17:10:34      57898 other/test2.png
2022-09-05 17:10:34     704651 test.png
```

### Deleting objects {#deleting-objects}

You can delete all objects with a specified prefix, use a filter, or delete objects one at a time.

* Delete all objects with the specified prefix:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/ --recursive
  ```

  Result:

  ```text
  delete: s3://bucket-name/path_style_prefix/test1.png
  delete: s3://bucket-name/path_style_prefix/subprefix/test2.png
  ```

* Delete objects specified in the `--include` filter and skip objects specified in the `--exclude` filter:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/ --recursive \
      --exclude "*" --include "*.log"
  ```

  Result:

  ```text
  delete: s3://bucket-name/path_style_prefix/test1.log
  delete: s3://bucket-name/path_style_prefix/subprefix/test2.log
  ```

* Delete objects one by one, running the following command for each object:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/textfile.txt
  ```

  Result:

  ```text
  delete: s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Retrieving an object {#retrieving-objects}

```bash
aws s3 cp s3://bucket-name/textfile.txt textfile.txt
```
Result:

```text
download: s3://bucket-name/path_style_prefix/textfile.txt to ./textfile.txt
```


## See also {#see-also}

* [{#T}](../quickstart/quickstart-aws-cli.md)
