---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/stylePresets/{stylePresetId}
    method: get
    path:
      type: object
      properties:
        stylePresetId:
          description: |-
            **string**
            Required field. ID of the style preset to retrieve.
          type: string
      required:
        - stylePresetId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/StylePreset/get.md
---

# Video API, REST: StylePreset.Get

Retrieves detailed information about a specific style preset by its ID.
Returns all style preset properties, colors, layout settings, and widget configurations.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/stylePresets/{stylePresetId}
```

## Path parameters

#|
||Field | Description ||
|| stylePresetId | **string**

Required field. ID of the style preset to retrieve. ||
|#

## Response {#yandex.cloud.video.v1.StylePreset}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "channelId": "string",
  "title": "string",
  "backgroundColor": "string",
  "widgetTextColorPrimary": "string",
  "widgetTextColorSecondary": "string",
  "widgetAccentColor": "string",
  "widgetBlockGap": "string",
  "widgetBlockSeparatorColor": "string",
  "playerBorderRadius": "string",
  "playerColor": "string",
  "playlistSelectedItemBackgroundColor": "string",
  "playlistItemBorderRadius": "string",
  "playlistItemGap": "string",
  "playlistLocation": "string",
  "rightWidgets": [
    {
      // Includes only one of the fields `summarization`, `description`
      "summarization": "object",
      "description": "object"
      // end of the list of possible fields
    }
  ],
  "bottomWidgets": [
    {
      // Includes only one of the fields `summarization`, `description`
      "summarization": "object",
      "description": "object"
      // end of the list of possible fields
    }
  ],
  "createdAt": "string",
  "updatedAt": "string"
}
```

Entity representing a collection of visual styling settings for content presentation.
Style presets define the appearance of players, widgets, and other UI elements
to ensure consistent branding and user experience.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the style preset. ||
|| channelId | **string**

Identifier of the channel where this style preset is created and managed. ||
|| title | **string**

Display name of the style preset shown in interfaces. ||
|| backgroundColor | **string**

Background color for the player page in hexadecimal format (e.g., "#FFFFFF"). ||
|| widgetTextColorPrimary | **string**

Primary text color for widgets in hexadecimal format. ||
|| widgetTextColorSecondary | **string**

Secondary text color for widgets in hexadecimal format. ||
|| widgetAccentColor | **string**

Accent color for interactive elements in widgets in hexadecimal format. ||
|| widgetBlockGap | **string** (int64)

Vertical spacing between widget blocks in pixels. ||
|| widgetBlockSeparatorColor | **string**

Color of separator lines between widget blocks in hexadecimal format. ||
|| playerBorderRadius | **string** (int64)

Corner radius of the player container in pixels. ||
|| playerColor | **string**

Primary color for player controls in hexadecimal format. ||
|| playlistSelectedItemBackgroundColor | **string**

Background color for the currently selected item in playlists in hexadecimal format. ||
|| playlistItemBorderRadius | **string** (int64)

Corner radius of playlist items in pixels. ||
|| playlistItemGap | **string** (int64)

Spacing between playlist items in pixels. ||
|| playlistLocation | **enum** (WidgetLocation)

Position of the playlist widget relative to the player.

- `WIDGET_LOCATION_UNSPECIFIED`: The widget location is not specified.
- `RIGHT`: Position the widget to the right of the player.
- `BOTTOM`: Position the widget below the player. ||
|| rightWidgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display to the right of the player. ||
|| bottomWidgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display below the player. ||
|| createdAt | **string** (date-time)

Timestamp when the style preset was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the style preset or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Widget {#yandex.cloud.video.v1.Widget}

Represents a UI component that displays additional content or functionality.
Widgets can be positioned in different locations around the player.

#|
||Field | Description ||
|| summarization | **object**

Widget that displays video content summarization.

Includes only one of the fields `summarization`, `description`.

Specifies the type of widget to display. ||
|| description | **object**

Widget that displays detailed video description.

Includes only one of the fields `summarization`, `description`.

Specifies the type of widget to display. ||
|#