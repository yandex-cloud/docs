---
editable: false
apiPlayground:
  - url: https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            id of organization
          type: string
        spaceId:
          description: |-
            **string**
            id of space
          type: string
        connectionId:
          description: |-
            **string**
            id of connection to search data
          type: string
        projectId:
          description: |-
            **string**
            id of project to search data
          type: string
        talkIds:
          description: |-
            **string**
            ids of talks to return. Requesting too many talks may result in "message exceeds maximum size" error.
            Up to 100 of talks per request is recommended.
          type: array
          items:
            type: string
        resultsMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/speechsense/v1/api-ref/Talk/get.md
---

# Talk Analytics API, REST: Talk.Get

rpc for bulk get

## HTTP request

```
POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get
```

## Body parameters {#yandex.cloud.speechsense.v1.GetTalkRequest}

```json
{
  "organizationId": "string",
  "spaceId": "string",
  "connectionId": "string",
  "projectId": "string",
  "talkIds": [
    "string"
  ],
  "resultsMask": "string"
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
|| resultsMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|#

## Response {#yandex.cloud.speechsense.v1.GetTalkResponse}

**HTTP Code: 200 - OK**

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
      "createdAt": "string",
      "modifiedBy": "string",
      "modifiedAt": "string",
      "talkFields": [
        {
          "name": "string",
          "value": "string",
          "type": "string"
        }
      ],
      "transcription": {
        "phrases": [
          {
            "channelNumber": "string",
            "startTimeMs": "string",
            "endTimeMs": "string",
            "phrase": {
              "text": "string",
              "language": "string",
              "normalizedText": "string",
              "words": [
                {
                  "word": "string",
                  "startTimeMs": "string",
                  "endTimeMs": "string"
                }
              ]
            },
            "statistics": {
              "statistics": {
                "speakerTag": "string",
                "speechBoundaries": {
                  "startTimeMs": "string",
                  "endTimeMs": "string",
                  "durationSeconds": "string"
                },
                "totalSpeechMs": "string",
                "speechRatio": "string",
                "totalSilenceMs": "string",
                "silenceRatio": "string",
                "wordsCount": "string",
                "lettersCount": "string",
                "wordsPerSecond": {
                  "min": "string",
                  "max": "string",
                  "mean": "string",
                  "std": "string",
                  "quantiles": [
                    {
                      "level": "string",
                      "value": "string"
                    }
                  ]
                },
                "lettersPerSecond": {
                  "min": "string",
                  "max": "string",
                  "mean": "string",
                  "std": "string",
                  "quantiles": [
                    {
                      "level": "string",
                      "value": "string"
                    }
                  ]
                }
              }
            },
            "classifiers": [
              {
                "startTimeMs": "string",
                "endTimeMs": "string",
                "classifier": "string",
                "highlights": [
                  {
                    "text": "string",
                    "offset": "string",
                    "count": "string"
                  }
                ],
                "labels": [
                  {
                    "label": "string",
                    "confidence": "string"
                  }
                ]
              }
            ]
          }
        ],
        "algorithmsMetadata": [
          {
            "createdTaskDate": "string",
            "completedTaskDate": "string",
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
        "totalSimultaneousSpeechDurationSeconds": "string",
        "totalSimultaneousSpeechDurationMs": "string",
        "totalSimultaneousSpeechRatio": "string",
        "simultaneousSpeechDurationEstimation": {
          "min": "string",
          "max": "string",
          "mean": "string",
          "std": "string",
          "quantiles": [
            {
              "level": "string",
              "value": "string"
            }
          ]
        }
      },
      "silenceStatistics": {
        "totalSimultaneousSilenceDurationMs": "string",
        "totalSimultaneousSilenceRatio": "string",
        "simultaneousSilenceDurationEstimation": {
          "min": "string",
          "max": "string",
          "mean": "string",
          "std": "string",
          "quantiles": [
            {
              "level": "string",
              "value": "string"
            }
          ]
        },
        "totalSimultaneousSilenceDurationSeconds": "string"
      },
      "interruptsStatistics": {
        "speakerInterrupts": [
          {
            "speakerTag": "string",
            "interruptsCount": "string",
            "interruptsDurationMs": "string",
            "interrupts": [
              {
                "startTimeMs": "string",
                "endTimeMs": "string",
                "durationSeconds": "string"
              }
            ],
            "interruptsDurationSeconds": "string"
          }
        ]
      },
      "conversationStatistics": {
        "conversationBoundaries": {
          "startTimeMs": "string",
          "endTimeMs": "string",
          "durationSeconds": "string"
        },
        "speakerStatistics": [
          {
            "speakerTag": "string",
            "completeStatistics": {
              "speakerTag": "string",
              "speechBoundaries": {
                "startTimeMs": "string",
                "endTimeMs": "string",
                "durationSeconds": "string"
              },
              "totalSpeechMs": "string",
              "speechRatio": "string",
              "totalSilenceMs": "string",
              "silenceRatio": "string",
              "wordsCount": "string",
              "lettersCount": "string",
              "wordsPerSecond": {
                "min": "string",
                "max": "string",
                "mean": "string",
                "std": "string",
                "quantiles": [
                  {
                    "level": "string",
                    "value": "string"
                  }
                ]
              },
              "lettersPerSecond": {
                "min": "string",
                "max": "string",
                "mean": "string",
                "std": "string",
                "quantiles": [
                  {
                    "level": "string",
                    "value": "string"
                  }
                ]
              }
            },
            "wordsPerUtterance": {
              "min": "string",
              "max": "string",
              "mean": "string",
              "std": "string",
              "quantiles": [
                {
                  "level": "string",
                  "value": "string"
                }
              ]
            },
            "lettersPerUtterance": {
              "min": "string",
              "max": "string",
              "mean": "string",
              "std": "string",
              "quantiles": [
                {
                  "level": "string",
                  "value": "string"
                }
              ]
            },
            "utteranceCount": "string",
            "utteranceDurationEstimation": {
              "min": "string",
              "max": "string",
              "mean": "string",
              "std": "string",
              "quantiles": [
                {
                  "level": "string",
                  "value": "string"
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
            "response": "string",
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
                "channelNumber": "string",
                "totalCount": "string",
                "histograms": [
                  {
                    "countValues": [
                      "string"
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
              "type": "string"
            },
            "response": [
              "string"
            ]
          }
        ]
      },
      "talkState": {
        "processingState": "string",
        "algorithmProcessingInfos": [
          {
            "algorithm": "string",
            "processingState": "string"
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
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedBy | **string** ||
|| modifiedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| talkState | **[TalkState](#yandex.cloud.speechsense.v1.TalkState)** ||
|#

## Field {#yandex.cloud.speechsense.v1.Field}

connection field value

#|
||Field | Description ||
|| name | **string**

name of the field ||
|| value | **string**

field value ||
|| type | **enum** (FieldType)

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
|| channelNumber | **string** (int64) ||
|| startTimeMs | **string** (int64) ||
|| endTimeMs | **string** (int64) ||
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
|| startTimeMs | **string** (int64) ||
|| endTimeMs | **string** (int64) ||
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
|| totalSpeechMs | **string** (int64)

Total speech duration ||
|| speechRatio | **string**

Speech ratio within audio segment ||
|| totalSilenceMs | **string** (int64)

Total silence duration ||
|| silenceRatio | **string**

Silence ratio within audio segment ||
|| wordsCount | **string** (int64)

Number of words in recognized speech ||
|| lettersCount | **string** (int64)

Number of letters in recognized speech ||
|| wordsPerSecond | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for words per second distribution ||
|| lettersPerSecond | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for letters per second distribution ||
|#

## AudioSegmentBoundaries {#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries}

#|
||Field | Description ||
|| startTimeMs | **string** (int64)

Audio segment start time ||
|| endTimeMs | **string** (int64)

Audio segment end time ||
|| durationSeconds | **string** (int64)

Duration in seconds ||
|#

## DescriptiveStatistics {#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics}

#|
||Field | Description ||
|| min | **string**

Minimum observed value ||
|| max | **string**

Maximum observed value ||
|| mean | **string**

Estimated mean of distribution ||
|| std | **string**

Estimated standard deviation of distribution ||
|| quantiles[] | **[Quantile](#yandex.cloud.speechsense.v1.analysis.Quantile)**

List of evaluated quantiles ||
|#

## Quantile {#yandex.cloud.speechsense.v1.analysis.Quantile}

#|
||Field | Description ||
|| level | **string**

Quantile level in range (0, 1) ||
|| value | **string**

Quantile value ||
|#

## RecognitionClassifierResult {#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierResult}

#|
||Field | Description ||
|| startTimeMs | **string** (int64)

Start time of the audio segment used for classification ||
|| endTimeMs | **string** (int64)

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
|| offset | **string** (int64)

offset in symbols from the beginning of whole phrase where highlight begins ||
|| count | **string** (int64)

count of symbols in highlighted text ||
|#

## RecognitionClassifierLabel {#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierLabel}

#|
||Field | Description ||
|| label | **string**

The label of the class predicted by the classifier ||
|| confidence | **string**

The prediction confidence ||
|#

## AlgorithmMetadata {#yandex.cloud.speechsense.v1.analysis.AlgorithmMetadata}

#|
||Field | Description ||
|| createdTaskDate | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| completedTaskDate | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| totalSimultaneousSpeechDurationSeconds | **string** (int64)

Total simultaneous speech duration in seconds ||
|| totalSimultaneousSpeechDurationMs | **string** (int64)

Total simultaneous speech duration in ms ||
|| totalSimultaneousSpeechRatio | **string**

Simultaneous speech ratio within audio segment ||
|| simultaneousSpeechDurationEstimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for simultaneous speech duration distribution ||
|#

## SilenceStatistics {#yandex.cloud.speechsense.v1.analysis.SilenceStatistics}

#|
||Field | Description ||
|| totalSimultaneousSilenceDurationMs | **string** (int64) ||
|| totalSimultaneousSilenceRatio | **string**

Simultaneous silence ratio within audio segment ||
|| simultaneousSilenceDurationEstimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for simultaneous silence duration distribution ||
|| totalSimultaneousSilenceDurationSeconds | **string** (int64) ||
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
|| interruptsCount | **string** (int64)

Number of interrupts made by the speaker ||
|| interruptsDurationMs | **string** (int64)

Total duration of all interrupts ||
|| interrupts[] | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Boundaries for every interrupt ||
|| interruptsDurationSeconds | **string** (int64)

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
|| utteranceCount | **string** (int64)

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
|| response | **string** ||
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
|| channelNumber | **string** (int64)

Channel number, null for whole talk ||
|| totalCount | **string** (int64)

classifier total count ||
|| histograms[] | **[Histogram](#yandex.cloud.speechsense.v1.analysis.Histogram)**

Represents various histograms build on top of classifiers ||
|#

## Histogram {#yandex.cloud.speechsense.v1.analysis.Histogram}

#|
||Field | Description ||
|| countValues[] | **string** (int64)

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
|| type | **enum** (SummarizationFieldType)

- `SUMMARIZATION_FIELD_TYPE_UNSPECIFIED`
- `TEXT`
- `TEXT_ARRAY` ||
|#

## TalkState {#yandex.cloud.speechsense.v1.TalkState}

#|
||Field | Description ||
|| processingState | **enum** (ProcessingState)

- `PROCESSING_STATE_UNSPECIFIED`
- `PROCESSING_STATE_NOT_STARTED`
- `PROCESSING_STATE_PROCESSING`
- `PROCESSING_STATE_SUCCESS`
- `PROCESSING_STATE_FAILED` ||
|| algorithmProcessingInfos[] | **[AlgorithmProcessingInfo](#yandex.cloud.speechsense.v1.AlgorithmProcessingInfo)** ||
|#

## AlgorithmProcessingInfo {#yandex.cloud.speechsense.v1.AlgorithmProcessingInfo}

#|
||Field | Description ||
|| algorithm | **enum** (Algorithm)

- `ALGORITHM_UNSPECIFIED`
- `ALGORITHM_SPEECHKIT`
- `ALGORITHM_YGPT`
- `ALGORITHM_CLASSIFIER`
- `ALGORITHM_SUMMARIZATION`
- `ALGORITHM_EMBEDDING`
- `ALGORITHM_STATISTICS` ||
|| processingState | **enum** (ProcessingState)

- `PROCESSING_STATE_UNSPECIFIED`
- `PROCESSING_STATE_NOT_STARTED`
- `PROCESSING_STATE_PROCESSING`
- `PROCESSING_STATE_SUCCESS`
- `PROCESSING_STATE_FAILED` ||
|#