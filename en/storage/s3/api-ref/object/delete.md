# delete method

Deletes an object.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
DELETE /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.

### Request parameters {#request-params}

Parameter | Description
----- | -----
`versionId` | Link to a specific version of the object.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

Moreover, if [governance-mode retention](../../../concepts/object-lock.md) is set for an object version in a versioned bucket, make sure to use the below-specified header to bypass retention and confirm deletion. Only users with the [`storage.admin` role](../../../security/index.md) can delete a retained object version. To check the retention status, use the [getObjectRetention](getobjectretention.md) method.

Header | Description
--- | ---
`X-Amz-Bypass-Governance-Retention` | Header that confirms bypassing of the governance-mode retention. Set it to `true`.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}