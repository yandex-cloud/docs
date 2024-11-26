---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/v3/stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile.md
---

# SpeechKit Recognition API v3, gRPC: AsyncRecognizer.RecognizeFile

## gRPC request

**rpc RecognizeFile ([RecognizeFileRequest](#speechkit.stt.v3.RecognizeFileRequest)) returns ([yandex.cloud.operation.Operation](#yandex.cloud.operation.Operation))**

## RecognizeFileRequest {#speechkit.stt.v3.RecognizeFileRequest}

```json
{
  // Includes only one of the fields `content`, `uri`
  "content": "bytes",
  "uri": "string",
  // end of the list of possible fields
  "recognition_model": {
    "model": "string",
    "audio_format": {
      // Includes only one of the fields `raw_audio`, `container_audio`
      "raw_audio": {
        "audio_encoding": "AudioEncoding",
        "sample_rate_hertz": "int64",
        "audio_channel_count": "int64"
      },
      "container_audio": {
        "container_audio_type": "ContainerAudioType"
      }
      // end of the list of possible fields
    },
    "text_normalization": {
      "text_normalization": "TextNormalization",
      "profanity_filter": "bool",
      "literature_text": "bool",
      "phone_formatting_mode": "PhoneFormattingMode"
    },
    "language_restriction": {
      "restriction_type": "LanguageRestrictionType",
      "language_code": [
        "string"
      ]
    },
    "audio_processing_type": "AudioProcessingType"
  },
  "recognition_classifier": {
    "classifiers": [
      {
        "classifier": "string",
        "triggers": [
          "TriggerType"
        ]
      }
    ]
  },
  "speech_analysis": {
    "enable_speaker_analysis": "bool",
    "enable_conversation_analysis": "bool",
    "descriptive_statistics_quantiles": [
      "double"
    ]
  },
  "speaker_labeling": {
    "speaker_labeling": "SpeakerLabeling"
  }
}
```

#|
||Field | Description ||
|| content | **bytes**

Bytes with data

Includes only one of the fields `content`, `uri`. ||
|| uri | **string**

S3 data url

Includes only one of the fields `content`, `uri`. ||
|| recognition_model | **[RecognitionModelOptions](#speechkit.stt.v3.RecognitionModelOptions)**

Configuration for speech recognition model. ||
|| recognition_classifier | **[RecognitionClassifierOptions](#speechkit.stt.v3.RecognitionClassifierOptions)**

Configuration for classifiers over speech recognition. ||
|| speech_analysis | **[SpeechAnalysisOptions](#speechkit.stt.v3.SpeechAnalysisOptions)**

Configuration for speech analysis over speech recognition. ||
|| speaker_labeling | **[SpeakerLabelingOptions](#speechkit.stt.v3.SpeakerLabelingOptions)**

Configuration for speaker labeling ||
|#

## RecognitionModelOptions {#speechkit.stt.v3.RecognitionModelOptions}

#|
||Field | Description ||
|| model | **string**

Sets the recognition model for the cloud version of SpeechKit. Possible values: 'general', 'general:rc', 'general:deprecated'.
The model is ignored for SpeechKit Hybrid. ||
|| audio_format | **[AudioFormatOptions](#speechkit.stt.v3.AudioFormatOptions)**

Specified input audio. ||
|| text_normalization | **[TextNormalizationOptions](#speechkit.stt.v3.TextNormalizationOptions)**

Text normalization options. ||
|| language_restriction | **[LanguageRestrictionOptions](#speechkit.stt.v3.LanguageRestrictionOptions)**

Possible languages in audio. ||
|| audio_processing_type | enum **AudioProcessingType**

How to deal with audio data (in real time, after all data is received, etc). Default is REAL_TIME.

- `AUDIO_PROCESSING_TYPE_UNSPECIFIED`
- `REAL_TIME`: Process audio in mode optimized for real-time recognition, i.e. send partials and final responses as soon as possible
- `FULL_DATA`: Process audio after all data was received ||
|#

## AudioFormatOptions {#speechkit.stt.v3.AudioFormatOptions}

Audio format options.

#|
||Field | Description ||
|| raw_audio | **[RawAudio](#speechkit.stt.v3.RawAudio)**

Audio without container.

Includes only one of the fields `raw_audio`, `container_audio`. ||
|| container_audio | **[ContainerAudio](#speechkit.stt.v3.ContainerAudio)**

Audio is wrapped in container.

Includes only one of the fields `raw_audio`, `container_audio`. ||
|#

## RawAudio {#speechkit.stt.v3.RawAudio}

RAW Audio format spec (no container to infer type). Used in AudioFormat options.

#|
||Field | Description ||
|| audio_encoding | enum **AudioEncoding**

Type of audio encoding

- `AUDIO_ENCODING_UNSPECIFIED`
- `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sample_rate_hertz | **int64**

PCM sample rate ||
|| audio_channel_count | **int64**

PCM channel count. Currently only single channel audio is supported in real-time recognition. ||
|#

## ContainerAudio {#speechkit.stt.v3.ContainerAudio}

Audio with fixed type in container. Used in AudioFormat options.

#|
||Field | Description ||
|| container_audio_type | enum **ContainerAudioType**

Type of audio container.

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
- `WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).
- `OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.
- `MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format. ||
|#

## TextNormalizationOptions {#speechkit.stt.v3.TextNormalizationOptions}

Options

#|
||Field | Description ||
|| text_normalization | enum **TextNormalization**

- `TEXT_NORMALIZATION_UNSPECIFIED`
- `TEXT_NORMALIZATION_ENABLED`: Enable normalization
- `TEXT_NORMALIZATION_DISABLED`: Disable normalization ||
|| profanity_filter | **bool**

Profanity filter (default: false). ||
|| literature_text | **bool**

Rewrite text in literature style (default: false). ||
|| phone_formatting_mode | enum **PhoneFormattingMode**

Define phone formatting mode

- `PHONE_FORMATTING_MODE_UNSPECIFIED`
- `PHONE_FORMATTING_MODE_DISABLED`: Disable phone formatting ||
|#

## LanguageRestrictionOptions {#speechkit.stt.v3.LanguageRestrictionOptions}

Type of restriction for the list of languages expected in the incoming speech stream.

#|
||Field | Description ||
|| restriction_type | enum **LanguageRestrictionType**

Language restriction type

- `LANGUAGE_RESTRICTION_TYPE_UNSPECIFIED`
- `WHITELIST`: The allowing list. The incoming audio can contain only the listed languages.
- `BLACKLIST`: The forbidding list. The incoming audio cannot contain the listed languages. ||
|| language_code[] | **string**

The list of language codes to restrict recognition in the case of an auto model ||
|#

## RecognitionClassifierOptions {#speechkit.stt.v3.RecognitionClassifierOptions}

#|
||Field | Description ||
|| classifiers[] | **[RecognitionClassifier](#speechkit.stt.v3.RecognitionClassifier)**

List of classifiers to use ||
|#

## RecognitionClassifier {#speechkit.stt.v3.RecognitionClassifier}

#|
||Field | Description ||
|| classifier | **string**

Classifier name ||
|| triggers[] | enum **TriggerType**

Describes the types of responses to which the classification results will come

- `TRIGGER_TYPE_UNSPECIFIED`
- `ON_UTTERANCE`: Apply classifier to utterance responses
- `ON_FINAL`: Apply classifier to final responses
- `ON_PARTIAL`: Apply classifier to partial responses ||
|#

## SpeechAnalysisOptions {#speechkit.stt.v3.SpeechAnalysisOptions}

#|
||Field | Description ||
|| enable_speaker_analysis | **bool**

Analyse speech for every speaker ||
|| enable_conversation_analysis | **bool**

Analyse conversation of two speakers ||
|| descriptive_statistics_quantiles[] | **double**

Quantile levels in range (0, 1) for descriptive statistics ||
|#

## SpeakerLabelingOptions {#speechkit.stt.v3.SpeakerLabelingOptions}

#|
||Field | Description ||
|| speaker_labeling | enum **SpeakerLabeling**

Specifies the execution of speaker labeling. Default is SPEAKER_LABELING_DISABLED.

- `SPEAKER_LABELING_UNSPECIFIED`
- `SPEAKER_LABELING_ENABLED`: Enable speaker labeling
- `SPEAKER_LABELING_DISABLED`: Disable speaker labeling ||
|#

## yandex.cloud.operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#