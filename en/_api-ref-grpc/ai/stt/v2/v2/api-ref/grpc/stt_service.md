---
editable: false
---

# SpeechKit Speech To Text Service API, gRPC: SttService



| Call | Description |
| --- | --- |
| [LongRunningRecognize](#LongRunningRecognize) |  |
| [StreamingRecognize](#StreamingRecognize) |  |

## Calls SttService {#calls}

## LongRunningRecognize {#LongRunningRecognize}



**rpc LongRunningRecognize ([LongRunningRecognitionRequest](#LongRunningRecognitionRequest)) returns ([operation.Operation](#Operation))**

	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LongRunningRecognitionResponse](#LongRunningRecognitionResponse)<br>

### LongRunningRecognitionRequest {#LongRunningRecognitionRequest}

Field | Description
--- | ---
config | **[RecognitionConfig](#RecognitionConfig)**<br> 
audio | **[RecognitionAudio](#RecognitionAudio)**<br> 


### RecognitionConfig {#RecognitionConfig}

Field | Description
--- | ---
specification | **[RecognitionSpec](#RecognitionSpec)**<br> 
folder_id | **string**<br> 


### RecognitionSpec {#RecognitionSpec}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><li>`MP3`: transcription only</li></ul>
sample_rate_hertz | **int64**<br>8000, 16000, 48000 only for pcm 
language_code | **string**<br>code in BCP-47 
profanity_filter | **bool**<br> 
model | **string**<br> 
partial_results | **bool**<br>If set true, tentative hypotheses may be returned as they become available (final=false flag) If false or omitted, only final=true result(s) are returned. Makes sense only for StreamingRecognize requests. 
single_utterance | **bool**<br> 
audio_channel_count | **int64**<br>Used only for long running recognize. 
raw_results | **bool**<br>This mark allows disable normalization text 
literature_text | **bool**<br>Rewrite text in literature style (default: false) 


### RecognitionAudio {#RecognitionAudio}

Field | Description
--- | ---
audio_source | **oneof:** `content` or `uri`<br>
&nbsp;&nbsp;content | **bytes**<br> 
&nbsp;&nbsp;uri | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LongRunningRecognitionResponse](#LongRunningRecognitionResponse)>**<br>if operation finished successfully. 


### LongRunningRecognitionResponse {#LongRunningRecognitionResponse}

Field | Description
--- | ---
chunks[] | **[SpeechRecognitionResult](#SpeechRecognitionResult)**<br> 


### SpeechRecognitionResult {#SpeechRecognitionResult}

Field | Description
--- | ---
alternatives[] | **[SpeechRecognitionAlternative](#SpeechRecognitionAlternative)**<br> 
channel_tag | **int64**<br> 


### SpeechRecognitionAlternative {#SpeechRecognitionAlternative}

Field | Description
--- | ---
text | **string**<br> 
confidence | **float**<br> 
words[] | **[WordInfo](#WordInfo)**<br> 


### WordInfo {#WordInfo}

Field | Description
--- | ---
start_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
end_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
word | **string**<br> 
confidence | **float**<br> 


## StreamingRecognize {#StreamingRecognize}



**rpc StreamingRecognize (stream [StreamingRecognitionRequest](#StreamingRecognitionRequest)) returns (stream [StreamingRecognitionResponse](#StreamingRecognitionResponse))**

### StreamingRecognitionRequest {#StreamingRecognitionRequest}

Field | Description
--- | ---
streaming_request | **oneof:** `config` or `audio_content`<br>
&nbsp;&nbsp;config | **[RecognitionConfig](#RecognitionConfig)**<br> 
&nbsp;&nbsp;audio_content | **bytes**<br> 


### RecognitionConfig {#RecognitionConfig1}

Field | Description
--- | ---
specification | **[RecognitionSpec](#RecognitionSpec)**<br> 
folder_id | **string**<br> 


### RecognitionSpec {#RecognitionSpec1}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><li>`MP3`: transcription only</li></ul>
sample_rate_hertz | **int64**<br>8000, 16000, 48000 only for pcm 
language_code | **string**<br>code in BCP-47 
profanity_filter | **bool**<br> 
model | **string**<br> 
partial_results | **bool**<br>If set true, tentative hypotheses may be returned as they become available (final=false flag) If false or omitted, only final=true result(s) are returned. Makes sense only for StreamingRecognize requests. 
single_utterance | **bool**<br> 
audio_channel_count | **int64**<br>Used only for long running recognize. 
raw_results | **bool**<br>This mark allows disable normalization text 
literature_text | **bool**<br>Rewrite text in literature style (default: false) 


### StreamingRecognitionResponse {#StreamingRecognitionResponse}

Field | Description
--- | ---
chunks[] | **[SpeechRecognitionChunk](#SpeechRecognitionChunk)**<br> 


### SpeechRecognitionChunk {#SpeechRecognitionChunk}

Field | Description
--- | ---
alternatives[] | **[SpeechRecognitionAlternative](#SpeechRecognitionAlternative)**<br> 
final | **bool**<br>This flag shows that the received chunk contains a part of the recognized text that won't be changed. 
end_of_utterance | **bool**<br>This flag shows that the received chunk is the end of an utterance. 


### SpeechRecognitionAlternative {#SpeechRecognitionAlternative1}

Field | Description
--- | ---
text | **string**<br> 
confidence | **float**<br> 
words[] | **[WordInfo](#WordInfo)**<br> 


### WordInfo {#WordInfo1}

Field | Description
--- | ---
start_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
end_time | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
word | **string**<br> 
confidence | **float**<br> 


