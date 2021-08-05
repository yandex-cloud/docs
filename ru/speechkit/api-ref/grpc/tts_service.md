---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Synthesizer

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
model | **string**<br>The name of the model. <br>Currently avalible only `general`. 
Utterance | **oneof:** `text` or `text_template`<br>Text to synthesis, one of text synthesis markups.
&nbsp;&nbsp;text | **string**<br>Raw text (e.g. "Hello, Alice"). 
&nbsp;&nbsp;text_template | **[TextTemplate](#TextTemplate)**<br>Text template instalce, e.g. `{"Hello, {username}" with username="Alice"}`. 
hints[] | **[Hints](#Hints)**<br>Optional hints for synthesis. 
output_audio_spec | **[AudioFormatOptions](#AudioFormatOptions)**<br>Optional. Default: 22050 Hz, linear 16-bit signed little-endian PCM, with WAV header 


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
Hint | **oneof:** `voice`, `audio_template`, `speed` or `volume`<br>The hint for TTS engine to specify synthesised audio characteristics.
&nbsp;&nbsp;voice | **string**<br>Name of speaker to use. 
&nbsp;&nbsp;audio_template | **[AudioTemplate](#AudioTemplate)**<br>Template for synthesizing. 
&nbsp;&nbsp;speed | **double**<br>hint to change speed 
&nbsp;&nbsp;volume | **double**<br>hint to regulate volume 


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


### AudioFormatOptions {#AudioFormatOptions}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio)**<br>The audio format specified in request parameters. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio)**<br>The audio format specified inside the container metadata. 


### RawAudio {#RawAudio}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Encoding type. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM).</li><ul/>
sample_rate_hertz | **int64**<br>Sampling frequency of the signal. 


### ContainerAudio {#ContainerAudio}

Field | Description
--- | ---
container_audio_type | enum **ContainerAudioType**<br> <ul><li>`WAV`: RIFF linear pcm with header audio file format.</li><ul/>


### TextTemplate {#TextTemplate1}

Field | Description
--- | ---
text_template | **string**<br>Template text. <br>Sample:`The {animal} goes to the {place}.` 
variables[] | **[TextVariable](#TextVariable1)**<br>Defining variables in template text. <br>Sample: `{animal: cat, place: forest}` 


### TextVariable {#TextVariable1}

Field | Description
--- | ---
variable_name | **string**<br>The name of the variable. 
variable_value | **string**<br>The text of the variable. 


### AudioVariable {#AudioVariable}

Field | Description
--- | ---
variable_name | **string**<br>The name of the variable. 
variable_start_ms | **int64**<br>Start time of the variable in milliseconds. 
variable_length_ms | **int64**<br>Lenght of the variable in milliseconds. 


### AudioFormatOptions {#AudioFormatOptions1}

Field | Description
--- | ---
AudioFormat | **oneof:** `raw_audio` or `container_audio`<br>
&nbsp;&nbsp;raw_audio | **[RawAudio](#RawAudio1)**<br>The audio format specified in request parameters. 
&nbsp;&nbsp;container_audio | **[ContainerAudio](#ContainerAudio1)**<br>The audio format specified inside the container metadata. 


### RawAudio {#RawAudio1}

Field | Description
--- | ---
audio_encoding | enum **AudioEncoding**<br>Encoding type. <ul><li>`LINEAR16_PCM`: 16-bit signed little-endian (Linear PCM).</li><ul/>
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
data | **bytes**<br>Sequence of bytes of the synthesized audio in format specified in output_audio_spec. 


