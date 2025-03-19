# listParts method

Returns a list of already uploaded parts for the specified multipart upload.

The response may not contain more than 1,000 elements. If there are more parts in the multipart upload, {{ objstorage-name }} will return the `IsTruncated` marker and the `NextPartNumberMarker` element. You can get the remaining elements with consecutive requests where the `part-number-marker` parameter is set to `NextPartNumberMarker` from the previous request.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```
GET /{bucket}/{key}?uploadId=UploadId HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.


### Request parameters {#request-parameters}

You can change a response from {{ objstorage-name }} using the parameters described in the table below.

Parameter | Description
----- | -----
`encoding-type` | Encoding of server responses.<br/><br/>{{ objstorage-name }} can encode responses in the format requested by the client.
`max-parts` | Maximum number of elements in a response per request.<br/><br/>The default value is 1,000.
`part-number-marker` | Number of the part to start a response from.<br/><br/>{{ objstorage-name }} will only include in the response the parts whose numbers are greater than the one specified.
`uploadId` | ID of the multipart upload.


Only the `uploadId` parameter is required.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```
<ListPartsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>example-bucket</Bucket>
  <Key>example-object</Key>
  <UploadId>0005B465********</UploadId>
  <Initiator>
      <ID>ajeanexa********</ID>
      <DisplayName>ajeanexampleuser</DisplayName>
  </Initiator>
  <Owner>
      <ID>ajeanexa********</ID>
      <DisplayName>ajeanexampleuser</DisplayName>
  </Owner>
  <StorageClass>STANDARD</StorageClass>
  <PartNumberMarker>0</PartNumberMarker>
  <NextPartNumberMarker>2</NextPartNumberMarker>
  <MaxParts>2</MaxParts>
  <IsTruncated>true</IsTruncated>
  <Part>
    <PartNumber>1</PartNumber>
    <LastModified>2020-11-18T17:33:46.787Z</LastModified>
    <ETag>"1430884b802ee5206cbe0ca0cf9b73d4"</ETag>
    <Size>8388608</Size>
  </Part>
  <Part>
    <PartNumber>2</PartNumber>
    <LastModified>2020-11-18T17:33:46.812Z</LastModified>
    <ETag>"449aa7eaff2e841923b0da9ff2be5946"</ETag>
    <Size>8388608</Size>
  </Part>
</ListPartsResult>
```

The possible response tags are described in the table below.

Tag | Description
----- | -----
`ListPartsResult` | Root element of the response.<br/><br/>Path: `/ListPartsResult`.
`Bucket` | Bucket to which the parts are being uploaded.<br/><br/>Path: `/ListPartsResult/Bucket`.
`Encoding-Type` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.<br/><br/>You will get this tag if the client provided the `encoding-type` parameter in the request.<br/><br/>Path: `/ListPartsResult/Encoding-Type`.
`Key` | Key the multipart upload is performed for.<br/><br/>Path: `/ListPartsResult/Key`.
`UploadId` | ID of the multipart upload.<br/><br/>Path: `/ListPartsResult/UploadId`.
`Initiator` | Information about the user who initiated the upload.<br/><br/>Path: `/ListPartsResult/Initiator`.
`ID` | User ID.<br/><br/>Path: `/ListPartsResult/Initiator/ID`.
`DisplayName` | Displayed user name.<br/><br/>Path: `/ListPartsResult/Initiator/DisplayName`.
`Owner` | Information about the object owner, matches `Initiator`.<br/><br/>Path: `/ListPartsResult/Owner`.
`StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, or `ICE`.<br/><br/>Path: `/ListPartsResult/StorageClass`.
`PartNumberMarker` | Number of the part immediately preceeding the list.<br/><br/>The number of the first list item is the next one after `PartNumberMarker`.<br/><br/>Path: `/ListPartsResult/PartNumberMarker`.
`NextPartNumberMarker` | Number of the part the list ends with.<br/><br/>You will get this tag if there are more parts than listed in the response.<br/><br/>Path: `/ListPartsResult/NextPartNumberMarker`.
`MaxParts` | Maximum list size per response.<br/><br/>Path: `/ListPartsResult/MaxParts`.
`IsTruncated` | Tag that indicates that a list is incomplete.<br/><br/>If `IsTruncated` is `true`, this means {{ objstorage-name }} returned an incomplete list of parts.<br/><br/>Path: `/ListPartsResult/IsTruncated`.
`Part` | Upload part description.<br/><br/>Path: `/ListPartsResult/Part`.
`PartNumber` | Part number.<br/><br/>It is a unique integer ID that determines the part position in the upload.<br/><br/>Path: `/ListPartsResult/Part/PartNumber`.
`LastModified` | Date and time when the part was uploaded.<br/><br/>Path: `/ListPartsResult/Part/LastModified`.
`ETag` | `ETag` of the uploaded part.<br/><br/>Path: `/ListPartsResult/Part/ETag`.
`Size` | Size of the uploaded part.<br/><br/>Path: `/ListPartsResult/Part/Size`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}