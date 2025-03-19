# listBuckets method

Returns a list of buckets available to the user.

{% include [sa-acl-bucket-list-note.md](../../../../_includes/storage/sa-acl-bucket-list-note.md) %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET / HTTP/2
```

### Headers {#request-headers}
Use only [common headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```xml
<ListAllMyBucketsResult>
  <Buckets>
    <Bucket>
      <Name>bucket-name</Name>
      <CreationDate>date_time</CreationDate>
    </Bucket>
    ...
  </Buckets>
</ListAllMyBucketsResult>
```

Element | Description
----- | -----
`Bucket` | Contains the bucket description.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket`.
`Buckets` | Contains the bucket list.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets`.
`CreationDate` | Bucket creation time in `yyyy-mm-ddThh:mm:ss.timezone` format.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`.
`ListAllMyBucketsResult` | Root element of the response.<br/><br/>Path: `/ListAllMyBucketsResult`.
`Name` | Bucket name.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket/Name`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}