# getBucketLogging method

Returns settings for [logging actions with the bucket](../../../concepts/server-logs.md).

## Request {#request}

```http
GET /{bucket}?logging HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
| --- | --- |
| `bucket` | [Bucket](../../../concepts/bucket.md) name. |

### Query parameters {#request-params}

| Parameter | Description |
| --- | --- |
| `logging` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#structure}

Response if logging of actions with the bucket is not configured:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<BucketLoggingStatus xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<!--<LoggingEnabled><TargetBucket>bucket-logs</TargetBucket><TargetPrefix>add/this/prefix/to/my/log/files/access_log-</TargetPrefix></LoggingEnabled>-->
</BucketLoggingStatus>
```

Response if logging of actions with the bucket is configured:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<BucketLoggingStatus xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <LoggingEnabled>
        <TargetBucket>bucket-logs</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
    </LoggingEnabled>
</BucketLoggingStatus>
```

| Element | Description |
| --- | --- |
| `BucketLoggingStatus` | Root element. |
| `TargetBucket` | Name of the target bucket where the log [objects](../../../concepts/object.md) are saved.<br>Path:`/BucketLoggingStatus/LoggingEnabled/TargetBucket`.<br>Type: String |
| `TargetPrefix` | [Prefix of the key for the log object](../../../concepts/server-logs.md#key-prefix).<br>Path:`/BucketLoggingStatus/LoggingEnabled/TargetPrefix`.<br>Type: String |
