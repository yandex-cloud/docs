# getBucketLogging method


Returns the settings for [bucket actions logging](../../../concepts/server-logs.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?logging HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
--- | ---
`bucket` | [Bucket](../../../concepts/bucket.md) name.

### Query parameters {#request-params}

Parameter | Description
--- | ---
`logging` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

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

Element | Description
--- | ---
`BucketLoggingStatus` | Root element.
`TargetBucket` | Name of the target bucket where [objects](../../../concepts/object.md) with logs are saved.<br>Path: `/BucketLoggingStatus/LoggingEnabled/TargetBucket`.<br>Type: String.
`TargetPrefix` | [Log object key prefix](../../../concepts/server-logs.md#key-prefix).<br>Path: `/BucketLoggingStatus/LoggingEnabled/TargetPrefix`.<br>Type: String.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}