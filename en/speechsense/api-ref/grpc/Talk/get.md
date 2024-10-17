---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/get.md
---

# Talk Analytics API, gRPC: TalkService.Get {#Get}

rpc for bulk get

## gRPC request

**rpc Get ([GetTalkRequest](#yandex.cloud.speechsense.v1.GetTalkRequest)) returns ([GetTalkResponse](#yandex.cloud.speechsense.v1.GetTalkResponse))**

## GetTalkRequest {#yandex.cloud.speechsense.v1.GetTalkRequest}

```json
{
  "organizationId": "string",
  "spaceId": "string",
  "connectionId": "string",
  "projectId": "string",
  "talkIds": [
    "string"
  ],
  "resultsMask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| organizationId | **string**

id of organization ||
|| spaceId | **string**

id of space ||
|| connectionId | **string**

id of connection to search data ||
|| projectId | **string**

id of project to search data ||
|| talkIds[] | **string**

ids of talks to return. Requesting too many talks may result in "message exceeds maximum size" error.
Up to 100 of talks per request is recommended. ||
|| resultsMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

All types of analysis will be returned if not set. ||
|#

## GetTalkResponse {#yandex.cloud.speechsense.v1.GetTalkResponse}

```json
{
  "talk": [
    {
      "id": "string",
      "organizationId": "string",
      "spaceId": "string",
      "connectionId": "string",
      "projectIds": [
        "string"
      ],
      "createdBy": "string",
      "createdAt": "google.protobuf.Timestamp",
      "modifiedBy": "string",
      "modifiedAt": "google.protobuf.Timestamp",
      "talkFields": [
        {
          "name": "string",
          "value": "string",
          "type": "FieldType"
        }
      ],
      "transcription": {
        "phrases": [
          {
            "channelNumber": "int64",
            "startTimeMs": "int64",
            "endTimeMs": "int64",
            "phrase": {
              "text": "string",
              "language": "string",
              "normalizedText": "string",
              "words": [
                {
                  "word": "string",
                  "startTimeMs": "int64",
                  "endTimeMs": "int64"
                }
              ]
            },
            "statistics": {
              "statistics": {
                "speakerTag": "string",
                "speechBoundaries": {
                  "startTimeMs": "int64",
                  "endTimeMs": "int64",
                  "durationSeconds": "int64"
                },
                "totalSpeechMs": "int64",
                "speechRatio": "double",
                "totalSilenceMs": "int64",
                "silenceRatio": "double",
                "wordsCount": "int64",
                "lettersCount": "int64",
                "wordsPerSecond": {
                  "min": "double",
                  "max": "double",
                  "mean": "double",
                  "std": "double",
                  "quantiles": [
                    {
                      "level": "double",
                      "value": "double"
                    }
                  ]
                },
                "lettersPerSecond": {
                  "min": "double",
                  "max": "double",
                  "mean": "double",
                  "std": "double",
                  "quantiles": [
                    {
                      "level": "double",
                      "value": "double"
                    }
                  ]
                }
              }
            },
            "classifiers": [
              {
                "startTimeMs": "int64",
                "endTimeMs": "int64",
                "classifier": "string",
                "highlights": [
                  {
                    "text": "string",
                    "offset": "int64",
                    "count": "int64"
                  }
                ],
                "labels": [
                  {
                    "label": "string",
                    "confidence": "double"
                  }
                ]
              }
            ]
          }
        ],
        "algorithmsMetadata": [
          {
            "createdTaskDate": "google.protobuf.Timestamp",
            "completedTaskDate": "google.protobuf.Timestamp",
            "error": {
              "code": "string",
              "message": "string"
            },
            "traceId": "string",
            "name": "string"
          }
        ]
      },
      "speechStatistics": {
        "totalSimultaneousSpeechDurationSeconds": "int64",
        "totalSimultaneousSpeechDurationMs": "int64",
        "totalSimultaneousSpeechRatio": "double",
        "simultaneousSpeechDurationEstimation": {
          "min": "double",
          "max": "double",
          "mean": "double",
          "std": "double",
          "quantiles": [
            {
              "level": "double",
              "value": "double"
            }
          ]
        }
      },
      "silenceStatistics": {
        "totalSimultaneousSilenceDurationMs": "int64",
        "totalSimultaneousSilenceRatio": "double",
        "simultaneousSilenceDurationEstimation": {
          "min": "double",
          "max": "double",
          "mean": "double",
          "std": "double",
          "quantiles": [
            {
              "level": "double",
              "value": "double"
            }
          ]
        },
        "totalSimultaneousSilenceDurationSeconds": "int64"
      },
      "interruptsStatistics": {
        "speakerInterrupts": [
          {
            "speakerTag": "string",
            "interruptsCount": "int64",
            "interruptsDurationMs": "int64",
            "interrupts": [
              {
                "startTimeMs": "int64",
                "endTimeMs": "int64",
                "durationSeconds": "int64"
              }
            ],
            "interruptsDurationSeconds": "int64"
          }
        ]
      },
      "conversationStatistics": {
        "conversationBoundaries": {
          "startTimeMs": "int64",
          "endTimeMs": "int64",
          "durationSeconds": "int64"
        },
        "speakerStatistics": [
          {
            "speakerTag": "string",
            "completeStatistics": {
              "speakerTag": "string",
              "speechBoundaries": {
                "startTimeMs": "int64",
                "endTimeMs": "int64",
                "durationSeconds": "int64"
              },
              "totalSpeechMs": "int64",
              "speechRatio": "double",
              "totalSilenceMs": "int64",
              "silenceRatio": "double",
              "wordsCount": "int64",
              "lettersCount": "int64",
              "wordsPerSecond": {
                "min": "double",
                "max": "double",
                "mean": "double",
                "std": "double",
                "quantiles": [
                  {
                    "level": "double",
                    "value": "double"
                  }
                ]
              },
              "lettersPerSecond": {
                "min": "double",
                "max": "double",
                "mean": "double",
                "std": "double",
                "quantiles": [
                  {
                    "level": "double",
                    "value": "double"
                  }
                ]
              }
            },
            "wordsPerUtterance": {
              "min": "double",
              "max": "double",
              "mean": "double",
              "std": "double",
              "quantiles": [
                {
                  "level": "double",
                  "value": "double"
                }
              ]
            },
            "lettersPerUtterance": {
              "min": "double",
              "max": "double",
              "mean": "double",
              "std": "double",
              "quantiles": [
                {
                  "level": "double",
                  "value": "double"
                }
              ]
            },
            "utteranceCount": "int64",
            "utteranceDurationEstimation": {
              "min": "double",
              "max": "double",
              "mean": "double",
              "std": "double",
              "quantiles": [
                {
                  "level": "double",
                  "value": "double"
                }
              ]
            }
          }
        ]
      },
      "points": {
        "quiz": [
          {
            "request": "string",
            "response": "google.protobuf.StringValue",
            "id": "string"
          }
        ]
      },
      "textClassifiers": {
        "classificationResult": [
          {
            "classifier": "string",
            "classifierStatistics": [
              {
                "channelNumber": "google.protobuf.Int64Value",
                "totalCount": "int64",
                "histograms": [
                  {
                    "countValues": [
                      "int64"
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      "summarization": {
        "statements": [
          {
            "field": {
              "id": "string",
              "name": "string",
              "type": "SummarizationFieldType"
            },
            "response": [
              "string"
            ]
          }
        ]
      }
    }
  ]
}
```

#|
||Field | Description ||
|| talk[] | **[Talk](#yandex.cloud.speechsense.v1.Talk)** ||
|#

## Talk {#yandex.cloud.speechsense.v1.Talk}

#|
||Field | Description ||
|| id | **string**

talk id ||
|| organizationId | **string** ||
|| spaceId | **string** ||
|| connectionId | **string** ||
|| projectIds[] | **string** ||
|| createdBy | **string**

audition info ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| modifiedBy | **string** ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| talkFields[] | **[Field](#yandex.cloud.speechsense.v1.Field)**

key-value representation of talk fields with values ||
|| transcription | **[Transcription](#yandex.cloud.speechsense.v1.analysis.Transcription)**

various ml analysis results ||
|| speechStatistics | **[SpeechStatistics](#yandex.cloud.speechsense.v1.analysis.SpeechStatistics)** ||
|| silenceStatistics | **[SilenceStatistics](#yandex.cloud.speechsense.v1.analysis.SilenceStatistics)** ||
|| interruptsStatistics | **[InterruptsStatistics](#yandex.cloud.speechsense.v1.analysis.InterruptsStatistics)** ||
|| conversationStatistics | **[ConversationStatistics](#yandex.cloud.speechsense.v1.analysis.ConversationStatistics)** ||
|| points | **[Points](#yandex.cloud.speechsense.v1.analysis.Points)** ||
|| textClassifiers | **[TextClassifiers](#yandex.cloud.speechsense.v1.analysis.TextClassifiers)** ||
|| summarization | **[Summarization](#yandex.cloud.speechsense.v1.analysis.Summarization)** ||
|#

## Field {#yandex.cloud.speechsense.v1.Field}

connection field value

#|
||Field | Description ||
|| name | **string**

name of the field ||
|| value | **string**

field value ||
|| type | enum **FieldType**

field type

- `FIELD_TYPE_UNSPECIFIED`
- `FIELD_TYPE_STRING`
- `FIELD_TYPE_NUMBER`
- `FIELD_TYPE_DECIMAL`
- `FIELD_TYPE_BOOLEAN`
- `FIELD_TYPE_DATE`
- `FIELD_TYPE_JSON` ||
|#

## Transcription {#yandex.cloud.speechsense.v1.analysis.Transcription}

#|
||Field | Description ||
|| phrases[] | **[Phrase](#yandex.cloud.speechsense.v1.analysis.Phrase)** ||
|| algorithmsMetadata[] | **[AlgorithmMetadata](#yandex.cloud.speechsense.v1.analysis.AlgorithmMetadata)**

Their might be several algorithms that work on talk transcription. For example: speechkit and translator
So there might be other fields here for tracing ||
|#

## Phrase {#yandex.cloud.speechsense.v1.analysis.Phrase}

#|
||Field | Description ||
|| channelNumber | **int64** ||
|| startTimeMs | **int64** ||
|| endTimeMs | **int64** ||
|| phrase | **[PhraseText](#yandex.cloud.speechsense.v1.analysis.PhraseText)** ||
|| statistics | **[PhraseStatistics](#yandex.cloud.speechsense.v1.analysis.PhraseStatistics)** ||
|| classifiers[] | **[RecognitionClassifierResult](#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierResult)** ||
|#

## PhraseText {#yandex.cloud.speechsense.v1.analysis.PhraseText}

#|
||Field | Description ||
|| text | **string** ||
|| language | **string** ||
|| normalizedText | **string** ||
|| words[] | **[Word](#yandex.cloud.speechsense.v1.analysis.Word)** ||
|#

## Word {#yandex.cloud.speechsense.v1.analysis.Word}

#|
||Field | Description ||
|| word | **string** ||
|| startTimeMs | **int64** ||
|| endTimeMs | **int64** ||
|#

## PhraseStatistics {#yandex.cloud.speechsense.v1.analysis.PhraseStatistics}

#|
||Field | Description ||
|| statistics | **[UtteranceStatistics](#yandex.cloud.speechsense.v1.analysis.UtteranceStatistics)** ||
|#

## UtteranceStatistics {#yandex.cloud.speechsense.v1.analysis.UtteranceStatistics}

#|
||Field | Description ||
|| speakerTag | **string** ||
|| speechBoundaries | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| totalSpeechMs | **int64**

Total speech duration ||
|| speechRatio | **double**

Speech ratio within audio segment ||
|| totalSilenceMs | **int64**

Total silence duration ||
|| silenceRatio | **double**

Silence ratio within audio segment ||
|| wordsCount | **int64**

Number of words in recognized speech ||
|| lettersCount | **int64**

Number of letters in recognized speech ||
|| wordsPerSecond | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for words per second distribution ||
|| lettersPerSecond | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for letters per second distribution ||
|#

## AudioSegmentBoundaries {#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries}

#|
||Field | Description ||
|| startTimeMs | **int64**

Audio segment start time ||
|| endTimeMs | **int64**

Audio segment end time ||
|| durationSeconds | **int64**

Duration in seconds ||
|#

## DescriptiveStatistics {#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics}

#|
||Field | Description ||
|| min | **double**

Minimum observed value ||
|| max | **double**

Maximum observed value ||
|| mean | **double**

Estimated mean of distribution ||
|| std | **double**

Estimated standard deviation of distribution ||
|| quantiles[] | **[Quantile](#yandex.cloud.speechsense.v1.analysis.Quantile)**

List of evaluated quantiles ||
|#

## Quantile {#yandex.cloud.speechsense.v1.analysis.Quantile}

#|
||Field | Description ||
|| level | **double**

Quantile level in range (0, 1) ||
|| value | **double**

Quantile value ||
|#

## RecognitionClassifierResult {#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierResult}

#|
||Field | Description ||
|| startTimeMs | **int64**

Start time of the audio segment used for classification ||
|| endTimeMs | **int64**

End time of the audio segment used for classification ||
|| classifier | **string**

Name of the triggered classifier ||
|| highlights[] | **[PhraseHighlight](#yandex.cloud.speechsense.v1.analysis.PhraseHighlight)**

List of highlights, i.e. parts of phrase that determine the result of the classification ||
|| labels[] | **[RecognitionClassifierLabel](#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierLabel)**

Classifier predictions ||
|#

## PhraseHighlight {#yandex.cloud.speechsense.v1.analysis.PhraseHighlight}

#|
||Field | Description ||
|| text | **string**

Text transcription of the highlighted audio segment ||
|| offset | **int64**

offset in symbols from the beginning of whole phrase where highlight begins ||
|| count | **int64**

count of symbols in highlighted text ||
|#

## RecognitionClassifierLabel {#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierLabel}

#|
||Field | Description ||
|| label | **string**

The label of the class predicted by the classifier ||
|| confidence | **double**

The prediction confidence ||
|#

## AlgorithmMetadata {#yandex.cloud.speechsense.v1.analysis.AlgorithmMetadata}

#|
||Field | Description ||
|| createdTaskDate | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| completedTaskDate | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| error | **[Error](#yandex.cloud.speechsense.v1.analysis.Error)** ||
|| traceId | **string** ||
|| name | **string** ||
|#

## Error {#yandex.cloud.speechsense.v1.analysis.Error}

#|
||Field | Description ||
|| code | **string** ||
|| message | **string** ||
|#

## SpeechStatistics {#yandex.cloud.speechsense.v1.analysis.SpeechStatistics}

#|
||Field | Description ||
|| totalSimultaneousSpeechDurationSeconds | **int64**

Total simultaneous speech duration in seconds ||
|| totalSimultaneousSpeechDurationMs | **int64**

Total simultaneous speech duration in ms ||
|| totalSimultaneousSpeechRatio | **double**

Simultaneous speech ratio within audio segment ||
|| simultaneousSpeechDurationEstimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for simultaneous speech duration distribution ||
|#

## SilenceStatistics {#yandex.cloud.speechsense.v1.analysis.SilenceStatistics}

#|
||Field | Description ||
|| totalSimultaneousSilenceDurationMs | **int64** ||
|| totalSimultaneousSilenceRatio | **double**

Simultaneous silence ratio within audio segment ||
|| simultaneousSilenceDurationEstimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for simultaneous silence duration distribution ||
|| totalSimultaneousSilenceDurationSeconds | **int64** ||
|#

## InterruptsStatistics {#yandex.cloud.speechsense.v1.analysis.InterruptsStatistics}

#|
||Field | Description ||
|| speakerInterrupts[] | **[InterruptsEvaluation](#yandex.cloud.speechsense.v1.analysis.InterruptsEvaluation)**

Interrupts description for every speaker ||
|#

## InterruptsEvaluation {#yandex.cloud.speechsense.v1.analysis.InterruptsEvaluation}

#|
||Field | Description ||
|| speakerTag | **string**

Speaker tag ||
|| interruptsCount | **int64**

Number of interrupts made by the speaker ||
|| interruptsDurationMs | **int64**

Total duration of all interrupts ||
|| interrupts[] | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Boundaries for every interrupt ||
|| interruptsDurationSeconds | **int64**

Total duration of all interrupts in seconds ||
|#

## ConversationStatistics {#yandex.cloud.speechsense.v1.analysis.ConversationStatistics}

#|
||Field | Description ||
|| conversationBoundaries | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| speakerStatistics[] | **[SpeakerStatistics](#yandex.cloud.speechsense.v1.analysis.SpeakerStatistics)**

Average statistics for each speaker ||
|#

## SpeakerStatistics {#yandex.cloud.speechsense.v1.analysis.SpeakerStatistics}

#|
||Field | Description ||
|| speakerTag | **string**

Speaker tag ||
|| completeStatistics | **[UtteranceStatistics](#yandex.cloud.speechsense.v1.analysis.UtteranceStatistics)**

analysis of all phrases in format of single utterance ||
|| wordsPerUtterance | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for words per utterance distribution ||
|| lettersPerUtterance | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for letters per utterance distribution ||
|| utteranceCount | **int64**

Number of utterances ||
|| utteranceDurationEstimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for utterance duration distribution ||
|#

## Points {#yandex.cloud.speechsense.v1.analysis.Points}

#|
||Field | Description ||
|| quiz[] | **[Quiz](#yandex.cloud.speechsense.v1.analysis.Quiz)** ||
|#

## Quiz {#yandex.cloud.speechsense.v1.analysis.Quiz}

#|
||Field | Description ||
|| request | **string** ||
|| response | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)** ||
|| id | **string** ||
|#

## TextClassifiers {#yandex.cloud.speechsense.v1.analysis.TextClassifiers}

#|
||Field | Description ||
|| classificationResult[] | **[ClassificationResult](#yandex.cloud.speechsense.v1.analysis.ClassificationResult)** ||
|#

## ClassificationResult {#yandex.cloud.speechsense.v1.analysis.ClassificationResult}

#|
||Field | Description ||
|| classifier | **string**

Classifier name ||
|| classifierStatistics[] | **[ClassifierStatistics](#yandex.cloud.speechsense.v1.analysis.ClassifierStatistics)**

Classifier statistics ||
|#

## ClassifierStatistics {#yandex.cloud.speechsense.v1.analysis.ClassifierStatistics}

#|
||Field | Description ||
|| channelNumber | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Channel number, null for whole talk ||
|| totalCount | **int64**

classifier total count ||
|| histograms[] | **[Histogram](#yandex.cloud.speechsense.v1.analysis.Histogram)**

Represents various histograms build on top of classifiers ||
|#

## Histogram {#yandex.cloud.speechsense.v1.analysis.Histogram}

#|
||Field | Description ||
|| countValues[] | **int64**

histogram count values. For example:
if len(count_values) = 2, it means that histogram is 50/50,
if len(count_values) = 3 - [0] value represents first third, [1] - second third, [2] - last third, etc. ||
|#

## Summarization {#yandex.cloud.speechsense.v1.analysis.Summarization}

#|
||Field | Description ||
|| statements[] | **[SummarizationStatement](#yandex.cloud.speechsense.v1.analysis.SummarizationStatement)** ||
|#

## SummarizationStatement {#yandex.cloud.speechsense.v1.analysis.SummarizationStatement}

#|
||Field | Description ||
|| field | **[SummarizationField](#yandex.cloud.speechsense.v1.analysis.SummarizationField)** ||
|| response[] | **string** ||
|#

## SummarizationField {#yandex.cloud.speechsense.v1.analysis.SummarizationField}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string** ||
|| type | enum **SummarizationFieldType**

- `SUMMARIZATION_FIELD_TYPE_UNSPECIFIED`
- `TEXT`
- `TEXT_ARRAY` ||
|#