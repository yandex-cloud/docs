[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Video](index.md) > RenewSource

# Video API, REST: Video.RenewSource

Renews video source data for further upload.
This method is not applicable to videos in WAIT_UPLOADING and PROCESSING statuses.
Returns an operation which restores the previously uploaded video source upon cancellation.


## HTTP request

```
POST https://video.api.cloud.yandex.net/video/v1/videos/{videoId}:renewSource
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.video.v1.RenewVideoSourceRequest}

```json
{
  // Includes only one of the fields `tusd`
  "tusd": {
    "fileSize": "string",
    "fileName": "string",
    "isDeferred": "boolean"
  },
  // end of the list of possible fields
  "autoTranscode": "string"
}
```

#|
||Field | Description ||
|| tusd | **[VideoTUSDParams](#yandex.cloud.video.v1.VideoTUSDParams)**

Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
This is a push-based upload method where the client pushes data to the server.

Includes only one of the fields `tusd`.

Specifies the video upload source method (exactly one must be chosen). ||
|| autoTranscode | **enum** (AutoTranscode)

New auto-transcoding setting for the video.
Controls whether transcoding starts automatically after upload.

- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|#

## VideoTUSDParams {#yandex.cloud.video.v1.VideoTUSDParams}

#|
||Field | Description ||
|| fileSize | **string** (int64)

Total size of the file to be uploaded, in bytes.
MUST be positive if upload length is not deferred, otherwise MUST be 0.

The minimum value is 0. ||
|| fileName | **string**

Original name of the file being uploaded.
This is used for reference and does not affect the upload process. ||
|| isDeferred | **boolean**

Defer upload file size.
File size MUST be provided by first client's PATCH request.
@see https://tus.io/protocols/resumable-upload#post ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#