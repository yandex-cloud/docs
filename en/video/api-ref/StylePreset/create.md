---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/stylePresets
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel.
          type: string
        title:
          description: |-
            **string**
            Required field. Style preset title.
          pattern: '[a-zA-Z0-9-_ ]+'
          type: string
        backgroundColor:
          description: |-
            **string**
            Required field. Background color.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        widgetTextColorPrimary:
          description: |-
            **string**
            Required field. Widget primary text color.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        widgetTextColorSecondary:
          description: |-
            **string**
            Required field. Widget secondary text color.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        widgetAccentColor:
          description: |-
            **string**
            Required field. Widget accent color.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        widgetBlockGap:
          description: |-
            **string** (int64)
            Gap between widget blocks.
          type: string
          format: int64
        widgetBlockSeparatorColor:
          description: |-
            **string**
            Required field. Line color between widget blocks.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        playerBorderRadius:
          description: |-
            **string** (int64)
            Player border radius.
          type: string
          format: int64
        playerColor:
          description: |-
            **string**
            Required field. Player color.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        playlistSelectedItemBackgroundColor:
          description: |-
            **string**
            Required field. Background color of selected video in playlist.
          pattern: '[#a-zA-Z0-9]+'
          type: string
        playlistItemBorderRadius:
          description: |-
            **string** (int64)
            Playlist item border radius.
          type: string
          format: int64
        playlistItemGap:
          description: |-
            **string** (int64)
            Gap between videos in playlist.
          type: string
          format: int64
        playlistLocation:
          description: |-
            **enum** (WidgetLocation)
            Required field. Playlist widget location.
            - `WIDGET_LOCATION_UNSPECIFIED`: The widget location is not specified.
            - `RIGHT`: Position the widget to the right of the player.
            - `BOTTOM`: Position the widget below the player.
          type: string
          enum:
            - WIDGET_LOCATION_UNSPECIFIED
            - RIGHT
            - BOTTOM
        rightWidgets:
          description: |-
            **[Widget](/docs/video/api-ref/StylePreset/get#yandex.cloud.video.v1.Widget)**
            List of widgets to display to the right of the player.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  summarization:
                    description: |-
                      **object**
                      Widget that displays video content summarization.
                      Includes only one of the fields `summarization`, `description`.
                      Specifies the type of widget to display.
                    $ref: '#/definitions/Summarization'
                  description:
                    description: |-
                      **object**
                      Widget that displays detailed video description.
                      Includes only one of the fields `summarization`, `description`.
                      Specifies the type of widget to display.
                    $ref: '#/definitions/Description'
        bottomWidgets:
          description: |-
            **[Widget](/docs/video/api-ref/StylePreset/get#yandex.cloud.video.v1.Widget)**
            List of widgets to display below the player.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  summarization:
                    description: |-
                      **object**
                      Widget that displays video content summarization.
                      Includes only one of the fields `summarization`, `description`.
                      Specifies the type of widget to display.
                    $ref: '#/definitions/Summarization'
                  description:
                    description: |-
                      **object**
                      Widget that displays detailed video description.
                      Includes only one of the fields `summarization`, `description`.
                      Specifies the type of widget to display.
                    $ref: '#/definitions/Description'
      required:
        - channelId
        - title
        - backgroundColor
        - widgetTextColorPrimary
        - widgetTextColorSecondary
        - widgetAccentColor
        - widgetBlockSeparatorColor
        - playerColor
        - playlistSelectedItemBackgroundColor
        - playlistLocation
      additionalProperties: false
    definitions:
      Summarization:
        type: object
        properties: {}
      Description:
        type: object
        properties: {}
sourcePath: en/_api-ref/video/v1/api-ref/StylePreset/create.md
---

# Video API, REST: StylePreset.Create

Creates a new style preset in the specified channel with the provided visual settings.
Style presets define the appearance of players, including colors, spacing, borders, and widgets.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/stylePresets
```

## Body parameters {#yandex.cloud.video.v1.CreateStylePresetRequest}

```json
{
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
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|| title | **string**

Required field. Style preset title. ||
|| backgroundColor | **string**

Required field. Background color. ||
|| widgetTextColorPrimary | **string**

Required field. Widget primary text color. ||
|| widgetTextColorSecondary | **string**

Required field. Widget secondary text color. ||
|| widgetAccentColor | **string**

Required field. Widget accent color. ||
|| widgetBlockGap | **string** (int64)

Gap between widget blocks. ||
|| widgetBlockSeparatorColor | **string**

Required field. Line color between widget blocks. ||
|| playerBorderRadius | **string** (int64)

Player border radius. ||
|| playerColor | **string**

Required field. Player color. ||
|| playlistSelectedItemBackgroundColor | **string**

Required field. Background color of selected video in playlist. ||
|| playlistItemBorderRadius | **string** (int64)

Playlist item border radius. ||
|| playlistItemGap | **string** (int64)

Gap between videos in playlist. ||
|| playlistLocation | **enum** (WidgetLocation)

Required field. Playlist widget location.

- `WIDGET_LOCATION_UNSPECIFIED`: The widget location is not specified.
- `RIGHT`: Position the widget to the right of the player.
- `BOTTOM`: Position the widget below the player. ||
|| rightWidgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display to the right of the player. ||
|| bottomWidgets[] | **[Widget](#yandex.cloud.video.v1.Widget)**

List of widgets to display below the player. ||
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
  "metadata": {
    "stylePresetId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| metadata | **[CreateStylePresetMetadata](#yandex.cloud.video.v1.CreateStylePresetMetadata)**

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

## CreateStylePresetMetadata {#yandex.cloud.video.v1.CreateStylePresetMetadata}

#|
||Field | Description ||
|| stylePresetId | **string**

ID of the style preset being created. ||
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

## StylePreset {#yandex.cloud.video.v1.StylePreset}

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
|| rightWidgets[] | **[Widget](#yandex.cloud.video.v1.Widget2)**

List of widgets to display to the right of the player. ||
|| bottomWidgets[] | **[Widget](#yandex.cloud.video.v1.Widget2)**

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

## Widget {#yandex.cloud.video.v1.Widget2}

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