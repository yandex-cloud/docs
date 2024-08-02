# GetObjectTagging method

Returns bucket object [labels](../../../concepts/tags.md).

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

## Request {#request}

```http
GET /{bucket}/{key}?tagging&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
--- | ---
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-params}

| Parameter | Description |
--- | ---
| `tagging` | Type of operation. This is a required parameter. |
| `versionId` | [Object version](../../../concepts/versioning.md) ID. This is a required parameter. |

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

A successful response contains additional data in XML format.

### Data schema {#structure}

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<Tagging xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <TagSet>
      <Tag>
         <Key>string</Key>
         <Value>string</Value>
      </Tag>
   </TagSet>
</Tagging>
```

| Element | Description |
--- | ---
| `Tagging` | Root element. |
| `TagSet` | Array of labels. |
| `Tag` | Container for labels. |
| `Key` | Label key.<br>Type: String. |
| `Value` | Label value.<br>Type: String. |

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}