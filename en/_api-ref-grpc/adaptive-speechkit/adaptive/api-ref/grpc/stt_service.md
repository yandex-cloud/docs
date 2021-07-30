---
editable: false
---

# Recognizer



| Call | Description |
| --- | --- |
| [RecognizeStreaming](#RecognizeStreaming) | Expects audio in real-time |

## Calls Recognizer {#calls}

## RecognizeStreaming {#RecognizeStreaming}

Expects audio in real-time

**rpc RecognizeStreaming (stream [StreamingRequest](#StreamingRequest)) returns (stream [StreamingResponse](#StreamingResponse))**

### StreamingRequest {#StreamingRequest}

Field | Description
--- | ---
Event | **oneof:** `session_options`, `chunk`, `silence_chunk` or `eou`<br>
&nbsp;&nbsp;session_options | **[StreamingOptions](#StreamingOptions)**<br> 
&nbsp;&nbsp;chunk | **[AudioChunk](#AudioChunk)**<br> 
&nbsp;&nbsp;silence_chunk | **[SilenceChunk](#SilenceChunk)**<br> 
&nbsp;&nbsp;eou | **[Eou](#Eou)**<br> 


### StreamingOptions {#StreamingOptions}

Field | Description
--- | ---
recognition_model | **[RecognitionModelOptions](#RecognitionModelOptions)**<br> 
eou_classifier | **[EouClassifierOptions](#EouClassifierOptions)**<br> 


### RecognitionModelOptions {#RecognitionModelOptions}

Field | Description
--- | ---
model | **string**<br>model name 
audio_format | **[AudioFormatOptions](#AudioFormatOptions)**<br>config for input audio 
text_normalization | **[TextNormalizationOptions](#TextNormalizationOptions)**<br> 


### AudioFormatOptions {#AudioFormatOptions}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio)**<br> 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio)**<br> 


### RawAudio {#RawAudio}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br> <ul><ul/>
sample_rate_hertz | **int64**<br> 
audio_channel_count | **int64**<br> 


### ContainerAudio {#ContainerAudio}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br> <ul><ul/>


### TextNormalizationOptions {#TextNormalizationOptions}

Field | Description
--- | ---
text_normalization | enum **TextNormalization**<br>Normalization <ul><li>`TEXT_NORMALIZATION_ENABLED`: Enable normalization</li><li>`TEXT_NORMALIZATION_DISABLED`: Disable normalization</li><ul/>
profanity_filter | **bool**<br>Profanity filter 


### EouClassifierOptions {#EouClassifierOptions}

Field | Description
--- | ---
Classifier | **oneof:** `default_classifier` or `external_classifier`<br>type of EOU classifier. default = speechkit internal. External - delegate to user side
&nbsp;&nbsp;default_classifier | **[DefaultEouClassifier](#DefaultEouClassifier)**<br>type of EOU classifier. default = speechkit internal. External - delegate to user side 
&nbsp;&nbsp;external_classifier | **[ExternalEouClassifier](#ExternalEouClassifier)**<br>type of EOU classifier. default = speechkit internal. External - delegate to user side 


### DefaultEouClassifier {#DefaultEouClassifier}

Field | Description
--- | ---
type | enum **EouSensitivity**<br>EOU sensitivity. There'll be at least two levels, faster with more error and more conservative (our default) <ul><ul/>
max_pause_between_words_hint_ms | **int64**<br> 


### ExternalEouClassifier {#ExternalEouClassifier}



### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br> 


### SilenceChunk {#SilenceChunk}

Field | Description
--- | ---
duration_ms | **int64**<br> 


### Eou {#Eou}



### StreamingResponse {#StreamingResponse}

Field | Description
--- | ---
session_uuid | **[SessionUuid](#SessionUuid)**<br> 
audio_cursors | **[AudioCursors](#AudioCursors)**<br> 
response_wall_time_ms | **int64**<br>wall clock on server side. This is time when server wrote results to stream 
Event | **oneof:** `partial`, `final`, `eou_update`, `final_refinement` or `status_code`<br>
&nbsp;&nbsp;partial | **[AlternativeUpdate](#AlternativeUpdate)**<br>partial results, server will send them regularly after enough audio data was received from user. This are current text estimation from final_time_ms to partial_time_ms. Could change after new data will arrive 
&nbsp;&nbsp;final | **[AlternativeUpdate](#AlternativeUpdate)**<br>final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases 
&nbsp;&nbsp;eou_update | **[EouUpdate](#EouUpdate)**<br>After EOU classifier, send the message with final, send the EouUpdate with time of EOU before eou_update we send final with the same time. there could be several finals before eou update 
&nbsp;&nbsp;final_refinement | **[FinalRefinement](#FinalRefinement)**<br>For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing). Final normalization will introduce additional latency 
&nbsp;&nbsp;status_code | **[StatusCode](#StatusCode)**<br>Status messages, send by server with fixed interval (keep-alive) 


### SessionUuid {#SessionUuid}

Field | Description
--- | ---
uuid | **string**<br> 
user_request_id | **string**<br> 


### AudioCursors {#AudioCursors}

Field | Description
--- | ---
received_data_ms | **int64**<br>amount of audio chunks server received. This cursor is moved after each audio chunk was received by server. 
reset_time_ms | **int64**<br>input stream reset data 
partial_time_ms | **int64**<br>how much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data to update recognition results (includes silence as well) 
final_time_ms | **int64**<br>Time of last final. This cursor is moved when server decides that recognition from start of audio until final_time_ms will not change anymore usually this even is followed by EOU detection (but this could change in future) 
final_index | **int64**<br>This is index of last final server send. Incremented after each new final. 
eou_time_ms | **int64**<br>Estimated time of EOU. Cursor is updated after each new EOU is sent For external classifier this equals to received_data_ms at the moment EOU event arrives For internal classifier this is estimation of time. The time is not exact and has the same guarantees as word timings 


### AlternativeUpdate {#AlternativeUpdate}

Field | Description
--- | ---
alternatives[] | **[Alternative](#Alternative)**<br> 
channel_tag | **string**<br> 


### Alternative {#Alternative}

Field | Description
--- | ---
words[] | **[Word](#Word)**<br> 
text | **string**<br> 
start_time_ms | **int64**<br> 
end_time_ms | **int64**<br> 
confidence | **double**<br> 


### Word {#Word}

Field | Description
--- | ---
text | **string**<br> 
start_time_ms | **int64**<br> 
end_time_ms | **int64**<br> 


### EouUpdate {#EouUpdate}

Field | Description
--- | ---
time_ms | **int64**<br> 


### FinalRefinement {#FinalRefinement}

Field | Description
--- | ---
final_index | **int64**<br> 
Type | **oneof:** `normalized_text`<br>
&nbsp;&nbsp;normalized_text | **[AlternativeUpdate](#AlternativeUpdate1)**<br> 


### AlternativeUpdate {#AlternativeUpdate1}

Field | Description
--- | ---
alternatives[] | **[Alternative](#Alternative1)**<br> 
channel_tag | **string**<br> 


### Alternative {#Alternative1}

Field | Description
--- | ---
words[] | **[Word](#Word1)**<br> 
text | **string**<br> 
start_time_ms | **int64**<br> 
end_time_ms | **int64**<br> 
confidence | **double**<br> 


### Word {#Word1}

Field | Description
--- | ---
text | **string**<br> 
start_time_ms | **int64**<br> 
end_time_ms | **int64**<br> 


### StatusCode {#StatusCode}

Field | Description
--- | ---
code_type | enum **CodeType**<br> <ul><ul/>
message | **string**<br> 


