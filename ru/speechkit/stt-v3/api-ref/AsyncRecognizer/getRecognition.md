---
editable: false
apiPlayground:
  - url: https://{{ api-host-sk-stt }}/stt/v3/getRecognition
    method: get
    path: null
    query:
      type: object
      properties:
        operationId:
          description: '**string**'
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ai/stt/v3/stt-v3/api-ref/AsyncRecognizer/getRecognition.md
---

# SpeechKit Recognition API v3, REST: AsyncRecognizer.GetRecognition

## HTTP request

```
GET https://{{ api-host-sk-stt }}/stt/v3/getRecognition
```

## Query parameters {#speechkit.stt.v3.GetRecognitionRequest}

#|
||Field | Description ||
|| operationId | **string** ||
|#

## Response {#speechkit.stt.v3.StreamingResponse}

**HTTP Code: 200 - OK**

```json
{
  "sessionUuid": {
    "uuid": "string",
    "userRequestId": "string"
  },
  "audioCursors": {
    "receivedDataMs": "string",
    "resetTimeMs": "string",
    "partialTimeMs": "string",
    "finalTimeMs": "string",
    "finalIndex": "string",
    "eouTimeMs": "string"
  },
  "responseWallTimeMs": "string",
  // Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`
  "partial": {
    "alternatives": [
      {
        "words": [
          {
            "text": "string",
            "startTimeMs": "string",
            "endTimeMs": "string"
          }
        ],
        "text": "string",
        "startTimeMs": "string",
        "endTimeMs": "string",
        "confidence": "string",
        "languages": [
          {
            "languageCode": "string",
            "probability": "string"
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
            "startTimeMs": "string",
            "endTimeMs": "string"
          }
        ],
        "text": "string",
        "startTimeMs": "string",
        "endTimeMs": "string",
        "confidence": "string",
        "languages": [
          {
            "languageCode": "string",
            "probability": "string"
          }
        ]
      }
    ],
    "channelTag": "string"
  },
  "eouUpdate": {
    "timeMs": "string"
  },
  "finalRefinement": {
    "finalIndex": "string",
    // Includes only one of the fields `normalizedText`
    "normalizedText": {
      "alternatives": [
        {
          "words": [
            {
              "text": "string",
              "startTimeMs": "string",
              "endTimeMs": "string"
            }
          ],
          "text": "string",
          "startTimeMs": "string",
          "endTimeMs": "string",
          "confidence": "string",
          "languages": [
            {
              "languageCode": "string",
              "probability": "string"
            }
          ]
        }
      ],
      "channelTag": "string"
    }
    // end of the list of possible fields
  },
  "statusCode": {
    "codeType": "string",
    "message": "string"
  },
  "classifierUpdate": {
    "windowType": "string",
    "startTimeMs": "string",
    "endTimeMs": "string",
    "classifierResult": {
      "classifier": "string",
      "highlights": [
        {
          "text": "string",
          "startTimeMs": "string",
          "endTimeMs": "string"
        }
      ],
      "labels": [
        {
          "label": "string",
          "confidence": "string"
        }
      ]
    }
  },
  "speakerAnalysis": {
    "speakerTag": "string",
    "windowType": "string",
    "speechBoundaries": {
      "startTimeMs": "string",
      "endTimeMs": "string"
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
  },
  "conversationAnalysis": {
    "conversationBoundaries": {
      "startTimeMs": "string",
      "endTimeMs": "string"
    },
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
    },
    "speakerInterrupts": [
      {
        "speakerTag": "string",
        "interruptsCount": "string",
        "interruptsDurationMs": "string",
        "interrupts": [
          {
            "startTimeMs": "string",
            "endTimeMs": "string"
          }
        ]
      }
    ],
    "totalSpeechDurationMs": "string",
    "totalSpeechRatio": "string"
  },
  "summarization": {
    "results": [
      {
        "response": "string"
      }
    ],
    "contentUsage": {
      "inputTextTokens": "string",
      "completionTokens": "string",
      "totalTokens": "string"
    }
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
|| responseWallTimeMs | **string** (int64)

Wall clock on server side. This is time when server wrote results to stream ||
|| partial | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Partial results, server will send them regularly after enough audio data was received from user. This are current text estimation
from final_time_ms to partial_time_ms. Could change after new data will arrive.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| final | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| eouUpdate | **[EouUpdate](#speechkit.stt.v3.EouUpdate)**

After EOU classifier, send the message with final, send the EouUpdate with time of EOU
before eou_update we send final with the same time. there could be several finals before eou update.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| finalRefinement | **[FinalRefinement](#speechkit.stt.v3.FinalRefinement)**

For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing).
Final normalization will introduce additional latency.

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| statusCode | **[StatusCode](#speechkit.stt.v3.StatusCode)**

Status messages, send by server with fixed interval (keep-alive).

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| classifierUpdate | **[RecognitionClassifierUpdate](#speechkit.stt.v3.RecognitionClassifierUpdate)**

Result of the triggered classifier

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| speakerAnalysis | **[SpeakerAnalysis](#speechkit.stt.v3.SpeakerAnalysis)**

Speech statistics for every speaker

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| conversationAnalysis | **[ConversationAnalysis](#speechkit.stt.v3.ConversationAnalysis)**

Conversation statistics

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
|| summarization | **[Summarization](#speechkit.stt.v3.Summarization)**

Summary

Includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`, `summarization`. ||
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
|| receivedDataMs | **string** (int64)

Amount of audio chunks server received. This cursor is moved after each audio chunk was received by server. ||
|| resetTimeMs | **string** (int64)

Input stream reset data. ||
|| partialTimeMs | **string** (int64)

How much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data
to update recognition results (includes silence as well). ||
|| finalTimeMs | **string** (int64)

Time of last final. This cursor is moved when server decides that recognition from start of audio until final_time_ms will not change anymore
usually this even is followed by EOU detection (but this could change in future). ||
|| finalIndex | **string** (int64)

This is index of last final server send. Incremented after each new final. ||
|| eouTimeMs | **string** (int64)

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
|| startTimeMs | **string** (int64)

Start of time frame. ||
|| endTimeMs | **string** (int64)

End of time frame. ||
|| confidence | **string**

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
|| startTimeMs | **string** (int64)

Estimation of word start time in ms. ||
|| endTimeMs | **string** (int64)

Estimation of word end time in ms. ||
|#

## LanguageEstimation {#speechkit.stt.v3.LanguageEstimation}

Estimation of language and its probability.

#|
||Field | Description ||
|| languageCode | **string**

Language tag in IETF BCP 47 format, consisting of ISO 639-1 language code and ISO 3166-1 country code (e.g., en-US, ru-RU). ||
|| probability | **string**

Estimation of language probability. ||
|#

## EouUpdate {#speechkit.stt.v3.EouUpdate}

Update information for external End of Utterance.

#|
||Field | Description ||
|| timeMs | **string** (int64)

EOU estimated time. ||
|#

## FinalRefinement {#speechkit.stt.v3.FinalRefinement}

Refinement for final hypo. For example, text normalization is refinement.

#|
||Field | Description ||
|| finalIndex | **string** (int64)

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
|| codeType | **enum** (CodeType)

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
|| windowType | **enum** (WindowType)

Response window type

- `WINDOW_TYPE_UNSPECIFIED`
- `LAST_UTTERANCE`: The result of applying the classifier to the last utterance response
- `LAST_FINAL`: The result of applying the classifier to the last final response
- `LAST_PARTIAL`: The result of applying the classifier to the last partial response ||
|| startTimeMs | **string** (int64)

Start time of the audio segment used for classification ||
|| endTimeMs | **string** (int64)

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
|| startTimeMs | **string** (int64)

Start time of the highlighted audio segment ||
|| endTimeMs | **string** (int64)

End time of the highlighted audio segment ||
|#

## RecognitionClassifierLabel {#speechkit.stt.v3.RecognitionClassifierLabel}

#|
||Field | Description ||
|| label | **string**

The label of the class predicted by the classifier ||
|| confidence | **string**

The prediction confidence ||
|#

## SpeakerAnalysis {#speechkit.stt.v3.SpeakerAnalysis}

#|
||Field | Description ||
|| speakerTag | **string**

Speaker tag ||
|| windowType | **enum** (WindowType)

Response window type

- `WINDOW_TYPE_UNSPECIFIED`
- `TOTAL`: Stats for all received audio.
- `LAST_UTTERANCE`: Stats for last utterance. ||
|| speechBoundaries | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

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
|| wordsPerSecond | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for words per second distribution ||
|| lettersPerSecond | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for letters per second distribution ||
|| wordsPerUtterance | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for words per utterance distribution ||
|| lettersPerUtterance | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for letters per utterance distribution ||
|| utteranceCount | **string** (int64)

Number of utterances ||
|| utteranceDurationEstimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for utterance duration distribution ||
|#

## AudioSegmentBoundaries {#speechkit.stt.v3.AudioSegmentBoundaries}

#|
||Field | Description ||
|| startTimeMs | **string** (int64)

Audio segment start time ||
|| endTimeMs | **string** (int64)

Audio segment end time ||
|#

## DescriptiveStatistics {#speechkit.stt.v3.DescriptiveStatistics}

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
|| quantiles[] | **[Quantile](#speechkit.stt.v3.DescriptiveStatistics.Quantile)**

List of evaluated quantiles ||
|#

## Quantile {#speechkit.stt.v3.DescriptiveStatistics.Quantile}

#|
||Field | Description ||
|| level | **string**

Quantile level in range (0, 1) ||
|| value | **string**

Quantile value ||
|#

## ConversationAnalysis {#speechkit.stt.v3.ConversationAnalysis}

#|
||Field | Description ||
|| conversationBoundaries | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| totalSimultaneousSilenceDurationMs | **string** (int64)

Total simultaneous silence duration ||
|| totalSimultaneousSilenceRatio | **string**

Simultaneous silence ratio within audio segment ||
|| simultaneousSilenceDurationEstimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for simultaneous silence duration distribution ||
|| totalSimultaneousSpeechDurationMs | **string** (int64)

Total simultaneous speech duration ||
|| totalSimultaneousSpeechRatio | **string**

Simultaneous speech ratio within audio segment ||
|| simultaneousSpeechDurationEstimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for simultaneous speech duration distribution ||
|| speakerInterrupts[] | **[InterruptsEvaluation](#speechkit.stt.v3.ConversationAnalysis.InterruptsEvaluation)**

Interrupts description for every speaker ||
|| totalSpeechDurationMs | **string** (int64)

Total speech duration, including both simultaneous and separate speech ||
|| totalSpeechRatio | **string**

Total speech ratio within audio segment ||
|#

## InterruptsEvaluation {#speechkit.stt.v3.ConversationAnalysis.InterruptsEvaluation}

#|
||Field | Description ||
|| speakerTag | **string**

Speaker tag ||
|| interruptsCount | **string** (int64)

Number of interrupts made by the speaker ||
|| interruptsDurationMs | **string** (int64)

Total duration of all interrupts ||
|| interrupts[] | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

Boundaries for every interrupt ||
|#

## Summarization {#speechkit.stt.v3.Summarization}

#|
||Field | Description ||
|| results[] | **[SummarizationPropertyResult](#speechkit.stt.v3.SummarizationPropertyResult)**

A list of summarizations of transcription. ||
|| contentUsage | **[ContentUsage](#speechkit.stt.v3.ContentUsage)**

A set of statistics describing the number of content tokens used by the completion model. ||
|#

## SummarizationPropertyResult {#speechkit.stt.v3.SummarizationPropertyResult}

Represents summarization response entry for transcription.

#|
||Field | Description ||
|| response | **string**

Summarization response text. ||
|#

## ContentUsage {#speechkit.stt.v3.ContentUsage}

An object representing the number of content [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model.

#|
||Field | Description ||
|| inputTextTokens | **string** (int64)

The number of tokens in the textual part of the model input. ||
|| completionTokens | **string** (int64)

The number of tokens in the generated completion. ||
|| totalTokens | **string** (int64)

The total number of tokens, including all input tokens and all generated tokens. ||
|#