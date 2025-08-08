---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/stylePresets/{stylePresetId}
    method: patch
    path:
      type: object
      properties:
        stylePresetId:
          description: |-
            **string**
            Required field. ID of the style preset.
          type: string
      required:
        - stylePresetId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        fieldMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        title:
          description: |-
            **string**
            Style preset title.
          pattern: '[a-zA-Z0-9-_ ]*'
          type: string
        backgroundColor:
          description: |-
            **string**
            Background color.
          pattern: '[#a-zA-Z0-9-]*'
          type: string
        widgetTextColorPrimary:
          description: |-
            **string**
            Widget primary text color.
          pattern: '[#a-zA-Z0-9-]*'
          type: string
        widgetTextColorSecondary:
          description: |-
            **string**
            Widget secondary text color.
          pattern: '[#a-zA-Z0-9-]*'
          type: string
        widgetAccentColor:
          description: |-
            **string**
            Widget accent color.
          pattern: '[#a-zA-Z0-9-]*'
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
            Line color between widget blocks.
          pattern: '[#a-zA-Z0-9-]*'
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
            Player color.
          pattern: '[#a-zA-Z0-9]*'
          type: string
        playlistSelectedItemBackgroundColor:
          description: |-
            **string**
            Background color of selected video in playlist.
          pattern: '[#a-zA-Z0-9]*'
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
            Playlist widget location.
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
        - fieldMask
      additionalProperties: false
    definitions:
      Summarization:
        type: object
        properties: {}
      Description:
        type: object
        properties: {}
sourcePath: en/_api-ref/video/v1/api-ref/StylePreset/update.md
---

# Video API, REST: StylePreset.Update

Updates an existing style preset's properties and visual settings.
Only fields specified in the field_mask will be updated.

## HTTP request

```
PATCH https://video.{{ api-host }}/video/v1/stylePresets/{stylePresetId}
```

## Path parameters

#|
||Field | Description ||
|| stylePresetId | **string**

Required field. ID of the style preset. ||
|#

## Body parameters {#yandex.cloud.video.v1.UpdateStylePresetRequest}

```json
{
  "fieldMask": "string",
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
|| fieldMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| title | **string**

Style preset title. ||
|| backgroundColor | **string**

Background color. ||
|| widgetTextColorPrimary | **string**

Widget primary text color. ||
|| widgetTextColorSecondary | **string**

Widget secondary text color. ||
|| widgetAccentColor | **string**

Widget accent color. ||
|| widgetBlockGap | **string** (int64)

Gap between widget blocks. ||
|| widgetBlockSeparatorColor | **string**

Line color between widget blocks. ||
|| playerBorderRadius | **string** (int64)

Player border radius. ||
|| playerColor | **string**

Player color. ||
|| playlistSelectedItemBackgroundColor | **string**

Background color of selected video in playlist. ||
|| playlistItemBorderRadius | **string** (int64)

Playlist item border radius. ||
|| playlistItemGap | **string** (int64)

Gap between videos in playlist. ||
|| playlistLocation | **enum** (WidgetLocation)

Playlist widget location.

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
|| metadata | **[UpdateStylePresetMetadata](#yandex.cloud.video.v1.UpdateStylePresetMetadata)**

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

## UpdateStylePresetMetadata {#yandex.cloud.video.v1.UpdateStylePresetMetadata}

#|
||Field | Description ||
|| stylePresetId | **string**

ID of the style preset being updated. ||
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