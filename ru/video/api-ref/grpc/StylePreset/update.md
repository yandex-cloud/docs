---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StylePreset/update.md
---

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

Required field. ID of the style preset. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields of the style preset should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| title | **string**

Style preset title. ||
|| background_color | **string**

Background color. ||
|| widget_text_color_primary | **string**

Widget primary text color. ||
|| widget_text_color_secondary | **string**

Widget secondary text color. ||
|| widget_accent_color | **string**

Widget accent color. ||
|| widget_block_gap | **int64**

Gap between widget blocks. ||
|| widget_block_separator_color | **string**

Line color between widget blocks. ||
|| player_border_radius | **int64**

Player border radius. ||
|| player_color | **string**

Player color. ||
|| playlist_selected_item_background_color | **string**

Background color of selected video in playlist. ||
|| playlist_item_border_radius | **int64**

Playlist item border radius. ||
|| playlist_item_gap | **int64**

Gap between videos in playlist. ||
|| playlist_location | enum **WidgetLocation**

Playlist widget location.

- `WIDGET_LOCATION_UNSPECIFIED`: The widget location is not specified.
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
  "metadata": {
    "style_preset_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channel_id": "string",
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
    ],
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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
|| metadata | **[UpdateStylePresetMetadata](#yandex.cloud.video.v1.UpdateStylePresetMetadata)**

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
|| response | **[StylePreset](#yandex.cloud.video.v1.StylePreset)**

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

## UpdateStylePresetMetadata {#yandex.cloud.video.v1.UpdateStylePresetMetadata}

#|
||Field | Description ||
|| style_preset_id | **string**

ID of the style preset being updated. ||
|#

## StylePreset {#yandex.cloud.video.v1.StylePreset}

Entity representing a collection of visual styling settings for content presentation.
Style presets define the appearance of players, widgets, and other UI elements
to ensure consistent branding and user experience.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the style preset. ||
|| channel_id | **string**

Identifier of the channel where this style preset is created and managed. ||
|| title | **string**

Display name of the style preset shown in interfaces. ||
|| background_color | **string**

Background color for the player page in hexadecimal format (e.g., "#FFFFFF"). ||
|| widget_text_color_primary | **string**

Primary text color for widgets in hexadecimal format. ||
|| widget_text_color_secondary | **string**

Secondary text color for widgets in hexadecimal format. ||
|| widget_accent_color | **string**

Accent color for interactive elements in widgets in hexadecimal format. ||
|| widget_block_gap | **int64**

Vertical spacing between widget blocks in pixels. ||
|| widget_block_separator_color | **string**

Color of separator lines between widget blocks in hexadecimal format. ||
|| player_border_radius | **int64**

Corner radius of the player container in pixels. ||
|| player_color | **string**

Primary color for player controls in hexadecimal format. ||
|| playlist_selected_item_background_color | **string**

Background color for the currently selected item in playlists in hexadecimal format. ||
|| playlist_item_border_radius | **int64**

Corner radius of playlist items in pixels. ||
|| playlist_item_gap | **int64**

Spacing between playlist items in pixels. ||
|| playlist_location | enum **WidgetLocation**

Position of the playlist widget relative to the player.

- `WIDGET_LOCATION_UNSPECIFIED`: The widget location is not specified.
- `RIGHT`: Position the widget to the right of the player.
- `BOTTOM`: Position the widget below the player. ||
|| right_widgets[] | **[Widget](#yandex.cloud.video.v1.Widget2)**

List of widgets to display to the right of the player. ||
|| bottom_widgets[] | **[Widget](#yandex.cloud.video.v1.Widget2)**

List of widgets to display below the player. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the style preset was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the style preset or its metadata. ||
|#

## Widget {#yandex.cloud.video.v1.Widget2}

Represents a UI component that displays additional content or functionality.
Widgets can be positioned in different locations around the player.

#|
||Field | Description ||
|| summarization | **[Summarization](#yandex.cloud.video.v1.Widget.Summarization2)**

Widget that displays video content summarization.

Includes only one of the fields `summarization`, `description`.

Specifies the type of widget to display. ||
|| description | **[Description](#yandex.cloud.video.v1.Widget.Description2)**

Widget that displays detailed video description.

Includes only one of the fields `summarization`, `description`.

Specifies the type of widget to display. ||
|#

## Summarization {#yandex.cloud.video.v1.Widget.Summarization2}

Widget that presents an automatically generated summary of the video content.
This helps viewers quickly understand the main points without watching the entire video.

#|
||Field | Description ||
|| Empty | > ||
|#

## Description {#yandex.cloud.video.v1.Widget.Description2}

Widget that displays the full description text for the video.
This can include details about the content, creators, and other relevant information.

#|
||Field | Description ||
|| Empty | > ||
|#