---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/playlists/{playlistId}:getPlayerURL
    method: get
    path:
      type: object
      properties:
        playlistId:
          description: |-
            **string**
            Required field. ID of the playlist for which to generate a player URL.
          type: string
      required:
        - playlistId
      additionalProperties: false
    query:
      type: object
      properties:
        params:
          description: |-
            **[PlaylistPlayerParams](/docs/video/api-ref/Playlist/getPlayerURL#yandex.cloud.video.v1.PlaylistPlayerParams)**
            Optional player parameters to customize the playback experience.
            These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
          $ref: '#/definitions/PlaylistPlayerParams'
      additionalProperties: false
    body: null
    definitions:
      PlaylistPlayerParams:
        type: object
        properties:
          mute:
            description: |-
              **boolean**
              If true, the player will start with audio muted.
              Users can unmute the audio manually after playback starts.
            type: boolean
          autoplay:
            description: |-
              **boolean**
              If true, the playlist will start playing automatically when the player loads.
              This may be subject to browser autoplay policies that restrict autoplay with sound.
            type: boolean
          hidden:
            description: |-
              **boolean**
              If true, the player interface controls will be hidden initially.
              Users can typically reveal the controls by moving the mouse over the player.
            type: boolean
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/getPlayerURL.md
---

# Video API, REST: Playlist.GetPlayerURL

Generates a player URL for watching the playlist.
The URL can include player parameters such as autoplay, mute, and visibility of interface controls.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/playlists/{playlistId}:getPlayerURL
```

## Path parameters

#|
||Field | Description ||
|| playlistId | **string**

Required field. ID of the playlist for which to generate a player URL. ||
|#

## Query parameters {#yandex.cloud.video.v1.GetPlaylistPlayerURLRequest}

#|
||Field | Description ||
|| params | **[PlaylistPlayerParams](#yandex.cloud.video.v1.PlaylistPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls. ||
|#

## PlaylistPlayerParams {#yandex.cloud.video.v1.PlaylistPlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **boolean**

If true, the playlist will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **boolean**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
|#

## Response {#yandex.cloud.video.v1.GetPlaylistPlayerURLResponse}

**HTTP Code: 200 - OK**

```json
{
  "playerUrl": "string",
  "html": "string"
}
```

#|
||Field | Description ||
|| playerUrl | **string**

Direct URL to the playlist player.
This URL can be used to access the playlist in a web browser
or shared with users who have appropriate permissions. ||
|| html | **string**

HTML embed code in iframe format that can be inserted into web pages.
This code allows the playlist to be embedded directly in third-party websites. ||
|#