# GetBucketTagging method

Returns bucket [tags](../../../../resource-manager/concepts/labels.md).

## Query {#request}

```http
GET /{bucket}?tagging HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
--- | ---
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
--- | ---
| `tagging` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

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
| `TagSet` | Array of tags. |
| `Tag` | Container for tags. |
| `Key` | Tag key.<br>Type: String. |
| `Value` | Tag value.<br>Type: String. |