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
| [Search](#Search) | rpc for searching talks. |
| [Get](#Get) | rpc for bulk get |

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
users[] | **[UserMetadata](#UserMetadata)**<br>per user specific metadata 


### UserMetadata {#UserMetadata}

Field | Description
--- | ---
id | **string**<br> 
role | enum **UserRole**<br> 
fields | **map<string,string>**<br> 


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
users[] | **[UserMetadata](#UserMetadata)**<br>per user specific metadata 


### UserMetadata {#UserMetadata1}

Field | Description
--- | ---
id | **string**<br> 
role | enum **UserRole**<br> 
fields | **map<string,string>**<br> 


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
users[] | **[UserMetadata](#UserMetadata)**<br>per user specific metadata 


### UserMetadata {#UserMetadata2}

Field | Description
--- | ---
id | **string**<br> 
role | enum **UserRole**<br> 
fields | **map<string,string>**<br> 


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


## Search {#Search}

rpc for searching talks. will return ids only

**rpc Search ([SearchTalkRequest](#SearchTalkRequest)) returns ([SearchTalkResponse](#SearchTalkResponse))**

### SearchTalkRequest {#SearchTalkRequest}

Field | Description
--- | ---
organization_id | **string**<br>id of organization 
space_id | **string**<br>id of space 
connection_id | **string**<br>id of connection 
project_id | **string**<br>id of project 
filters[] | **[Filter](#Filter)**<br>metadata keys filters (user and system) 
query | **[Query](#Query)**<br>Full-text search query 
page_size | **int64**<br>page size, from 1 to 1000, default 100 
page_token | **string**<br>next page token, if page is not first 
sort_data | **[SortData](#SortData)**<br>talks sorting options 


### Filter {#Filter}

Field | Description
--- | ---
key | **string**<br>metadata key (user.some_key / system.created_at / analysis.speechkit.duration) 
filter | **oneof:** `any_match`, `int_range`, `double_range`, `date_range`, `duration_range` or `boolean_match`<br>
&nbsp;&nbsp;any_match | **[AnyMatchFilter](#AnyMatchFilter)**<br>find talk matched by any text filters 
&nbsp;&nbsp;int_range | **[IntRangeFilter](#IntRangeFilter)**<br>find talks with value from int range 
&nbsp;&nbsp;double_range | **[DoubleRangeFilter](#DoubleRangeFilter)**<br>find talks with value from double range 
&nbsp;&nbsp;date_range | **[DateRangeFilter](#DateRangeFilter)**<br>find talks with value from date range 
&nbsp;&nbsp;duration_range | **[DurationRangeFilter](#DurationRangeFilter)**<br>find talks with value from duration range 
&nbsp;&nbsp;boolean_match | **[BooleanFilter](#BooleanFilter)**<br>find talks with value equals boolean 
inverse | **bool**<br> 
channel_number | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>channel number to apply filter for, starting with 0. applies to all channels if not specified 


### AnyMatchFilter {#AnyMatchFilter}

Field | Description
--- | ---
values[] | **string**<br>values list to match with "OR" operator 


### IntRangeFilter {#IntRangeFilter}

Field | Description
--- | ---
from_value | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
to_value | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
bounds_inclusive | **[BoundsInclusive](#BoundsInclusive)**<br> 


### BoundsInclusive {#BoundsInclusive}

Field | Description
--- | ---
from_inclusive | **bool**<br>include from bound 
to_inclusive | **bool**<br>include to bound 


### DoubleRangeFilter {#DoubleRangeFilter}

Field | Description
--- | ---
from_value | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 
to_value | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 
bounds_inclusive | **[BoundsInclusive](#BoundsInclusive1)**<br> 


### DateRangeFilter {#DateRangeFilter}

Field | Description
--- | ---
from_value | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
to_value | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
bounds_inclusive | **[BoundsInclusive](#BoundsInclusive1)**<br> 


### DurationRangeFilter {#DurationRangeFilter}

Field | Description
--- | ---
from_value | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
to_value | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> 
bounds_inclusive | **[BoundsInclusive](#BoundsInclusive1)**<br> 


### BooleanFilter {#BooleanFilter}

Field | Description
--- | ---
value | **bool**<br> 


### Query {#Query}

Field | Description
--- | ---
text | **string**<br> 
inverse | **bool**<br>should or should NOT match 
channel_number | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>id of channel to search ("1", "2", ..., any channel if not set) 


### SortData {#SortData}

Field | Description
--- | ---
fields[] | **[SortField](#SortField)**<br> 


### SortField {#SortField}

Field | Description
--- | ---
field | **string**<br>sorting key 
order | enum **SortOrder**<br>sorting order by current `field` 
position | **int64**<br>number of field in comparing order (sort by key1 (position = 0), then key2 (position = 1), then key3...) 


### SearchTalkResponse {#SearchTalkResponse}

Field | Description
--- | ---
talk_ids[] | **string**<br>page results entries 
talks_count | **int64**<br>total documents matched 
next_page_token | **string**<br>page token for next request 


## Get {#Get}

rpc for bulk get

**rpc Get ([GetTalkRequest](#GetTalkRequest)) returns ([GetTalkResponse](#GetTalkResponse))**

### GetTalkRequest {#GetTalkRequest}

Field | Description
--- | ---
organization_id | **string**<br>id of organization 
space_id | **string**<br>id of space 
connection_id | **string**<br>id of connection to search data 
project_id | **string**<br>id of project to search data 
talk_ids[] | **string**<br>ids of talks to return. Requesting too many talks may result in "message exceeds maximum size" error. Up to 100 of talks per request is recommended. 
results_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>All types of analysis will be returned if not set. 


### GetTalkResponse {#GetTalkResponse}

Field | Description
--- | ---
talk[] | **[Talk](#Talk)**<br> 


### Talk {#Talk}

Field | Description
--- | ---
id | **string**<br>talk id 
organization_id | **string**<br> 
space_id | **string**<br> 
connection_id | **string**<br> 
project_ids[] | **string**<br> 
created_by | **string**<br>audition info 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
modified_by | **string**<br> 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
talk_fields[] | **[Field](#Field)**<br>key-value representation of talk fields with values 
transcription | **`yandex.cloud.speechsense.v1.analysis.Transcription`**<br>various ml analysis results 
speech_statistics | **`yandex.cloud.speechsense.v1.analysis.SpeechStatistics`**<br> 
silence_statistics | **`yandex.cloud.speechsense.v1.analysis.SilenceStatistics`**<br> 
interrupts_statistics | **`yandex.cloud.speechsense.v1.analysis.InterruptsStatistics`**<br> 
conversation_statistics | **`yandex.cloud.speechsense.v1.analysis.ConversationStatistics`**<br> 
points | **`yandex.cloud.speechsense.v1.analysis.Points`**<br> 
text_classifiers | **`yandex.cloud.speechsense.v1.analysis.TextClassifiers`**<br> 


### Field {#Field}

Field | Description
--- | ---
name | **string**<br>name of the field 
value | **string**<br>field value 
type | enum **FieldType**<br>field type 


### Transcription {#Transcription}

Field | Description
--- | ---
phrases[] | **[Phrase](#Phrase)**<br> 
algorithms_metadata[] | **[AlgorithmMetadata](#AlgorithmMetadata)**<br>Their might be several algorithms that work on talk transcription. For example: speechkit and translator So there might be other fields here for tracing 


### Phrase {#Phrase}

Field | Description
--- | ---
channel_number | **int64**<br> 
start_time_ms | **int64**<br> 
end_time_ms | **int64**<br> 
phrase | **[PhraseText](#PhraseText)**<br> 
statistics | **[PhraseStatistics](#PhraseStatistics)**<br> 
classifiers[] | **[RecognitionClassifierResult](#RecognitionClassifierResult)**<br> 


### PhraseText {#PhraseText}

Field | Description
--- | ---
text | **string**<br> 
language | **string**<br> 
normalized_text | **string**<br> 
words[] | **[Word](#Word)**<br> 


### Word {#Word}

Field | Description
--- | ---
word | **string**<br> 
start_time_ms | **int64**<br> 
end_time_ms | **int64**<br> 


### PhraseStatistics {#PhraseStatistics}

Field | Description
--- | ---
statistics | **[UtteranceStatistics](#UtteranceStatistics)**<br> 


### UtteranceStatistics {#UtteranceStatistics}

Field | Description
--- | ---
speaker_tag | **string**<br> 
speech_boundaries | **[AudioSegmentBoundaries](#AudioSegmentBoundaries)**<br>Audio segment boundaries 
total_speech_ms | **int64**<br>Total speech duration 
speech_ratio | **double**<br>Speech ratio within audio segment 
total_silence_ms | **int64**<br>Total silence duration 
silence_ratio | **double**<br>Silence ratio within audio segment 
words_count | **int64**<br>Number of words in recognized speech 
letters_count | **int64**<br>Number of letters in recognized speech 
words_per_second | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for words per second distribution 
letters_per_second | **[DescriptiveStatistics](#DescriptiveStatistics)**<br>Descriptive statistics for letters per second distribution 


### AudioSegmentBoundaries {#AudioSegmentBoundaries}

Field | Description
--- | ---
start_time_ms | **int64**<br>Audio segment start time 
end_time_ms | **int64**<br>Audio segment end time 
duration_seconds | **int64**<br>Duration in seconds 


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


### RecognitionClassifierResult {#RecognitionClassifierResult}

Field | Description
--- | ---
start_time_ms | **int64**<br>Start time of the audio segment used for classification 
end_time_ms | **int64**<br>End time of the audio segment used for classification 
classifier | **string**<br>Name of the triggered classifier 
highlights[] | **[PhraseHighlight](#PhraseHighlight)**<br>List of highlights, i.e. parts of phrase that determine the result of the classification 
labels[] | **[RecognitionClassifierLabel](#RecognitionClassifierLabel)**<br>Classifier predictions 


### PhraseHighlight {#PhraseHighlight}

Field | Description
--- | ---
text | **string**<br>Text transcription of the highlighted audio segment 
offset | **int64**<br>offset in symbols from the beginning of whole phrase where highlight begins 
count | **int64**<br>count of symbols in highlighted text 


### RecognitionClassifierLabel {#RecognitionClassifierLabel}

Field | Description
--- | ---
label | **string**<br>The label of the class predicted by the classifier 
confidence | **double**<br>The prediction confidence 


### AlgorithmMetadata {#AlgorithmMetadata}

Field | Description
--- | ---
created_task_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
completed_task_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
error | **[Error](#Error)**<br> 
trace_id | **string**<br> 
name | **string**<br> 


### Error {#Error}

Field | Description
--- | ---
code | **string**<br> 
message | **string**<br> 


### SpeechStatistics {#SpeechStatistics}

Field | Description
--- | ---
total_simultaneous_speech_duration_seconds | **int64**<br>Total simultaneous speech duration in seconds 
total_simultaneous_speech_duration_ms | **int64**<br>Total simultaneous speech duration in ms 
total_simultaneous_speech_ratio | **double**<br>Simultaneous speech ratio within audio segment 
simultaneous_speech_duration_estimation | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for simultaneous speech duration distribution 


### SilenceStatistics {#SilenceStatistics}

Field | Description
--- | ---
total_simultaneous_silence_duration_ms | **int64**<br> 
total_simultaneous_silence_ratio | **double**<br>Simultaneous silence ratio within audio segment 
simultaneous_silence_duration_estimation | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for simultaneous silence duration distribution 
total_simultaneous_silence_duration_seconds | **int64**<br> 


### InterruptsStatistics {#InterruptsStatistics}

Field | Description
--- | ---
speaker_interrupts[] | **[InterruptsEvaluation](#InterruptsEvaluation)**<br>Interrupts description for every speaker 


### InterruptsEvaluation {#InterruptsEvaluation}

Field | Description
--- | ---
speaker_tag | **string**<br>Speaker tag 
interrupts_count | **int64**<br>Number of interrupts made by the speaker 
interrupts_duration_ms | **int64**<br>Total duration of all interrupts 
interrupts[] | **[AudioSegmentBoundaries](#AudioSegmentBoundaries1)**<br>Boundaries for every interrupt 
interrupts_duration_seconds | **int64**<br>Total duration of all interrupts in seconds 


### ConversationStatistics {#ConversationStatistics}

Field | Description
--- | ---
conversation_boundaries | **[AudioSegmentBoundaries](#AudioSegmentBoundaries1)**<br>Audio segment boundaries 
speaker_statistics[] | **[SpeakerStatistics](#SpeakerStatistics)**<br>Average statistics for each speaker 


### SpeakerStatistics {#SpeakerStatistics}

Field | Description
--- | ---
speaker_tag | **string**<br>Speaker tag 
complete_statistics | **[UtteranceStatistics](#UtteranceStatistics1)**<br>analysis of all phrases in format of single utterance 
words_per_utterance | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for words per utterance distribution 
letters_per_utterance | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for letters per utterance distribution 
utterance_count | **int64**<br>Number of utterances 
utterance_duration_estimation | **[DescriptiveStatistics](#DescriptiveStatistics1)**<br>Descriptive statistics for utterance duration distribution 


### Points {#Points}

Field | Description
--- | ---
quiz[] | **[Quiz](#Quiz)**<br> 


### Quiz {#Quiz}

Field | Description
--- | ---
request | **string**<br> 
response | **google.protobuf.StringValue**<br> 
id | **string**<br> 


### TextClassifiers {#TextClassifiers}

Field | Description
--- | ---
classification_result[] | **[ClassificationResult](#ClassificationResult)**<br> 


### ClassificationResult {#ClassificationResult}

Field | Description
--- | ---
classifier | **string**<br>Classifier name 
classifier_statistics[] | **[ClassifierStatistics](#ClassifierStatistics)**<br>Classifier statistics 


### ClassifierStatistics {#ClassifierStatistics}

Field | Description
--- | ---
channel_number | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Channel number, null for whole talk 
total_count | **int64**<br>classifier total count 
histograms[] | **[Histogram](#Histogram)**<br>Represents various histograms build on top of classifiers 


### Histogram {#Histogram}

Field | Description
--- | ---
count_values[] | **int64**<br>histogram count values. For example: if len(count_values) = 2, it means that histogram is 50/50, if len(count_values) = 3 - [0] value represents first third, [1] - second third, [2] - last third, etc. 


