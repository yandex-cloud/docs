---
editable: false
sourcePath: en/_api-ref-grpc/ai/tts/v3/tts-v3/api-ref/grpc/Synthesizer/streamSynthesis.md
---

# SpeechKit Synthesis Service API v3, gRPC: Synthesizer.StreamSynthesis

Bidirectional streaming RPC for real-time synthesis.

## gRPC request

**rpc StreamSynthesis (stream [StreamSynthesisRequest](#speechkit.tts.v3.StreamSynthesisRequest)) returns (stream [StreamSynthesisResponse](#speechkit.tts.v3.StreamSynthesisResponse))**

## StreamSynthesisRequest {#speechkit.tts.v3.StreamSynthesisRequest}

```json
{
  // Includes only one of the fields `options`, `synthesis_input`, `force_synthesis`
  "options": {
    "model": "string",
    "voice": "string",
    "role": "string",
    "speed": "double",
    "volume": "double",
    "pitch_shift": "double",
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
    "loudness_normalization_type": "LoudnessNormalizationType"
  },
  "synthesis_input": {
    "text": "string"
  },
  "force_synthesis": "ForceSynthesisEvent"
  // end of the list of possible fields
}
```

Sent by client to control or provide data during streaming synthesis.

#|
||Field | Description ||
|| options | **[SynthesisOptions](#speechkit.tts.v3.SynthesisOptions)**

Synthesis options. Must be provided in the first request of the stream and cannot be updated afterwards.

Includes only one of the fields `options`, `synthesis_input`, `force_synthesis`. ||
|| synthesis_input | **[SynthesisInput](#speechkit.tts.v3.SynthesisInput)**

Input to be synthesized.

Includes only one of the fields `options`, `synthesis_input`, `force_synthesis`. ||
|| force_synthesis | **[ForceSynthesisEvent](#speechkit.tts.v3.ForceSynthesisEvent)**

Triggers immediate synthesis of buffered input.

Includes only one of the fields `options`, `synthesis_input`, `force_synthesis`. ||
|#

## SynthesisOptions {#speechkit.tts.v3.SynthesisOptions}

#|
||Field | Description ||
|| model | **string**

The name of the TTS model to use for synthesis. Currently should be empty. Do not use it. ||
|| voice | **string**

The voice to use for speech synthesis. ||
|| role | **string**

The role or speaking style. Can be used to specify pronunciation character for the speaker. ||
|| speed | **double**

Speed multiplier (default: 1.0). ||
|| volume | **double**

Volume adjustment:
* For `MAX_PEAK`: range is (0, 1], default 0.7.
* For `LUFS`: range is [-145, 0), default -19. ||
|| pitch_shift | **double**

Pitch adjustment, in Hz, range [-1000, 1000], default 0. ||
|| output_audio_spec | **[AudioFormatOptions](#speechkit.tts.v3.AudioFormatOptions)**

Specifies output audio format. Default: 22050Hz, linear 16-bit signed little-endian PCM, with WAV header. ||
|| loudness_normalization_type | enum **LoudnessNormalizationType**

Loudness normalization type for output (default: `LUFS`).

- `LOUDNESS_NORMALIZATION_TYPE_UNSPECIFIED`: Unspecified loudness normalization. The default behavior will be used.
- `MAX_PEAK`: The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.
- `LUFS`: The type of normalization based on EBU R 128 recommendation. ||
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

## SynthesisInput {#speechkit.tts.v3.SynthesisInput}

The input for synthesis.

#|
||Field | Description ||
|| text | **string**

The text string to be synthesized. ||
|#

## ForceSynthesisEvent {#speechkit.tts.v3.ForceSynthesisEvent}

Event to forcibly trigger synthesis.

#|
||Field | Description ||
|| Empty | > ||
|#

## StreamSynthesisResponse {#speechkit.tts.v3.StreamSynthesisResponse}

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