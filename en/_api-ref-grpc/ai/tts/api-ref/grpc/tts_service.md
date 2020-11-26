---
editable: false
---

# TtsService



| Call | Description |
| --- | --- |
| [AdaptiveSynthesize](#AdaptiveSynthesize) |  |

## Calls TtsService {#calls}

## AdaptiveSynthesize {#AdaptiveSynthesize}



**rpc AdaptiveSynthesize ([AdaptiveSynthesizeRequest](#AdaptiveSynthesizeRequest)) returns (stream [AdaptiveSynthesizeResponse](#AdaptiveSynthesizeResponse))**

### AdaptiveSynthesizeRequest {#AdaptiveSynthesizeRequest}

Field | Description
--- | ---
template_audio | **[AudioContent](#AudioContent)**<br>Required.  
template_text | **string**<br>Required.  The maximum string length in characters is 256.
replacements[] | **[ReplacementUnit](#ReplacementUnit)**<br> The maximum number of elements is 10.
folder_id | **string**<br> The maximum string length in characters is 50.
output_audio_spec | **[AudioSpec](#AudioSpec)**<br> 


### AudioContent {#AudioContent}

Field | Description
--- | ---
audio_source | **oneof:** `content`<br>
&nbsp;&nbsp;content | **bytes**<br> The maximum string length in characters is 10485760.
audio_spec | **[AudioSpec](#AudioSpec)**<br>Required.  


### AudioSpec {#AudioSpec}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br> 
voice | **string**<br> 


### ReplacementUnit {#ReplacementUnit}

Field | Description
--- | ---
word_index_start | **int64**<br> Acceptable values are 0 to 128, inclusive.
word_index_end | **int64**<br> Acceptable values are 0 to 128, inclusive.
replacement_text | **string**<br>Required.  The maximum string length in characters is 100.
audio_unit_start_ms | **int64**<br> The minimum value is 0.
audio_unit_end_ms | **int64**<br> The minimum value is 0.


### AudioSpec {#AudioSpec1}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br> 
voice | **string**<br> 


### AdaptiveSynthesizeResponse {#AdaptiveSynthesizeResponse}

Field | Description
--- | ---
audio_chunk | **[AudioChunk](#AudioChunk)**<br> 


### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br> 


