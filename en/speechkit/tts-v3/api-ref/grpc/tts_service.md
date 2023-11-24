---
editable: false
sourcePath: en/_api-ref-grpc/ai/tts/tts-v3/tts-v3/api-ref/grpc/tts_service.md
---

# SpeechKit Synthesis Service API v3, gRPC: Synthesizer

A set of methods for voice synthesis.

| Call | Description |
| --- | --- |
| [UtteranceSynthesis](#UtteranceSynthesis) | Synthesizing text into speech. |

## Calls Synthesizer {#calls}

## UtteranceSynthesis {#UtteranceSynthesis}

Synthesizing text into speech.

**rpc UtteranceSynthesis ([UtteranceSynthesisRequest](#UtteranceSynthesisRequest)) returns (stream [UtteranceSynthesisResponse](#UtteranceSynthesisResponse))**

### UtteranceSynthesisRequest {#UtteranceSynthesisRequest}

Field | Description
--- | ---
model | **string**<br>The name of the model. Specifies basic synthesis functionality. Currently should be empty. Do not use it. 
Utterance | **oneof:** `text` or `text_template`<br>Text to synthesis, one of text synthesis markups.
&nbsp;&nbsp;text | **string**<br>Raw text (e.g. "Hello, Alice"). 
&nbsp;&nbsp;text_template | **[TextTemplate](#TextTemplate)**<br>Text template instance, e.g. `{"Hello, {username}" with username="Alice"}`. 
hints[] | **[Hints](#Hints)**<br>Optional hints for synthesis. 
output_audio_spec | **[AudioFormatOptions](#AudioFormatOptions)**<br>Optional. Default: 22050 Hz, linear 16-bit signed little-endian PCM, with WAV header 
loudness_normalization_type | enum **LoudnessNormalizationType**<br>Specifies type of loudness normalization. Optional. Default: `LUFS`. <ul><li>`MAX_PEAK`: The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.</li><li>`LUFS`: The type of normalization based on EBU R 128 recommendation.</li></ul>
unsafe_mode | **bool**<br>Optional. Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible. 


### TextTemplate {#TextTemplate}

Field | Description
--- | ---
text_template | **string**<br>Template text. <br>Sample:`The {animal} goes to the {place}.` 
variables[] | **[TextVariable](#TextVariable)**<br>Defining variables in template text. <br>Sample: `{animal: cat, place: forest}` 


### TextVariable {#TextVariable}

Field | Description
--- | ---
variable_name | **string**<br>The name of the variable. 
variable_value | **string**<br>The text of the variable. 


### Hints {#Hints}

Field | Description
--- | ---
Hint | **oneof:** `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift` or `duration`<br>The hint for TTS engine to specify synthesised audio characteristics.
&nbsp;&nbsp;voice | **string**<br>Name of speaker to use. 
&nbsp;&nbsp;audio_template | **[AudioTemplate](#AudioTemplate)**<br>Template for synthesizing. 
&nbsp;&nbsp;speed | **double**<br>Hint to change speed. 
&nbsp;&nbsp;volume | **double**<br>Hint to regulate normalization level. <ul><li>For `MAX_PEAK` loudness_normalization_type: volume changes in a range (0;1], default value is 0.7. </li><li>For `LUFS` loudness_normalization_type: volume changes in a range [-145;0), default value is -19.</li></ul> 
&nbsp;&nbsp;role | **string**<br>Hint to specify pronunciation character for the speaker. 
&nbsp;&nbsp;pitch_shift | **double**<br>Hint to increase (or decrease) speaker's pitch, measured in Hz. Valid values are in range [-1000;1000], default value is 0. 
&nbsp;&nbsp;duration | **[DurationHint](#DurationHint)**<br>Hint to limit both minimum and maximum audio duration. 


### AudioTemplate {#AudioTemplate}

Field | Description
--- | ---
audio | **[AudioContent](#AudioContent)**<br>Audio file. 
text_template | **[TextTemplate](#TextTemplate1)**<br>Template and description of its variables. 
variables[] | **[AudioVariable](#AudioVariable)**<br>Describing variables in audio. 


### AudioContent {#AudioContent}

Field | Description
--- | ---
AudioSource | **oneof:** `content`<br>The audio source to read the data from.
&nbsp;&nbsp;content | **bytes**<br>Bytes with audio data. 
audio_spec | **[AudioFormatOptions](#AudioFormatOptions)**<br>Description of the audio format. 


### AudioVariable {#AudioVariable}

Field | Description
--- | ---
variable_name | **string**<br>The name of the variable. 
variable_start_ms | **int64**<br>Start time of the variable in milliseconds. 
variable_length_ms | **int64**<br>Length of the variable in milliseconds. 


### DurationHint {#DurationHint}

Field | Description
--- | ---
policy | enum **DurationHintPolicy**<br>Type of duration constraint. <ul><li>`EXACT_DURATION`: Limit audio duration to exact value.</li><li>`MIN_DURATION`: Limit the minimum audio duration.</li><li>`MAX_DURATION`: Limit the maximum audio duration.</li></ul>
duration_ms | **int64**<br>Constraint on audio duration in milliseconds. 


### AudioFormatOptions {#AudioFormatOptions}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio)**<br>The audio format specified in request parameters. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio)**<br>The audio format specified inside the container metadata. 


### RawAudio {#RawAudio}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Encoding type. <ul><li>`LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li></ul>
sample_rate_hertz | **int64**<br>Sampling frequency of the signal. 


### ContainerAudio {#ContainerAudio}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br> <ul><li>`WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).</li><li>`OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li><li>`MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li></ul>


### UtteranceSynthesisResponse {#UtteranceSynthesisResponse}

Field | Description
--- | ---
audio_chunk | **[AudioChunk](#AudioChunk)**<br>Part of synthesized audio. 


### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br>Sequence of bytes of the synthesized audio in format specified in output_audio_spec. 


