# DeleteObjectTagging method

Deletes all objects [labels](../../../concepts/tags.md) from a bucket.

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

## Query {#request}

```http
DELETE /{bucket}/{key}?tagging&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
--- | ---
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-params}

| Parameter | Description |
--- | ---
| `tagging` | Type of operation. This parameter is required. |
| `versionId` | [Object version](../../../concepts/versioning.md) ID. This parameter is required. |

### Headers {#request-headers}

Use [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

In addition to [common response headers](../common-response-headers.md), responses may contain:

| Header | Description |
--------- | --------
| `x-amz-version-id` | Object version ID. |

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.
