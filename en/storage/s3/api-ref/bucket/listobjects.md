# listObjects method

Returns a list of bucket objects.

Pagination is used for output. You can get a list of up to 1000 objects per request. If there are more objects, make several consecutive requests.

## Request {#request}

```
GET /{bucket} HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#parameters}

All the parameters listed in the table are optional.

| Parameter | Description |
| ----- | ----- |
| `delimiter` | Delimiter character.<br/><br/>If this parameter is specified, {{ objstorage-name }} interprets the key as the path to the file with folders separated by the `delimiter` character. In response to the request, the user gets a list of <q>files</q> and <q>folders</q> in the bucket. <q>Files</q> are output in the `Contents` elements, and <q>folders</q> in the `CommonPrefixes` elements.<br/><br/>If the request also specifies the `prefix` parameter, {{ objstorage-name }} returns a list of <q>files</q> and <q> folders</q> in the <q></q> `prefix` folder. |
| `marker` | Key to start the output from.<br/><br/>In the resulting output, {{ objstorage-name }} leaves the keys starting from the one following the `marker`. |
| `max-keys` | Maximum number of elements in a response.<br/><br/>By default, {{ objstorage-name }} returns a maximum of 1000 `Contents` and `CommonPrefixes` elements. This parameter should be used if you need to get less than 1000 elements in a single response.<br/><br/>If the number of keys meeting the selection criteria is greater than the number that could fit in the output, the response contains `<IsTruncated>true</IsTruncated>`.<br/><br/>To get all output elements if their number exceeds the `max-keys` value, make several consecutive requests to {{ objstorage-name }} with the `marker` parameter, where, for each request, the `marker` is equal to the value of the `MaxKeys` element from the previous response. |
| `prefix` | String to start the key from.<br/><br/>{{ objstorage-name }} selects only those keys that start with `prefix`.<br/><br/>Can be used simultaneously with the `delimiter` parameter. In this case, the output logic is the same as that specified in the `delimiter` parameter description. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#structure}

```
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
    <Name>bucket</Name>
    <Prefix/>
    <Marker/>
    <MaxKeys>1000</MaxKeys>
    <IsTruncated>false</IsTruncated>
    <Contents>
        <Key>my-image.jpg</Key>
        <LastModified>2018-09-10T17:50:30.000Z</LastModified>
        <ETag>MD5</ETag>
        <Size>434234</Size>
        <StorageClass>STANDARD</StorageClass>
    </Contents>
</ListBucketResult>
```

| Element | Description |
| ----- | ----- |
| `Contents` | Object description.<br/><br/>The response contains as many `Contents` elements as there are keys that meet the request criteria.<br/><br/>Path: `/ListBucketResult/Contents`. |
| `CommonPrefixes` | Part of the key name that is identified when processing the `delimiter` and `prefix` path parameters.<br/><br/>Path: `/ListBucketResult/CommonPrefixes`. |
| `Delimiter` | Value of the `delimiter` path parameter.<br/><br/>Path: `/ListBucketResult/Delimiter`. |
| `ETag` | MD5 hash of the object. No metadata is included in the hash value calculation.<br/><br/>Path: `/ListBucketResult/Contents/ETag`. |
| `IsTruncated` | Flag indicating whether all results are returned in the response.<br/><br/>`True`: All. `False`: Not all.<br/><br/>Path: `/ListBucketResult/IsTruncated`. |
| `Key` | Object key.<br/><br/>Path: `/ListBucketResult/Contents/Key`. |
| `LastModified` | Date and time when the object was last modified.<br/><br/>Path: `/ListBucketResult/Contents/LastModified`. |
| `Marker` | Value of the `marker` path parameter.<br/><br/>Path: `/ListBucketResult/Marker`. |
| `MaxKeys` | Value of the `max-keys` path parameter.<br/><br/>Path: `/ListBucketResult/MaxKeys`. |
| `Name` | Bucket name.<br/><br/>Path: `/ListBucketResult/Name`. |
| `NextMarker` | Value to insert in the `marker` path parameter to get the next part of the list if the entire list does not fit in the current response.<br/><br/>Path: `/ListBucketResult/NextMarker`. |
| `Prefix` | Value of the `prefix` path parameter.<br/><br/>Path: `/ListBucketResult/Prefix`. |
| `Size` | Object size in bytes.<br/><br/>Path: `/ListBucketResult/Contents/Size`. |
| `StorageClass` | Object storage class: `STANDARD` or `COLD`.<br/><br/>Path: `/ListBucketResult/Contents/StorageClass`. |

