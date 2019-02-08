# upload method

Uploads an object and its metadata to Yandex [!KEYREF objstorage-name].

> [!NOTE]
> 
> [!KEYREF objstorage-name] does not lock an object for writing and can simultaneously accept multiple write requests for the same object, but the user will only get the last object written from [!KEYREF objstorage-name].

To make sure an object is passed via the network without any corruption, use the `Content-MD5` header. [!KEYREF objstorage-name] calculates the `MD5` value for a saved object and, if the calculated `MD5` value does not match the one passed in the header, it returns an error. You can also perform this check on the client side by comparing the `ETag` from the [!KEYREF objstorage-name] response with the precalculated `MD5` value.

## Request {#request}

```
PUT /{bucket}/{key} HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |
| `key` | Object key. ID to use for saving the object in [!KEYREF objstorage-name]. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

You can also use the headers listed in the table below.

| Header name | Description |
| ----- | ----- |
| `x-amz-meta-*` | User-defined metadata for the object.<br/><br/>All headers starting with `x-amz-meta- are considered by` [!KEYREF objstorage-name] to be user-defined. It does not process these headers, but saves them in the original form.<br/><br/>The total size of user-defined headers should not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. |
| `x-amz-storage-class` | Object storage class.<br/><br/>Possible values:<br/>- `STANDARD` for uploading an object to standard storage.<br/>- `COLD`, `STANDARD_IA`, and `NEARLINE` for uploading an object to cold storage.<br/><br/>If the header is omitted, the object is saved in standard storage. |

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [[!TITLE]](../response-codes.md).

