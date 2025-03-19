---
title: Bucket logging
description: In this article, you will learn about the bucket logging algorithm, source and target bucket requirements, log object key format, and logging features.
---

# Bucket logging


{{ objstorage-name }} allows you to _log_ all actions with a [bucket](./bucket.md). For example, you can use logging for an internal security audit or to get more granular information about bucket-related operations.

{% note info %}

Actions performed with objects as part of their [lifecycle](./lifecycles.md) are not logged.

{% endnote %}

By default, logging is disabled. Once you enable this option, {{ objstorage-name }} will start writing data on bucket actions as an [object](../concepts/object.md) once an hour.

To enable logging, do the following:
* Define the _source_ bucket for which you want to log actions.
* Create a _target_ bucket where you want to save the logs.
* [Enable logging](../operations/buckets/enable-logging.md#enable) using the [management console]({{ link-console-main }}), [AWS CLI](../tools/aws-cli.md), [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md), or API.
* Select the prefix of the object [key](../concepts/object.md#key) (optional).

## Prerequisites {#requirements}

* The source and target buckets must be different.

* The source and target buckets must be in the same [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).


* [Encryption](../operations/buckets/encrypt.md) must be disabled on the target bucket.


{% include [target-backet-note](../../_includes/storage/target-bucket-note.md) %}

## Format of the key for the log object {#key-format}

{{ objstorage-name }} uses the following format of the key for the log object:

```text
<prefix>/YYYY-MM-DD-HH-MM-SS-<ID>
```

Where:

* `<prefix>`: [Prefix of the key](#key-prefix) for the log object. You can specify the prefix yourself when enabling logging.
* `YYYY-MM-DD-HH-MM-SS`: Date and time of saving the log object in the target bucket (in UTC format).
* `<ID>`: Unique record ID that prevents object overwrites.

### Key prefix {#key-prefix}

The key prefix allows you to distinguish:
* Data from different buckets, if logs for multiple source buckets are saved to the same target bucket.
* Logging actions from other actions with the bucket, if logs are saved to the source bucket. This is because, in this case, the logging operation is also considered an action with the bucket.
* Log objects from other objects, in order to regularly delete logs. You can set up a [lifecycle](../concepts/lifecycles.md) for the target bucket to automatically delete objects with a specific key prefix.

## Log object format {#object-format}

Logs are saved to a JSON file. Every action with a bucket adds the respective record to the file.

You can find the full list of logged parameters in the [log reference](../logs-ref.md).

Example of a record in the log file:

```json
{
  "bucket": "my-bucket-example",
  "bytes_received": 749,
  "bytes_send": 1251,
  "handler": "REST.GET.OBJECT",
  "http_referer": "https://example.com/page",
  "ip": "84.201.121.46",
  "method": "GET",
  "object_key": "path/logs/2020-11-10-14-42-11-123f57b5-1853-4120-8d7a-5bcc1e9e9b4f",
  "protocol": "HTTP/1.1",
  "range": "-",
  "requester": "-",
  "request_args": "X-Amz-Algorithm=AWS4-HMAC-SHA256\u0026X-Amz-Date=20201030T072100Z\u0026X-Amz-SignedHeaders=host\u0026X-Amz-Expires=43200\u0026X-Amz-Credential=ZGB4EY1...\u0026X-Amz-Signature=12f350...",
  "request_id": "1235efda********",
  "request_path": "/my-bucket-example/path/logs/2020-11-10-14-42-11-123f57b5-1853-4120-8d7a-5bcc1e9e9b4f?X-Amz-...",
  "request_time":88,
  "scheme": "https",
  "ssl_protocol": "TLSv1.2",
  "status": 200,
  "storage_class": "STANDARD",
  "timestamp": "2020-11-10T13:21:18Z",
  "user_agent": "docker/19.03.9 go/go1.13.10 git-commit/1d238398e7 kernel/4.4.0-142-generic os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)",
  "version_id": "",
  "vhost": "{{ s3-storage-host }}"
}
```

## Logging features {#features}

There are several points to note about bucket logging in {{ objstorage-name }}.

### Best-effort log delivery {#best-effort}

Most requests to a bucket are written to the log file, if the bucket logging was set up correctly. Most records are written within a few hours after the request is actually processed.

However, {{ objstorage-name }} does not guarantee complete and timely logging. It may take up to a few hours to record an action with the bucket in a log file. In some cases, a record might fail to appear in the file.

The log file provides an overview of the bucket traffic and is not intended for logging each and every request. In the payment documents, you might find a few requests absent in the log file.

### No object lifecycle action logging {#lifecycle}

In buckets with [lifecycle](./lifecycles.md) rules configured, actions on objects as part of their lifecycle are not logged.

### Enabling logging takes time {#long-engagement}

It takes around an hour to enable logging and change the settings. The first log object is saved to the bucket in two hours after logging is enabled; sometimes, however, it may take longer.

When you change the target bucket, some logs will still be delivered to the previous target bucket, while others will be delivered to the new one.

All changes to the settings will take effect without additional user actions.


## Pricing {#billing}

The logging pricing follows the regular [{{ objstorage-name }} pricing rules](../pricing.md).

