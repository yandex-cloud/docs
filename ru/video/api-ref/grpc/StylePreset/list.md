---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StylePreset/list.md
---

# Video API, gRPC: StylePresetService.List

Lists all style presets in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## gRPC request

**rpc List ([ListStylePresetsRequest](#yandex.cloud.video.v1.ListStylePresetsRequest)) returns ([ListStylePresetsResponse](#yandex.cloud.video.v1.ListStylePresetsResponse))**

## ListStylePresetsRequest {#yandex.cloud.video.v1.ListStylePresetsRequest}

```json
{
  "channel_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel containing the style presets to list. ||
|| page_size | **int64**

The maximum number of style presets to return per page. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListStylePresetsResponse. ||
|| order_by | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned style presets.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'dark' AND id='preset-1'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported. ||
|#

## ListStylePresetsResponse {#yandex.cloud.video.v1.ListStylePresetsResponse}

```json
{
  "style_presets": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| style_presets[] | **[StylePreset](#yandex.cloud.video.v1.StylePreset)**

List of style presets matching the request criteria.
May be empty if no style presets match the criteria or if the channel has no style presets. ||
|| next_page_token | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
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
|| right_widgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display to the right of the player. ||
|| bottom_widgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display below the player. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the style preset was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the style preset or its metadata. ||
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