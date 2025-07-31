---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/v3/stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md
---

# SpeechKit Recognition API v3, gRPC: Recognizer.RecognizeStreaming

Expects audio in real-time

## gRPC request

**rpc RecognizeStreaming (stream [StreamingRequest](#speechkit.stt.v3.StreamingRequest)) returns (stream [StreamingResponse](#speechkit.stt.v3.StreamingResponse))**

## StreamingRequest {#speechkit.stt.v3.StreamingRequest}

```json
{
  // Includes only one of the fields `session_options`, `chunk`, `silence_chunk`, `eou`
  "session_options": {
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
    "eou_classifier": {
      // Includes only one of the fields `default_classifier`, `external_classifier`
      "default_classifier": {
        "type": "EouSensitivity",
        "max_pause_between_words_hint_ms": "int64"
      },
      "external_classifier": "ExternalEouClassifier"
      // end of the list of possible fields
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
    },
    "summarization": {
      "model_uri": "string",
      "properties": [
        {
          "instruction": "string",
          // Includes only one of the fields `json_object`, `json_schema`
          "json_object": "bool",
          "json_schema": {
            "schema": "google.protobuf.Struct"
          }
          // end of the list of possible fields
        }
      ]
    }
  },
  "chunk": {
    "data": "bytes"
  },
  "silence_chunk": {
    "duration_ms": "int64"
  },
  "eou": "Eou"
  // end of the list of possible fields
}
```

Streaming audio request
Events are control messages from user.
First message should be session options.
The next messages are audio data chunks or control messages.

#|
||Field | Description ||
|| session_options | **[StreamingOptions](#speechkit.stt.v3.StreamingOptions)**

Session options. Should be the first message from user.

Includes only one of the fields `session_options`, `chunk`, `silence_chunk`, `eou`. ||
|| chunk | **[AudioChunk](#speechkit.stt.v3.AudioChunk)**

Chunk with audio data.

Includes only one of the fields `session_options`, `chunk`, `silence_chunk`, `eou`. ||
|| silence_chunk | **[SilenceChunk](#speechkit.stt.v3.SilenceChunk)**

Chunk with silence.

Includes only one of the fields `session_options`, `chunk`, `silence_chunk`, `eou`. ||
|| eou | **[Eou](#speechkit.stt.v3.Eou)**

Request to end current utterance. Works only with external EOU detector.

Includes only one of the fields `session_options`, `chunk`, `silence_chunk`, `eou`. ||
|#

## StreamingOptions {#speechkit.stt.v3.StreamingOptions}

#|
||Field | Description ||
|| recognition_model | **[RecognitionModelOptions](#speechkit.stt.v3.RecognitionModelOptions)**

Configuration for speech recognition model. ||
|| eou_classifier | **[EouClassifierOptions](#speechkit.stt.v3.EouClassifierOptions)**

Configuration for end of utterance detection model. ||
|| recognition_classifier | **[RecognitionClassifierOptions](#speechkit.stt.v3.RecognitionClassifierOptions)**

Configuration for classifiers over speech recognition. ||
|| speech_analysis | **[SpeechAnalysisOptions](#speechkit.stt.v3.SpeechAnalysisOptions)**

Configuration for speech analysis over speech recognition. ||
|| speaker_labeling | **[SpeakerLabelingOptions](#speechkit.stt.v3.SpeakerLabelingOptions)**

Configuration for speaker labeling ||
|| summarization | **[SummarizationOptions](#speechkit.stt.v3.SummarizationOptions)**

Summarization options ||
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

## EouClassifierOptions {#speechkit.stt.v3.EouClassifierOptions}

#|
||Field | Description ||
|| default_classifier | **[DefaultEouClassifier](#speechkit.stt.v3.DefaultEouClassifier)**

EOU classifier provided by SpeechKit. Default.

Includes only one of the fields `default_classifier`, `external_classifier`.

Type of EOU classifier. ||
|| external_classifier | **[ExternalEouClassifier](#speechkit.stt.v3.ExternalEouClassifier)**

EOU is enforced by external messages from user.

Includes only one of the fields `default_classifier`, `external_classifier`.

Type of EOU classifier. ||
|#

## DefaultEouClassifier {#speechkit.stt.v3.DefaultEouClassifier}

#|
||Field | Description ||
|| type | enum **EouSensitivity**

EOU sensitivity. Currently two levels, faster with more error and more conservative (our default).

- `EOU_SENSITIVITY_UNSPECIFIED`
- `DEFAULT`
- `HIGH` ||
|| max_pause_between_words_hint_ms | **int64**

Hint for max pause between words. Our EOU detector could use this information to distinguish between end of utterance and slow speech (like one <long pause> two <long pause> three, etc). ||
|#

## ExternalEouClassifier {#speechkit.stt.v3.ExternalEouClassifier}

Use EOU provided by user

#|
||Field | Description ||
|| Empty | > ||
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

## SummarizationOptions {#speechkit.stt.v3.SummarizationOptions}

Represents transcription summarization options.

#|
||Field | Description ||
|| model_uri | **string**

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
|| json_object | **bool**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `json_object`, `json_schema`.

Specifies the format of the model's response. ||
|| json_schema | **[JsonSchema](#speechkit.stt.v3.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `json_object`, `json_schema`.

Specifies the format of the model's response. ||
|#

## JsonSchema {#speechkit.stt.v3.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The JSON Schema that the model's output must conform to. ||
|#

## AudioChunk {#speechkit.stt.v3.AudioChunk}

Data chunk with audio.

#|
||Field | Description ||
|| data | **bytes**

Bytes with audio data. ||
|#

## SilenceChunk {#speechkit.stt.v3.SilenceChunk}

Data chunk with silence.

#|
||Field | Description ||
|| duration_ms | **int64**

Duration of silence chunk in ms. ||
|#

## Eou {#speechkit.stt.v3.Eou}

Force EOU

#|
||Field | Description ||
|| Empty | > ||
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