# PutBucketTagging method

Adds [labels](../../../concepts/tags.md) to a bucket. This overwrites any existing bucket labels.

## Query {#request}

```http
PUT /{bucket}?tagging HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
--- | ---
| `tagging` | Required parameter that indicates the type of operation. |

### Data schema {#request-scheme}

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

### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.
