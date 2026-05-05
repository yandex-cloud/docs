# listUploads method

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


### Request parameters {#request-parameters}

Parameter | Description
----- | -----
`delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as a file path, where folder names are separated by the `delimiter` character. The user gets a list of <q>files</q> and <q>folders</q> in the <q>root</q> of the bucket. <q>Files</q> are output in the `Uploads` elements, and <q>folders</q> in the `CommonPrefixes` elements.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return a list of <q>files</q> and <q>folders</q> in the  <q>folder</q>`prefix`.
`max-uploads` | Maximum number of uploads in a response.<br/><br/>By default, {{ objstorage-name }} outputs a maximum of 1,000 keys. This parameter should be used if you need to get less than 1,000 elements per response.<br/><br/>If the selection criteria are met by more keys than the output has room for, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output objects, if there are more than `max-keys` of them, make several consecutive requests to {{ objstorage-name }} with the `key-marker` parameter, where for each request `key-marker` is equal to the value of the `NextKeyMarker` element from the previous response.
`key-marker` | Key. The output begins with the key that follows the one specified in the parameter value.<br/><br/>Use it together with `upload-id-marker` for output filtering.<br/><br/>If `upload-id-marker` is specified, the output will also contain `key-marker`.
`prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} will select only keys that start with `prefix`.
`upload-id-marker` | Upload ID.<br/><br/>Output begins with the upload whose ID follows the one specified in the parameter value. The `key-marker` parameter is used in processing, i.e., the output will include uploads filtered by both `upload-id-marker` and `key-marker`.<br/><br/>If `key-marker` is not specified, `upload-id-marker` is ignored.
`uploads` | Flag indicating a multipart upload operation.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

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
`Bucket` | Multipart upload bucket.<br/><br/>Path: `/ListMultipartUploadsResult/Bucket`.
`KeyMarker` | Key.<br/><br/>The output begins with the key that follows the one specified in the element value.<br/><br/>See the `key-marker` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/KeyMarker`.
`UploadIdMarker` | Upload ID.<br/><br/>The output begins with the upload whose ID follows the one specified in the parameter.<br/><br/>See the `upload-id-​marker` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/UploadIdMarker`.
`NextKeyMarker` | Key.<br/><br/>If the output could not fit all the elements the user has to receive, this value must be used in the `key-marker` parameter for subsequent requests.<br/><br/>It is present if the response did not have enough room for all the elements.<br/><br/>Path: `/ListMultipartUploadsResult/NextKeyMarker`.
`NextUploadIdMarker` | Upload ID.<br/><br/>If the output could not fit all the elements the user has to receive, this value must be used in the `upload-id-marker` parameter for subsequent requests.<br/><br/>It is present if the response did not have enough room for all the elements.<br/><br/>Path: `/ListMultipartUploadsResult/NextUploadMarker`.
`Encoding-Type` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.<br/><br/>See the `encoding-type` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/Encoding-Type`.
`MaxUploads` | Maximum list length per response.<br/><br/>See the `max-uploads` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/MaxUploads`.
`IsTruncated` | Flag indicating an incomplete list.<br/><br/>If `IsTruncated` is `true`, it means {{ objstorage-name }} has returned an incomplete list of uploads.<br/><br/>Path: `/ListMultipartUploadsResult/IsTruncated`.
`Upload` | Upload description.<br/><br/>Path: `/ListMultipartUploadsResult/Upload`.
`Key` | Target upload object key.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/Key`.
`UploadId` | Multipart upload ID.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/UploadId`.
`Initiator` | Multipart upload initiator.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/Initiator`.
`ID` | User ID.<br/><br/>Possible paths:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/ID`
`DisplayName` | Displayed user name.<br/><br/>Possible paths:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/DisplayName`
`Owner` | Object owner info; matches `Initiator`.<br/><br/>Path: `/ListMultipartUploadsResult/Owner`.
`StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, or `ICE`.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/StorageClass`.
`Initiated` | Date and time of the request for [starting a multipart upload](startupload.md).
`/ListMultipartUploadsResult/Prefix` | Key prefix.<br/><br/>See the `prefix` request parameter.<br/><br/>Path: `/ListMultipartUploadsResult/Prefix`.
`Delimiter` | Delimiter character used when generating output.<br/><br/>See the `delimiter` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/Delimiter`.
`CommonPrefixes` | Contains the `Prefix` element.<br/><br/>Path: `/ListMultipartUploadsResult/CommonPrefixes`.
`CommonPrefixes/Prefix` | Key name part identified when processing the `delimiter` and `prefix` request parameters.<br/><br/>Path: `/ListMultipartUploadsResult/CommonPrefixes/Prefix`.

#### Related articles {#related-articles}

* [{#T}](../../../concepts/multipart.md)

* [{#T}](../../../operations/objects/deleting-multipart.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
