---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/stylePresets
    method: get
    path: null
    query:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the style presets to list.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of style presets to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListStylePresetsResponse.
          type: string
        orderBy:
          description: |-
            **string**
            Specifies the ordering of results.
            Format is "<field> <order>" (e.g., "createdAt desc").
            Default: "id asc".
            Supported fields: ["id", "title", "createdAt", "updatedAt"].
            Both snake_case and camelCase field names are supported.
          type: string
        filter:
          description: |-
            **string**
            Filter expression to narrow down the list of returned style presets.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'dark' AND id='preset-1'`
            Filterable fields: ["id", "title"].
            Both snake_case and camelCase field names are supported.
          type: string
      required:
        - channelId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/StylePreset/list.md
---

# Video API, REST: StylePreset.List

Lists all style presets in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/stylePresets
```

## Query parameters {#yandex.cloud.video.v1.ListStylePresetsRequest}

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the style presets to list. ||
|| pageSize | **string** (int64)

The maximum number of style presets to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListStylePresetsResponse. ||
|| orderBy | **string**

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

## Response {#yandex.cloud.video.v1.ListStylePresetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "stylePresets": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| stylePresets[] | **[StylePreset](#yandex.cloud.video.v1.StylePreset)**

List of style presets matching the request criteria.
May be empty if no style presets match the criteria or if the channel has no style presets. ||
|| nextPageToken | **string**

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