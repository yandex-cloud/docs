---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/getPlayerURL.md
---

# Video API, REST: Episode.getPlayerURL
Returns url to the player.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getPlayerUrl
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
episodeId | <p>ID of the episode.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
params.mute | <p>If true, a player will be muted by default.</p> 
params.autoplay | <p>If true, playback will start automatically.</p> 
params.hidden | <p>If true, a player interface will be hidden by default.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "playerUrl": "string",
  "html": "string"
}
```

 
Field | Description
--- | ---
playerUrl | **string**<br><p>Direct link to the video.</p> 
html | **string**<br><p>HTML embed code in Iframe format.</p> 