# Video API, gRPC: StylePresetService.Update

Updates an existing style preset's properties and visual settings.
Only fields specified in the field_mask will be updated.

## gRPC request

**rpc Update ([UpdateStylePresetRequest](#yandex.cloud.video.v1.UpdateStylePresetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateStylePresetRequest {#yandex.cloud.video.v1.UpdateStylePresetRequest}

```json
{
  "style_preset_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "background_color": "string",
  "widget_text_color_primary": "string",
  "widget_text_color_secondary": "string",
  "widget_accent_color": "string",
  "widget_block_gap": "int64",
  "widget_block_separator_color": "string",
  "player_border_radius": "int64",
  "player_color": "string",
  "playlist_selected_item_background_color": "string",
  "playlist_item_border_radius": "int64",
  "playlist_item_gap": "int64",
  "playlist_location": "WidgetLocation",
  "right_widgets": [
    {
      // Includes only one of the fields `summarization`, `description`
      "summarization": "Summarization",
      "description": "Description"
      // end of the list of possible fields
    }
  ],
  "bottom_widgets": [
    {
      // Includes only one of the fields `summarization`, `description`
      "summarization": "Summarization",
      "description": "Description"
      // end of the list of possible fields
    }
  ]
}
```

#|
||Field | Description ||
|| style_preset_id | **string**

Required field. ID of the style preset.

The maximum string length in characters is 50. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields of the style preset should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| title | **string**

Style preset title.

The maximum string length in characters is 50. ||
|| background_color | **string**

Background color.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9-]* `. ||
|| widget_text_color_primary | **string**

Widget primary text color.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9-]* `. ||
|| widget_text_color_secondary | **string**

Widget secondary text color.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9-]* `. ||
|| widget_accent_color | **string**

Widget accent color.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9-]* `. ||
|| widget_block_gap | **int64**

Gap between widget blocks.

Acceptable values are 0 to 50, inclusive. ||
|| widget_block_separator_color | **string**

Line color between widget blocks.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9-]* `. ||
|| player_border_radius | **int64**

Player border radius.

The minimum value is 0. ||
|| player_color | **string**

Player color.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9]* `. ||
|| playlist_selected_item_background_color | **string**

Background color of selected video in playlist.

The maximum string length in characters is 50. Value must match the regular expression ` [#a-zA-Z0-9]* `. ||
|| playlist_item_border_radius | **int64**

Playlist item border radius.

The minimum value is 0. ||
|| playlist_item_gap | **int64**

Gap between videos in playlist.

Acceptable values are 0 to 50, inclusive. ||
|| playlist_location | enum **WidgetLocation**

Playlist widget location.

- `RIGHT`: Position the widget to the right of the player.
- `BOTTOM`: Position the widget below the player. ||
|| right_widgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display to the right of the player. ||
|| bottom_widgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display below the player. ||
|#

## Widget {#yandex.cloud.video.v1.Widget}

Represents a UI component that displays additional content or functionality.
Widgets can be positioned in different locations around the player.

#|
||Field | Description ||
|| summarization | **[Summarization](#yandex.cloud.video.v1.Widget.Summarization)**

Widget that displays video content summarization.

Includes only one of the fields `summarization`, `description`.

Specifies the type of widget to display. ||
|| description | **[Description](#yandex.cloud.video.v1.Widget.Description)**

Widget that displays detailed video description.

Includes only one of the fields `summarization`, `description`.

Specifies the type of widget to display. ||
|#

## Summarization {#yandex.cloud.video.v1.Widget.Summarization}

Widget that presents an automatically generated summary of the video content.
This helps viewers quickly understand the main points without watching the entire video.

#|
||Field | Description ||
|| Empty | > ||
|#

## Description {#yandex.cloud.video.v1.Widget.Description}

Widget that displays the full description text for the video.
This can include details about the content, creators, and other relevant information.

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