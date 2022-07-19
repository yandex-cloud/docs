# Logging actions with the bucket

To track operations with the [bucket](../../concepts/bucket.md), enable [logging](../../concepts/server-logs.md). Detailed information about requests to the _source_ bucket will be saved in an [object](../../concepts/object.md) in the _target_ bucket. However, {{ objstorage-name }} [doesn't guarantee](../../concepts/server-logs.md) that the logs will be saved fully and quickly.

Logging is disabled by default. After you enable it, {{ objstorage-name }} will save information about actions with the bucket once an hour.

## Enable logging {#enable}

To log requests to the bucket:

1. Use an existing target bucket or create a new target bucket named `bucket-logs`, for example. This is the bucket your logs will be written to.

   {% cut "How create backet" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

1. Enable logging in the source bucket that you want to track.

   {% list tabs %}

   - API

     Send the request using the method [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md).

     Example of the HTTP request body:

     ```xml
     <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
       <LoggingEnabled>
         <TargetBucket>bucket-logs</TargetBucket>
         <TargetPrefix>logs/</TargetPrefix>
       </LoggingEnabled>
     </BucketLoggingStatus>
     ```

     Where:

     * `<TargetBucket>`: The name of the target bucket.
     * `<TargetPrefix>`: Prefix to be used with all the [keys](../../concepts/object.md#key) of the log objects. The prefix must end with `/`, for example, `logs/`. Optional.

   {% endlist %}

## Get the logging settings {#get-settings}

To get the name of the target bucket and the prefix of the key for the log object, follow these steps:

{% list tabs %}

- API

  Send the request using the method [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md).

  Example of the HTTP response body:

  ```xml
  HTTP/1.1 200
  <?xml version="1.0" encoding="UTF-8"?>
  <BucketLoggingStatus>
     <LoggingEnabled>
        <TargetBucket>bucket-logs</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
     </LoggingEnabled>
  </BucketLoggingStatus>
  ```

{% endlist %}

## Get the logs {#get-logs}

To get your logs, download the object with the `logs/` prefix from the `bucket-logs` bucket:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the `bucket-logs` bucket is located.
  1. Select **{{ objstorage-name }}**.
  1. Click on the `bucket-logs` bucket name.
  1. Click on the object name with the `logs/` prefix.
  1. Click **Download**.

{% endlist %}

## Disable logging {#stop-logging}

To disable logging, follow these steps:

{% list tabs %}

- API

  Send the request using the method [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md). In the request body, pass the `<BucketLoggingStatus>` parameter with an empty value.

  Example of the HTTP request body:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
  ```

{% endlist %}
