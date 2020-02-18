# listUploads method

Returns a list of current multipart uploads.

The response may contain no more than 1,000 elements. If there are more uploads, {{ objstorage-name }} returns the `IsTruncated` element and the `NextKeyMarker` and `NextUploadIdMarker` elements to be used for the `key-marker` and `upload-id-​marker` parameters of a subsequent request.

## Request {#request}

```
GET /{bucket}?uploads HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folder names separated by the `delimiter` character. The user gets a list of <q>files</q> and <q>folders</q> in the <q>root</q> of the bucket. <q>Files</q> are output in the `Uploads` elements, and the <q>folders</q> in the `CommonPrefixes` elements.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} returns the a of <q>files</q> and <q>folders</q> in the ` prefix` <q>folder</q>. |
| `max-uploads` | Maximum number of uploads in a response.<br/><br/>By default, {{ objstorage-name }} outputs a maximum of 1000 keys. This parameter should be used if you need to get less than 1000 keys in a single response.<br/><br/>If the number of keys meeting the selection criteria is greater than the number that could fit in the output, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output objects if their number exceeds the `max-keys` value, make several consecutive requests to {{ objstorage-name }} with the `key-marker` parameter, where the `key-marker` of each request is equal to the value of the `NextKeyMarker` element in the previous response. |
| `key-marker` | Key. Output begins with the key that follows the one specified in the parameter value.<br/><br/>Use it together with the `upload-id-marker` for output filtering.<br/><br/>If the `upload-id-marker` is specified, then the output also contains the `key-marker`. |
| `prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} selects only those keys that start with `prefix`. |
| `upload-id-​marker` | Upload ID.<br/><br/>Output begins with the upload whose ID follows the one specified in the parameter value. The `key-marker` value is processed, meaning that the output contains the uploads that match filtering by both `upload-id-​marker` and `key-marker`.<br/><br/>If no`key-marker`  is specified, the `upload-id-​marker` is ignored. |
| `uploads` | Flag indicating a multipart upload operation. |

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
<ListMultipartUploadsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>bucket</Bucket>
  <KeyMarker></KeyMarker>
  <UploadIdMarker></UploadIdMarker>
  <NextKeyMarker>my-movie.m2ts</NextKeyMarker>
  <NextUploadIdMarker>YW55IGlkZWEgd2h5IGVsdmluZydzIHVwbG9hZCBmYWlsZWQ</NextUploadIdMarker>
  <MaxUploads>3</MaxUploads>
  <IsTruncated>true</IsTruncated>
  <Upload>
    <Key>my-divisor</Key>
    <UploadId>XMgbGlrZSBlbHZpbmcncyBub3QgaGF2aW5nIG11Y2ggbHVjaw</UploadId>
    <Initiator>
      <ID>arn:aws:iam::111122223333:user/user1-11111a31-17b5-4fb7-9df5-b111111f13de</ID>
      <DisplayName>user1-11111a31-17b5-4fb7-9df5-b111111f13de</DisplayName>
    </Initiator>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2010-11-10T20:48:33.000Z</Initiated>
  </Upload>
  <Upload>
    <Key>my-movie.m2ts</Key>
    <UploadId>VXBsb2FkIElEIGZvciBlbHZpbmcncyBteS1tb3ZpZS5tMnRzIHVwbG9hZA</UploadId>
    <Initiator>
      <ID>b1d16700c70b0b05597d7acd6a3f92be</ID>
      <DisplayName>InitiatorDisplayName</DisplayName>
    </Initiator>
    <StorageClass>COLD</StorageClass>
    <Initiated>2010-11-10T20:48:33.000Z</Initiated>
  </Upload>
  <Upload>
    <Key>my-movie.m2ts</Key>
    <UploadId>YW55IGlkZWEgd2h5IGVsdmluZydzIHVwbG9hZCBmYWlsZWQ</UploadId>
    <Initiator>
      <ID>arn:aws:iam::444455556666:user/user1-22222a31-17b5-4fb7-9df5-b222222f13de</ID>
      <DisplayName>user1-22222a31-17b5-4fb7-9df5-b222222f13de</DisplayName>
    </Initiator>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2010-11-10T20:49:33.000Z</Initiated>
  </Upload>
