# putBucketLogging method

Enables and disables the [mechanism for logging actions with the bucket](../../../concepts/server-logs.md).

## Request {#request}

```http
PUT /{bucket}?logging HTTP/1.1
```

### Path parameters {#path-parameters}

Parameter | Description
--- | ---
`bucket` | Name of the [bucket](../../../concepts/bucket.md).

### Query parameters {#request-params}

Parameter | Description
--- | ---
`logging` | Required parameter that indicates the type of operation.

### Data schema {#request-scheme}

**To enable logging of actions with the bucket:**

```xml
<?xml version="1.0" encoding="UTF-8" ?>
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
`TargetBucket` | The name of the target bucket where the [objects](../../../concepts/object.md) are saved with logs.<br>Type: String.
`TargetPrefix` | [Object key prefix](../../../concepts/server-logs.md#key-prefix) with logs.<br>Type: String.

**To disable logging of actions with the bucket:**

```xml
<BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
```

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.