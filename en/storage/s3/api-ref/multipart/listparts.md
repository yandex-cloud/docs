---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# listParts method

Returns a list of already uploaded parts for the specified multipart upload.

The response may contain no more than 1,000 elements. If there are more parts in the multipart upload, {{ objstorage-name }} returns the `IsTruncated` marker and the `NextPartNumberMarker` element. The remaining elements can be obtained via consecutive requests with the `part-number-marker` parameter set to `NextPartNumberMarker` from the previous request.

## Request {#request}

```
GET /{bucket}/{key}?uploadId=UploadId HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-parameters}

You can change a response from {{ objstorage-name }} using the parameters described in the table below.

| Parameter | Description |
| ----- | ----- |
| `encoding-type` | Encoding of server responses.<br/><br/>{{ objstorage-name }} can encode responses in the format requested by the client. |
| `max-parts` | The maximum number of elements in a response per request.<br/><br/>By default, 1000. |
| `part-number-marker` | Number of the part to start a response from. In the response, <br/><br/>{{ objstorage-name }} only includes the parts whose numbers are greater than the one specified. |
| `uploadId` | ID of multipart upload. |

Only the `uploadId` parameter is required.

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```
<ListPartsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>example-bucket</Bucket>
  <Key>example-object</Key>
  <UploadId>XXBsb2FkIElEIGZvciBlbHZpbmcncyVcdS1tb3ZpZS5tMnRzEEEwbG9hZA</UploadId>
  <Initiator>
      <ID>arn:aws:iam::111122223333:user/some-user-11116a31-17b5-4fb7-9df5-b288870f11xx</ID>
      <DisplayName>umat-user-11116a31-17b5-4fb7-9df5-b288870f11xx</DisplayName>
  </Initiator>
  <StorageClass>STANDARD</StorageClass>
  <PartNumberMarker>1</PartNumberMarker>
  <NextPartNumberMarker>3</NextPartNumberMarker>
  <MaxParts>2</MaxParts>
  <IsTruncated>true</IsTruncated>
  <Part>
    <PartNumber>2</PartNumber>
    <LastModified>2010-11-10T20:48:34.000Z</LastModified>
    <ETag>"7778aef83f66abc1fa1e8477f296d394"</ETag>
    <Size>10485760</Size>
  </Part>
  <Part>
    <PartNumber>3</PartNumber>
    <LastModified>2010-11-10T20:48:33.000Z</LastModified>
    <ETag>"aaaa18db4cc2f85cedef654fccc4a4x8"</ETag>
    <Size>10485760</Size>
  </Part>
</ListPartsResult>
```

Possible response tags are described in the table below.

| Tag | Description |
| ----- | ----- |
| `ListPartsResult` | Root element of the response.<br/><br/>Path: `/ListPartsResult`. |
| `Bucket` | The bucket that the multipart upload belongs to.<br/><br/>Path: `/ListPartsResult/Bucket`. |
| `Encoding-Type` | Encoding in which {{ objstorage-name }} provides a key in the XML response.<br/><br/>Appears if the client passed the `encoding-type` parameter in the request.<br/><br/>Path: `/ListPartsResult/Encoding-Type`. |
| `Key` | The key the multipart upload is made for.<br/><br/>Path: `/ListPartsResult/Key`. |
| `UploadId` | ID of the multipart upload.<br/><br/>Path: `/ListPartsResult/UploadId`. |
| `Initiator` | Information about the user who initiated the upload.<br/><br/>Path: `/ListPartsResult/Initiator`. |
| `ID` | User ID.<br/><br/>Path: `/ListPartsResult/Initiator/ID`. |
| `DisplayName` | User name displayed.<br/><br/>Path: `/ListPartsResult/Initiator/DisplayName`. |
| `StorageClass` | Object storage class: `STANDARD` or `COLD`.<br/><br/>Path: `/ListPartsResult/StorageClass`. |
| `PartNumberMarker` | Number of the part after which the list begins.<br/><br/>The first item on the list has the number following the `PartNumberMarker`.<br/><br/>Path: `/ListPartsResult/PartNumberMarker`. |
| `NextPartNumberMarker` | Number of the part the current list ends with.<br/><br/>Present if the entire list of parts does not fit in the response.<br/><br/>Path: `/ListPartsResult/NextPartNumberMarker`. |
| `MaxParts` | Maximum list size per response.<br/><br/>Path: `/ListPartsResult/MaxParts`. |
| `IsTruncated` | Flag indicating that a list is incomplete.<br/><br/>If `IsTruncated` is `true`, this means that {{ objstorage-name }} returned an incomplete list of parts.<br/><br/>Path: `/ListPartsResult/IsTruncated`. |
| `Part` | Description of an upload part.<br/><br/>Path: `/ListPartsResult/Part`. |
| `PartNumber` | Part number.<br/><br/>A unique integer ID that defines the position of the part in the upload.<br/><br/>Path: `/ListPartsResult/Part/PartNumber`. |
| `LastModified` | Date and time a part is uploaded.<br/><br/>Path: `/ListPartsResult/Part/LastModified`. |
| `ETag` | `ETag` of the uploaded part.<br/><br/>Path: `/ListPartsResult/Part/ETag`. |
| `Size` | Size of the uploaded part.<br/><br/>Path: `/ListPartsResult/Part/Size`. |

