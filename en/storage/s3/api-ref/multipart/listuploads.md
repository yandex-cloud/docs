# ListUploads method

Returns a list of current multipart uploads.

The response may not contain more than 1,000 elements. If there are more uploads, {{ objstorage-name }} will return the `IsTruncated` element, as well as the `NextKeyMarker` and `NextUploadIdMarker` elements to use for the `key-marker` and `upload-id-marker` parameters of a subsequent request.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?uploads HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Query parameters {#request-parameters}

Parameter | Description
----- | -----
`delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folder names separated by `delimiter`. The user will see a list of files and folders in the root of the bucket. Files will be output in the `Uploads` elements, and folders, in the `CommonPrefixes` elements.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return the list of files and folders in the folder named `prefix`.
`max-uploads` | Maximum number of uploads in a response.<br/><br/>By default, {{ objstorage-name }} outputs no more than 1,000 keys. Use this parameter if you need less than 1,000 keys in a single response.<br/><br/>If the selection criteria are met by more keys than can fit into the output, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output objects if their number exceeds `max-keys`, run multiple requests to {{ objstorage-name }} with the `key-marker` parameter, where the `key-marker` of each request is equal to the value of the `NextKeyMarker` element in the previous response.
`key-marker` | Key. The output begins with the key that follows the one specified in the parameter value.<br/><br/>Use it along with `upload-id-marker` for output filtering.<br/><br/>If `upload-id-marker` is specified, the output also contains `key-marker`.
`prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} selects only those keys which start with `prefix`.
`upload-id-marker` | Upload ID.<br/><br/>The first upload in the output is the one whose ID follows the upload specified in this parameter. The `key-marker` parameter is used in processing, i.e., the output includes uploads filtered by both `upload-id-marker` and `key-marker`.<br/><br/>If `key-marker` is not specified, `upload-id-marker` is ignored.
`uploads` | Flag indicating the multipart upload operation.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```xml
<ListMultipartUploadsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>bucket</Bucket>
  <KeyMarker></KeyMarker>
  <UploadIdMarker></UploadIdMarker>
  <NextKeyMarker>my-movie.m2ts</NextKeyMarker>
  <NextUploadIdMarker>0005B466********</NextUploadIdMarker>
  <MaxUploads>3</MaxUploads>
  <IsTruncated>true</IsTruncated>
  <Upload>
    <Key>my-divisor</Key>
    <UploadId>0005B465********</UploadId>
    <Initiator>
      <ID>ajeanexa********</ID>
      <DisplayName>ajeanexa********</DisplayName>
    </Initiator>
    <Owner>
      <ID>aje2v5og9qpl********</ID>
      <DisplayName>aje2v5og9qplr6pe0c59</DisplayName>
    </Owner>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2020-11-18T17:33:46.007Z</Initiated>
  </Upload>
  <Upload>
    <Key>my-movie.m2ts</Key>
    <UploadId>0005B465********</UploadId>
    <Initiator>
      <ID>ajeanexa********</ID>
      <DisplayName>ajeanexampleuser</DisplayName>
    </Initiator>
    <Owner>
      <ID>aje2v5og9qpl********</ID>
      <DisplayName>aje2v5og9qplr6pe0c59</DisplayName>
    </Owner>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2020-11-18T18:34:47.017Z</Initiated>
  </Upload>
  <Upload>
    <Key>my-movie.m2ts</Key>
    <UploadId>0005B466********</UploadId>
    <Initiator>
      <ID>ajeanexa********</ID>
      <DisplayName>ajeanexa********</DisplayName>
    </Initiator>
    <Owner>
      <ID>aje2v5og9qpl********</ID>
      <DisplayName>aje2v5og9qplr6pe0c59</DisplayName>
    </Owner>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2020-11-18T18:35:41.231Z</Initiated>
  </Upload>
</ListMultipartUploadsResult>
```

Tag | Description
----- | -----
`ListMultipartUploadsResult` | Response root tag.<br/><br/>Path: `/ListMultipartUploadsResult`.
`Bucket` | Bucket the multipart upload belongs to.<br/><br/>Path: `/ListMultipartUploadsResult/Bucket`.
`KeyMarker` | Key.<br/><br/>The output begins with the key that follows the one specified in the element value.<br/><br/>See the `key-marker` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/KeyMarker`.
`UploadIdMarker` | Upload ID.<br/><br/>The first upload in the output is the one whose ID follows the upload specified in this parameter.<br/><br/>See the `upload-id-​marker` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/UploadIdMarker`.
`NextKeyMarker` | Key.<br/><br/>If the output fails to include all the elements the user should get, use this value in the `key-marker` parameter for subsequent requests.<br/><br/>It appears if there are more elements than the response returns.<br/><br/>Path: `/ListMultipartUploadsResult/NextKeyMarker`.
`NextUploadIdMarker` | Upload ID.<br/><br/>If the output fails to include all the elements the user should get, use this value in the `upload-id-marker` parameter for subsequent requests.<br/><br/>It appears if there are more elements than the response returns.<br/><br/>Path: `/ListMultipartUploadsResult/NextUploadMarker`.
`Encoding-Type` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.><br/>See the `encoding-type` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/Encoding-Type`.
`MaxUploads` | Maximum list size per response.<br/><br/>See the `max-uploads` request parameter.<br/><br/>Path: `/ListMultipartUploadsResult/MaxUploads`.
`IsTruncated` | Marker indicating that a list is incomplete.<br/><br/>If `IsTruncated` is `true`, this means {{ objstorage-name }} returned an incomplete list of uploads.<br/><br/>Path: `/ListMultipartUploadsResult/IsTruncated`.
`Upload` | Upload description.<br/><br/>Path: `/ListMultipartUploadsResult/Upload`.
`Key` | Target upload object key.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/Key`.
`UploadId` | Multipart upload ID.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/UploadId`.
`Initiator` | Multipart upload initiator.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/Initiator`.
`ID` | User ID.<br/><br/>Possible paths:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/ID`
`DisplayName` | Displayed user name.<br/><br/>Possible paths:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/DisplayName`
`Owner` | Information about the object owner, matches `Initiator`.<br/><br/>Path: `/ListMultipartUploadsResult/Owner`.
`StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, or `ICE`.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/StorageClass`.
`Initiated` | Date and time of the request for [starting multipart upload](startupload.md).
`/ListMultipartUploadsResult/Prefix` | Key prefix.<br/><br/>See the `prefix` request parameter.<br/><br/>Path: `/ListMultipartUploadsResult/Prefix`.
`Delimiter` | Delimiter character used when generating output.<br/><br/>See the `delimiter` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/Delimiter`.
`CommonPrefixes` | It contains the `Prefix` element.<br/><br/>Path: `/ListMultipartUploadsResult/CommonPrefixes`.
`CommonPrefixes/Prefix` | Key name part identified when processing the `delimiter` and `prefix` request parameters.<br/><br/>Path: `/ListMultipartUploadsResult/CommonPrefixes/Prefix`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}