---
editable: false
sourcePath: en/_api-ref-grpc/ai/tts/v3/tts-v3/api-ref/grpc/Synthesizer/utteranceSynthesis.md
---

# SpeechKit Synthesis Service API v3, gRPC: Synthesizer.UtteranceSynthesis

Synthesizing text into speech.

## gRPC request

**rpc UtteranceSynthesis ([UtteranceSynthesisRequest](#speechkit.tts.v3.UtteranceSynthesisRequest)) returns (stream [UtteranceSynthesisResponse](#speechkit.tts.v3.UtteranceSynthesisResponse))**

## UtteranceSynthesisRequest {#speechkit.tts.v3.UtteranceSynthesisRequest}

```json
{
  "model": "string",
  // Includes only one of the fields `text`, `text_template`
  "text": "string",
  "text_template": {
    "text_template": "string",
    "variables": [
      {
        "variable_name": "string",
        "variable_value": "string"
      }
    ]
  },
  // end of the list of possible fields
  "hints": [
    {
      // Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`
      "voice": "string",
      "audio_template": {
        "audio": {
          // Includes only one of the fields `content`
          "content": "bytes",
          // end of the list of possible fields
          "audio_spec": {
            // Includes only one of the fields `raw_audio`, `container_audio`
            "raw_audio": {
              "audio_encoding": "AudioEncoding",
              "sample_rate_hertz": "int64"
            },
            "container_audio": {
              "container_audio_type": "ContainerAudioType"
            }
            // end of the list of possible fields
          }
        },
        "text_template": {
          "text_template": "string",
          "variables": [
            {
              "variable_name": "string",
              "variable_value": "string"
            }
          ]
        },
        "variables": [
          {
            "variable_name": "string",
            "variable_start_ms": "int64",
            "variable_length_ms": "int64"
          }
        ]
      },
      "speed": "double",
      "volume": "double",
      "role": "string",
      "pitch_shift": "double",
      "duration": {
        "policy": "DurationHintPolicy",
        "duration_ms": "int64"
      }
      // end of the list of possible fields
    }
  ],
  "output_audio_spec": {
    // Includes only one of the fields `raw_audio`, `container_audio`
    "raw_audio": {
      "audio_encoding": "AudioEncoding",
      "sample_rate_hertz": "int64"
    },
    "container_audio": {
      "container_audio_type": "ContainerAudioType"
    }
    // end of the list of possible fields
  },
  "loudness_normalization_type": "LoudnessNormalizationType",
  "unsafe_mode": "bool"
}
```

#|
||Field | Description ||
|| model | **string**

The name of the model.
Specifies basic synthesis functionality. Currently should be empty. Do not use it. ||
|| text | **string**

Raw text (e.g. "Hello, Alice").

Includes only one of the fields `text`, `text_template`.

Text to synthesis, one of text synthesis markups. ||
|| text_template | **[TextTemplate](#speechkit.tts.v3.TextTemplate)**

Text template instance, e.g. `{"Hello, {username}" with username="Alice"}`.

Includes only one of the fields `text`, `text_template`.

Text to synthesis, one of text synthesis markups. ||
|| hints[] | **[Hints](#speechkit.tts.v3.Hints)**

Optional hints for synthesis. ||
|| output_audio_spec | **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Optional. Default: 22050 Hz, linear 16-bit signed little-endian PCM, with WAV header ||
|| loudness_normalization_type | enum **LoudnessNormalizationType**

Specifies type of loudness normalization.
Optional. Default: `LUFS`.

- `LOUDNESS_NORMALIZATION_TYPE_UNSPECIFIED`
- `MAX_PEAK`: The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.
- `LUFS`: The type of normalization based on EBU R 128 recommendation. ||
|| unsafe_mode | **bool**

Optional. Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible. ||
|#

## TextTemplate {#speechkit.tts.v3.TextTemplate}

#|
||Field | Description ||
|| text_template | **string**

Template text.

Sample:`The {animal} goes to the {place}.` ||
|| variables[] | **[TextVariable](#speechkit.tts.v3.TextVariable)**

Defining variables in template text.

Sample: `{animal: cat, place: forest}` ||
|#

## TextVariable {#speechkit.tts.v3.TextVariable}

#|
||Field | Description ||
|| variable_name | **string**

The name of the variable. ||
|| variable_value | **string**

The text of the variable. ||
|#

## Hints {#speechkit.tts.v3.Hints}

#|
||Field | Description ||
|| voice | **string**

Name of speaker to use.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| audio_template | **[AudioTemplate](#speechkit.tts.v3.AudioTemplate)**

Template for synthesizing.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| speed | **double**

Hint to change speed.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| volume | **double**

Hint to regulate normalization level.
* For `MAX_PEAK` loudness_normalization_type: volume changes in a range (0;1], default value is 0.7.
* For `LUFS` loudness_normalization_type: volume changes in a range [-145;0), default value is -19.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| role | **string**

Hint to specify pronunciation character for the speaker.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| pitch_shift | **double**

Hint to increase (or decrease) speaker's pitch, measured in Hz. Valid values are in range [-1000;1000], default value is 0.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| duration | **[DurationHint](#speechkit.tts.v3.DurationHint)**

Hint to limit both minimum and maximum audio duration.

Includes only one of the fields `voice`, `audio_template`, `speed`, `volume`, `role`, `pitch_shift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|#

