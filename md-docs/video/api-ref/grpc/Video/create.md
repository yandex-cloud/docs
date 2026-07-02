[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Video](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Video](index.md) > Create

# Video API, gRPC: VideoService.Create

Creates a new video in the specified channel.
The video can be created from different sources: TUS upload, direct link, or S3 storage.

## gRPC request

**rpc Create ([CreateVideoRequest](#yandex.cloud.video.v1.CreateVideoRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateVideoRequest {#yandex.cloud.video.v1.CreateVideoRequest}

```json
{
  "channel_id": "string",
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "auto_transcode": "AutoTranscode",
  "style_preset_id": "string",
  "auto_publish": "google.protobuf.BoolValue",
  "enable_ad": "google.protobuf.BoolValue",
  "labels": "map<string, string>",
  // Includes only one of the fields `tusd`
  "tusd": {
    "file_size": "int64",
    "file_name": "string",
    "is_deferred": "bool"
  },
  // end of the list of possible fields
  // Includes only one of the fields `public_access`, `sign_url_access`
  "public_access": "VideoPublicAccessParams",
  "sign_url_access": "VideoSignURLAccessParams"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel where the video will be created.

The maximum string length in characters is 50. ||
|| title | **string**

Required field. Title of the video to be displayed in interfaces and players.

The maximum string length in characters is 300. ||
|| description | **string**

Detailed description of the video content and context.
Optional field that can provide additional information about the video.

The maximum string length in characters is 5000. ||
|| thumbnail_id | **string**

ID of the thumbnail image to be used for the video.
If not provided, a thumbnail may be automatically generated during transcoding.

The maximum string length in characters is 50. ||
|| auto_transcode | enum **AutoTranscode**

Controls whether transcoding starts automatically after upload.
Set to ENABLE to automatically initiate transcoding after upload,
or DISABLE for manual initiation via the Transcode() method.

- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|| style_preset_id | **string**

ID of the style preset to apply to the video during processing.
Style presets define visual appearance settings for the video player.

The maximum string length in characters is 50. ||
|| auto_publish | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether the video is automatically published after transcoding.
When set to true, the video's visibility status will be set to PUBLISHED
once transcoding is complete, making it available for watching. ||
|| enable_ad | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

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
|| public_access | **[VideoPublicAccessParams](#yandex.cloud.video.v1.VideoPublicAccessParams)**

Video is publicly available.

Includes only one of the fields `public_access`, `sign_url_access`.

Video access permission settings (exactly one must be chosen). ||
|| sign_url_access | **[VideoSignURLAccessParams](#yandex.cloud.video.v1.VideoSignURLAccessParams)**

Access to the video is restricted by temporarily signed links.

Includes only one of the fields `public_access`, `sign_url_access`.

Video access permission settings (exactly one must be chosen). ||
|#

## VideoTUSDParams {#yandex.cloud.video.v1.VideoTUSDParams}

#|
||Field | Description ||
|| file_size | **int64**

Total size of the file to be uploaded, in bytes.
MUST be positive if upload length is not deferred, otherwise MUST be 0.

The minimum value is 0. ||
|| file_name | **string**

Original name of the file being uploaded.
This is used for reference and does not affect the upload process. ||
|| is_deferred | **bool**

Defer upload file size.
File size MUST be provided by first client's PATCH request.
@see https://tus.io/protocols/resumable-upload#post ||
|#

## VideoPublicAccessParams {#yandex.cloud.video.v1.VideoPublicAccessParams}

Parameters for video public access rights.

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoSignURLAccessParams {#yandex.cloud.video.v1.VideoSignURLAccessParams}

Parameters for video access restrictions based on temporary signed links.

#|
||Field | Description ||
|| Empty | > ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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