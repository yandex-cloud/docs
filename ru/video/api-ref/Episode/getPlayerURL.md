---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getPlayerUrl
    method: get
    path:
      type: object
      properties:
        episodeId:
          description: |-
            **string**
            Required field. ID of the episode for which to generate a player URL.
          type: string
      required:
        - episodeId
      additionalProperties: false
    query:
      type: object
      properties:
        params:
          description: |-
            **[EpisodePlayerParams](/docs/video/api-ref/Episode/getPlayerURL#yandex.cloud.video.v1.EpisodePlayerParams)**
            Optional player parameters to customize the playback experience.
            These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
          $ref: '#/definitions/EpisodePlayerParams'
        signedUrlExpirationDuration:
          description: |-
            **string** (duration)
            For episodes with signed URL access, specifies how long the generated URL will be valid.
            If not provided, a default expiration duration will be used.
          type: string
          format: duration
      additionalProperties: false
    body: null
    definitions:
      EpisodePlayerParams:
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
              If true, the episode will start playing automatically when the player loads.
              This may be subject to browser autoplay policies that restrict autoplay with sound.
            type: boolean
          hidden:
            description: |-
              **boolean**
              If true, the player interface controls will be hidden initially.
              Users can typically reveal the controls by moving the mouse over the player.
            type: boolean
sourcePath: en/_api-ref/video/v1/api-ref/Episode/getPlayerURL.md
---

# Video API, REST: Episode.GetPlayerURL

Generates a player URL for watching the episode.
The URL can include player parameters such as autoplay, mute, and visibility of interface controls.
For episodes with signed URL access, an expiration duration can be specified.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getPlayerUrl
```

## Path parameters

#|
||Field | Description ||
|| episodeId | **string**

Required field. ID of the episode for which to generate a player URL. ||
|#

## Query parameters {#yandex.cloud.video.v1.GetEpisodePlayerURLRequest}

#|
||Field | Description ||
|| params | **[EpisodePlayerParams](#yandex.cloud.video.v1.EpisodePlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls. ||
|| signedUrlExpirationDuration | **string** (duration)

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used. ||
|#

## EpisodePlayerParams {#yandex.cloud.video.v1.EpisodePlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **boolean**

If true, the episode will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **boolean**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
|#

## Response {#yandex.cloud.video.v1.GetEpisodePlayerURLResponse}

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

Direct URL to the episode player.
This URL can be used to access the episode in a web browser
or shared with users who have appropriate permissions. ||
|| html | **string**

HTML embed code in iframe format that can be inserted into web pages.
This code allows the episode to be embedded directly in third-party websites. ||
|#