## AudioTemplate {#speechkit.tts.v3.AudioTemplate}

#|
||Field | Description ||
|| audio | **[AudioContent](#speechkit.tts.v3.AudioContent)**

Audio file. ||
|| text_template | **[TextTemplate](#speechkit.tts.v3.TextTemplate)**

Template and description of its variables. ||
|| variables[] | **[AudioVariable](#speechkit.tts.v3.AudioVariable)**

Describing variables in audio. ||
|#

## AudioContent {#speechkit.tts.v3.AudioContent}

#|
||Field | Description ||
|| content | **bytes**

Bytes with audio data.

Includes only one of the fields `content`.

The audio source to read the data from. ||
|| audio_spec | **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Description of the audio format. ||
|#

## AudioFormatOptions {#speechkit.tts.v3.AudioFormatOptions}

#|
||Field | Description ||
|| raw_audio | **[RawAudio](#speechkit.tts.v3.RawAudio)**

The audio format specified in request parameters.

Includes only one of the fields `raw_audio`, `container_audio`. ||
|| container_audio | **[ContainerAudio](#speechkit.tts.v3.ContainerAudio)**

The audio format specified inside the container metadata.

Includes only one of the fields `raw_audio`, `container_audio`. ||
|#

## RawAudio {#speechkit.tts.v3.RawAudio}

#|
||Field | Description ||
|| audio_encoding | enum **AudioEncoding**

Encoding type.

- `AUDIO_ENCODING_UNSPECIFIED`
- `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sample_rate_hertz | **int64**

Sampling frequency of the signal. ||
|#

## ContainerAudio {#speechkit.tts.v3.ContainerAudio}

#|
||Field | Description ||
|| container_audio_type | enum **ContainerAudioType**

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
- `WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).
- `OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.
- `MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format. ||
|#

## AudioVariable {#speechkit.tts.v3.AudioVariable}

#|
||Field | Description ||
|| variable_name | **string**

The name of the variable. ||
|| variable_start_ms | **int64**

Start time of the variable in milliseconds. ||
|| variable_length_ms | **int64**

Length of the variable in milliseconds. ||
|#

## DurationHint {#speechkit.tts.v3.DurationHint}

#|
||Field | Description ||
|| policy | enum **DurationHintPolicy**

Type of duration constraint.

- `DURATION_HINT_POLICY_UNSPECIFIED`
- `EXACT_DURATION`: Limit audio duration to exact value.
- `MIN_DURATION`: Limit the minimum audio duration.
- `MAX_DURATION`: Limit the maximum audio duration. ||
|| duration_ms | **int64**

Constraint on audio duration in milliseconds. ||
|#

## UtteranceSynthesisResponse {#speechkit.tts.v3.UtteranceSynthesisResponse}

```json
{
  "audio_chunk": {
    "data": "bytes"
  },
  "text_chunk": {
    "text": "string"
  },
  "start_ms": "int64",
  "length_ms": "int64"
}
```

#|
||Field | Description ||
|| audio_chunk | **[AudioChunk](#speechkit.tts.v3.AudioChunk)**

Part of synthesized audio. ||
|| text_chunk | **[TextChunk](#speechkit.tts.v3.TextChunk)**

Part of synthesized text. ||
|| start_ms | **int64**

Start time of the audio chunk in milliseconds. ||
|| length_ms | **int64**

Length of the audio chunk in milliseconds. ||
|#

## AudioChunk {#speechkit.tts.v3.AudioChunk}

#|
||Field | Description ||
|| data | **bytes**

Sequence of bytes of the synthesized audio in format specified in output_audio_spec. ||
|#

## TextChunk {#speechkit.tts.v3.TextChunk}

#|
||Field | Description ||
|| text | **string**

Synthesized text. ||
|#