# Logging actions with a bucket

In {{ objstorage-name }}, there is an option to log all actions with a [bucket](../concepts/bucket.md). You can record logs, for example, to run an internal security audit or get more granular information about bucket operations.

Logging is disabled by default. After you enable this option, {{ objstorage-name }} will write actions with the bucket to an [object](../concepts/object.md) once an hour.

To save logs, do the following:
* Define the _source_ bucket that you want to log actions with.
* Create a _target_ bucket where you want to save the logs.
* [Enable logging](../operations/buckets/enable-logging.md).
* (optional) Select the prefix of the object [key](../concepts/object.md#key).

## Prerequisites {#requirements}

The source and target buckets must be in the same {% if audience != "internal" %}[cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud){% else %}cloud{% endif %}

{% if product == "yandex-cloud" and audience != "internal" %}

[Encryption](../operations/buckets/encrypt.md) must be disabled on the target bucket.

{% endif %}

## Format of the key for the log object {#key-format}

{{ objstorage-name }} uses the following format of the key for the log object:

```
<prefix>/YYYY-MM-DD-HH-MM-SS-<ID>
```

Where:

* `prefix`: The [prefix of the key](#key-prefix) for the log object. You can specify your own prefix when enabling logging.
* `YYYY-MM-DD-HH-MM-SS`: Date and time of saving the log object in the target bucket (UTC format).
* `ID`: A unique record ID that prevents the object from being overwritten.

### Prefix of the key {#key-prefix}

The key prefix lets you distinguish:
* Data from different buckets, if the logs for multiple source buckets are saved to the same target bucket.
* Logging actions from other actions with the bucket, if the logs are saved to the source bucket. That's because the logging operation is also considered an action with the bucket in this case.
* The log objects from other objects, in order to delete logs from time to time. You can set up the [lifecycle](../concepts/lifecycles.md) for the target bucket so that objects with a specific key prefix are deleted automatically.

## Format of the log object {#object-format}

Logs are saved to a JSON file. For every action with the bucket, a record is written to the file in the following format:

| Field | Type | Description |
--- | --- | ---
| `bucket` | String | Bucket name. |
| `bytes_received` | Int64 | Size of the request in bytes. |
| `bytes_send` | Int64 | Response size in bytes. |
| `handler` | String | Request method in `REST format.<HTTP method>.<subject>`. |
| `http_referer` | String | URL of the request source. |
| `ip` | String | User's IP address. |
| `method` | String | HTTP request method. |
| `object_key` | String | [Object's key](#key-format) in [URL encoded](https://en.wikipedia.org/wiki/Percent-encoding) format. |
| `protocol` | String | Data transfer protocol version. |
| `range` | String | An HTTP header that defines the range of bytes to load from the object. |
| `requester` | String | User ID. |
| `request_args` | String | Arguments of the URL request. |
| `request_id` | String | Query ID. |
| `request_path` | String | Full path of the request. |
| `request_time` | Int64 | Request processing time, in milliseconds. |
| `scheme` | String | Type of data transfer protocol. <br>Possible values:<br>- `http`: An application layer protocol.<br>- `https`: An application layer protocol with encryption support. |
| `ssl_protocol` | String | Security protocol. |
| `status` | Int64 | HTTP [response](../s3/api-ref/response-codes.md) code. |
| `storage_class` | String | [Storage class](../concepts/storage-class.md) of the object. |
| `timestamp` | String | Date and time of the operation with the bucket, in the `YYYY-MM-DDTHH:MM:MMZ` format. |
| `user_agent` | String | Client application (User Agent) that executed the request. |
| `version_id` | String | Version of the object. |
| `vhost` | String | Virtual host of request. <br>Possible values:<br>– `{{ s3-storage-host }}`.<br>– `<bucket name>.{{ s3-storage-host }}`.<br>– `{{ s3-web-host }}`.<br> – `<bucket name>.{{ s3-web-host }}`. |

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
  "request_id": "1235efdab7445028",
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

## Logging specifics {#features}

There are several points to note about how actions with a bucket are logged in {{ objstorage-name }}.

### Best-effort log delivery {#best-effort}

Most requests to a bucket are written to the log file (if the bucket was set up correctly to support logging). Most records are written within a few hours after the request is actually processed.

However, {{ objstorage-name }} doesn't guarantee that the logs are saved in a complete and timely manner. It may take several hours to record an action with the bucket in a log file. In some cases, a record might fail to appear in the file.

The log file provides an overview of the nature of traffic in the bucket, but is not intended for logging every request. In the payment documents, you might find a few requests that are not shown in the log file.

### It takes a while to enable logging {#long-engagement}

Enabling logging and changing the settings takes about an hour. The first log object is saved to the bucket in a couple of hours after logging is enabled, but sometimes it may take longer to deliver logs.

When you change the target bucket, some logs are still delivered to the previous target bucket, and other logs are delivered to the new target bucket.

All changes to the settings will take effect without additional user actions.

{% if audience != "internal" %}

## Pricing {#billing}

The standard {{ objstorage-name }} [pricing rules](../pricing.md) apply to logging.

{% endif %}
