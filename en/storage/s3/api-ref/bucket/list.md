# listBuckets method

Returns a list of buckets available to the user.

## Request {#request}

```
GET / HTTP/1.1
```

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.

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
| ----- | ----- |
| `Bucket` | Contains a bucket description.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket`. |
| `Buckets` | Contains a list of buckets.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets`. |
| `CreationDate` | Bucket creation time in the format `yyyy-mm-ddThh:mm:ss.timezone`.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`. |
| `ListAllMyBucketsResult` | Response root element.<br/><br/>Path: `/ListAllMyBucketsResult`. |
| `Name` | Bucket name.<br/><br/>Path: `/ListAllMyBucketsResult/Buckets/Bucket/Name`. |

