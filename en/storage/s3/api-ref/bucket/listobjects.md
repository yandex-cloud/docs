# listObjects method

Returns a list of bucket objects.

It does not return object contents. To get them, use the [get](../object/get.md) method.

Pagination is used for output. You can get a list of up to 1,000 objects per request. If there are more objects, make multiple consecutive requests.

{% note info %}

This method has two versions:
- `listObjectsV2`: Current version, which is easier to use.
- `listObjectsV1`: Previous version.

The same `URL`, with different query parameters, is used to call both methods. To call `listObjectsV2`, use the [`list-type=2`](#requestV2) parameter.

{% endnote %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## listObjectsV2 {#listObjectsV2}

### Request {#requestV2}

```http
GET /{bucket}?list-type=2&continuation-token=ContinuationToken&delimiter=Delimiter&encoding-type=EncodingType&max-keys=MaxKeys&prefix=Prefix&start-after=StartAfter HTTP/2
```

#### Path parameters {#path-parametersV2}

Parameter | Description
----- | -----
`bucket` | Bucket name.

#### Query parameters {#parametersV2}

All parameters listed in the table are optional.

Parameter | Description
----- | -----
`continuation-token` | Used to get the next part of the list if all results do not fit in a single response.<br/>To get the next part of the list, use the `NextContinuationToken` value from the previous response.
`delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In response to the request, the user gets a list of files and folders in the bucket. Files will be output in the `Contents` elements, and folders, in the `CommonPrefixes` elements.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return the list of files and folders in the folder named `prefix`.
`encoding-type` | Encoding of server response.<br/><br/>{{ objstorage-name }} can encode responses in the format requested by the client.<br/><br/>Possible values: `url`.
`max-keys` | Maximum number of elements in a response.<br/><br/>By default, {{ objstorage-name }} outputs no more than 1,000 `Contents` and `CommonPrefixes` elements. Use this parameter if you need less than 1,000 elements in a single response.<br/><br/>If the selection criteria are met by more keys than can fit into the output, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output elements if their number exceeds `max-keys`, run multiple requests to {{ objstorage-name }} with the `continuation-token` parameter, where the `continuation-token` of each request is equal to the value of the `NextContinuationToken` element in the previous response.
`prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} selects only those keys which start with `prefix`.<br/><br/>You can use this parameter along with `delimiter`. In this case, the output logic is determined by the `delimiter` parameter.
`start-after` | Key to start the listing from.

#### Headers {#request-headersV2}
Use only [common request headers](../common-request-headers.md) in your requests.

### Response {#responseV2}

#### Headers {#response-headersV2}

Responses can only contain [common response headers](../common-response-headers.md).

#### Response codes {#response-codesV2}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

#### Data schema {#structureV2}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
   <IsTruncated>boolean</IsTruncated>
   <Contents>
      <ETag>string</ETag>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Size>integer</Size>
      <StorageClass>string</StorageClass>
   </Contents>
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
   <KeyCount>integer</KeyCount>
   <ContinuationToken>string</ContinuationToken>
   <NextContinuationToken>string</NextContinuationToken>
   <StartAfter>string</StartAfter>
</ListBucketResult>
```

Element | Description
----- | -----
`ListBucketResult` | Root element.
`IsTruncated` | This flag shows whether all results are returned in the response.<br/><br/>`True` means not all, `False` stands for all.<br/><br/>Path: `/ListBucketResult/IsTruncated`.
`Contents` | Object description.<br/><br/>The response contains as many `Contents` elements as there are keys that meet the request criteria.<br/><br/>Path: `/ListBucketResult/Contents`.
`ETag` | MD5 hash of the object. No metadata is included in the hash value calculation.<br/><br/>Path: `/ListBucketResult/Contents/ETag`.
`Key` | Object key.<br/><br/>Path: `/ListBucketResult/Contents/Key`.
`LastModified` | Object’s last update date.<br/><br/>Path: `/ListBucketResult/Contents/LastModified`.
`Size` | Object size in bytes.<br/><br/>Path: `/ListBucketResult/Contents/Size`.
`StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, or `ICE`.<br/><br/>Path: `/ListBucketResult/Contents/StorageClass`.
`Name` | Bucket name.<br/><br/>Path: `/ListBucketResult/Name`.
`Prefix` | Value of the `prefix` query parameter.<br/><br/>Path: `/ListBucketResult/Prefix`.
`Delimiter` | Value of the `delimiter` query parameter.<br/><br/>Path: `/ListBucketResult/Delimiter`.
`MaxKeys` | Value of the `max-keys` query parameter.<br/><br/>Path: `/ListBucketResult/MaxKeys`.
`CommonPrefixes` | Key name part identified when processing the `delimiter` and `prefix` query parameters.<br/><br/>Path: `/ListBucketResult/CommonPrefixes`.
`EncodingType` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.<br/><br/>Appears if the client provided the `encoding-type` parameter in the request.<br/><br/>Path: `/ListBucketResult/EncodingType`.
`KeyCount` | Number of keys the request returns.<br/>The number of keys is always less than or equal to `MaxKeys`.<br/><br/>Path: `/ContinuationToken/KeyCount`.
`ContinuationToken` | Value of the `continuation-token` query parameter.<br/><br/>Path: `/ContinuationToken/ContinuationToken`.
`NextContinuationToken` | Value to insert in the `continuation-token` query parameter to get the next part of the list if the entire list does not fit in the current response.<br/>It is returned only in case `IsTruncated = true`.<br/><br/>Path: `/ListBucketResult/NextContinuationToken`.
`StartAfter` | Value of the `start-after` query parameter.<br/><br/>Path: `/ListBucketResult/StartAfter`.

## listObjectsV1 {#listObjectsV1}

### Request {#requestV1}

```http
GET /{bucket}?delimiter=Delimiter&encoding-type=EncodingType&marker=Marker&max-keys=MaxKeys&prefix=Prefix HTTP/2
```

#### Path parameters {#path-parametersV1}

Parameter | Description
----- | -----
`bucket` | Bucket name.

#### Query parameters {#parametersV1}

All parameters listed in the table are optional.

Parameter | Description
----- | -----
`delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In response to the request, the user gets a list of files and folders in the bucket. Files will be output in the `Contents` elements, and folders in the `CommonPrefixes` elements.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return the list of files and folders in the folder named `prefix`.
`encoding-type` | Encoding of server response.<br/><br/>{{ objstorage-name }} can encode responses in the format requested by the client.<br/><br/>Possible values: `url`.
`marker` | Key to start the output from.<br/><br/>In the resulting output, {{ objstorage-name }} will leave the keys starting from the one following `marker`.
`max-keys` | Maximum number of elements in a response.<br/><br/>By default, {{ objstorage-name }} outputs no more than 1,000 `Contents` and `CommonPrefixes` elements. Use this parameter if you need less than 1,000 elements in a single response.<br/><br/>If the selection criteria are met by more keys than can fit into the output, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output elements if their number exceeds `max-keys`, run multiple requests to {{ objstorage-name }} with the `marker` parameter, where the `marker` of each request is equal to the value of the `NextMarker` element in the previous response.
`prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} selects only those keys which start with `prefix`.<br/><br/>You can use this parameter along with `delimiter`. In this case, the output logic is determined by the `delimiter` parameter.

