---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/v3/stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile.md
---

# SpeechKit Recognition API v3, gRPC: AsyncRecognizer.RecognizeFile {#RecognizeFile}

## gRPC request

**rpc RecognizeFile ([RecognizeFileRequest](#speechkit.stt.v3.RecognizeFileRequest)) returns ([yandex.cloud.operation.Operation](#yandex.cloud.operation.Operation))**

## RecognizeFileRequest {#speechkit.stt.v3.RecognizeFileRequest}

```json
{
  // Includes only one of the fields `content`, `uri`
  "content": "bytes",
  "uri": "string",
  // end of the list of possible fields
  "recognitionModel": {
    "model": "string",
    "audioFormat": {
      // Includes only one of the fields `rawAudio`, `containerAudio`
      "rawAudio": {
        "audioEncoding": "AudioEncoding",
        "sampleRateHertz": "int64",
        "audioChannelCount": "int64"
      },
      "containerAudio": {
        "containerAudioType": "ContainerAudioType"
      }
      // end of the list of possible fields
    },
    "textNormalization": {
      "textNormalization": "TextNormalization",
      "profanityFilter": "bool",
      "literatureText": "bool",
      "phoneFormattingMode": "PhoneFormattingMode"
    },
    "languageRestriction": {
      "restrictionType": "LanguageRestrictionType",
      "languageCode": [
        "string"
      ]
    },
    "audioProcessingType": "AudioProcessingType"
  },
  "recognitionClassifier": {
    "classifiers": [
      {
        "classifier": "string",
        "triggers": [
          "TriggerType"
        ]
      }
    ]
  },
  "speechAnalysis": {
    "enableSpeakerAnalysis": "bool",
    "enableConversationAnalysis": "bool",
    "descriptiveStatisticsQuantiles": [
      "double"
    ]
  },
  "speakerLabeling": {
    "speakerLabeling": "SpeakerLabeling"
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
|| recognitionModel | **[RecognitionModelOptions](#speechkit.stt.v3.RecognitionModelOptions)**

Configuration for speech recognition model. ||
|| recognitionClassifier | **[RecognitionClassifierOptions](#speechkit.stt.v3.RecognitionClassifierOptions)**

Configuration for classifiers over speech recognition. ||
|| speechAnalysis | **[SpeechAnalysisOptions](#speechkit.stt.v3.SpeechAnalysisOptions)**

Configuration for speech analysis over speech recognition. ||
|| speakerLabeling | **[SpeakerLabelingOptions](#speechkit.stt.v3.SpeakerLabelingOptions)**

Configuration for speaker labeling ||
|#

## RecognitionModelOptions {#speechkit.stt.v3.RecognitionModelOptions}

#|
||Field | Description ||
|| model | **string**

Sets the recognition model for the cloud version of SpeechKit. Possible values: 'general', 'general:rc', 'general:deprecated'.
The model is ignored for SpeechKit Hybrid. ||
|| audioFormat | **[AudioFormatOptions](#speechkit.stt.v3.AudioFormatOptions)**

Specified input audio. ||
|| textNormalization | **[TextNormalizationOptions](#speechkit.stt.v3.TextNormalizationOptions)**

Text normalization options. ||
|| languageRestriction | **[LanguageRestrictionOptions](#speechkit.stt.v3.LanguageRestrictionOptions)**

Possible languages in audio. ||
|| audioProcessingType | enum **AudioProcessingType**

How to deal with audio data (in real time, after all data is received, etc). Default is REAL_TIME.

- `AUDIO_PROCESSING_TYPE_UNSPECIFIED`
- `REAL_TIME`: Process audio in mode optimized for real-time recognition, i.e. send partials and final responses as soon as possible
- `FULL_DATA`: Process audio after all data was received ||
|#

## AudioFormatOptions {#speechkit.stt.v3.AudioFormatOptions}

Audio format options.

#|
||Field | Description ||
|| rawAudio | **[RawAudio](#speechkit.stt.v3.RawAudio)**

Audio without container.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|| containerAudio | **[ContainerAudio](#speechkit.stt.v3.ContainerAudio)**

Audio is wrapped in container.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|#

## RawAudio {#speechkit.stt.v3.RawAudio}

RAW Audio format spec (no container to infer type). Used in AudioFormat options.

#|
||Field | Description ||
|| audioEncoding | enum **AudioEncoding**

Type of audio encoding

- `AUDIO_ENCODING_UNSPECIFIED`
- `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sampleRateHertz | **int64**

PCM sample rate ||
|| audioChannelCount | **int64**

PCM channel count. Currently only single channel audio is supported in real-time recognition. ||
|#

## ContainerAudio {#speechkit.stt.v3.ContainerAudio}

Audio with fixed type in container. Used in AudioFormat options.

#|
||Field | Description ||
|| containerAudioType | enum **ContainerAudioType**

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
|| textNormalization | enum **TextNormalization**

- `TEXT_NORMALIZATION_UNSPECIFIED`
- `TEXT_NORMALIZATION_ENABLED`: Enable normalization
- `TEXT_NORMALIZATION_DISABLED`: Disable normalization ||
|| profanityFilter | **bool**

Profanity filter (default: false). ||
|| literatureText | **bool**

Rewrite text in literature style (default: false). ||
|| phoneFormattingMode | enum **PhoneFormattingMode**

Define phone formatting mode

- `PHONE_FORMATTING_MODE_UNSPECIFIED`
- `PHONE_FORMATTING_MODE_DISABLED`: Disable phone formatting ||
|#

## LanguageRestrictionOptions {#speechkit.stt.v3.LanguageRestrictionOptions}

Type of restriction for the list of languages expected in the incoming speech stream.

#|
||Field | Description ||
|| restrictionType | enum **LanguageRestrictionType**

Language restriction type

- `LANGUAGE_RESTRICTION_TYPE_UNSPECIFIED`
- `WHITELIST`: The allowing list. The incoming audio can contain only the listed languages.
- `BLACKLIST`: The forbidding list. The incoming audio cannot contain the listed languages. ||
|| languageCode[] | **string**

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
|| enableSpeakerAnalysis | **bool**

Analyse speech for every speaker ||
|| enableConversationAnalysis | **bool**

Analyse conversation of two speakers ||
|| descriptiveStatisticsQuantiles[] | **double**

Quantile levels in range (0, 1) for descriptive statistics ||
|#

## SpeakerLabelingOptions {#speechkit.stt.v3.SpeakerLabelingOptions}

#|
||Field | Description ||
|| speakerLabeling | enum **SpeakerLabeling**

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
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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