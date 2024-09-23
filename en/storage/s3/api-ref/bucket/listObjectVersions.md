# listObjectVersions method

Returns metadata for all versions of objects in the bucket.
You can also use request parameters as a selection criterion to return metadata about a subset of object versions.

## Request {#request}

```http
GET /{bucket}?versions&delimiter=Delimiter&encoding-type=EncodingType&key-marker=KeyMarker&max-keys=MaxKeys&prefix=Prefix&version-id-marker=VersionIdMarker HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Query parameters {#parameters}

All the parameters listed in the table are optional.

Parameter | Description
----- | -----
`delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In response to the request, the user will get a list of files and folders in the bucket. The files will be output in the `Contents` elements, and folders, in `CommonPrefixes`.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return the list of files and folders in the `prefix` folder.
`encoding-type` | Encoding of server response.<br/><br/>{{ objstorage-name }} can encode responses in the format requested by the client.<br/><br/>Possible values: `url`.
`key-marker` | Key to start the output from.<br/><br/>In the resulting output, {{ objstorage-name }} will leave the keys starting from the one following `key-marker`.
`max-keys` | Maximum number of elements in a response.<br/><br/>By default, {{ objstorage-name }} outputs no more than 1,000 `Contents` and `CommonPrefixes` elements. Use this parameter if you need less than 1,000 elements in a single response.<br/><br/>If the number of keys meeting the selection criteria is greater than the number that could fit in the output, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output elements if their number exceeds `max-keys`, run multiple requests to {{ objstorage-name }} with the `key-marker` parameter, where `key-marker` and `version-id-marker` of each request is equal to the value of the `NextKeyMarker` and `NextVersionIdMarker` elements in the previous response.
`prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} selects only those keys which start with `prefix`.<br/><br/>You can use this parameter at the same time with `delimiter`. In this case, the output logic is the same as that specified in the `delimiter` parameter description.
`version-id-marker` | Object version to start the output from.<br/><br/>In the resulting output, {{ objstorage-name }} will leave the versions starting from the one following `version-id-marker`.

### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#structure}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ListVersionsResult>
   <IsTruncated>boolean</IsTruncated>
   <KeyMarker>string</KeyMarker>
   <VersionIdMarker>string</VersionIdMarker>
   <NextKeyMarker>string</NextKeyMarker>
   <NextVersionIdMarker>string</NextVersionIdMarker>
   <Version>
      <ETag>string</ETag>
      <IsLatest>boolean</IsLatest>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Owner>
         <DisplayName>string</DisplayName>
         <ID>string</ID>
      </Owner>
      <Size>integer</Size>
      <StorageClass>string</StorageClass>
      <VersionId>string</VersionId>
   </Version>
   ...
   <DeleteMarker>
      <IsLatest>boolean</IsLatest>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Owner>
         <DisplayName>string</DisplayName>
         <ID>string</ID>
      </Owner>
      <VersionId>string</VersionId>
   </DeleteMarker>
   ...
   <Name>string</Name>
   <Prefix>string</Prefix>
   <Delimiter>string</Delimiter>
   <MaxKeys>integer</MaxKeys>
   <CommonPrefixes>
      <Prefix>string</Prefix>
   </CommonPrefixes>
   ...
   <EncodingType>string</EncodingType>
</ListVersionsResult>
```

Element | Description
----- | -----
`ListVersionsResult` | Root element
`CommonPrefixes` | Key name part identified when processing the `delimiter` and `prefix` query parameters.<br/><br/>Path: `/ListVersionsResult/CommonPrefixes`.
`DeleteMarker` | Container for an object that is a delete marker.<br/><br/>Path: `/ListVersionsResult/DeleteMarker`.
`Delimiter` | Value of the `delimiter` query parameter.<br/><br/>Path: `/ListVersionsResult/Delimiter`.
`EncodingType` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.<br/><br/>Appears if the client provided the `encoding-type` parameter in the request.<br/><br/>Path: `/ListVersionsResult/EncodingType`.
`IsTruncated` | Marker indicating that a list is incomplete.<br/><br/>If `IsTruncated` is `true`, this means {{ objstorage-name }} returned an incomplete list of parts.<br/><br/>Path: `/ListVersionsResult/IsTruncated`.
`KeyMarker` | The last key returned in the incomplete response.<br/><br/>Path: `/ListVersionsResult/KeyMarker`.
`MaxKeys` | Value of the `max-keys` query parameter.<br/><br/>Path: `/ListBucketResult/MaxKeys`.
`Name` | Bucket name.<br/><br/>Path: `/ListBucketResult/Name`.
`NextKeyMarker` | Value to insert in the `key-marker` query parameter to get the next part of the list if the entire list does not fit in the current response.<br/><br/>Path: `/ListBucketResult/NextMarker`.
`NextVersionIdMarker` | Value to insert in the `version-id-marker` query parameter to get the next part of the list if the entire list does not fit in the current response.<br/><br/>Path: `/ListBucketResult/NextVersionIdMarker`.
`Prefix` | Value of the `prefix` query parameter.<br/><br/>Path: `/ListBucketResult/Prefix`.
`Version` | Object version.<br/><br/>Path: `/ListBucketResult/Version`.
`VersionIdMarker` | Marks the latest version of the key returned in the truncated response. <br/><br/>Path: `/ListBucketResult/VersionIdMarker`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}