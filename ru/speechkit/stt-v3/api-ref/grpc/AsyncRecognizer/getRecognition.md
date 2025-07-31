---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/v3/stt-v3/api-ref/grpc/AsyncRecognizer/getRecognition.md
---

# SpeechKit Recognition API v3, gRPC: AsyncRecognizer.GetRecognition

## gRPC request

**rpc GetRecognition ([GetRecognitionRequest](#speechkit.stt.v3.GetRecognitionRequest)) returns (stream [StreamingResponse](#speechkit.stt.v3.StreamingResponse))**

## GetRecognitionRequest {#speechkit.stt.v3.GetRecognitionRequest}

```json
{
  "operation_id": "string"
}
```

#|
||Field | Description ||
|| operation_id | **string** ||
|#

## StreamingResponse {#speechkit.stt.v3.StreamingResponse}

```json
{
  "session_uuid": {
    "uuid": "string",
    "user_request_id": "string"
  },
  "audio_cursors": {
    "received_data_ms": "int64",
    "reset_time_ms": "int64",
    "partial_time_ms": "int64",
    "final_time_ms": "int64",
    "final_index": "int64",
    "eou_time_ms": "int64"
  },
  "response_wall_time_ms": "int64",
  // Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`
  "partial": {
    "alternatives": [
      {
        "words": [
          {
            "text": "string",
            "start_time_ms": "int64",
            "end_time_ms": "int64"
          }
        ],
        "text": "string",
        "start_time_ms": "int64",
        "end_time_ms": "int64",
        "confidence": "double",
        "languages": [
          {
            "language_code": "string",
            "probability": "double"
          }
        ]
      }
    ],
    "channel_tag": "string"
  },
  "final": {
    "alternatives": [
      {
        "words": [
          {
            "text": "string",
            "start_time_ms": "int64",
            "end_time_ms": "int64"
          }
        ],
        "text": "string",
        "start_time_ms": "int64",
        "end_time_ms": "int64",
        "confidence": "double",
        "languages": [
          {
            "language_code": "string",
            "probability": "double"
          }
        ]
      }
    ],
    "channel_tag": "string"
  },
  "eou_update": {
    "time_ms": "int64"
  },
  "final_refinement": {
    "final_index": "int64",
    // Includes only one of the fields `normalized_text`
    "normalized_text": {
      "alternatives": [
        {
          "words": [
            {
              "text": "string",
              "start_time_ms": "int64",
              "end_time_ms": "int64"
            }
          ],
          "text": "string",
          "start_time_ms": "int64",
          "end_time_ms": "int64",
          "confidence": "double",
          "languages": [
            {
              "language_code": "string",
              "probability": "double"
            }
          ]
        }
      ],
      "channel_tag": "string"
    }
    // end of the list of possible fields
  },
  "status_code": {
    "code_type": "CodeType",
    "message": "string"
  },
  "classifier_update": {
    "window_type": "WindowType",
    "start_time_ms": "int64",
    "end_time_ms": "int64",
    "classifier_result": {
      "classifier": "string",
      "highlights": [
        {
          "text": "string",
          "start_time_ms": "int64",
          "end_time_ms": "int64"
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
  "speaker_analysis": {
    "speaker_tag": "string",
    "window_type": "WindowType",
    "speech_boundaries": {
      "start_time_ms": "int64",
      "end_time_ms": "int64"
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
  },
  "conversation_analysis": {
    "conversation_boundaries": {
      "start_time_ms": "int64",
      "end_time_ms": "int64"
    },
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
    },
    "speaker_interrupts": [
      {
        "speaker_tag": "string",
        "interrupts_count": "int64",
        "interrupts_duration_ms": "int64",
        "interrupts": [
          {
            "start_time_ms": "int64",
            "end_time_ms": "int64"
          }
        ]
      }
    ],
    "total_speech_duration_ms": "int64",
    "total_speech_ratio": "double"
  },
  "summarization": {
    "results": [
      {
        "response": "string"
      }
    ],
    "content_usage": {
      "input_text_tokens": "int64",
      "completion_tokens": "int64",
      "total_tokens": "int64"
    }
  },
  // end of the list of possible fields
  "channel_tag": "string"
}
```

Responses from server.
Each response contains session uuid
AudioCursors
plus specific event

#|
||Field | Description ||
|| session_uuid | **[SessionUuid](#speechkit.stt.v3.SessionUuid)**

Session identifier ||
|| audio_cursors | **[AudioCursors](#speechkit.stt.v3.AudioCursors)**

Progress bar for stream session recognition: how many data we obtained; final and partial times; etc. ||
|| response_wall_time_ms | **int64**

Wall clock on server side. This is time when server wrote results to stream ||
|| partial | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Partial results, server will send them regularly after enough audio data was received from user. This are current text estimation
from final_time_ms to partial_time_ms. Could change after new data will arrive.

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| final | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases.

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| eou_update | **[EouUpdate](#speechkit.stt.v3.EouUpdate)**

After EOU classifier, send the message with final, send the EouUpdate with time of EOU
before eou_update we send final with the same time. there could be several finals before eou update.

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| final_refinement | **[FinalRefinement](#speechkit.stt.v3.FinalRefinement)**

For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing).
Final normalization will introduce additional latency.

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| status_code | **[StatusCode](#speechkit.stt.v3.StatusCode)**

Status messages, send by server with fixed interval (keep-alive).

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| classifier_update | **[RecognitionClassifierUpdate](#speechkit.stt.v3.RecognitionClassifierUpdate)**

Result of the triggered classifier

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| speaker_analysis | **[SpeakerAnalysis](#speechkit.stt.v3.SpeakerAnalysis)**

Speech statistics for every speaker

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| conversation_analysis | **[ConversationAnalysis](#speechkit.stt.v3.ConversationAnalysis)**

Conversation statistics

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| summarization | **[Summarization](#speechkit.stt.v3.Summarization)**

Summary

Includes only one of the fields `partial`, `final`, `eou_update`, `final_refinement`, `status_code`, `classifier_update`, `speaker_analysis`, `conversation_analysis`, `summarization`. ||
|| channel_tag | **string**

Tag for distinguish audio channels. ||
|#

## SessionUuid {#speechkit.stt.v3.SessionUuid}

Session identifier.

#|
||Field | Description ||
|| uuid | **string**

Internal session identifier. ||
|| user_request_id | **string**

User session identifier. ||
|#

## AudioCursors {#speechkit.stt.v3.AudioCursors}

AudioCursors are state of ASR recognition stream.

#|
||Field | Description ||
|| received_data_ms | **int64**

Amount of audio chunks server received. This cursor is moved after each audio chunk was received by server. ||
|| reset_time_ms | **int64**

Input stream reset data. ||
|| partial_time_ms | **int64**

How much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data
to update recognition results (includes silence as well). ||
|| final_time_ms | **int64**

Time of last final. This cursor is moved when server decides that recognition from start of audio until final_time_ms will not change anymore
usually this even is followed by EOU detection (but this could change in future). ||
|| final_index | **int64**

This is index of last final server send. Incremented after each new final. ||
|| eou_time_ms | **int64**

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
|| channel_tag | **string** ||
|#

## Alternative {#speechkit.stt.v3.Alternative}

Recognition of specific time frame.

#|
||Field | Description ||
|| words[] | **[Word](#speechkit.stt.v3.Word)**

Words in time frame. ||
|| text | **string**

Text in time frame. ||
|| start_time_ms | **int64**

Start of time frame. ||
|| end_time_ms | **int64**

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
|| start_time_ms | **int64**

Estimation of word start time in ms. ||
|| end_time_ms | **int64**

Estimation of word end time in ms. ||
|#

## LanguageEstimation {#speechkit.stt.v3.LanguageEstimation}

Estimation of language and its probability.

#|
||Field | Description ||
|| language_code | **string**

Language tag in IETF BCP 47 format, consisting of ISO 639-1 language code and ISO 3166-1 country code (e.g., en-US, ru-RU). ||
|| probability | **double**

Estimation of language probability. ||
|#

## EouUpdate {#speechkit.stt.v3.EouUpdate}

Update information for external End of Utterance.

#|
||Field | Description ||
|| time_ms | **int64**

EOU estimated time. ||
|#

## FinalRefinement {#speechkit.stt.v3.FinalRefinement}

Refinement for final hypo. For example, text normalization is refinement.

#|
||Field | Description ||
|| final_index | **int64**

Index of final for which server sends additional information. ||
|| normalized_text | **[AlternativeUpdate](#speechkit.stt.v3.AlternativeUpdate)**

Normalized text instead of raw one.

Includes only one of the fields `normalized_text`.

Type of refinement. ||
|#

## StatusCode {#speechkit.stt.v3.StatusCode}

Status message

#|
||Field | Description ||
|| code_type | enum **CodeType**

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
|| window_type | enum **WindowType**

Response window type

- `WINDOW_TYPE_UNSPECIFIED`
- `LAST_UTTERANCE`: The result of applying the classifier to the last utterance response
- `LAST_FINAL`: The result of applying the classifier to the last final response
- `LAST_PARTIAL`: The result of applying the classifier to the last partial response ||
|| start_time_ms | **int64**

Start time of the audio segment used for classification ||
|| end_time_ms | **int64**

End time of the audio segment used for classification ||
|| classifier_result | **[RecognitionClassifierResult](#speechkit.stt.v3.RecognitionClassifierResult)**

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
|| start_time_ms | **int64**

Start time of the highlighted audio segment ||
|| end_time_ms | **int64**

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
|| speaker_tag | **string**

Speaker tag ||
|| window_type | enum **WindowType**

Response window type

- `WINDOW_TYPE_UNSPECIFIED`
- `TOTAL`: Stats for all received audio.
- `LAST_UTTERANCE`: Stats for last utterance. ||
|| speech_boundaries | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

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
|| words_per_second | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for words per second distribution ||
|| letters_per_second | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for letters per second distribution ||
|| words_per_utterance | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for words per utterance distribution ||
|| letters_per_utterance | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for letters per utterance distribution ||
|| utterance_count | **int64**

Number of utterances ||
|| utterance_duration_estimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for utterance duration distribution ||
|#

## AudioSegmentBoundaries {#speechkit.stt.v3.AudioSegmentBoundaries}

#|
||Field | Description ||
|| start_time_ms | **int64**

Audio segment start time ||
|| end_time_ms | **int64**

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
|| conversation_boundaries | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

Audio segment boundaries ||
|| total_simultaneous_silence_duration_ms | **int64**

Total simultaneous silence duration ||
|| total_simultaneous_silence_ratio | **double**

Simultaneous silence ratio within audio segment ||
|| simultaneous_silence_duration_estimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for simultaneous silence duration distribution ||
|| total_simultaneous_speech_duration_ms | **int64**

Total simultaneous speech duration ||
|| total_simultaneous_speech_ratio | **double**

Simultaneous speech ratio within audio segment ||
|| simultaneous_speech_duration_estimation | **[DescriptiveStatistics](#speechkit.stt.v3.DescriptiveStatistics)**

Descriptive statistics for simultaneous speech duration distribution ||
|| speaker_interrupts[] | **[InterruptsEvaluation](#speechkit.stt.v3.ConversationAnalysis.InterruptsEvaluation)**

Interrupts description for every speaker ||
|| total_speech_duration_ms | **int64**

Total speech duration, including both simultaneous and separate speech ||
|| total_speech_ratio | **double**

Total speech ratio within audio segment ||
|#

## InterruptsEvaluation {#speechkit.stt.v3.ConversationAnalysis.InterruptsEvaluation}

#|
||Field | Description ||
|| speaker_tag | **string**

Speaker tag ||
|| interrupts_count | **int64**

Number of interrupts made by the speaker ||
|| interrupts_duration_ms | **int64**

Total duration of all interrupts ||
|| interrupts[] | **[AudioSegmentBoundaries](#speechkit.stt.v3.AudioSegmentBoundaries)**

Boundaries for every interrupt ||
|#

## Summarization {#speechkit.stt.v3.Summarization}

#|
||Field | Description ||
|| results[] | **[SummarizationPropertyResult](#speechkit.stt.v3.SummarizationPropertyResult)**

A list of summarizations of transcription. ||
|| content_usage | **[ContentUsage](#speechkit.stt.v3.ContentUsage)**

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
|| input_text_tokens | **int64**

The number of tokens in the textual part of the model input. ||
|| completion_tokens | **int64**

The number of tokens in the generated completion. ||
|| total_tokens | **int64**

The total number of tokens, including all input tokens and all generated tokens. ||
|#