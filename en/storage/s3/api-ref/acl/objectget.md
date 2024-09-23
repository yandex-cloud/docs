# objectGetAcl method

Returns an access control list for an object.

## Request {#request}

```http
GET /{bucket}/{key}?acl HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.


### Query parameters {#request-params}

Parameter | Description
----- | -----
`acl` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Data schema {#response-scheme}

The structure of the returned data is described in [ACL XML schema](xml-config.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}