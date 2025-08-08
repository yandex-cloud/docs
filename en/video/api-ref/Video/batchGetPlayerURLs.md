---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos:batchGetPlayerURLs
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the videos for which to generate player URLs.
          type: string
        videoIds:
          description: |-
            **string**
            List of video IDs for which to generate player URLs.
          type: array
          items:
            type: string
        params:
          description: |-
            **[VideoPlayerParams](/docs/video/api-ref/Video/getPlayerURL#yandex.cloud.video.v1.VideoPlayerParams)**
            Optional player parameters to customize the playback experience.
            These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
            These parameters will be applied to all generated player URLs.
          $ref: '#/definitions/VideoPlayerParams'
        signedUrlExpirationDuration:
          description: |-
            **string** (duration)
            For episodes with signed URL access, specifies how long the generated URL will be valid.
            If not provided, a default expiration duration will be used.
            This setting applies to all videos in the batch that use sign_url_access.
          type: string
          format: duration
      required:
        - channelId
      additionalProperties: false
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
sourcePath: en/_api-ref/video/v1/api-ref/Video/batchGetPlayerURLs.md
---

# Video API, REST: Video.BatchGetPlayerURLs

Generates multiple player URLs for a list of videos in a specific channel in a single request.
This is more efficient than making multiple GetPlayerURL requests when retrieving several URLs.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos:batchGetPlayerURLs
```

## Body parameters {#yandex.cloud.video.v1.BatchGetVideoPlayerURLsRequest}

```json
{
  "channelId": "string",
  "videoIds": [
    "string"
  ],
  "params": {
    "mute": "boolean",
    "autoplay": "boolean",
    "hidden": "boolean"
  },
  "signedUrlExpirationDuration": "string"
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the videos for which to generate player URLs. ||
|| videoIds[] | **string**

List of video IDs for which to generate player URLs. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
These parameters will be applied to all generated player URLs. ||
|| signedUrlExpirationDuration | **string** (duration)

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used.
This setting applies to all videos in the batch that use sign_url_access. ||
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

## Response {#yandex.cloud.video.v1.BatchGetVideoPlayerURLsResponse}

**HTTP Code: 200 - OK**

```json
{
  "playerUrls": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| playerUrls[] | **string**

List of player URLs corresponding to the requested video IDs.
The order of URLs matches the order of video IDs in the request. ||
|#