# Object Storage API, Amazon S3-compatible REST: ListObjects

Returns a list of bucket objects.

It does not return object contents; use the [get](../object/get.md) method instead.

Output is paginated; you can get a list of up to 1,000 objects per request. If there are more objects, make multiple consecutive requests.

{% note info %}

This method has two versions:

* `listObjectsV2`: Current version, which is easier to use.
* `listObjectsV1`: Previous version.

Both methods are called using the same `URL` but with different query parameters. To call `listObjectsV2`, use the [`list-type=2`](#requestV2) parameter.

{% endnote %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## listObjectsV2 {#listObjectsV2}

### Request {#requestV2}

```http
GET /{bucket}?list-type=2&continuation-token=ContinuationToken&delimiter=Delimiter&encoding-type=EncodingType&max-keys=MaxKeys&prefix=Prefix&start-after=StartAfter HTTP/2
```

#### Path parameters {#path-parametersV2}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

#### Query parameters {#parametersV2}

All parameters listed in the table are optional.

#|
|| **Parameter** | **Description** ||
|| `continuation-token` | Use this parameter to get the next part of the list if all results do not fit in a single response.
To get the next part of the list, use the `NextContinuationToken` value from the previous response. ||
|| `delimiter` | Delimiter character.

If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In the response, the user will get a list of <q>files</q> and <q>folders</q> in the bucket. <q>Files</q> will be output in the `Contents` elements, and <q>folders</q>, in the `CommonPrefixes` elements.

If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return a list of <q>files</q> and <q>folders</q> in the `prefix` <q>folder</q>. ||
|| `encoding-type` | Encoding of server responses.

{{ objstorage-name }} can encode responses in the format requested by the client.

The possible value is `url`. ||
|| `max-keys` | Maximum number of elements in a response.

By default, {{ objstorage-name }} outputs no more than 1,000 `Contents` and `CommonPrefixes` elements. Use this parameter if you need fewer than 1,000 elements in a single response.

If the selection criteria are met by more keys than can fit into the output, the response will contain `<IsTruncated>true</IsTruncated>`.

To get all the output elements if their number exceeds `max-keys`, run multiple requests to {{ objstorage-name }} with the `continuation-token` parameter, where the `continuation-token` of each request is equal to the value of the `NextContinuationToken` element in the previous response. ||
|| `prefix` | String to start the key from.

{{ objstorage-name }} selects only those keys which start with `prefix`.

Can be used together with `delimiter`. In this case, the output logic is determined by the `delimiter` parameter. ||
|| `start-after` | Key to start the listing from. ||
|#

#### Headings {#request-headersV2}

Use only [common headers](../common-request-headers.md) in your requests.

### Response {#responseV2}

#### Headers {#response-headersV2}

Responses can only contain [common headers](../common-response-headers.md).

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

#|
|| **Element** | **Description** ||
|| `ListBucketResult` | Root element. ||
|| `IsTruncated` | This flag shows whether all results are returned in the response.

`True` means not all, `False` stands for all.

Path: `/ListBucketResult/IsTruncated`. ||
|| `Contents` | Object description.

The response contains as many `Contents` elements as there are keys that meet the request criteria.

Path: `/ListBucketResult/Contents`. ||
|| `ETag` | MD5 hash of the object. No metadata is included in the hash value calculation.

Path: `/ListBucketResult/Contents/ETag`. ||
|| `Key` | Object key.

Path: `/ListBucketResult/Contents/Key`. ||
||`LastModified` | Date and time when the object was last modified.

Path: `/ListBucketResult/Contents/LastModified`. ||
|| `Size` | Object size in bytes.

Path: `/ListBucketResult/Contents/Size`. ||
|| `StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, `ICE`, or `INTELLIGENT_TIERING`.

Path: `/ListBucketResult/Contents/StorageClass`. ||
|| `Name` | Bucket name.

Path: `/ListBucketResult/Name`. ||
|| `Prefix` | Value of the `prefix` request parameter.

Path: `/ListBucketResult/Prefix`. ||
|| `Delimiter` | Value of the `delimiter` request parameter.

Path: `/ListBucketResult/Delimiter`. ||
|| `MaxKeys` | Value of the `max-keys` request parameter.

Path: `/ListBucketResult/MaxKeys`. ||
|| `CommonPrefixes` | Key name part identified when processing the `delimiter` and `prefix` request parameters.

Path: `/ListBucketResult/CommonPrefixes`. ||
|| `EncodingType` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.

You will get this tag if the client provided the `encoding-type` parameter in the request.

Path: `/ListBucketResult/EncodingType`. ||
|| `KeyCount` | Number of keys the request returns.
The number of keys is always less than or equal to `MaxKeys`.

Path: `/ContinuationToken/KeyCount`. ||
|| `ContinuationToken` | Value of the `continuation-token` request parameter.

Path: `/ContinuationToken/ContinuationToken`. ||
|| `NextContinuationToken` | Value to substitute into the `continuation-token` query parameter to get the next part of the list, if the entire list does not fit into the current response.
It is returned only in case `IsTruncated = true`.

Path: `/ListBucketResult/NextContinuationToken`. ||
|| `StartAfter` | Value of the `start-after` request parameter.

Path: `/ListBucketResult/StartAfter`. ||
|#

## listObjectsV1 {#listObjectsV1}

### Request {#requestV1}

```http
GET /{bucket}?delimiter=Delimiter&encoding-type=EncodingType&marker=Marker&max-keys=MaxKeys&prefix=Prefix HTTP/2
```

#### Path parameters {#path-parametersV1}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

#### Query parameters {#parametersV1}

All parameters listed in the table are optional.

#|
|| **Parameter** | **Description** ||
|| `delimiter` | Delimiter character.

If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In the response, the user will get a list of <q>files</q> and <q>folders</q> in the bucket. <q>Files</q> will be output in the `Contents` elements, and <q>folders</q>, in the `CommonPrefixes` elements.

If the request also specifies the `prefix` parameter, {{ objstorage-name }} will return a list of <q>files</q> and <q>folders</q> in the `prefix` <q>folder</q>. ||
|| `encoding-type` | Encoding of server responses.

{{ objstorage-name }} can encode responses in the format requested by the client.

The possible value is `url`. ||
|| `marker` | Key to start the output from.

In the output, {{ objstorage-name }} will leave the keys starting from the one that follows `marker`. ||
|| `max-keys` | Maximum number of elements in a response.

By default, {{ objstorage-name }} outputs no more than 1,000 `Contents` and `CommonPrefixes` elements. Use this parameter if you need fewer than 1,000 elements in a single response.

If the selection criteria are met by more keys than can fit into the output, the response will contain `<IsTruncated>true</IsTruncated>`.

To get all the output elements if their number exceeds `max-keys`, run multiple requests to {{ objstorage-name }} with the `marker` parameter, where the `marker` of each request is equal to the value of the `NextMarker` element in the previous response. ||
|| `prefix` | String to start the key from.

{{ objstorage-name }} selects only those keys which start with `prefix`.

Can be used together with `delimiter`. In this case, the output logic is determined by the `delimiter` parameter. ||
|#

#### Headings {#request-headersV1}

Use only [common headers](../common-request-headers.md) in your requests.

### Response {#responseV1}

#### Headers {#response-headersV1}

Responses can only contain [common headers](../common-response-headers.md).

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

#|
|| **Element** | **Description** ||
|| `ListBucketResult` | Root element. ||
|| `IsTruncated` | This flag shows whether all results are returned in the response.

`True` means not all, `False` stands for all.

Path: `/ListBucketResult/IsTruncated`. ||
|| `Marker` | Value of the `marker` request parameter.

Path: `/ListBucketResult/Marker`. ||
|| `NextMarker` | Value to substitute into the `marker` query parameter to get the next part of the list, if the entire list does not fit into the current response.

Path: `/ListBucketResult/NextMarker`. ||
|| `Contents` | Object description.

The response contains as many `Contents` elements as there are keys that meet the request criteria.

Path: `/ListBucketResult/Contents`. ||
|| `ETag` | MD5 hash of the object. No metadata is included in the hash value calculation.

Path: `/ListBucketResult/Contents/ETag`. ||
|| `Key` | Object key.

Path: `/ListBucketResult/Contents/Key`. ||
|| `LastModified` | Date and time when the object was last modified.

Path: `/ListBucketResult/Contents/LastModified`. ||
|| `Size` | Object size in bytes.

Path: `/ListBucketResult/Contents/Size`. ||
|| `StorageClass` | Object [storage class](../../../concepts/storage-class.md): `STANDARD`, `COLD`, `ICE`, or `INTELLIGENT_TIERING`.

Path: `/ListBucketResult/Contents/StorageClass`. ||
|| `Name` | Bucket name.

Path: `/ListBucketResult/Name`. ||
|| `Prefix` | Value of the `prefix` request parameter.

Path: `/ListBucketResult/Prefix`. ||
|| `Delimiter` | Value of the `delimiter` request parameter.

Path: `/ListBucketResult/Delimiter`. ||
|| `MaxKeys` | Value of the `max-keys` request parameter.

Path: `/ListBucketResult/MaxKeys`. ||
|| `CommonPrefixes` | Key name part identified when processing the `delimiter` and `prefix` request parameters.

Path: `/ListBucketResult/CommonPrefixes`. ||
|| `EncodingType` | Encoding used by {{ objstorage-name }} to provide a key in an XML response.

You will get this tag if the client provided the `encoding-type` parameter in the request.

Path: `/ListBucketResult/EncodingType`. ||
|#

#### Related articles {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../operations/objects/list.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