#### Headers {#request-headersV1}
Use only [common request headers](../common-request-headers.md) in your requests.

### Response {#responseV1}

#### Headers {#response-headersV1}

Responses can only contain [common response headers](../common-response-headers.md).

#### Response codes {#response-codesV1}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

#### Data schema {#structureV1}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
   <IsTruncated>boolean</IsTruncated>
   <Marker>string</Marker>
   <NextMarker>string</NextMarker>
   <Contents>
      <ETag>string</ETag>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Size>integer</Size>
      <StorageClass>string</StorageClass>
   </Contents>
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
</ListBucketResult>
```

Element | Description
----- | -----
`ListBucketResult` | Root element.
`IsTruncated` | This flag shows whether all results are returned in the response.<br/><br/>`True` means not all, `False` stands for all.<br/><br/>Path: `/ListBucketResult/IsTruncated`.
`Marker` | Value of the `marker` query parameter.<br/><br/>Path: `/ListBucketResult/Marker`.
`NextMarker` | Value to insert in the `marker` query parameter to get the next part of the list if the entire list does not fit in the current response.<br/><br/>Path: `/ListBucketResult/NextMarker`.
`Contents` | Object description.<br/><br/>The response contains as many `Contents` elements as there are keys that meet the request criteria.<br/><br/>Path: `/ListBucketResult/Contents`.
`ETag` | MD5 hash of the object. No metadata is included in the hash value calculation.<br/><br/>Path: `/ListBucketResult/Contents/ETag`.
`Key` | Object key.<br/><br/>Path: `/ListBucketResult/Contents/Key`.
`LastModified` | Object’s last update date.<br/><br/>Path: `/ListBucketResult/Contents/LastModified`.
`Size` | Object size in bytes.<br/><br/>Path: `/ListBucketResult/Contents/Size`.
`StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, or `ICE`.<br/><br/>Path: `/ListBucketResult/Contents/StorageClass`.
`Name` | Bucket name.<br/><br/>Path: `/ListBucketResult/Name`.
`Prefix` | Value of the `prefix` query parameter.<br/><br/>Path: `/ListBucketResult/Prefix`.
`Delimiter` | Value of the `delimiter` query parameter.<br/><br/>Path: `/ListBucketResult/Delimiter`.
`MaxKeys` | Value of the `max-keys` query parameter.<br/><br/>Path: `/ListBucketResult/MaxKeys`.
`CommonPrefixes` | Key name part identified when processing the `delimiter` and `prefix` query parameters.<br/><br/>Path: `/ListBucketResult/CommonPrefixes`.
`EncodingType` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.<br/><br/>Appears if the client provided the `encoding-type` parameter in the request.<br/><br/>Path: `/ListBucketResult/EncodingType`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}