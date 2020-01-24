# S3cmd

[S3cmd](https://s3tools.org/s3cmd) is a command line tool (for Linux and Mac) designed for services that support the Amazon S3 HTTP API. The general [procedure for running commands](https://s3tools.org/usage) can be found in the official S3cmd documentation.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To learn how to download and install S3cmd, see the [Download](https://s3tools.org/download) section on the official website of the project.

## Configuration {#setup}

To configure S3cmd, use the `s3cmd --configure` command. The command will request values for the following parameters:

1. `Access Key`: Enter the ID of the key that you received when generating the static key.

1. `Secret Key`: Enter the secret key that you received when generating the static key.

1. `Default Region`: Enter `ru-central1`.

   {% note info %}

   Always specify the `ru-central1` region when accessing {{ objstorage-name }}. A different value of the region may lead to an authorization error.

   {% endnote %}

1. `S3 Endpoint`: Enter `{{ s3-storage-host }}`.

1. `DNS-style bucket+hostname:port template for accessing a bucket`: Enter `%(bucket)s.{{ s3-storage-host }}`.

1. Leave the other parameter values unchanged.

The client tries to establish a connection with {{ objstorage-name }} and get a list of buckets. If successful, it will return `Success. Your access key and secret key worked fine :-)`.

The `s3cmd --configure` command saves the settings to a `~/.s3cfg` file in the format:

```
[default]
access_key = id
secret_key = secretKey
bucket_location = ru-central1
host_base = {{ s3-storage-host }}
host_bucket = %(bucket)s.{{ s3-storage-host }}
```

If necessary, you can change these settings directly in the file. You can also specify settings when launching the client by using the appropriate parameters.

For the static website hosting control commands to work correctly, manually add the following parameter to the configuration file:

```
website_endpoint = http://%(bucket)s.{{ s3-web-host }}
```

## Specifics {#specifics}

Keep in mind that S3cmd treats {{ objstorage-name }} as a hierarchical file system and object keys look like file paths.

## Examples of operations {#s3cmd-examples}

### List buckets {#listing-buckets}

```bash
s3cmd ls
```

### Create a bucket {#creating-bucket}

```bash
s3cmd  mb s3://bucket
```

{% note info %}

When creating a bucket, follow the [naming conventions](../concepts/bucket.md#naming).

{% endnote %}

### Upload an object {#uploading-object}

```
s3cmd put local_file s3://bucket/object
```

### Getting a list of objects {#getting-object-list}

```bash
s3cmd ls s3://bucket
```

### Retrieve an object {#retrieving-object}

```bash
s3cmd get s3://bucket/object local_file
```

### Deleting an object {#deleting-object}

```bash
s3cmd del s3://bucket/object
```

