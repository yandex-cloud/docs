# Object Storage API, Amazon S3-compatible REST: GetBucketLifecycleConfiguration

Returns the bucket object lifecycle configuration from {{ objstorage-name }}.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?lifecycle HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Query parameters {#request-params}

Parameter | Description
----- | -----
`lifecycle` | Required parameter that indicates the type of operation.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

If there is no configuration, {{ objstorage-name }} returns a 404 error with the `NoSuchLifecycleConfiguration` code.

For a list of other possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

The structure of returned data is the same as the structure of data provided by the [upload](upload.md) method. The structure is described in [{#T}](xml-config.md).

#### Related articles {#related-articles}

* [{#T}](../../../concepts/lifecycles.md)

* [{#T}](../../../operations/buckets/lifecycles.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
