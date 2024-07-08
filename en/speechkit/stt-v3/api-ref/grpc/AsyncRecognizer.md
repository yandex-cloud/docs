---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/stt-v3/stt-v3/api-ref/grpc/AsyncRecognizer.md
---

# SpeechKit Recognition API v3, gRPC: AsyncRecognizer

A set of methods for async voice recognition.

| Call | Description |
| --- | --- |
| [RecognizeFile](#RecognizeFile) |  |
| [GetRecognition](#GetRecognition) |  |

## Calls AsyncRecognizer {#calls}

## RecognizeFile {#RecognizeFile}



**rpc RecognizeFile ([RecognizeFileRequest](#RecognizeFileRequest)) returns (`yandex.cloud.operation.Operation`)**

Response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RecognizeFileRequest {#RecognizeFileRequest}

Field | Description
--- | ---
AudioSource | **oneof:** `content` or `uri`<br>
&nbsp;&nbsp;content | **bytes**<br>Bytes with data 
&nbsp;&nbsp;uri | **string**<br>S3 data url 
recognition_model | **[RecognitionModelOptions](#RecognitionModelOptions)**<br>Configuration for speech recognition model. 
recognition_classifier | **[RecognitionClassifierOptions](#RecognitionClassifierOptions)**<br>Configuration for classifiers over speech recognition. 
speech_analysis | **[SpeechAnalysisOptions](#SpeechAnalysisOptions)**<br>Configuration for speech analysis over speech recognition. 
speaker_labeling | **[SpeakerLabelingOptions](#SpeakerLabelingOptions)**<br>Configuration for speaker labeling 


### RecognitionModelOptions {#RecognitionModelOptions}

Field | Description
--- | ---
model | **string**<br>Sets the recognition model for the cloud version of SpeechKit. Possible values: 'general', 'general:rc', 'general:deprecated'. The model is ignored for SpeechKit Hybrid. 
audio_format | **[AudioFormatOptions](#AudioFormatOptions)**<br>Specified input audio. 
text_normalization | **[TextNormalizationOptions](#TextNormalizationOptions)**<br>Text normalization options. 
language_restriction | **[LanguageRestrictionOptions](#LanguageRestrictionOptions)**<br>Possible languages in audio. 
audio_processing_type | enum **AudioProcessingType**<br>How to deal with audio data (in real time, after all data is received, etc). Default is REAL_TIME. <ul><li>`REAL_TIME`: Process audio in mode optimized for real-time recognition, i.e. send partials and final responses as soon as possible</li><li>`FULL_DATA`: Process audio after all data was received</li></ul>


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
phone_formatting_mode | enum **PhoneFormattingMode**<br>Define phone formatting mode <ul><li>`PHONE_FORMATTING_MODE_DISABLED`: Disable phone formatting</li></ul>


### LanguageRestrictionOptions {#LanguageRestrictionOptions}

Field | Description
--- | ---
restriction_type | enum **LanguageRestrictionType**<br>Language restriction type <ul><li>`WHITELIST`: The allowing list. The incoming audio can contain only the listed languages.</li><li>`BLACKLIST`: The forbidding list. The incoming audio cannot contain the listed languages.</li></ul>
language_code[] | **string**<br>The list of language codes to restrict recognition in the case of an auto model 


### RecognitionClassifierOptions {#RecognitionClassifierOptions}

Field | Description
--- | ---
classifiers[] | **[RecognitionClassifier](#RecognitionClassifier)**<br>List of classifiers to use 


### RecognitionClassifier {#RecognitionClassifier}

Field | Description
--- | ---
classifier | **string**<br>Classifier name 
triggers[] | enum **TriggerType**<br>Describes the types of responses to which the classification results will come <ul><li>`ON_UTTERANCE`: Apply classifier to utterance responses</li><li>`ON_FINAL`: Apply classifier to final responses</li><li>`ON_PARTIAL`: Apply classifier to partial responses</li></ul>


### SpeechAnalysisOptions {#SpeechAnalysisOptions}

Field | Description
--- | ---
enable_speaker_analysis | **bool**<br>Analyse speech for every speaker 
enable_conversation_analysis | **bool**<br>Analyse conversation of two speakers 
descriptive_statistics_quantiles[] | **double**<br>Quantile levels in range (0, 1) for descriptive statistics 


### SpeakerLabelingOptions {#SpeakerLabelingOptions}

Field | Description
--- | ---
speaker_labeling | enum **SpeakerLabeling**<br>Specifies the execution of speaker labeling. Default is SPEAKER_LABELING_DISABLED. <ul><li>`SPEAKER_LABELING_ENABLED`: Enable speaker labeling</li><li>`SPEAKER_LABELING_DISABLED`: Disable speaker labeling</li></ul>


## GetRecognition {#GetRecognition}



**rpc GetRecognition ([GetRecognitionRequest](#GetRecognitionRequest)) returns (stream [StreamingResponse](#StreamingResponse))**

### GetRecognitionRequest {#GetRecognitionRequest}

Field | Description
--- | ---
operation_id | **string**<br> The maximum string length in characters is 50.


### StreamingResponse {#StreamingResponse}

Field | Description
--- | ---
session_uuid | **[SessionUuid](#SessionUuid)**<br>Session identifier 
audio_cursors | **[AudioCursors](#AudioCursors)**<br>Progress bar for stream session recognition: how many data we obtained; final and partial times; etc. 
response_wall_time_ms | **int64**<br>Wall clock on server side. This is time when server wrote results to stream 
Event | **oneof:** `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis` or `conversation_analysis`<br>
&nbsp;&nbsp;partial | **[AlternativeUpdate](#AlternativeUpdate)**<br>Partial results, server will send them regularly after enough audio data was received from user. This are current text estimation from final_time_ms to partial_time_ms. Could change after new data will arrive. 
&nbsp;&nbsp;final | **[AlternativeUpdate](#AlternativeUpdate)**<br>Final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases. 
&nbsp;&nbsp;eou_update | **[EouUpdate](#EouUpdate)**<br>After EOU classifier, send the message with final, send the EouUpdate with time of EOU before eou_update we send final with the same time. there could be several finals before eou update. 
&nbsp;&nbsp;final_refinement | **[FinalRefinement](#FinalRefinement)**<br>For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing). Final normalization will introduce additional latency. 
&nbsp;&nbsp;status_code | **[StatusCode](#StatusCode)**<br>Status messages, send by server with fixed interval (keep-alive). 
&nbsp;&nbsp;classifier_update | **[RecognitionClassifierUpdate](#RecognitionClassifierUpdate)**<br>Result of the triggered classifier 
&nbsp;&nbsp;speaker_analysis | **[SpeakerAnalysis](#SpeakerAnalysis)**<br>Speech statistics for every speaker 
&nbsp;&nbsp;conversation_analysis | **[ConversationAnalysis](#ConversationAnalysis)**<br>Conversation statistics 
channel_tag | **string**<br>Tag for distinguish audio channels. 


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
channel_tag | **string**<br> 


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
code_type | enum **CodeType**<br>Code type. <ul><li>`WORKING`: All good.</li><li>`WARNING`: For example, if speech is sent not in real time or context is unknown and we've made fallback.</li><li>`CLOSED`: After session was closed.</li></ul>
message | **string**<br>Human readable message. 


### RecognitionClassifierUpdate {#RecognitionClassifierUpdate}

Field | Description
--- | ---
window_type | enum **WindowType**<br>Response window type <ul><li>`LAST_UTTERANCE`: The result of applying the classifier to the last utterance response</li><li>`LAST_FINAL`: The result of applying the classifier to the last final response</li><li>`LAST_PARTIAL`: The result of applying the classifier to the last partial response</li></ul>
start_time_ms | **int64**<br>Start time of the audio segment used for classification 
end_time_ms | **int64**<br>End time of the audio segment used for classification 
classifier_result | **[RecognitionClassifierResult](#RecognitionClassifierResult)**<br>Result for dictionary-based classifier 


### RecognitionClassifierResult {#RecognitionClassifierResult}

Field | Description
--- | ---
classifier | **string**<br>Name of the triggered classifier 
highlights[] | **[PhraseHighlight](#PhraseHighlight)**<br>List of highlights, i.e. parts of phrase that determine the result of the classification 
labels[] | **[RecognitionClassifierLabel](#RecognitionClassifierLabel)**<br>Classifier predictions 


### PhraseHighlight {#PhraseHighlight}

Field | Description
--- | ---
text | **string**<br>Text transcription of the highlighted audio segment 
start_time_ms | **int64**<br>Start time of the highlighted audio segment 
end_time_ms | **int64**<br>End time of the highlighted audio segment 


### RecognitionClassifierLabel {#RecognitionClassifierLabel}

Field | Description
--- | ---
label | **string**<br>The label of the class predicted by the classifier 
confidence | **double**<br>The prediction confidence 


### SpeakerAnalysis {#SpeakerAnalysis}

Field | Description
--- | ---
speaker_tag | **string**<br>Speaker tag 
window_type | enum **WindowType**<br>Response window type <ul><li>`TOTAL`: Stats for all received audio.</li><li>`LAST_UTTERANCE`: Stats for last utterance.</li></ul>
speech_boundaries | **[AudioSegmentBoundaries](#AudioSegmentBoundaries)**<br>Audio segment boundaries 
total_speech_ms | **int64**<br>Total speech duration 
speech_ratio | **double**<br>Speech ratio within audio segment 
total_silence_ms | **int64**<br>Total silence duration 
silence_ratio | **double**<br>Silence ratio within audio segment 
words_count | **int64**<br>Number of words in recognized speech 
letters_count | **int64**<br>Number of letters in recognized speech 
words_per_second | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for words per second distribution 
letters_per_second | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for letters per second distribution 
words_per_utterance | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for words per utterance distribution 
letters_per_utterance | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for letters per utterance distribution 
utterance_count | **int64**<br>Number of utterances 
utterance_duration_estimation | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for utterance duration distribution 


### AudioSegmentBoundaries {#AudioSegmentBoundaries}

Field | Description
--- | ---
start_time_ms | **int64**<br>Audio segment start time 
end_time_ms | **int64**<br>Audio segment end time 


### DescriptiveStatistics {#DescriptiveStatistics}

Field | Description
--- | ---
min | **double**<br>Minimum observed value 
max | **double**<br>Maximum observed value 
mean | **double**<br>Estimated mean of distribution 
std | **double**<br>Estimated standard deviation of distribution 
quantiles[] | **[Quantile](#Quantile)**<br>List of evaluated quantiles 


### Quantile {#Quantile}

Field | Description
--- | ---
level | **double**<br>Quantile level in range (0, 1) 
value | **double**<br>Quantile value 


### ConversationAnalysis {#ConversationAnalysis}

Field | Description
--- | ---
conversation_boundaries | **[AudioSegmentBoundaries](#AudioSegmentBoundaries1)**<br>Audio segment boundaries 
total_simultaneous_silence_duration_ms | **int64**<br>Total simultaneous silence duration 
total_simultaneous_silence_ratio | **double**<br>Simultaneous silence ratio within audio segment 
simultaneous_silence_duration_estimation | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for simultaneous silence duration distribution 
total_simultaneous_speech_duration_ms | **int64**<br>Total simultaneous speech duration 
total_simultaneous_speech_ratio | **double**<br>Simultaneous speech ratio within audio segment 
simultaneous_speech_duration_estimation | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for simultaneous speech duration distribution 
speaker_interrupts[] | **[InterruptsEvaluation](#InterruptsEvaluation)**<br>Interrupts description for every speaker 
total_speech_duration_ms | **int64**<br>Total speech duration, including both simultaneous and separate speech 
total_speech_ratio | **double**<br>Total speech ratio within audio segment 


### InterruptsEvaluation {#InterruptsEvaluation}

Field | Description
--- | ---
speaker_tag | **string**<br>Speaker tag 
interrupts_count | **int64**<br>Number of interrupts made by the speaker 
interrupts_duration_ms | **int64**<br>Total duration of all interrupts 
interrupts[] | **[AudioSegmentBoundaries](#AudioSegmentBoundaries1)**<br>Boundaries for every interrupt 


