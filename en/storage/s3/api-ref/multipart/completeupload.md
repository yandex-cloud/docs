# completeUpload method

The request completes multipart upload.

When receiving the {{ objstorage-name }} request:

- Combines the parts obtained during the upload in the order of their numbering to form a target object.
- Deletes the upload ID, which means that any subsequent requests with that ID will return the `NoSuchUpload` error.

When completing the upload, the client must provide the list of the parts it sent. Each part's description must contain the `ETag` which the client receives in response to each uploaded part. See [{#T}](uploadpart.md).

The operation may take several minutes, depending on the object size and the number of parts.

If the request failed, the client app must be ready to repeat the request.


## Request {#request}

```
POST /{bucket}/{key}?uploadId=UploadId HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. |


### Query parameters {#request-parameters}

| Parameter | Description |
----- | -----
| `uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at [startup](startupload.md). |


### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

### Data schema {#request-scheme}

The list of parts of a multipart upload is passed as an XML file in the following format:

```
<CompleteMultipartUpload>
  <Part>
    <PartNumber>PartNumber</PartNumber>
    <ETag>ETag</ETag>
  </Part>
  ...
</CompleteMultipartUpload>
```

| Tag | Description |
----- | -----
| `CompleteMultipartUpload` | Data in the request.<br/><br/>Path: `/CompleteMultipartUpload`. |
| `Part` | Data about the object's uploaded part.<br/><br/>Path: `/CompleteMultipartUpload/Part`. |
| `PartNumber` | Part number.<br/><br/>A unique identifier that determines the part's position among the other parts in the upload.<br/><br/>Path: `/CompleteMultipartUpload/Part/PartNumber`. |
| `ETag` | ID that the client received from {{ objstorage-name }} in response to the upload of a part.<br/><br/>Path: `/CompleteMultipartUpload/Part/ETag`. |

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

| Error | Description | HTTP code |
----- | ----- | -----
| `NoSuchUpload` | The specified upload doesn't exist. The specified upload ID might be incorrect or the upload was completed or deleted. | 404 Not Found |
| `InvalidPart` | Some of the specified parts not found.<br/><br/>Possible causes:<br/>- The parts have not been uploaded.<br/>- The passed `ETag` does not match the saved one. | 400 Bad Request |
| `InvalidPartOrder` | The list of parts was not in ascending order.<br/><br/>The list must be sorted by part number in ascending order. | 400 Bad Request |


A successful response contains additional data in XML format with the schema described below.

### Data schema {#request-scheme}

```
<CompleteMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Location>http://Example-Bucket.{{ s3-storage-host }}/Example-Object</Location>
  <Bucket>Example-Bucket</Bucket>
  <Key>Example-Object</Key>
  <ETag>"3858f62230ac3c915f300c664312c11f-9"</ETag>
</CompleteMultipartUploadResult>
```

| Tag | Description |
----- | -----
| `CompleteMultipartUploadResult` | Response data.<br/><br/>Path: `/CompleteMultipartUploadResult`. |
| `Location` | URI of the object created as a result of uploading.<br/><br/>Path: `/CompleteMultipartUploadResult/Location`. |
| `Bucket` | Name of the bucket where the object is located.<br/><br/>Path: `/CompleteMultipartUploadResult/Bucket`. |
| `Key` | Key of the created object.<br/><br/>Path: `/CompleteMultipartUploadResult/Key`. |
| `ETag` | Hash value of the object.<br/><br/>ETag may or may not be not an MD5 hash.<br/><br/>Path: `/CompleteMultipartUploadResult/ETag`. |


