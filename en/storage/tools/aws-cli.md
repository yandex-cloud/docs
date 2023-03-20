# AWS Command Line Interface (AWS CLI)

[AWS CLI](https://aws.amazon.com/cli/) is a command line interface for working with AWS services. To learn [how to run commands](https://docs.aws.amazon.com/cli/latest/reference/), see the official Amazon documentation.

To work with {{ objstorage-name }} via the AWS CLI, you can use the following sets of commands:
* [s3api](https://docs.aws.amazon.com/cli/latest/reference/s3api/index.html): Commands corresponding to operations in the REST API. Before you start, look through the [list of supported operations](../s3/api-ref/index.md).
* [s3](https://docs.aws.amazon.com/cli/latest/reference/s3/index.html): Additional commands that make it easier to work with a large number of objects.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

{% include [install-aws-cli](../../_includes/aws-tools/install-aws-cli.md) %}

## Setup {#setup}

To configure the AWS CLI, enter the `aws configure` command. The command requests values for the following parameters:
1. `AWS Access Key ID`: ID of a static key created [when getting started](#before-you-begin).
1. `AWS Secret Access Key`: the contents of the static key.
1. `Default region name`: `{{ region-id }}` region.

   {% note info %}

   To work with {{ objstorage-name }}, always specify `{{ region-id }}` as the region. A different region value may lead to an authorization error.

   {% endnote %}

1. Leave the other parameter values unchanged.

### Configuration files {#config-files}

The `aws configure` command saves the following data:
* Your static key to the `.aws/credentials` file in the format:

   ```
   [default]
     aws_access_key_id = id
     aws_secret_access_key = secretKey
   ```

* The default region to the `.aws/config` file in the format:

   ```
   [default]
     region={{ region-id }}
   ```

## Specifics {#specifics}

When using the AWS CLI to work with {{ objstorage-name }}, keep the following in mind:
* The AWS CLI treats {{ objstorage-name }} like a hierarchical file system and object keys look like file paths.
* When running the `aws` command to work with {{ objstorage-name }}, the `--endpoint-url` parameter is required because the client is configured to work with the Amazon servers by default. To avoid specifying the parameter manually at each run, create an alias, for example:

   ```bash
   alias {{ storage-aws-cli-alias }}='aws s3 --endpoint-url=https://{{ s3-storage-host }}'
   ```

   The following two commands have the same authority with this alias:

   ```bash
   aws s3 --endpoint-url=https://{{ s3-storage-host }} ls
   ```

   ```bash
   {{ storage-aws-cli-alias }} ls
   ```

   To have an alias created each time the terminal runs, add the `alias` command to the configuration file `~/.bashrc` or `~/.zshrc`, depending on the type of shell.

* When using macOS, in some cases you need to run the command:

   ```bash
   export PYTHONPATH=/Library/Python/2.7/site-packages; aws --endpoint-url=https://{{ s3-storage-host }} s3 ls
   ```

## Example operations {#aws-cli-examples}

{% note info %}

To enable debug output in the console, use the `--debug` key.

{% endnote %}

### Creating a bucket {#creating-bucket}

```bash
aws --endpoint-url=https://{{ s3-storage-host }} s3 mb s3://bucket-name
```

Result:

```text
make_bucket: bucket-name
```

{% note info %}

When creating a bucket, follow the [naming conventions](../concepts/bucket.md#naming).

{% endnote %}

### Uploading objects {#uploading-objects}

You can upload objects using one of the following methods:
* Upload all objects from a local directory:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
   ```

   Result:

   ```text
   upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
   upload: ./textfile2.txt to s3://bucket-name/path_style_prefix/textfile2.txt
   upload: ./prefix/textfile3.txt to s3://bucket-name/path_style_prefix/prefix/textfile3.txt
   ```

* Upload objects specified in the `--include` filter and skip objects specified in the `--exclude` filter:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 cp --recursive --exclude "*" --include "*.log" \
     local_files/ s3://bucket-name/path_style_prefix/
   ```

   Result:

   ```text
   upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
   ```

* Upload objects one by one, running the following command for each object:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
   ```

   Result:

   ```text
   upload: ./testfile.txt to s3://bucket-name/path_style_prefix/textfile.txt
   ```

### Getting a list of objects {#getting-objects-list}

```bash
aws --endpoint-url=https://{{ s3-storage-host }} \
  s3 ls --recursive s3://bucket-name
```

Result:

```text
2022-09-05 17:10:34      10023 other/test1.png
2022-09-05 17:10:34      57898 other/test2.png
2022-09-05 17:10:34     704651 test.png
```

### Deleting objects {#deleting-objects}

You can delete objects using one of the following methods:

* Delete all objects with the specified prefix:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 rm s3://bucket-name/path_style_prefix/ --recursive
   ```

   Result:

   ```text
   delete: s3://bucket-name/path_style_prefix/test1.png
   delete: s3://bucket-name/path_style_prefix/subprefix/test2.png
   ```

* Delete objects specified in the `--include` filter and skip objects specified in the `--exclude` filter:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 rm s3://bucket-name/path_style_prefix/ --recursive \
       --exclude "*" --include "*.log"
   ```

   Result:

   ```text
   delete: s3://bucket-name/path_style_prefix/test1.log
   delete: s3://bucket-name/path_style_prefix/subprefix/test2.log
   ```

* Delete objects one by one, running the following command for each object:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 rm s3://bucket-name/path_style_prefix/textfile.txt
   ```

   Result:

   ```text
   delete: s3://bucket-name/path_style_prefix/textfile.txt
   ```

### Retrieving an object {#retrieving-objects}

```bash
aws --endpoint-url=https://{{ s3-storage-host }} \
  s3 cp s3://bucket-name/textfile.txt textfile.txt
```
Result:

```text
download: s3://bucket-name/path_style_prefix/textfile.txt to ./textfile.txt
```
