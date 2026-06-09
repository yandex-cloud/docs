# Video API, REST: Video.Create

Creates a new video in the specified channel.
The video can be created from different sources: TUS upload, direct link, or S3 storage.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos
```

## Body parameters {#yandex.cloud.video.v1.CreateVideoRequest}

```json
{
  "channelId": "string",
  "title": "string",
  "description": "string",
  "thumbnailId": "string",
  "autoTranscode": "string",
  "stylePresetId": "string",
  "autoPublish": "boolean",
  "enableAd": "boolean",
  "labels": "object",
  // Includes only one of the fields `tusd`
  "tusd": {
    "fileSize": "string",
    "fileName": "string",
    "isDeferred": "boolean"
  },
  // end of the list of possible fields
  // Includes only one of the fields `publicAccess`, `signUrlAccess`
  "publicAccess": "object",
  "signUrlAccess": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel where the video will be created.

The maximum string length in characters is 50. ||
|| title | **string**

Required field. Title of the video to be displayed in interfaces and players.

The maximum string length in characters is 300. ||
|| description | **string**

Detailed description of the video content and context.
Optional field that can provide additional information about the video.

The maximum string length in characters is 5000. ||
|| thumbnailId | **string**

ID of the thumbnail image to be used for the video.
If not provided, a thumbnail may be automatically generated during transcoding.

The maximum string length in characters is 50. ||
|| autoTranscode | **enum** (AutoTranscode)

Controls whether transcoding starts automatically after upload.
Set to ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|| stylePresetId | **string**

ID of the style preset to apply to the video during processing.
Style presets define visual appearance settings for the video player.

The maximum string length in characters is 50. ||
|| autoPublish | **boolean**

Controls whether the video is automatically published after transcoding.
When set to true, the video's visibility status will be set to PUBLISHED
once transcoding is complete, making it available for watching. ||
|| enableAd | **boolean**

Controls the ability to display advertisements for this video.
Default: true
Set explicitly to false to disable advertisements for this specific video. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per video.
Keys must be lowercase alphanumeric strings with optional hyphens/underscores.
Values can contain alphanumeric characters and various symbols.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource. ||
|| tusd | **[VideoTUSDParams](#yandex.cloud.video.v1.VideoTUSDParams)**

Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
This is a push-based upload method where the client pushes data to the server.

Includes only one of the fields `tusd`.

Specifies the video upload source method (exactly one must be chosen). ||
|| publicAccess | **object**

Video is publicly available.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Video access permission settings (exactly one must be chosen). ||
|| signUrlAccess | **object**

Access to the video is restricted by temporarily signed links.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Video access permission settings (exactly one must be chosen). ||
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