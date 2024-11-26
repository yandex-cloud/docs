---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/getPlayerURL.md
---

# Video API, REST: Episode.GetPlayerURL

Returns url to the player.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getPlayerUrl
```

## Path parameters

#|
||Field | Description ||
|| episodeId | **string**

Required field. ID of the episode. ||
|#

## Query parameters {#yandex.cloud.video.v1.GetEpisodePlayerURLRequest}

#|
||Field | Description ||
|| params | **[EpisodePlayerParams](#yandex.cloud.video.v1.EpisodePlayerParams)** ||
|#

## EpisodePlayerParams {#yandex.cloud.video.v1.EpisodePlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, a player will be muted by default. ||
|| autoplay | **boolean**

If true, playback will start automatically. ||
|| hidden | **boolean**

If true, a player interface will be hidden by default. ||
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

Direct link to the video. ||
|| html | **string**

HTML embed code in Iframe format. ||
|#