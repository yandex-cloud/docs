---
editable: false
sourcePath: en/_api-ref-grpc/talk-analytics/api-ref/grpc/talk_service.md
---

# Talk Analytics API, gRPC: TalkService



| Call | Description |
| --- | --- |
| [UploadAsStream](#UploadAsStream) | rpc for streaming talk documents. |
| [Upload](#Upload) | rpc for uploading talk document as single message |
| [UploadText](#UploadText) | rpc for uploading text talk document |

## Calls TalkService {#calls}

## UploadAsStream {#UploadAsStream}

rpc for streaming talk documents. First message should contain Talk related metadata, second - audio metadata, others should contain audio bytes in chunks

**rpc UploadAsStream (stream [StreamTalkRequest](#StreamTalkRequest)) returns ([UploadTalkResponse](#UploadTalkResponse))**

### StreamTalkRequest {#StreamTalkRequest}

Field | Description
--- | ---
Event | **oneof:** `metadata` or `audio`<br>
&nbsp;&nbsp;metadata | **[TalkMetadata](#TalkMetadata)**<br>talk document metadata containing channel id and channel field values 
&nbsp;&nbsp;audio | **[AudioStreamingRequest](#AudioStreamingRequest)**<br>audio metadata or chunk 


### TalkMetadata {#TalkMetadata}

Field | Description
--- | ---
connection_id | **string**<br>id of connection this talk belongs too 
fields | **map<string,string>**<br>channel defined fields 


### AudioStreamingRequest {#AudioStreamingRequest}

Field | Description
--- | ---
AudioEvent | **oneof:** `audio_metadata` or `chunk`<br>
&nbsp;&nbsp;audio_metadata | **[AudioMetadata](#AudioMetadata)**<br>Session options. Should be the first message from user. 
&nbsp;&nbsp;chunk | **[AudioChunk](#AudioChunk)**<br>Chunk with audio data. 


### AudioMetadata {#AudioMetadata}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio)**<br>Audio without container. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio)**<br>Audio is wrapped in container. 


### RawAudio {#RawAudio}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Type of audio encoding <ul><li>`AUDIO_ENCODING_LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li></ul>
sample_rate_hertz | **int64**<br>PCM sample rate 
audio_channel_count | **int64**<br>PCM channel count. 


### ContainerAudio {#ContainerAudio}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br>Type of audio container. <ul><li>`CONTAINER_AUDIO_TYPE_WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li><li>`CONTAINER_AUDIO_TYPE_OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li><li>`CONTAINER_AUDIO_TYPE_MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li></ul>


### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br>Bytes with audio data. 


### UploadTalkResponse {#UploadTalkResponse}

Field | Description
--- | ---
talk_id | **string**<br>id of created talk document 


## Upload {#Upload}

rpc for uploading talk document as single message

**rpc Upload ([UploadTalkRequest](#UploadTalkRequest)) returns ([UploadTalkResponse](#UploadTalkResponse))**

### UploadTalkRequest {#UploadTalkRequest}

Field | Description
--- | ---
metadata | **[TalkMetadata](#TalkMetadata)**<br> 
audio | **[AudioRequest](#AudioRequest)**<br>audio payload 


### TalkMetadata {#TalkMetadata1}

Field | Description
--- | ---
connection_id | **string**<br>id of connection this talk belongs too 
fields | **map<string,string>**<br>channel defined fields 


### AudioRequest {#AudioRequest}

Field | Description
--- | ---
audio_metadata | **[AudioMetadata](#AudioMetadata1)**<br>audio metadata 
audio_data | **[AudioChunk](#AudioChunk1)**<br>Bytes with audio data. 


### AudioMetadata {#AudioMetadata1}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio1)**<br>Audio without container. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio1)**<br>Audio is wrapped in container. 


### RawAudio {#RawAudio1}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Type of audio encoding <ul><li>`AUDIO_ENCODING_LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li></ul>
sample_rate_hertz | **int64**<br>PCM sample rate 
audio_channel_count | **int64**<br>PCM channel count. 


### ContainerAudio {#ContainerAudio1}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br>Type of audio container. <ul><li>`CONTAINER_AUDIO_TYPE_WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li><li>`CONTAINER_AUDIO_TYPE_OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li><li>`CONTAINER_AUDIO_TYPE_MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li></ul>


### AudioChunk {#AudioChunk1}

Field | Description
--- | ---
data | **bytes**<br>Bytes with audio data. 


### UploadTalkResponse {#UploadTalkResponse1}

Field | Description
--- | ---
talk_id | **string**<br>id of created talk document 


## UploadText {#UploadText}

rpc for uploading text talk document

**rpc UploadText ([UploadTextRequest](#UploadTextRequest)) returns ([UploadTextResponse](#UploadTextResponse))**

### UploadTextRequest {#UploadTextRequest}

Field | Description
--- | ---
metadata | **[TalkMetadata](#TalkMetadata)**<br> 
text_content | **[TextContent](#TextContent)**<br> 


### TalkMetadata {#TalkMetadata2}

Field | Description
--- | ---
connection_id | **string**<br>id of connection this talk belongs too 
fields | **map<string,string>**<br>channel defined fields 


### TextContent {#TextContent}

Field | Description
--- | ---
messages[] | **[Message](#Message)**<br> 


### Message {#Message}

Field | Description
--- | ---
user_id | **string**<br> 
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **[TextPayload](#TextPayload)**<br> 


### TextPayload {#TextPayload}

Field | Description
--- | ---
text | **string**<br> 


### UploadTextResponse {#UploadTextResponse}

Field | Description
--- | ---
talk_id | **string**<br>id of created talk document 


