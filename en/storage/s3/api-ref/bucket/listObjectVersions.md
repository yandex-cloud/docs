# Object Storage API, Amazon S3-compatible REST: ListObjectVersions

Returns metadata for all versions of objects in the bucket.
You can also use request parameters as a selection criterion to return metadata about a subset of object versions.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?versions&delimiter=Delimiter&encoding-type=EncodingType&key-marker=KeyMarker&max-keys=MaxKeys&prefix=Prefix&version-id-marker=VersionIdMarker HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query parameters {#parameters}

All parameters listed in the table are optional.

#|
|| **Parameter** | **Description** ||
|| `delimiter` | Delimiter character.

If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In the response, the user will get a list of <q>files</q> and <q>folders</q> in the bucket. <q>Files</q> will be output in the `Contents` elements, and <q>folders</q>, in the `CommonPrefixes` elements.

If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return a list of <q>files</q> and <q>folders</q> in the `prefix` <q>folder</q>. ||
|| `encoding-type` | Encoding of server responses.

{{ objstorage-name }} can encode responses in the format requested by the client.

The possible value is `url`. ||
|| `key-marker` | Key to start the output from.

In the output, {{ objstorage-name }} will leave the keys starting from the one that follows `key-marker`. ||
|| `max-keys` | Maximum number of elements in a response.

By default, {{ objstorage-name }} outputs no more than 1,000 `Contents` and `CommonPrefixes` elements. Use this parameter if you need fewer than 1,000 elements in a single response.

If the selection criteria are met by more keys than can fit into the output, the response will contain `<IsTruncated>true</IsTruncated>`.

To get all the output elements if their number exceeds `max-keys`, run multiple consecutive requests to {{ objstorage-name }} with the `key-marker` parameter, where the `key-marker` and `version-id-marker` of each request are equal to the values of the `NextKeyMarker` and `NextVersionIdMarker` elements in the previous response. ||
|| `prefix` | String to start the key from.

{{ objstorage-name }} selects only those keys which start with `prefix`.

Can be used together with `delimiter`. In this case, the output logic is the same as that specified in the `delimiter` parameter description. ||
|| `version-id-marker` | Object version to start the output from.

In the output, {{ objstorage-name }} will leave the versions starting from the one following `version-id-marker`. ||
|#

### Headings {#request-headers}

Use only [common headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

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

#|
|| **Element** | **Description** ||
|| `ListVersionsResult` | Root element. ||
|| `CommonPrefixes` | Key name part identified when processing the `delimiter` and `prefix` request parameters.

Path: `/ListVersionsResult/CommonPrefixes`. ||
|| `DeleteMarker` | Container for an object that is a delete marker.

Path: `/ListVersionsResult/DeleteMarker`. ||
||`Delimiter` | Value of the `delimiter` request parameter.

Path: `/ListVersionsResult/Delimiter`. ||
|| `EncodingType` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.

You will get this tag if the client provided the `encoding-type` parameter in the request.

Path: `/ListVersionsResult/EncodingType`. ||
|| `IsTruncated` | Tag that indicates that a list is incomplete.

If `IsTruncated` is `true`, this means {{ objstorage-name }} returned an incomplete list of parts.

Path: `/ListVersionsResult/IsTruncated`. ||
|| `KeyMarker` | Last key returned in the incomplete response.

Path: `/ListVersionsResult/KeyMarker`. ||
|| `MaxKeys` | Value of the `max-keys` request parameter.

Path: `/ListBucketResult/MaxKeys`. ||
|| `Name` | Bucket name.

Path: `/ListBucketResult/Name`. ||
|| `NextKeyMarker` | Value to substitute into the `key-marker` query parameter to get the next part of the list, if the entire list does not fit into the current response.

Path: `/ListBucketResult/NextMarker`. ||
|| `NextVersionIdMarker` | Value to substitute into the `version-id-marker` query parameter to get the next part of the list, if the entire list does not fit into the current response.

Path: `/ListBucketResult/NextVersionIdMarker`. ||
|| `Prefix` | Value of the `prefix` request parameter.

Path: `/ListBucketResult/Prefix`. ||
|| `Version` | Object version.

Path: `/ListBucketResult/Version`. ||
|| `VersionIdMarker` | Marks the last version of the key returned in the truncated response. 

Path: `/ListBucketResult/VersionIdMarker`. ||
|#

#### Related articles {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../../storage/concepts/object-lock.md)

* [{#T}](../../../operations/objects/restore-object-version.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
