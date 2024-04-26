# listBuckets method

Returns a list of buckets available to the user.

{% include [sa-acl-bucket-list-note.md](../../../../_includes/storage/sa-acl-bucket-list-note.md) %}

## Request {#request}

```
GET / HTTP/2
```

### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```
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

| Element | Description |
----- | -----
| `Bucket` | Contains a bucket description.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket`. |
| `Buckets` | Contains a list of buckets.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets`. |
| `CreationDate` | Bucket creation time in the format `yyyy-mm-ddThh:mm:ss.timezone`.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`. |
| `ListAllMyBucketsResult` | Root element of a response.<br/><br/>Path: `/ListAllMyBucketsResult`. |
| `Name` | Bucket name.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket/Name`. |
