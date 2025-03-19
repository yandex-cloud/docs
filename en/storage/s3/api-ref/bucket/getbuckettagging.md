# getBucketTagging method

Returns bucket [labels](../../../concepts/tags.md).

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?tagging HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
--- | ---
`bucket` | Bucket name.

### Request parameters {#request-params}

Parameter | Description
--- | ---
`tagging` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use [common headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

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

Element | Description
--- | ---
`Tagging` | Root element.
`TagSet` | Array of labels.
`Tag` | Container for a label.
`Key` | Label key.<br>Type: String.
`Value` | Label value.<br>Type: String.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}