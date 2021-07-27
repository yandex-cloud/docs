---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# S3cmd

[S3cmd](https://s3tools.org/s3cmd) is a console client (Linux, Mac) for services that support the Amazon S3 HTTP API. The general procedure for running commands is described in the [official S3cmd documentation](https://s3tools.org/usage).

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To learn how to download and install S3cmd, see the [Download](https://s3tools.org/download) section on the official website of the project.

## Configuration {#setup}

To configure S3cmd, use the `s3cmd --configure` command. The command requests values for the following parameters:

1. `Access Key`: Enter the ID of the key that you received when generating the static key.

1. `Secret Key`: Enter the secret key that you received when generating the static key.

1. `Default Region`: Enter `ru-central1`.

   {% note info %}

   Always specify the `ru-central1` region when accessing {{ objstorage-name }}. A different region value may lead to an authorization error.

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

- S3cmd treats {{ objstorage-name }} as a hierarchical file system and object keys look like file paths.
- By default, S3cmd uploads objects to cold storage. To specify the [storage class](../concepts/storage-class.md) when uploading an object, use the `--storage-class` key.

## Examples of operations {#s3cmd-examples}

{% note info %}

To enable debug output in the console, use the `--debug` key.

{% endnote %}

### Getting a list of buckets {#listing-buckets}

```bash
s3cmd ls
```

### Creating a bucket {#creating-bucket}

```bash
s3cmd mb s3://bucket
```

{% note info %}

When creating a bucket, follow the [naming conventions](../concepts/bucket.md#naming).

{% endnote %}

### Uploading an object to cold storage {#uploading-object}

```
s3cmd --storage-class COLD put local_file s3://bucket/object
```

### Getting a list of objects {#getting-object-list}

```bash
s3cmd ls s3://bucket
```

### Retrieving an object {#retrieving-object}

```bash
s3cmd get s3://bucket/object local_file
```

### Deleting an object {#deleting-object}

```bash
s3cmd del s3://bucket/object
```

