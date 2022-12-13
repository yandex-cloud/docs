---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/stt-v3/stt-v3/api-ref/grpc/stt_service.md
---

# SpeechKit Recognition API v3, gRPC: Recognizer

A set of methods for voice recognition.

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
&nbsp;&nbsp;session_options | **[StreamingOptions](#StreamingOptions)**<br>Session options. Should be the first message from user. 
&nbsp;&nbsp;chunk | **[AudioChunk](#AudioChunk)**<br>Chunk with audio data. 
&nbsp;&nbsp;silence_chunk | **[SilenceChunk](#SilenceChunk)**<br>Chunk with silence. 
&nbsp;&nbsp;eou | **[Eou](#Eou)**<br>Request to end current utterance. Works only with external EOU detector. 


### StreamingOptions {#StreamingOptions}

Field | Description
--- | ---
recognition_model | **[RecognitionModelOptions](#RecognitionModelOptions)**<br>Configuration for speech recognition model. 
eou_classifier | **[EouClassifierOptions](#EouClassifierOptions)**<br>Configuration for end of utterance detection model. 


### RecognitionModelOptions {#RecognitionModelOptions}

Field | Description
--- | ---
model | **string**<br>Reserved for future, do not use. 
audio_format | **[AudioFormatOptions](#AudioFormatOptions)**<br>Specified input audio. 
text_normalization | **[TextNormalizationOptions](#TextNormalizationOptions)**<br>Text normalization options. 
language_restriction | **[LanguageRestrictionOptions](#LanguageRestrictionOptions)**<br>Possible languages in audio. 
audio_processing_type | enum **AudioProcessingType**<br>How to deal with audio data (in real time, after all data is received, etc). Default is REAL_TIME. 


### AudioFormatOptions {#AudioFormatOptions}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio)**<br>Audio without container. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio)**<br>Audio is wrapped in container. 


### RawAudio {#RawAudio}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Type of audio encoding <ul><li>`LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li></ul>
sample_rate_hertz | **int64**<br>PCM sample rate 
audio_channel_count | **int64**<br>PCM channel count. Currently only single channel audio is supported in real-time recognition. 


### ContainerAudio {#ContainerAudio}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br>Type of audio container. <ul><li>`WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li><li>`OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li><li>`MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li></ul>


### TextNormalizationOptions {#TextNormalizationOptions}

Field | Description
--- | ---
text_normalization | enum **TextNormalization**<br>Normalization <ul><li>`TEXT_NORMALIZATION_ENABLED`: Enable normalization</li><li>`TEXT_NORMALIZATION_DISABLED`: Disable normalization</li></ul>
profanity_filter | **bool**<br>Profanity filter (default: false). 
literature_text | **bool**<br>Rewrite text in literature style (default: false). 


### LanguageRestrictionOptions {#LanguageRestrictionOptions}

Field | Description
--- | ---
restriction_type | enum **LanguageRestrictionType**<br> <ul><li>`WHITELIST`: The allowing list. The incoming audio can contain only the listed languages.</li><li>`BLACKLIST`: The forbidding list. The incoming audio cannot contain the listed languages.</li></ul>
language_code[] | **string**<br> 


### EouClassifierOptions {#EouClassifierOptions}

Field | Description
--- | ---
Classifier | **oneof:** `default_classifier` or `external_classifier`<br>Type of EOU classifier.
&nbsp;&nbsp;default_classifier | **[DefaultEouClassifier](#DefaultEouClassifier)**<br>EOU classifier provided by SpeechKit. Default. 
&nbsp;&nbsp;external_classifier | **[ExternalEouClassifier](#ExternalEouClassifier)**<br>EOU is enforced by external messages from user. 


### DefaultEouClassifier {#DefaultEouClassifier}

Field | Description
--- | ---
type | enum **EouSensitivity**<br>EOU sensitivity. Currently two levels, faster with more error and more conservative (our default). 
max_pause_between_words_hint_ms | **int64**<br>Hint for max pause between words. Our EOU detector could use this information to distinguish between end of utterance and slow speech (like one <long pause> two <long pause> three, etc). 


### ExternalEouClassifier {#ExternalEouClassifier}



### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br>Bytes with audio data. 


### SilenceChunk {#SilenceChunk}

Field | Description
--- | ---
duration_ms | **int64**<br>Duration of silence chunk in ms. 


### Eou {#Eou}



### StreamingResponse {#StreamingResponse}

Field | Description
--- | ---
session_uuid | **[SessionUuid](#SessionUuid)**<br>Session identifier 
audio_cursors | **[AudioCursors](#AudioCursors)**<br>Progress bar for stream session recognition: how many data we obtained; final and partial times; etc. 
response_wall_time_ms | **int64**<br>Wall clock on server side. This is time when server wrote results to stream 
Event | **oneof:** `partial`, `final`, `eou_update`, `final_refinement` or `status_code`<br>
&nbsp;&nbsp;partial | **[AlternativeUpdate](#AlternativeUpdate)**<br>Partial results, server will send them regularly after enough audio data was received from user. This are current text estimation from final_time_ms to partial_time_ms. Could change after new data will arrive. 
&nbsp;&nbsp;final | **[AlternativeUpdate](#AlternativeUpdate)**<br>Final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases. 
&nbsp;&nbsp;eou_update | **[EouUpdate](#EouUpdate)**<br>After EOU classifier, send the message with final, send the EouUpdate with time of EOU before eou_update we send final with the same time. there could be several finals before eou update. 
&nbsp;&nbsp;final_refinement | **[FinalRefinement](#FinalRefinement)**<br>For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing). Final normalization will introduce additional latency. 
&nbsp;&nbsp;status_code | **[StatusCode](#StatusCode)**<br>Status messages, send by server with fixed interval (keep-alive). 


### SessionUuid {#SessionUuid}

Field | Description
--- | ---
uuid | **string**<br>Internal session identifier. 
user_request_id | **string**<br>User session identifier. 


### AudioCursors {#AudioCursors}

Field | Description
--- | ---
received_data_ms | **int64**<br>Amount of audio chunks server received. This cursor is moved after each audio chunk was received by server. 
reset_time_ms | **int64**<br>Input stream reset data. 
partial_time_ms | **int64**<br>How much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data to update recognition results (includes silence as well). 
final_time_ms | **int64**<br>Time of last final. This cursor is moved when server decides that recognition from start of audio until final_time_ms will not change anymore usually this even is followed by EOU detection (but this could change in future). 
final_index | **int64**<br>This is index of last final server send. Incremented after each new final. 
eou_time_ms | **int64**<br>Estimated time of EOU. Cursor is updated after each new EOU is sent. For external classifier this equals to received_data_ms at the moment EOU event arrives. For internal classifier this is estimation of time. The time is not exact and has the same guarantees as word timings. 


### AlternativeUpdate {#AlternativeUpdate}

Field | Description
--- | ---
alternatives[] | **[Alternative](#Alternative)**<br>List of hypothesis for timeframes. 
channel_tag | **string**<br>Tag for distinguish audio channels. 


### Alternative {#Alternative}

Field | Description
--- | ---
words[] | **[Word](#Word)**<br>Words in time frame. 
text | **string**<br>Text in time frame. 
start_time_ms | **int64**<br>Start of time frame. 
end_time_ms | **int64**<br>End of time frame. 
confidence | **double**<br>The hypothesis confidence. Currently is not used. 
languages[] | **[LanguageEstimation](#LanguageEstimation)**<br>Distribution over possible languages. 


### Word {#Word}

Field | Description
--- | ---
text | **string**<br>Word text. 
start_time_ms | **int64**<br>Estimation of word start time in ms. 
end_time_ms | **int64**<br>Estimation of word end time in ms. 


### LanguageEstimation {#LanguageEstimation}

Field | Description
--- | ---
language_code | **string**<br>Language code in ISO 639-1 format. 
probability | **double**<br>Estimation of language probability. 


### EouUpdate {#EouUpdate}

Field | Description
--- | ---
time_ms | **int64**<br>EOU estimated time. 


### FinalRefinement {#FinalRefinement}

Field | Description
--- | ---
final_index | **int64**<br>Index of final for which server sends additional information. 
Type | **oneof:** `normalized_text`<br>Type of refinement.
&nbsp;&nbsp;normalized_text | **[AlternativeUpdate](#AlternativeUpdate1)**<br>Normalized text instead of raw one. 


### StatusCode {#StatusCode}

Field | Description
--- | ---
code_type | enum **CodeType**<br>Code type. 
message | **string**<br>Human readable message. 


