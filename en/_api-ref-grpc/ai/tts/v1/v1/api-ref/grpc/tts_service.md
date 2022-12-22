---
editable: false
---

# SpeechKit Text To Speech Service API, gRPC: TtsService



| Call | Description |
| --- | --- |
| [AdaptiveSynthesize](#AdaptiveSynthesize) |  |

## Calls TtsService {#calls}

## AdaptiveSynthesize {#AdaptiveSynthesize}



**rpc AdaptiveSynthesize ([AdaptiveSynthesizeRequest](#AdaptiveSynthesizeRequest)) returns (stream [AdaptiveSynthesizeResponse](#AdaptiveSynthesizeResponse))**

### AdaptiveSynthesizeRequest {#AdaptiveSynthesizeRequest}

Field | Description
--- | ---
template_audio | **[AudioContent](#AudioContent)**<br>Required. Template audio to copy prosody and audio characteristics from. 
template_text | **string**<br>Required. The spoken text on the template audio. The maximum string length in characters is 256.
replacements[] | **[ReplacementUnit](#ReplacementUnit)**<br>List of changeable parts in the template with substitutions to be synthesized. The maximum number of elements is 10.
folder_id | **string**<br>Folder id. The maximum string length in characters is 50.
output_audio_spec | **[AudioSpec](#AudioSpec)**<br> 


### AudioContent {#AudioContent}

Field | Description
--- | ---
audio_source | **oneof:** `content`<br>The audio source to read the data from.
&nbsp;&nbsp;content | **bytes**<br>The audio source to read the data from. The maximum string length in characters is 10485760.
audio_spec | **[AudioSpec](#AudioSpec)**<br>Required. Description of the audio format. 


### ReplacementUnit {#ReplacementUnit}

Field | Description
--- | ---
word_index_start | **int64**<br>The position of the beginning of the template in characters. Acceptable values are 0 to 128, inclusive.
word_index_end | **int64**<br>The position of the ending of the template in characters. Acceptable values are 0 to 128, inclusive.
replacement_text | **string**<br>Required. The text of the variable to be synthesized instead of the template. The maximum string length in characters is 100.
audio_unit_start_ms | **int64**<br>The position of the beggining of the template in audio in milliseconds. The minimum value is 0.
audio_unit_end_ms | **int64**<br>End of the template in audio in milliseconds. The minimum value is 0.


### AudioSpec {#AudioSpec}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Encoding type. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li></ul>
sample_rate_hertz | **int64**<br>Sampling frequency of the signal. 
voice | **string**<br>The hint for specifying the voice that need to synthesize in the audio. 


### AdaptiveSynthesizeResponse {#AdaptiveSynthesizeResponse}

Field | Description
--- | ---
audio_chunk | **[AudioChunk](#AudioChunk)**<br>Part of synthesized audio. 


### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br>Sequence of bytes of the synthesized audio in format specified in output_audio_spec 


