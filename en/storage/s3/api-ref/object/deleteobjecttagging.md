# deleteObjectTagging method

Deletes all object [labels](../../../concepts/tags.md) from a bucket.

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
DELETE /{bucket}/{key}?tagging&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
--- | ---
`bucket` | Bucket name.
`key` | Object key.

### Request parameters {#request-params}

Parameter | Description
--- | ---
`tagging` | Type of operation. This is a required parameter.
`versionId` | [Object version](../../../concepts/versioning.md) ID. This is a required parameter.

### Headers {#request-headers}

Use [common headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

In addition to [common headers](../common-response-headers.md), responses may contain:

Header | Description
--------- | --------
`x-amz-version-id` | Object version ID.

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}