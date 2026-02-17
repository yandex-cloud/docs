---
editable: false
apiPlayground:
  - url: https://{{ api-host-sk-stt }}/stt/v3/recognizeFileAsync
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        content:
          description: |-
            **string** (bytes)
            Bytes with data
            Includes only one of the fields `content`, `uri`.
          type: string
          format: bytes
        uri:
          description: |-
            **string**
            S3 data URL
            Includes only one of the fields `content`, `uri`.
          type: string
        recognitionModel:
          description: |-
            **[RecognitionModelOptions](#speechkit.stt.v3.RecognitionModelOptions)**
            Configuration for speech recognition model.
          $ref: '#/definitions/RecognitionModelOptions'
        recognitionClassifier:
          description: |-
            **[RecognitionClassifierOptions](#speechkit.stt.v3.RecognitionClassifierOptions)**
            Configuration for classifiers over speech recognition.
          $ref: '#/definitions/RecognitionClassifierOptions'
        speechAnalysis:
          description: |-
            **[SpeechAnalysisOptions](#speechkit.stt.v3.SpeechAnalysisOptions)**
            Configuration for speech analysis over speech recognition.
          $ref: '#/definitions/SpeechAnalysisOptions'
        speakerLabeling:
          description: |-
            **[SpeakerLabelingOptions](#speechkit.stt.v3.SpeakerLabelingOptions)**
            Configuration for speaker labeling
          $ref: '#/definitions/SpeakerLabelingOptions'
        summarization:
          description: |-
            **[SummarizationOptions](#speechkit.stt.v3.SummarizationOptions)**
            Summarization options
          $ref: '#/definitions/SummarizationOptions'
      additionalProperties: false
      oneOf:
        - required:
            - content
        - required:
            - uri
    definitions:
      RawAudio:
        type: object
        properties:
          audioEncoding:
            description: |-
              **enum** (AudioEncoding)
              Type of audio encoding.
              - `AUDIO_ENCODING_UNSPECIFIED`
              - `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM).
            type: string
            enum:
              - AUDIO_ENCODING_UNSPECIFIED
              - LINEAR16_PCM
          sampleRateHertz:
            description: |-
              **string** (int64)
              PCM sample rate.
            type: string
            format: int64
          audioChannelCount:
            description: |-
              **string** (int64)
              PCM channel count. Currently only single channel audio is supported in real-time recognition.
            type: string
            format: int64
      ContainerAudio:
        type: object
        properties:
          containerAudioType:
            description: |-
              **enum** (ContainerAudioType)
              Type of audio container.
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
      AudioFormatOptions:
        type: object
        properties:
          rawAudio:
            description: |-
              **[RawAudio](#speechkit.stt.v3.RawAudio)**
              RAW audio without container.
              Includes only one of the fields `rawAudio`, `containerAudio`.
            $ref: '#/definitions/RawAudio'
          containerAudio:
            description: |-
              **[ContainerAudio](#speechkit.stt.v3.ContainerAudio)**
              Audio is wrapped in container.
              Includes only one of the fields `rawAudio`, `containerAudio`.
            $ref: '#/definitions/ContainerAudio'
        oneOf:
          - required:
              - rawAudio
          - required:
              - containerAudio
      TextNormalizationOptions:
        type: object
        properties:
          textNormalization:
            description: |-
              **enum** (TextNormalization)
              - `TEXT_NORMALIZATION_UNSPECIFIED`
              - `TEXT_NORMALIZATION_ENABLED`: Enable converting numbers, dates and time from text to numeric format.
              - `TEXT_NORMALIZATION_DISABLED`: Disable all normalization. Default value.
            type: string
            enum:
              - TEXT_NORMALIZATION_UNSPECIFIED
              - TEXT_NORMALIZATION_ENABLED
              - TEXT_NORMALIZATION_DISABLED
          profanityFilter:
            description: |-
              **boolean**
              Profanity filter (default: false).
            default: false
            type: boolean
          literatureText:
            description: |-
              **boolean**
              Rewrite text in literature style (default: false).
            default: false
            type: boolean
          phoneFormattingMode:
            description: |-
              **enum** (PhoneFormattingMode)
              Define phone formatting mode
              - `PHONE_FORMATTING_MODE_UNSPECIFIED`
              - `PHONE_FORMATTING_MODE_DISABLED`: Disable phone formatting
            type: string
            enum:
              - PHONE_FORMATTING_MODE_UNSPECIFIED
              - PHONE_FORMATTING_MODE_DISABLED
      LanguageRestrictionOptions:
        type: object
        properties:
          restrictionType:
            description: |-
              **enum** (LanguageRestrictionType)
              Language restriction type.
              All of these restrictions are used by the model as guidelines, not as strict rules.
              The language is recognized for each sentence. If a sentence has phrases in different languages, all of them will be transcribed in the most probable language.
              - `LANGUAGE_RESTRICTION_TYPE_UNSPECIFIED`
              - `WHITELIST`: The list of most possible languages in the incoming audio.
              - `BLACKLIST`: The list of languages that are likely not to be included in the incoming audio.
            type: string
            enum:
              - LANGUAGE_RESTRICTION_TYPE_UNSPECIFIED
              - WHITELIST
              - BLACKLIST
          languageCode:
            description: |-
              **string**
              The list of [language codes](/docs/speechkit/stt/models) to restrict recognition in the case of an auto model.
            type: array
            items:
              type: string
      RecognitionModelOptions:
        type: object
        properties:
          model:
            description: |-
              **string**
              Sets the recognition model for the cloud version of SpeechKit.
              For `Recognizer.RecognizeStreaming`, possible values are `general`, `general:rc`, `general:deprecated`.
              For `AsyncRecognizer.RecognizeFile`, possible values are `general`, `general:rc`, `general:deprecated`, `deferred-general`, `deferred-general:rc`, and `deferred-general:deprecated`.
              The model is ignored for SpeechKit Hybrid.
            type: string
          audioFormat:
            description: |-
              **[AudioFormatOptions](#speechkit.stt.v3.AudioFormatOptions)**
              Specified input audio.
            $ref: '#/definitions/AudioFormatOptions'
          textNormalization:
            description: |-
              **[TextNormalizationOptions](#speechkit.stt.v3.TextNormalizationOptions)**
              Text normalization options.
            $ref: '#/definitions/TextNormalizationOptions'
          languageRestriction:
            description: |-
              **[LanguageRestrictionOptions](#speechkit.stt.v3.LanguageRestrictionOptions)**
              Possible languages in audio.
            $ref: '#/definitions/LanguageRestrictionOptions'
          audioProcessingType:
            description: |-
              **enum** (AudioProcessingType)
              For `Recognizer.RecognizeStreaming`, defines the audio data processing mode. Default is `REAL_TIME`.
              For `AsyncRecognizer.RecognizeFile`, this field is ignored.
              - `AUDIO_PROCESSING_TYPE_UNSPECIFIED`
              - `REAL_TIME`: Process audio in mode optimized for real-time recognition, i.e. send partials and final responses as soon as possible.
              - `FULL_DATA`: Process audio after all data was received.
            type: string
            enum:
              - AUDIO_PROCESSING_TYPE_UNSPECIFIED
              - REAL_TIME
              - FULL_DATA
      RecognitionClassifier:
        type: object
        properties:
          classifier:
            description: |-
              **string**
              Classifier name
            type: string
          triggers:
            description: |-
              **enum** (TriggerType)
              Describes the types of responses to which the classification results will come. Classification responses will follow the responses of the specified types.
              - `TRIGGER_TYPE_UNSPECIFIED`
              - `ON_UTTERANCE`: Apply classifier to utterance responses.
              - `ON_FINAL`: Apply classifier to final responses.
              - `ON_PARTIAL`: Apply classifier to partial responses.
            type: array
            items:
              type: string
              enum:
                - TRIGGER_TYPE_UNSPECIFIED
                - ON_UTTERANCE
                - ON_FINAL
                - ON_PARTIAL
      RecognitionClassifierOptions:
        type: object
        properties:
          classifiers:
            description: |-
              **[RecognitionClassifier](#speechkit.stt.v3.RecognitionClassifier)**
              List of classifiers to use. For detailed information and usage example, see [documentation](/docs/speechkit/stt/analysis).
            type: array
            items:
              $ref: '#/definitions/RecognitionClassifier'
      SpeechAnalysisOptions:
        type: object
        properties:
          enableSpeakerAnalysis:
            description: |-
              **boolean**
              Analyse speech for every speaker
            type: boolean
          enableConversationAnalysis:
            description: |-
              **boolean**
              Analyse conversation of two speakers
            type: boolean
          descriptiveStatisticsQuantiles:
            description: |-
              **string**
              Quantile levels in range (0, 1) for descriptive statistics
            type: array
            items:
              type: string
      SpeakerLabelingOptions:
        type: object
        properties:
          speakerLabeling:
            description: |-
              **enum** (SpeakerLabeling)
              Specifies the execution of speaker labeling.
              - `SPEAKER_LABELING_UNSPECIFIED`
              - `SPEAKER_LABELING_ENABLED`: Enable speaker labeling.
              - `SPEAKER_LABELING_DISABLED`: Disable speaker labeling. Default value.
            type: string
            enum:
              - SPEAKER_LABELING_UNSPECIFIED
              - SPEAKER_LABELING_ENABLED
              - SPEAKER_LABELING_DISABLED
      JsonSchema:
        type: object
        properties:
          schema:
            description: |-
              **object**
              The JSON Schema that the model's output must conform to.
            type: object
      SummarizationProperty:
        type: object
        properties:
          instruction:
            description: |-
              **string**
              Summarization instruction for model.
            type: string
          jsonObject:
            description: |-
              **boolean**
              When set to true, the model will return a valid JSON object.
              Be sure to ask the model explicitly for JSON.
              Otherwise, it may produce excessive whitespace and run indefinitely until it reaches the token limit.
              Includes only one of the fields `jsonObject`, `jsonSchema`.
              Specifies the format of the model's response.
            type: boolean
          jsonSchema:
            description: |-
              **[JsonSchema](#speechkit.stt.v3.JsonSchema)**
              Enforces a specific JSON structure for the model's response based on a provided schema.
              Includes only one of the fields `jsonObject`, `jsonSchema`.
              Specifies the format of the model's response.
            $ref: '#/definitions/JsonSchema'
        oneOf:
          - required:
              - jsonObject
          - required:
              - jsonSchema
      SummarizationOptions:
        type: object
        properties:
          modelUri:
            description: |-
              **string**
              The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation.
            type: string
          properties:
            description: |-
              **[SummarizationProperty](#speechkit.stt.v3.SummarizationProperty)**
              A list of suimmarizations to perform with transcription.
            type: array
            items:
              $ref: '#/definitions/SummarizationProperty'
---

# SpeechKit Recognition API v3, REST: AsyncRecognizer.RecognizeFile

Performs asynchronous speech recognition.

## HTTP request

```
POST https://{{ api-host-sk-stt }}/stt/v3/recognizeFileAsync
```

## Body parameters {#speechkit.stt.v3.RecognizeFileRequest}

```json
{
  // Includes only one of the fields `content`, `uri`
  "content": "string",
  "uri": "string",
  // end of the list of possible fields
  "recognitionModel": {
    "model": "string",
    "audioFormat": {
      // Includes only one of the fields `rawAudio`, `containerAudio`
      "rawAudio": {
        "audioEncoding": "string",
        "sampleRateHertz": "string",
        "audioChannelCount": "string"
      },
      "containerAudio": {
        "containerAudioType": "string"
      }
      // end of the list of possible fields
    },
    "textNormalization": {
      "textNormalization": "string",
      "profanityFilter": "boolean",
      "literatureText": "boolean",
      "phoneFormattingMode": "string"
    },
    "languageRestriction": {
      "restrictionType": "string",
      "languageCode": [
        "string"
      ]
    },
    "audioProcessingType": "string"
  },
  "recognitionClassifier": {
    "classifiers": [
      {
        "classifier": "string",
        "triggers": [
          "string"
        ]
      }
    ]
  },
  "speechAnalysis": {
    "enableSpeakerAnalysis": "boolean",
    "enableConversationAnalysis": "boolean",
    "descriptiveStatisticsQuantiles": [
      "string"
    ]
  },
  "speakerLabeling": {
    "speakerLabeling": "string"
  },
  "summarization": {
    "modelUri": "string",
    "properties": [
      {
        "instruction": "string",
        // Includes only one of the fields `jsonObject`, `jsonSchema`
        "jsonObject": "boolean",
        "jsonSchema": {
          "schema": "object"
        }
        // end of the list of possible fields
      }
    ]
  }
}
```

#|
||Field | Description ||
|| content | **string** (bytes)

Bytes with data

Includes only one of the fields `content`, `uri`. ||
|| uri | **string**

S3 data URL

Includes only one of the fields `content`, `uri`. ||
|| recognitionModel | **[RecognitionModelOptions](#speechkit.stt.v3.RecognitionModelOptions)**

Configuration for speech recognition model. ||
|| recognitionClassifier | **[RecognitionClassifierOptions](#speechkit.stt.v3.RecognitionClassifierOptions)**

Configuration for classifiers over speech recognition. ||
|| speechAnalysis | **[SpeechAnalysisOptions](#speechkit.stt.v3.SpeechAnalysisOptions)**

Configuration for speech analysis over speech recognition. ||
|| speakerLabeling | **[SpeakerLabelingOptions](#speechkit.stt.v3.SpeakerLabelingOptions)**

Configuration for speaker labeling ||
|| summarization | **[SummarizationOptions](#speechkit.stt.v3.SummarizationOptions)**

Summarization options ||
|#

## RecognitionModelOptions {#speechkit.stt.v3.RecognitionModelOptions}

#|
||Field | Description ||
|| model | **string**

Sets the recognition model for the cloud version of SpeechKit.
For `Recognizer.RecognizeStreaming`, possible values are `general`, `general:rc`, `general:deprecated`.
For `AsyncRecognizer.RecognizeFile`, possible values are `general`, `general:rc`, `general:deprecated`, `deferred-general`, `deferred-general:rc`, and `deferred-general:deprecated`.
The model is ignored for SpeechKit Hybrid. ||
|| audioFormat | **[AudioFormatOptions](#speechkit.stt.v3.AudioFormatOptions)**

Specified input audio. ||
|| textNormalization | **[TextNormalizationOptions](#speechkit.stt.v3.TextNormalizationOptions)**

Text normalization options. ||
|| languageRestriction | **[LanguageRestrictionOptions](#speechkit.stt.v3.LanguageRestrictionOptions)**

Possible languages in audio. ||
|| audioProcessingType | **enum** (AudioProcessingType)

For `Recognizer.RecognizeStreaming`, defines the audio data processing mode. Default is `REAL_TIME`.
For `AsyncRecognizer.RecognizeFile`, this field is ignored.

- `AUDIO_PROCESSING_TYPE_UNSPECIFIED`
- `REAL_TIME`: Process audio in mode optimized for real-time recognition, i.e. send partials and final responses as soon as possible.
- `FULL_DATA`: Process audio after all data was received. ||
|#

## AudioFormatOptions {#speechkit.stt.v3.AudioFormatOptions}

Audio format options.

#|
||Field | Description ||
|| rawAudio | **[RawAudio](#speechkit.stt.v3.RawAudio)**

RAW audio without container.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|| containerAudio | **[ContainerAudio](#speechkit.stt.v3.ContainerAudio)**

Audio is wrapped in container.

Includes only one of the fields `rawAudio`, `containerAudio`. ||
|#

## RawAudio {#speechkit.stt.v3.RawAudio}

RAW Audio format spec (no container to infer type). Used in AudioFormat options.

#|
||Field | Description ||
|| audioEncoding | **enum** (AudioEncoding)

Type of audio encoding.

- `AUDIO_ENCODING_UNSPECIFIED`
- `LINEAR16_PCM`: Audio bit depth 16-bit signed little-endian (Linear PCM). ||
|| sampleRateHertz | **string** (int64)

PCM sample rate. ||
|| audioChannelCount | **string** (int64)

PCM channel count. Currently only single channel audio is supported in real-time recognition. ||
|#

## ContainerAudio {#speechkit.stt.v3.ContainerAudio}

Audio with fixed type in container. Used in AudioFormat options.

#|
||Field | Description ||
|| containerAudioType | **enum** (ContainerAudioType)

Type of audio container.

- `CONTAINER_AUDIO_TYPE_UNSPECIFIED`
- `WAV`: Audio bit depth 16-bit signed little-endian (Linear PCM).
- `OGG_OPUS`: Data is encoded using the OPUS audio codec and compressed using the OGG container format.
- `MP3`: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format. ||
|#

## TextNormalizationOptions {#speechkit.stt.v3.TextNormalizationOptions}

Options for post-processing text results. The normalization levels depend on the settings and the language.
For detailed information, see [documentation](/docs/speechkit/stt/normalization).

#|
||Field | Description ||
|| textNormalization | **enum** (TextNormalization)

- `TEXT_NORMALIZATION_UNSPECIFIED`
- `TEXT_NORMALIZATION_ENABLED`: Enable converting numbers, dates and time from text to numeric format.
- `TEXT_NORMALIZATION_DISABLED`: Disable all normalization. Default value. ||
|| profanityFilter | **boolean**

Profanity filter (default: false). ||
|| literatureText | **boolean**

Rewrite text in literature style (default: false). ||
|| phoneFormattingMode | **enum** (PhoneFormattingMode)

Define phone formatting mode

- `PHONE_FORMATTING_MODE_UNSPECIFIED`
- `PHONE_FORMATTING_MODE_DISABLED`: Disable phone formatting ||
|#

## LanguageRestrictionOptions {#speechkit.stt.v3.LanguageRestrictionOptions}

Type of restriction for the list of languages expected in the incoming audio.

#|
||Field | Description ||
|| restrictionType | **enum** (LanguageRestrictionType)

Language restriction type.
All of these restrictions are used by the model as guidelines, not as strict rules.
The language is recognized for each sentence. If a sentence has phrases in different languages, all of them will be transcribed in the most probable language.

- `LANGUAGE_RESTRICTION_TYPE_UNSPECIFIED`
- `WHITELIST`: The list of most possible languages in the incoming audio.
- `BLACKLIST`: The list of languages that are likely not to be included in the incoming audio. ||
|| languageCode[] | **string**

The list of [language codes](/docs/speechkit/stt/models) to restrict recognition in the case of an auto model. ||
|#

## RecognitionClassifierOptions {#speechkit.stt.v3.RecognitionClassifierOptions}

#|
||Field | Description ||
|| classifiers[] | **[RecognitionClassifier](#speechkit.stt.v3.RecognitionClassifier)**

List of classifiers to use. For detailed information and usage example, see [documentation](/docs/speechkit/stt/analysis). ||
|#

## RecognitionClassifier {#speechkit.stt.v3.RecognitionClassifier}

#|
||Field | Description ||
|| classifier | **string**

Classifier name ||
|| triggers[] | **enum** (TriggerType)

Describes the types of responses to which the classification results will come. Classification responses will follow the responses of the specified types.

- `TRIGGER_TYPE_UNSPECIFIED`
- `ON_UTTERANCE`: Apply classifier to utterance responses.
- `ON_FINAL`: Apply classifier to final responses.
- `ON_PARTIAL`: Apply classifier to partial responses. ||
|#

## SpeechAnalysisOptions {#speechkit.stt.v3.SpeechAnalysisOptions}

#|
||Field | Description ||
|| enableSpeakerAnalysis | **boolean**

Analyse speech for every speaker ||
|| enableConversationAnalysis | **boolean**

Analyse conversation of two speakers ||
|| descriptiveStatisticsQuantiles[] | **string**

Quantile levels in range (0, 1) for descriptive statistics ||
|#

## SpeakerLabelingOptions {#speechkit.stt.v3.SpeakerLabelingOptions}

#|
||Field | Description ||
|| speakerLabeling | **enum** (SpeakerLabeling)

Specifies the execution of speaker labeling.

- `SPEAKER_LABELING_UNSPECIFIED`
- `SPEAKER_LABELING_ENABLED`: Enable speaker labeling.
- `SPEAKER_LABELING_DISABLED`: Disable speaker labeling. Default value. ||
|#

## SummarizationOptions {#speechkit.stt.v3.SummarizationOptions}

Represents transcription summarization options.

#|
||Field | Description ||
|| modelUri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| properties[] | **[SummarizationProperty](#speechkit.stt.v3.SummarizationProperty)**

A list of suimmarizations to perform with transcription. ||
|#

## SummarizationProperty {#speechkit.stt.v3.SummarizationProperty}

Represents summarization entry for transcription.

#|
||Field | Description ||
|| instruction | **string**

Summarization instruction for model. ||
|| jsonObject | **boolean**

When set to true, the model will return a valid JSON object.
Be sure to ask the model explicitly for JSON.
Otherwise, it may produce excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `jsonObject`, `jsonSchema`.

Specifies the format of the model's response. ||
|| jsonSchema | **[JsonSchema](#speechkit.stt.v3.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `jsonObject`, `jsonSchema`.

Specifies the format of the model's response. ||
|#

## JsonSchema {#speechkit.stt.v3.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **object**

The JSON Schema that the model's output must conform to. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  }
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#