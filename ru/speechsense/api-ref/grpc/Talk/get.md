---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/get.md
---

# Talk Analytics API, gRPC: TalkService.Get

rpc for bulk get

## gRPC request

**rpc Get ([GetTalkRequest](#yandex.cloud.speechsense.v1.GetTalkRequest)) returns ([GetTalkResponse](#yandex.cloud.speechsense.v1.GetTalkResponse))**

## GetTalkRequest {#yandex.cloud.speechsense.v1.GetTalkRequest}

```json
{
  "organization_id": "string",
  "space_id": "string",
  "connection_id": "string",
  "project_id": "string",
  "talk_ids": [
    "string"
  ],
  "results_mask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| organization_id | **string**

id of organization ||
|| space_id | **string**

id of space ||
|| connection_id | **string**

id of connection to search data ||
|| project_id | **string**

id of project to search data ||
|| talk_ids[] | **string**

ids of talks to return. Requesting too many talks may result in "message exceeds maximum size" error.
Up to 100 of talks per request is recommended. ||
|| results_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

All types of analysis will be returned if not set. ||
|#

## GetTalkResponse {#yandex.cloud.speechsense.v1.GetTalkResponse}

```json
{
  "talk": [
    {
      "id": "string",
      "organization_id": "string",
      "space_id": "string",
      "connection_id": "string",
      "project_ids": [
        "string"
      ],
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "modified_by": "string",
      "modified_at": "google.protobuf.Timestamp",
      "talk_fields": [
        {
          "name": "string",
          "value": "string",
          "type": "FieldType"
        }
      ],
      "transcription": {
        "phrases": [
          {
            "channel_number": "int64",
            "start_time_ms": "int64",
            "end_time_ms": "int64",
            "phrase": {
              "text": "string",
              "language": "string",
              "normalized_text": "string",
              "words": [
                {
                  "word": "string",
                  "start_time_ms": "int64",
                  "end_time_ms": "int64"
                }
              ]
            },
            "statistics": {
              "statistics": {
                "speaker_tag": "string",
                "speech_boundaries": {
                  "start_time_ms": "int64",
                  "end_time_ms": "int64",
                  "duration_seconds": "int64"
                },
                "total_speech_ms": "int64",
                "speech_ratio": "double",
                "total_silence_ms": "int64",
                "silence_ratio": "double",
                "words_count": "int64",
                "letters_count": "int64",
                "words_per_second": {
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
                "letters_per_second": {
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
                "start_time_ms": "int64",
                "end_time_ms": "int64",
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
        "algorithms_metadata": [
          {
            "created_task_date": "google.protobuf.Timestamp",
            "completed_task_date": "google.protobuf.Timestamp",
            "error": {
              "code": "string",
              "message": "string"
            },
            "trace_id": "string",
            "name": "string"
          }
        ]
      },
      "speech_statistics": {
        "total_simultaneous_speech_duration_seconds": "int64",
        "total_simultaneous_speech_duration_ms": "int64",
        "total_simultaneous_speech_ratio": "double",
        "simultaneous_speech_duration_estimation": {
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
      "silence_statistics": {
        "total_simultaneous_silence_duration_ms": "int64",
        "total_simultaneous_silence_ratio": "double",
        "simultaneous_silence_duration_estimation": {
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
        "total_simultaneous_silence_duration_seconds": "int64"
      },
      "interrupts_statistics": {
        "speaker_interrupts": [
          {
            "speaker_tag": "string",
            "interrupts_count": "int64",
            "interrupts_duration_ms": "int64",
            "interrupts": [
              {
                "start_time_ms": "int64",
                "end_time_ms": "int64",
                "duration_seconds": "int64"
              }
            ],
            "interrupts_duration_seconds": "int64"
          }
        ]
      },
      "conversation_statistics": {
        "conversation_boundaries": {
          "start_time_ms": "int64",
          "end_time_ms": "int64",
          "duration_seconds": "int64"
        },
        "speaker_statistics": [
          {
            "speaker_tag": "string",
            "complete_statistics": {
              "speaker_tag": "string",
              "speech_boundaries": {
                "start_time_ms": "int64",
                "end_time_ms": "int64",
                "duration_seconds": "int64"
              },
              "total_speech_ms": "int64",
              "speech_ratio": "double",
              "total_silence_ms": "int64",
              "silence_ratio": "double",
              "words_count": "int64",
              "letters_count": "int64",
              "words_per_second": {
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
              "letters_per_second": {
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
            "words_per_utterance": {
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
            "letters_per_utterance": {
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
            "utterance_count": "int64",
            "utterance_duration_estimation": {
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
      "text_classifiers": {
        "classification_result": [
          {
            "classifier": "string",
            "classifier_statistics": [
              {
                "channel_number": "google.protobuf.Int64Value",
                "total_count": "int64",
                "histograms": [
                  {
                    "count_values": [
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
      },
      "talk_state": {
        "processing_state": "ProcessingState",
        "algorithm_processing_infos": [
          {
            "algorithm": "Algorithm",
            "processing_state": "ProcessingState"
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
|| organization_id | **string** ||
|| space_id | **string** ||
|| connection_id | **string** ||
|| project_ids[] | **string** ||
|| created_by | **string**

audition info ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| modified_by | **string** ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| talk_fields[] | **[Field](#yandex.cloud.speechsense.v1.Field)**

key-value representation of talk fields with values ||
|| transcription | **[Transcription](#yandex.cloud.speechsense.v1.analysis.Transcription)**

various ml analysis results ||
|| speech_statistics | **[SpeechStatistics](#yandex.cloud.speechsense.v1.analysis.SpeechStatistics)** ||
|| silence_statistics | **[SilenceStatistics](#yandex.cloud.speechsense.v1.analysis.SilenceStatistics)** ||
|| interrupts_statistics | **[InterruptsStatistics](#yandex.cloud.speechsense.v1.analysis.InterruptsStatistics)** ||
|| conversation_statistics | **[ConversationStatistics](#yandex.cloud.speechsense.v1.analysis.ConversationStatistics)** ||
|| points | **[Points](#yandex.cloud.speechsense.v1.analysis.Points)** ||
|| text_classifiers | **[TextClassifiers](#yandex.cloud.speechsense.v1.analysis.TextClassifiers)** ||
|| summarization | **[Summarization](#yandex.cloud.speechsense.v1.analysis.Summarization)** ||
|| talk_state | **[TalkState](#yandex.cloud.speechsense.v1.TalkState)** ||
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
|| algorithms_metadata[] | **[AlgorithmMetadata](#yandex.cloud.speechsense.v1.analysis.AlgorithmMetadata)**

Their might be several algorithms that work on talk transcription. For example: speechkit and translator
So there might be other fields here for tracing ||
|#

## Phrase {#yandex.cloud.speechsense.v1.analysis.Phrase}

#|
||Field | Description ||
|| channel_number | **int64** ||
|| start_time_ms | **int64** ||
|| end_time_ms | **int64** ||
|| phrase | **[PhraseText](#yandex.cloud.speechsense.v1.analysis.PhraseText)** ||
|| statistics | **[PhraseStatistics](#yandex.cloud.speechsense.v1.analysis.PhraseStatistics)** ||
|| classifiers[] | **[RecognitionClassifierResult](#yandex.cloud.speechsense.v1.analysis.RecognitionClassifierResult)** ||
|#

## PhraseText {#yandex.cloud.speechsense.v1.analysis.PhraseText}

#|
||Field | Description ||
|| text | **string** ||
|| language | **string** ||
|| normalized_text | **string** ||
|| words[] | **[Word](#yandex.cloud.speechsense.v1.analysis.Word)** ||
|#

## Word {#yandex.cloud.speechsense.v1.analysis.Word}

#|
||Field | Description ||
|| word | **string** ||
|| start_time_ms | **int64** ||
|| end_time_ms | **int64** ||
|#

## PhraseStatistics {#yandex.cloud.speechsense.v1.analysis.PhraseStatistics}

#|
||Field | Description ||
|| statistics | **[UtteranceStatistics](#yandex.cloud.speechsense.v1.analysis.UtteranceStatistics)** ||
|#

## UtteranceStatistics {#yandex.cloud.speechsense.v1.analysis.UtteranceStatistics}

#|
||Field | Description ||
|| speaker_tag | **string** ||
|| speech_boundaries | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| total_speech_ms | **int64**

Total speech duration ||
|| speech_ratio | **double**

Speech ratio within audio segment ||
|| total_silence_ms | **int64**

Total silence duration ||
|| silence_ratio | **double**

Silence ratio within audio segment ||
|| words_count | **int64**

Number of words in recognized speech ||
|| letters_count | **int64**

Number of letters in recognized speech ||
|| words_per_second | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for words per second distribution ||
|| letters_per_second | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for letters per second distribution ||
|#

## AudioSegmentBoundaries {#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries}

#|
||Field | Description ||
|| start_time_ms | **int64**

Audio segment start time ||
|| end_time_ms | **int64**

Audio segment end time ||
|| duration_seconds | **int64**

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
|| start_time_ms | **int64**

Start time of the audio segment used for classification ||
|| end_time_ms | **int64**

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
|| created_task_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| completed_task_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| error | **[Error](#yandex.cloud.speechsense.v1.analysis.Error)** ||
|| trace_id | **string** ||
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
|| total_simultaneous_speech_duration_seconds | **int64**

Total simultaneous speech duration in seconds ||
|| total_simultaneous_speech_duration_ms | **int64**

Total simultaneous speech duration in ms ||
|| total_simultaneous_speech_ratio | **double**

Simultaneous speech ratio within audio segment ||
|| simultaneous_speech_duration_estimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for simultaneous speech duration distribution ||
|#

## SilenceStatistics {#yandex.cloud.speechsense.v1.analysis.SilenceStatistics}

#|
||Field | Description ||
|| total_simultaneous_silence_duration_ms | **int64** ||
|| total_simultaneous_silence_ratio | **double**

Simultaneous silence ratio within audio segment ||
|| simultaneous_silence_duration_estimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for simultaneous silence duration distribution ||
|| total_simultaneous_silence_duration_seconds | **int64** ||
|#

## InterruptsStatistics {#yandex.cloud.speechsense.v1.analysis.InterruptsStatistics}

#|
||Field | Description ||
|| speaker_interrupts[] | **[InterruptsEvaluation](#yandex.cloud.speechsense.v1.analysis.InterruptsEvaluation)**

Interrupts description for every speaker ||
|#

## InterruptsEvaluation {#yandex.cloud.speechsense.v1.analysis.InterruptsEvaluation}

#|
||Field | Description ||
|| speaker_tag | **string**

Speaker tag ||
|| interrupts_count | **int64**

Number of interrupts made by the speaker ||
|| interrupts_duration_ms | **int64**

Total duration of all interrupts ||
|| interrupts[] | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Boundaries for every interrupt ||
|| interrupts_duration_seconds | **int64**

Total duration of all interrupts in seconds ||
|#

## ConversationStatistics {#yandex.cloud.speechsense.v1.analysis.ConversationStatistics}

#|
||Field | Description ||
|| conversation_boundaries | **[AudioSegmentBoundaries](#yandex.cloud.speechsense.v1.analysis.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| speaker_statistics[] | **[SpeakerStatistics](#yandex.cloud.speechsense.v1.analysis.SpeakerStatistics)**

Average statistics for each speaker ||
|#

## SpeakerStatistics {#yandex.cloud.speechsense.v1.analysis.SpeakerStatistics}

#|
||Field | Description ||
|| speaker_tag | **string**

Speaker tag ||
|| complete_statistics | **[UtteranceStatistics](#yandex.cloud.speechsense.v1.analysis.UtteranceStatistics)**

analysis of all phrases in format of single utterance ||
|| words_per_utterance | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for words per utterance distribution ||
|| letters_per_utterance | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

Descriptive statistics for letters per utterance distribution ||
|| utterance_count | **int64**

Number of utterances ||
|| utterance_duration_estimation | **[DescriptiveStatistics](#yandex.cloud.speechsense.v1.analysis.DescriptiveStatistics)**

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
|| classification_result[] | **[ClassificationResult](#yandex.cloud.speechsense.v1.analysis.ClassificationResult)** ||
|#

## ClassificationResult {#yandex.cloud.speechsense.v1.analysis.ClassificationResult}

#|
||Field | Description ||
|| classifier | **string**

Classifier name ||
|| classifier_statistics[] | **[ClassifierStatistics](#yandex.cloud.speechsense.v1.analysis.ClassifierStatistics)**

Classifier statistics ||
|#

## ClassifierStatistics {#yandex.cloud.speechsense.v1.analysis.ClassifierStatistics}

#|
||Field | Description ||
|| channel_number | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Channel number, null for whole talk ||
|| total_count | **int64**

classifier total count ||
|| histograms[] | **[Histogram](#yandex.cloud.speechsense.v1.analysis.Histogram)**

Represents various histograms build on top of classifiers ||
|#

## Histogram {#yandex.cloud.speechsense.v1.analysis.Histogram}

#|
||Field | Description ||
|| count_values[] | **int64**

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

## TalkState {#yandex.cloud.speechsense.v1.TalkState}

#|
||Field | Description ||
|| processing_state | enum **ProcessingState**

- `PROCESSING_STATE_UNSPECIFIED`
- `PROCESSING_STATE_NOT_STARTED`
- `PROCESSING_STATE_PROCESSING`
- `PROCESSING_STATE_SUCCESS`
- `PROCESSING_STATE_FAILED` ||
|| algorithm_processing_infos[] | **[AlgorithmProcessingInfo](#yandex.cloud.speechsense.v1.AlgorithmProcessingInfo)** ||
|#

## AlgorithmProcessingInfo {#yandex.cloud.speechsense.v1.AlgorithmProcessingInfo}

#|
||Field | Description ||
|| algorithm | enum **Algorithm**

- `ALGORITHM_UNSPECIFIED`
- `ALGORITHM_SPEECHKIT`
- `ALGORITHM_YGPT`
- `ALGORITHM_CLASSIFIER`
- `ALGORITHM_SUMMARIZATION`
- `ALGORITHM_EMBEDDING`
- `ALGORITHM_STATISTICS` ||
|| processing_state | enum **ProcessingState**

- `PROCESSING_STATE_UNSPECIFIED`
- `PROCESSING_STATE_NOT_STARTED`
- `PROCESSING_STATE_PROCESSING`
- `PROCESSING_STATE_SUCCESS`
- `PROCESSING_STATE_FAILED` ||
|#