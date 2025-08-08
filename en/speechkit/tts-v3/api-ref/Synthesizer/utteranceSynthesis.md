---
editable: false
apiPlayground:
  - url: https://{{ api-host-sk-tts }}/tts/v3/utteranceSynthesis
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        model:
          description: |-
            **string**
            The name of the model.
            Specifies basic synthesis functionality. Currently should be empty. Do not use it.
          type: string
        text:
          description: |-
            **string**
            Raw text (e.g. "Hello, Alice").
            Includes only one of the fields `text`, `textTemplate`.
            Text to synthesis, one of text synthesis markups.
          type: string
        textTemplate:
          description: |-
            **[TextTemplate](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.TextTemplate)**
            Text template instance, e.g. `{"Hello, {username}" with username="Alice"}`.
            Includes only one of the fields `text`, `textTemplate`.
            Text to synthesis, one of text synthesis markups.
          $ref: '#/definitions/TextTemplate'
        hints:
          description: |-
            **[Hints](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.Hints)**
            Optional hints for synthesis.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  voice:
                    description: |-
                      **string**
                      Name of speaker to use.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    type: string
                  audioTemplate:
                    description: |-
                      **[AudioTemplate](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.AudioTemplate)**
                      Template for synthesizing.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    $ref: '#/definitions/AudioTemplate'
                  speed:
                    description: |-
                      **string**
                      Hint to change speed.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    type: string
                  volume:
                    description: |-
                      **string**
                      Hint to regulate normalization level.
                      * For `MAX_PEAK` loudness_normalization_type: volume changes in a range (0;1], default value is 0.7.
                      * For `LUFS` loudness_normalization_type: volume changes in a range [-145;0), default value is -19.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    type: string
                  role:
                    description: |-
                      **string**
                      Hint to specify pronunciation character for the speaker.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    type: string
                  pitchShift:
                    description: |-
                      **string**
                      Hint to increase (or decrease) speaker's pitch, measured in Hz. Valid values are in range [-1000;1000], default value is 0.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    type: string
                  duration:
                    description: |-
                      **[DurationHint](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.DurationHint)**
                      Hint to limit both minimum and maximum audio duration.
                      Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.
                      The hint for TTS engine to specify synthesised audio characteristics.
                    $ref: '#/definitions/DurationHint'
        outputAudioSpec:
          description: |-
            **[AudioFormatOptions](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.AudioFormatOptions)**
            Optional. Default: 22050 Hz, linear 16-bit signed little-endian PCM, with WAV header
          oneOf:
            - type: object
              properties:
                rawAudio:
                  description: |-
                    **[RawAudio](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.RawAudio)**
                    The audio format specified in request parameters.
                    Includes only one of the fields `rawAudio`, `containerAudio`.
                  $ref: '#/definitions/RawAudio'
                containerAudio:
                  description: |-
                    **[ContainerAudio](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.ContainerAudio)**
                    The audio format specified inside the container metadata.
                    Includes only one of the fields `rawAudio`, `containerAudio`.
                  $ref: '#/definitions/ContainerAudio'
        loudnessNormalizationType:
          description: |-
            **enum** (LoudnessNormalizationType)
            Specifies type of loudness normalization.
            Optional. Default: `LUFS`.
            - `LOUDNESS_NORMALIZATION_TYPE_UNSPECIFIED`
            - `MAX_PEAK`: The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.
            - `LUFS`: The type of normalization based on EBU R 128 recommendation.
          type: string
          enum:
            - LOUDNESS_NORMALIZATION_TYPE_UNSPECIFIED
            - MAX_PEAK
            - LUFS
        unsafeMode:
          description: |-
            **boolean**
            Optional. Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible.
          type: boolean
      additionalProperties: false
    definitions:
      TextVariable:
        type: object
        properties:
          variableName:
            description: |-
              **string**
              The name of the variable.
            type: string
          variableValue:
            description: |-
              **string**
              The text of the variable.
            type: string
      TextTemplate:
        type: object
        properties:
          textTemplate:
            description: |-
              **string**
              Template text.
              Sample:`The {animal} goes to the {place}.`
            type: string
          variables:
            description: |-
              **[TextVariable](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.TextVariable)**
              Defining variables in template text.
              Sample: `{animal: cat, place: forest}`
            type: array
            items:
              $ref: '#/definitions/TextVariable'
      AudioVariable:
        type: object
        properties:
          variableName:
            description: |-
              **string**
              The name of the variable.
            type: string
          variableStartMs:
            description: |-
              **string** (int64)
              Start time of the variable in milliseconds.
            type: string
            format: int64
          variableLengthMs:
            description: |-
              **string** (int64)
              Length of the variable in milliseconds.
            type: string
            format: int64
      AudioTemplate:
        type: object
        properties:
          audio:
            description: |-
              **[AudioContent](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.AudioContent)**
              Audio file.
            oneOf:
              - type: object
                properties:
                  content:
                    description: |-
                      **string** (bytes)
                      Bytes with audio data.
                      Includes only one of the fields `content`.
                      The audio source to read the data from.
                    type: string
                    format: bytes
          textTemplate:
            description: |-
              **[TextTemplate](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.TextTemplate)**
              Template and description of its variables.
            $ref: '#/definitions/TextTemplate'
          variables:
            description: |-
              **[AudioVariable](/docs/ai/tts/tts-v3/api-ref/Synthesizer/utteranceSynthesis#speechkit.tts.v3.AudioVariable)**
              Describing variables in audio.
            type: array
            items:
              $ref: '#/definitions/AudioVariable'
      DurationHint:
        type: object
        properties:
          policy:
            description: |-
              **enum** (DurationHintPolicy)
              Type of duration constraint.
              - `DURATION_HINT_POLICY_UNSPECIFIED`
              - `EXACT_DURATION`: Limit audio duration to exact value.
              - `MIN_DURATION`: Limit the minimum audio duration.
              - `MAX_DURATION`: Limit the maximum audio duration.
            type: string
            enum:
              - DURATION_HINT_POLICY_UNSPECIFIED
              - EXACT_DURATION
              - MIN_DURATION
              - MAX_DURATION
          durationMs:
            description: |-
              **string** (int64)
              Constraint on audio duration in milliseconds.
            type: string
            format: int64
      RawAudio:
        type: object
        properties:
          audioEncoding:
            description: |-
              **enum** (AudioEncoding)
              Encoding type.
              - `AUDIO_ENCODING_UNSPECIFIED`
              - `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM).
            type: string
            enum:
              - AUDIO_ENCODING_UNSPECIFIED
              - LINEAR16_PCM
          sampleRateHertz:
            description: |-
              **string** (int64)
              Sampling frequency of the signal.
            type: string
            format: int64
      ContainerAudio:
        type: object
        properties:
          containerAudioType:
            description: |-
              **enum** (ContainerAudioType)
              - `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
              - `WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).
              - `OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.
              - `MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.
            type: string
            enum:
              - CONTAINER_AUDIO_TYPE_UNSPECIFIED
              - WAV
              - OGG_OPUS
              - MP3
sourcePath: en/_api-ref/ai/tts/v3/tts-v3/api-ref/Synthesizer/utteranceSynthesis.md
---

# SpeechKit Synthesis Service API v3, REST: Synthesizer.UtteranceSynthesis

Synthesizing text into speech.

## HTTP request

```
POST https://{{ api-host-sk-tts }}/tts/v3/utteranceSynthesis
```

## Body parameters {#speechkit.tts.v3.UtteranceSynthesisRequest}

```json
{
  "model": "string",
  // Includes only one of the fields `text`, `textTemplate`
  "text": "string",
  "textTemplate": {
    "textTemplate": "string",
    "variables": [
      {
        "variableName": "string",
        "variableValue": "string"
      }
    ]
  },
  // end of the list of possible fields
  "hints": [
    {
      // Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`
      "voice": "string",
      "audioTemplate": {
        "audio": {
          // Includes only one of the fields `content`
          "content": "string",
          // end of the list of possible fields
          "audioSpec": {
            // Includes only one of the fields `rawAudio`, `containerAudio`
            "rawAudio": {
              "audioEncoding": "string",
              "sampleRateHertz": "string"
            },
            "containerAudio": {
              "containerAudioType": "string"
            }
            // end of the list of possible fields
          }
        },
        "textTemplate": {
          "textTemplate": "string",
          "variables": [
            {
              "variableName": "string",
              "variableValue": "string"
            }
          ]
        },
        "variables": [
          {
            "variableName": "string",
            "variableStartMs": "string",
            "variableLengthMs": "string"
          }
        ]
      },
      "speed": "string",
      "volume": "string",
      "role": "string",
      "pitchShift": "string",
      "duration": {
        "policy": "string",
        "durationMs": "string"
      }
      // end of the list of possible fields
    }
  ],
  "outputAudioSpec": {
    // Includes only one of the fields `rawAudio`, `containerAudio`
    "rawAudio": {
      "audioEncoding": "string",
      "sampleRateHertz": "string"
    },
    "containerAudio": {
      "containerAudioType": "string"
    }
    // end of the list of possible fields
  },
  "loudnessNormalizationType": "string",
  "unsafeMode": "boolean"
}
```

#|
||Field | Description ||
|| model | **string**

The name of the model.
Specifies basic synthesis functionality. Currently should be empty. Do not use it. ||
|| text | **string**

Raw text (e.g. "Hello, Alice").

Includes only one of the fields `text`, `textTemplate`.

Text to synthesis, one of text synthesis markups. ||
|| textTemplate | **[TextTemplate](#speechkit.tts.v3.TextTemplate)**

Text template instance, e.g. `{"Hello, {username}" with username="Alice"}`.

Includes only one of the fields `text`, `textTemplate`.

Text to synthesis, one of text synthesis markups. ||
|| hints[] | **[Hints](#speechkit.tts.v3.Hints)**

Optional hints for synthesis. ||
|| outputAudioSpec | **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Optional. Default: 22050 Hz, linear 16-bit signed little-endian PCM, with WAV header ||
|| loudnessNormalizationType | **enum** (LoudnessNormalizationType)

Specifies type of loudness normalization.
Optional. Default: `LUFS`.

- `LOUDNESS_NORMALIZATION_TYPE_UNSPECIFIED`
- `MAX_PEAK`: The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.
- `LUFS`: The type of normalization based on EBU R 128 recommendation. ||
|| unsafeMode | **boolean**

Optional. Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible. ||
|#

## TextTemplate {#speechkit.tts.v3.TextTemplate}

#|
||Field | Description ||
|| textTemplate | **string**

Template text.

Sample:`The {animal} goes to the {place}.` ||
|| variables[] | **[TextVariable](#speechkit.tts.v3.TextVariable)**

Defining variables in template text.

Sample: `{animal: cat, place: forest}` ||
|#

## TextVariable {#speechkit.tts.v3.TextVariable}

#|
||Field | Description ||
|| variableName | **string**

The name of the variable. ||
|| variableValue | **string**

The text of the variable. ||
|#

## Hints {#speechkit.tts.v3.Hints}

#|
||Field | Description ||
|| voice | **string**

Name of speaker to use.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| audioTemplate | **[AudioTemplate](#speechkit.tts.v3.AudioTemplate)**

Template for synthesizing.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| speed | **string**

Hint to change speed.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| volume | **string**

Hint to regulate normalization level.
* For `MAX_PEAK` loudness_normalization_type: volume changes in a range (0;1], default value is 0.7.
* For `LUFS` loudness_normalization_type: volume changes in a range [-145;0), default value is -19.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| role | **string**

Hint to specify pronunciation character for the speaker.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| pitchShift | **string**

Hint to increase (or decrease) speaker's pitch, measured in Hz. Valid values are in range [-1000;1000], default value is 0.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|| duration | **[DurationHint](#speechkit.tts.v3.DurationHint)**

Hint to limit both minimum and maximum audio duration.

Includes only one of the fields `voice`, `audioTemplate`, `speed`, `volume`, `role`, `pitchShift`, `duration`.

The hint for TTS engine to specify synthesised audio characteristics. ||
|#

## AudioTemplate {#speechkit.tts.v3.AudioTemplate}

#|
||Field | Description ||
|| audio | **[AudioContent](#speechkit.tts.v3.AudioContent)**

Audio file. ||
|| textTemplate | **[TextTemplate](#speechkit.tts.v3.TextTemplate)**

Template and description of its variables. ||
|| variables[] | **[AudioVariable](#speechkit.tts.v3.AudioVariable)**

Describing variables in audio. ||
|#

## AudioContent {#speechkit.tts.v3.AudioContent}

#|
||Field | Description ||
|| content | **string** (bytes)

Bytes with audio data.

Includes only one of the fields `content`.

The audio source to read the data from. ||
|| audioSpec | **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Description of the audio format. ||
|#

## AudioFormatOptions {#speechkit.tts.v3.AudioFormatOptions}

#|
||Field | Description ||
|| rawAudio | **[RawAudio](#speechkit.tts.v3.RawAudio)**

The audio format specified in request parameters.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|| containerAudio | **[ContainerAudio](#speechkit.tts.v3.ContainerAudio)**

The audio format specified inside the container metadata.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|#

## RawAudio {#speechkit.tts.v3.RawAudio}

#|
||Field | Description ||
|| audioEncoding | **enum** (AudioEncoding)

Encoding type.

- `AUDIO_ENCODING_UNSPECIFIED`
- `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sampleRateHertz | **string** (int64)

Sampling frequency of the signal. ||
|#

## ContainerAudio {#speechkit.tts.v3.ContainerAudio}

#|
||Field | Description ||
|| containerAudioType | **enum** (ContainerAudioType)

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
- `WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).
- `OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.
- `MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format. ||
|#

## AudioVariable {#speechkit.tts.v3.AudioVariable}

#|
||Field | Description ||
|| variableName | **string**

The name of the variable. ||
|| variableStartMs | **string** (int64)

Start time of the variable in milliseconds. ||
|| variableLengthMs | **string** (int64)

Length of the variable in milliseconds. ||
|#

## DurationHint {#speechkit.tts.v3.DurationHint}

#|
||Field | Description ||
|| policy | **enum** (DurationHintPolicy)

Type of duration constraint.

- `DURATION_HINT_POLICY_UNSPECIFIED`
- `EXACT_DURATION`: Limit audio duration to exact value.
- `MIN_DURATION`: Limit the minimum audio duration.
- `MAX_DURATION`: Limit the maximum audio duration. ||
|| durationMs | **string** (int64)

Constraint on audio duration in milliseconds. ||
|#

## Response {#speechkit.tts.v3.UtteranceSynthesisResponse}

**HTTP Code: 200 - OK**

```json
{
  "audioChunk": {
    "data": "string"
  },
  "textChunk": {
    "text": "string"
  },
  "startMs": "string",
  "lengthMs": "string"
}
```

#|
||Field | Description ||
|| audioChunk | **[AudioChunk](#speechkit.tts.v3.AudioChunk)**

Part of synthesized audio. ||
|| textChunk | **[TextChunk](#speechkit.tts.v3.TextChunk)**

Part of synthesized text. ||
|| startMs | **string** (int64)

Start time of the audio chunk in milliseconds. ||
|| lengthMs | **string** (int64)

Length of the audio chunk in milliseconds. ||
|#

## AudioChunk {#speechkit.tts.v3.AudioChunk}

#|
||Field | Description ||
|| data | **string** (bytes)

Sequence of bytes of the synthesized audio in format specified in output_audio_spec. ||
|#

## TextChunk {#speechkit.tts.v3.TextChunk}

#|
||Field | Description ||
|| text | **string**

Synthesized text. ||
|#