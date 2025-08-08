---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos/{videoId}:getPlayerURL
    method: get
    path:
      type: object
      properties:
        videoId:
          description: |-
            **string**
            Required field. ID of the video for which to generate a player URL.
          type: string
      required:
        - videoId
      additionalProperties: false
    query:
      type: object
      properties:
        params:
          description: |-
            **[VideoPlayerParams](/docs/video/api-ref/Video/getPlayerURL#yandex.cloud.video.v1.VideoPlayerParams)**
            Optional player parameters to customize the playback experience.
            These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
          $ref: '#/definitions/VideoPlayerParams'
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
      VideoPlayerParams:
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
              If true, the video will start playing automatically when the player loads.
              This may be subject to browser autoplay policies that restrict autoplay with sound.
            type: boolean
          hidden:
            description: |-
              **boolean**
              If true, the player interface controls will be hidden initially.
              Users can typically reveal the controls by moving the mouse over the player.
            type: boolean
sourcePath: en/_api-ref/video/v1/api-ref/Video/getPlayerURL.md
---

# Video API, REST: Video.GetPlayerURL

Generates a standard player URL for watching the video.
The URL respects the video's access rights and can include custom player parameters.
For videos with signed URL access, an expiration duration can be specified.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}:getPlayerURL
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video for which to generate a player URL. ||
|#

## Query parameters {#yandex.cloud.video.v1.GetVideoPlayerURLRequest}

#|
||Field | Description ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls. ||
|| signedUrlExpirationDuration | **string** (duration)

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used. ||
|#

## VideoPlayerParams {#yandex.cloud.video.v1.VideoPlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **boolean**

If true, the video will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **boolean**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
|#

## Response {#yandex.cloud.video.v1.GetVideoPlayerURLResponse}

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

Direct URL to the video player.
This URL can be used to access the video in a web browser
or shared with users who have appropriate permissions. ||
|| html | **string**

HTML embed code in iframe format that can be inserted into web pages.
This code allows the video to be embedded directly in third-party websites. ||
|#