</ListMultipartUploadsResult>
```

| Tag | Description |
| ----- | ----- |
| `ListMultipartUploadsResult` | Root tag for the response.<br/><br/>Path: `/ListMultipartUploadsResult`. |
| `Bucket` | The bucket that the multipart upload belongs to.<br/><br/>Path: `/ListMultipartUploadsResult/Bucket`. |
| `KeyMarker` | Key.<br/><br/>The output begins with the key that follows the one specified in the element value.<br/><br/>See the `key-marker` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/KeyMarker`. |
| `UploadIdMarker` | Upload ID.<br/><br/>Output begins with the upload whose ID follows the one specified in the parameter value.<br/><br/>See the `upload-id-marker` parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/UploadIdMarker`. |
| `NextKeyMarker` | Key.<br/><br/>If the output failed to include all the elements the user should have received, this value is to be used in the `key-marker` parameter for subsequent requests.<br/><br/>Present if some of the elements do not fit in the response.<br/><br/>Path: `/ListMultipartUploadsResult/NextKeyMarker`. |
| `NextUploadIdMarker` | Upload ID.<br/><br/>If the output failed to include all the elements the user should have received, this value is to be used in the `upload-id-marker` parameter for subsequent requests.<br/><br/>Present if some of the elements do not fit in the response.<br/><br/>Path: `/ListMultipartUploadsResult/NextUploadMarker`. |
| `Encoding-Type` | Encoding in which {{ objstorage-name }} provides a key in an XML response.<br/><br/>See the `encoding-type` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/Encoding-Type`. |
| `MaxUploads` | Maximum list length for a single response. <br/><br/>See the `max-uploads` request parameter description. <br/><br/>Path: `/ListMultipartUploadsResult/MaxUploads`. |
| `IsTruncated` | Flag indicating that a list is incomplete.<br/><br/>If `IsTruncated` is `true`, this means that {{ objstorage-name }} returned an incomplete list of uploads.<br/><br/>Path: `/ListMultipartUploadsResult/IsTruncated`. |
| `Upload` | Upload description.<br/><br/>Path: `/ListMultipartUploadsResult/Upload`. |
| `Key` | Key of the last upload object.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/Key`. |
| `UploadId` | Multipart upload ID.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/UploadId`. |
| `Initiator` | Multipart upload initiator.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/Initiator`. |
| `ID` | User ID.<br/><br/>Possible paths:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/ID` |
| `DisplayName` | User name displayed.<br/><br/>Possible paths:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/DisplayName` |
| `StorageClass` | Object storage class: `STANDARD` or `COLD`.<br/><br/>Path: `/ListMultipartUploadsResult/Upload/StorageClass`. |
| `Initiated` | Date and time of the request for [starting multipart upload](startupload.md). |
| `/ListMultipartUploadsResult/Prefix` | Key prefix.<br/><br/>See the `prefix` request parameter description.<br/><br/>Path: `/ListMultipartUploadsResult/Prefix`. |
| `Delimiter` | Delimiter character that was used when generating output.<br/><br/>See the description of the `delimiter` request parameter.<br/><br/>Path: `/ListMultipartUploadsResult/Delimiter`. |
| `CommonPrefixes` | Contains the `Prefix` element.<br/><br/>Path: `/ListMultipartUploadsResult/CommonPrefixes`. |
| `CommonPrefixes/Prefix` | Part of the key name identified when processing the `delimiter` and `prefix` request parameters.<br/><br/>Path: `/ListMultipartUploadsResult/CommonPrefixes/Prefix`. |

