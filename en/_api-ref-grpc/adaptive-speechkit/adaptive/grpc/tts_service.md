---
editable: false
---

# Synthesizer

Service for adaptive synthesis from template with variable parts

| Call | Description |
| --- | --- |
| [UtteranceSynthesis](#UtteranceSynthesis) | tts here will change, just for MVP |

## Calls Synthesizer {#calls}

## UtteranceSynthesis {#UtteranceSynthesis}

tts here will change, just for MVP

**rpc UtteranceSynthesis ([UtteranceSynthesisRequest](#UtteranceSynthesisRequest)) returns (stream [UtteranceSynthesisResponse](#UtteranceSynthesisResponse))**

### UtteranceSynthesisRequest {#UtteranceSynthesisRequest}

Field | Description
--- | ---
model | **string**<br> 
Utterance | **oneof:** `text` or `text_template`<br>Text to synthesis, one of for advanced mark up in future
&nbsp;&nbsp;text | **string**<br>Text to synthesis, one of for advanced mark up in future 
&nbsp;&nbsp;text_template | **[TextTemplate](#TextTemplate)**<br>Text to synthesis, one of for advanced mark up in future 
hints[] | **[Hints](#Hints)**<br>Optional hints for synthesis. 
output_audio_spec | **[AudioFormatOptions](#AudioFormatOptions)**<br>Optional. Default: 22050 Hz, linear 16-bit signed little-endian pcm 


### TextTemplate {#TextTemplate}

Field | Description
--- | ---
text_template | **string**<br>hello, {user} 
variables[] | **[TextVariable](#TextVariable)**<br>{user: Adam} 


### TextVariable {#TextVariable}

Field | Description
--- | ---
variable_name | **string**<br> 
variable_value | **string**<br>The text of the variable to be synthesized instead of the template. 


### Hints {#Hints}

Field | Description
--- | ---
Hint | **oneof:** `voice` or `audio_template`<br>The hint for specifying the voice that need to synthesize in the audio.
&nbsp;&nbsp;voice | **string**<br>The hint for specifying the voice that need to synthesize in the audio. 
&nbsp;&nbsp;audio_template | **[AudioTemplate](#AudioTemplate)**<br>The hint for specifying the voice that need to synthesize in the audio. 


### AudioTemplate {#AudioTemplate}

Field | Description
--- | ---
audio | **[AudioContent](#AudioContent)**<br> 
text_template | **[TextTemplate](#TextTemplate1)**<br> 
variables[] | **[AudioVariable](#AudioVariable)**<br> 


### AudioContent {#AudioContent}

Field | Description
--- | ---
AudioSource | **oneof:** `content`<br>The audio source to read the data from.
&nbsp;&nbsp;content | **bytes**<br>The audio source to read the data from. 
audio_spec | **[AudioFormatOptions](#AudioFormatOptions)**<br>Description of the audio format. 


### AudioFormatOptions {#AudioFormatOptions}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio)**<br>The audio format specified in request parameters. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio)**<br>The audio format specified inside the file header. 


### RawAudio {#RawAudio}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Encoding type. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br>Sampling frequency of the signal. 


### ContainerAudio {#ContainerAudio}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br> <ul><li>`WAV`: RIFF linear pcm with header audio file format.</li><ul/>


### TextTemplate {#TextTemplate1}

Field | Description
--- | ---
text_template | **string**<br>hello, {user} 
variables[] | **[TextVariable](#TextVariable1)**<br>{user: Adam} 


### TextVariable {#TextVariable1}

Field | Description
--- | ---
variable_name | **string**<br> 
variable_value | **string**<br>The text of the variable to be synthesized instead of the template. 


### AudioVariable {#AudioVariable}

Field | Description
--- | ---
variable_name | **string**<br> 
variable_start_ms | **int64**<br> 
variable_length_ms | **int64**<br> 


### AudioFormatOptions {#AudioFormatOptions1}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio1)**<br>The audio format specified in request parameters. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio1)**<br>The audio format specified inside the file header. 


### RawAudio {#RawAudio1}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Encoding type. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM)</li><ul/>
sample_rate_hertz | **int64**<br>Sampling frequency of the signal. 


### ContainerAudio {#ContainerAudio1}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br> <ul><li>`WAV`: RIFF linear pcm with header audio file format.</li><ul/>


### UtteranceSynthesisResponse {#UtteranceSynthesisResponse}

Field | Description
--- | ---
audio_chunk | **[AudioChunk](#AudioChunk)**<br>Part of synthesized audio. 


### AudioChunk {#AudioChunk}

Field | Description
--- | ---
data | **bytes**<br>Sequence of bytes of the synthesized audio in format specified in output_audio_spec 


