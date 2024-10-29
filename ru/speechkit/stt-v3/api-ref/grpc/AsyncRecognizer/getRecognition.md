---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/v3/stt-v3/api-ref/grpc/AsyncRecognizer/getRecognition.md
---

# SpeechKit Recognition API v3, gRPC: AsyncRecognizer.GetRecognition {#GetRecognition}

## gRPC request

**rpc GetRecognition ([GetRecognitionRequest](#speechkit.stt.v3.GetRecognitionRequest)) returns (stream [StreamingResponse](#speechkit.stt.v3.StreamingResponse))**

## GetRecognitionRequest {#speechkit.stt.v3.GetRecognitionRequest}

```json
{
  "operationId": "string"
}
```

#|
||Field | Description ||
|| operationId | **string** ||
|#

## StreamingResponse {#speechkit.stt.v3.StreamingResponse}

```json
{
  "sessionUuid": {
    "uuid": "string",
    "userRequestId": "string"
  },
  "audioCursors": {
    "receivedDataMs": "int64",
    "resetTimeMs": "int64",
    "partialTimeMs": "int64",
    "finalTimeMs": "int64",
    "finalIndex": "int64",
    "eouTimeMs": "int64"
  },
  "responseWallTimeMs": "int64",
  // Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`
  "partial": {
    "alternatives": [
      {
        "words": [
          {
            "text": "string",
            "startTimeMs": "int64",
            "endTimeMs": "int64"
          }
        ],
        "text": "string",
        "startTimeMs": "int64",
        "endTimeMs": "int64",
        "confidence": "double",
        "languages": [
          {
            "languageCode": "string",
            "probability": "double"
          }
        ]
      }
    ],
    "channelTag": "string"
  },
  "final": {
    "alternatives": [
      {
        "words": [
          {
            "text": "string",
            "startTimeMs": "int64",
            "endTimeMs": "int64"
          }
        ],
        "text": "string",
        "startTimeMs": "int64",
        "endTimeMs": "int64",
        "confidence": "double",
        "languages": [
          {
            "languageCode": "string",
            "probability": "double"
          }
        ]
      }
    ],
    "channelTag": "string"
  },
  "eouUpdate": {
    "timeMs": "int64"
  },
  "finalRefinement": {
    "finalIndex": "int64",
    // Includes only one of the fields `normalizedText`
    "normalizedText": {
      "alternatives": [
        {
          "words": [
            {
              "text": "string",
              "startTimeMs": "int64",
              "endTimeMs": "int64"
            }
          ],
          "text": "string",
          "startTimeMs": "int64",
          "endTimeMs": "int64",
          "confidence": "double",
          "languages": [
            {
              "languageCode": "string",
              "probability": "double"
            }
          ]
        }
      ],
      "channelTag": "string"
    }
    // end of the list of possible fields
  },
  "statusCode": {
    "codeType": "CodeType",
    "message": "string"
  },
  "classifierUpdate": {
    "windowType": "WindowType",
    "startTimeMs": "int64",
    "endTimeMs": "int64",
    "classifierResult": {
      "classifier": "string",
      "highlights": [
        {
          "text": "string",
          "startTimeMs": "int64",
          "endTimeMs": "int64"
        }
      ],
      "labels": [
        {
          "label": "string",
          "confidence": "double"
        }
      ]
    }
  },
  "speakerAnalysis": {
    "speakerTag": "string",
    "windowType": "WindowType",
    "speechBoundaries": {
      "startTimeMs": "int64",
      "endTimeMs": "int64"
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
  },
  "conversationAnalysis": {
    "conversationBoundaries": {
      "startTimeMs": "int64",
      "endTimeMs": "int64"
    },
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
    },
    "speakerInterrupts": [
      {
        "speakerTag": "string",
        "interruptsCount": "int64",
        "interruptsDurationMs": "int64",
        "interrupts": [
          {
            "startTimeMs": "int64",
            "endTimeMs": "int64"
          }
        ]
      }
    ],
    "totalSpeechDurationMs": "int64",
    "totalSpeechRatio": "double"
  },
  // end of the list of possible fields
  "channelTag": "string"
}
```

Responses from server.
Each response contains session uuid
AudioCursors
plus specific event

#|
||Field | Description ||
|| sessionUuid | **[SessionUuid](#speechkit.stt.v3.SessionUuid)**

Session identifier ||
|| audioCursors | **[AudioCursors](#speechkit.stt.v3.AudioCursors)**

Progress bar for stream session recognition: how many data we obtained; final and partial times; etc. ||
|| responseWallTimeMs | **int64**

Wall clock on server side. This is time when server wrote results to stream ||
|| partial | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Partial results, server will send them regularly after enough audio data was received from user. This are current text estimation
from final_time_ms to partial_time_ms. Could change after new data will arrive.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| final | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| eouUpdate | **[EouUpdate](#speechkit.stt.v3.EouUpdate)**

After EOU classifier, send the message with final, send the EouUpdate with time of EOU
before eou_update we send final with the same time. there could be several finals before eou update.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| finalRefinement | **[FinalRefinement](#speechkit.stt.v3.FinalRefinement)**

For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing).
Final normalization will introduce additional latency.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| statusCode | **[StatusCode](#speechkit.stt.v3.StatusCode)**

Status messages, send by server with fixed interval (keep-alive).

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| classifierUpdate | **[RecognitionClassifierUpdate](#speechkit.stt.v3.RecognitionClassifierUpdate)**

Result of the triggered classifier

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| speakerAnalysis | **[SpeakerAnalysis](#speechkit.stt.v3.SpeakerAnalysis)**

Speech statistics for every speaker

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| conversationAnalysis | **[ConversationAnalysis](#speechkit.stt.v3.ConversationAnalysis)**

Conversation statistics

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`. ||
|| channelTag | **string**

Tag for distinguish audio channels. ||
|#

## SessionUuid {#speechkit.stt.v3.SessionUuid}

Session identifier.

#|
||Field | Description ||
|| uuid | **string**

Internal session identifier. ||
|| userRequestId | **string**

User session identifier. ||
|#

## AudioCursors {#speechkit.stt.v3.AudioCursors}

AudioCursors are state of ASR recognition stream.

#|
||Field | Description ||
|| receivedDataMs | **int64**

Amount of audio chunks server received. This cursor is moved after each audio chunk was received by server. ||
|| resetTimeMs | **int64**

Input stream reset data. ||
|| partialTimeMs | **int64**

How much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data
to update recognition results (includes silence as well). ||
|| finalTimeMs | **int64**

Time of last final. This cursor is moved when server decides that recognition from start of audio until final_time_ms will not change anymore
usually this even is followed by EOU detection (but this could change in future). ||
|| finalIndex | **int64**

This is index of last final server send. Incremented after each new final. ||
|| eouTimeMs | **int64**

Estimated time of EOU. Cursor is updated after each new EOU is sent.
For external classifier this equals to received_data_ms at the moment EOU event arrives.
For internal classifier this is estimation of time. The time is not exact and has the same guarantees as word timings. ||
|#

## AlternativeUpdate {#speechkit.stt.v3.AlternativeUpdate}

Update of hypothesis.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#speechkit.stt.v3.Alternative)**

List of hypothesis for timeframes. ||
|| channelTag | **string** ||
|#

## Alternative {#speechkit.stt.v3.Alternative}

Recognition of specific time frame.

#|
||Field | Description ||
|| words[] | **[Word](#speechkit.stt.v3.Word)**

Words in time frame. ||
|| text | **string**

Text in time frame. ||
|| startTimeMs | **int64**

Start of time frame. ||
|| endTimeMs | **int64**

End of time frame. ||
|| confidence | **double**

The hypothesis confidence. Currently is not used. ||
|| languages[] | **[LanguageEstimation](#speechkit.stt.v3.LanguageEstimation)**

Distribution over possible languages. ||
|#

## Word {#speechkit.stt.v3.Word}

Recognized word.

#|
||Field | Description ||
|| text | **string**

Word text. ||
|| startTimeMs | **int64**

Estimation of word start time in ms. ||
|| endTimeMs | **int64**

Estimation of word end time in ms. ||
|#

## LanguageEstimation {#speechkit.stt.v3.LanguageEstimation}

Estimation of language and its probability.

#|
||Field | Description ||
|| languageCode | **string**

Language code in ISO 639-1 format. ||
|| probability | **double**

Estimation of language probability. ||
|#

## EouUpdate {#speechkit.stt.v3.EouUpdate}

Update information for external End of Utterance.

#|
||Field | Description ||
|| timeMs | **int64**

EOU estimated time. ||
|#

## FinalRefinement {#speechkit.stt.v3.FinalRefinement}

Refinement for final hypo. For example, text normalization is refinement.

#|
||Field | Description ||
|| finalIndex | **int64**

Index of final for which server sends additional information. ||
|| normalizedText | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Normalized text instead of raw one.

Includes only one of the fields `normalizedText`.

Type of refinement. ||
|#

## StatusCode {#speechkit.stt.v3.StatusCode}

Status message

#|
||Field | Description ||
|| codeType | enum **CodeType**

Code type.

- `CODE_TYPE_UNSPECIFIED`
- `WORKING`: All good.
- `WARNING`: For example, if speech is sent not in real time or context is unknown and we've made fallback.
- `CLOSED`: After session was closed. ||
|| message | **string**

Human readable message. ||
|#

## RecognitionClassifierUpdate {#speechkit.stt.v3.RecognitionClassifierUpdate}

#|
||Field | Description ||
|| windowType | enum **WindowType**

Response window type

- `WINDOW_TYPE_UNSPECIFIED`
- `LAST_UTTERANCE`: The result of applying the classifier to the last utterance response
- `LAST_FINAL`: The result of applying the classifier to the last final response
- `LAST_PARTIAL`: The result of applying the classifier to the last partial response ||
|| startTimeMs | **int64**

Start time of the audio segment used for classification ||
|| endTimeMs | **int64**

End time of the audio segment used for classification ||
|| classifierResult | **[RecognitionClassifierResult](#speechkit.stt.v3.RecognitionClassifierResult)**

Result for dictionary-based classifier ||
|#

## RecognitionClassifierResult {#speechkit.stt.v3.RecognitionClassifierResult}

#|
||Field | Description ||
|| classifier | **string**

Name of the triggered classifier ||
|| highlights[] | **[PhraseHighlight](#speechkit.stt.v3.PhraseHighlight)**

List of highlights, i.e. parts of phrase that determine the result of the classification ||
|| labels[] | **[RecognitionClassifierLabel](#speechkit.stt.v3.RecognitionClassifierLabel)**

Classifier predictions ||
|#

## PhraseHighlight {#speechkit.stt.v3.PhraseHighlight}

#|
||Field | Description ||
|| text | **string**

Text transcription of the highlighted audio segment ||
|| startTimeMs | **int64**

Start time of the highlighted audio segment ||
|| endTimeMs | **int64**

End time of the highlighted audio segment ||
|#

## RecognitionClassifierLabel {#speechkit.stt.v3.RecognitionClassifierLabel}

#|
||Field | Description ||
|| label | **string**

The label of the class predicted by the classifier ||
|| confidence | **double**

The prediction confidence ||
|#

## SpeakerAnalysis {#speechkit.stt.v3.SpeakerAnalysis}

#|
||Field | Description ||
|| speakerTag | **string**

Speaker tag ||
|| windowType | enum **WindowType**

Response window type

- `WINDOW_TYPE_UNSPECIFIED`
- `TOTAL`: Stats for all received audio.
- `LAST_UTTERANCE`: Stats for last utterance. ||
|| speechBoundaries | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

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
|| wordsPerSecond | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for words per second distribution ||
|| lettersPerSecond | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for letters per second distribution ||
|| wordsPerUtterance | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for words per utterance distribution ||
|| lettersPerUtterance | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for letters per utterance distribution ||
|| utteranceCount | **int64**

Number of utterances ||
|| utteranceDurationEstimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for utterance duration distribution ||
|#

## AudioSegmentBoundaries {#speechkit.stt.v3.AudioSegmentBoundaries}

#|
||Field | Description ||
|| startTimeMs | **int64**

Audio segment start time ||
|| endTimeMs | **int64**

Audio segment end time ||
|#

## DescriptiveStatistics {#speechkit.stt.v3.DescriptiveStatistics}

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
|| quantiles[] | **[Quantile](#speechkit.stt.v3.DescriptiveStatistics.Quantile)**

List of evaluated quantiles ||
|#

## Quantile {#speechkit.stt.v3.DescriptiveStatistics.Quantile}

#|
||Field | Description ||
|| level | **double**

Quantile level in range (0, 1) ||
|| value | **double**

Quantile value ||
|#

## ConversationAnalysis {#speechkit.stt.v3.ConversationAnalysis}

#|
||Field | Description ||
|| conversationBoundaries | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| totalSimultaneousSilenceDurationMs | **int64**

Total simultaneous silence duration ||
|| totalSimultaneousSilenceRatio | **double**

Simultaneous silence ratio within audio segment ||
|| simultaneousSilenceDurationEstimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for simultaneous silence duration distribution ||
|| totalSimultaneousSpeechDurationMs | **int64**

Total simultaneous speech duration ||
|| totalSimultaneousSpeechRatio | **double**

Simultaneous speech ratio within audio segment ||
|| simultaneousSpeechDurationEstimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for simultaneous speech duration distribution ||
|| speakerInterrupts[] | **[InterruptsEvaluation](#speechkit.stt.v3.ConversationAnalysis.InterruptsEvaluation)**

Interrupts description for every speaker ||
|| totalSpeechDurationMs | **int64**

Total speech duration, including both simultaneous and separate speech ||
|| totalSpeechRatio | **double**

Total speech ratio within audio segment ||
|#

## InterruptsEvaluation {#speechkit.stt.v3.ConversationAnalysis.InterruptsEvaluation}

#|
||Field | Description ||
|| speakerTag | **string**

Speaker tag ||
|| interruptsCount | **int64**

Number of interrupts made by the speaker ||
|| interruptsDurationMs | **int64**

Total duration of all interrupts ||
|| interrupts[] | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

Boundaries for every interrupt ||
|#