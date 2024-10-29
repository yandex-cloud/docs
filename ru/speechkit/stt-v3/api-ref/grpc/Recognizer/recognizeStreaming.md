---
editable: false
sourcePath: en/_api-ref-grpc/ai/stt/v3/stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md
---

# SpeechKit Recognition API v3, gRPC: Recognizer.RecognizeStreaming {#RecognizeStreaming}

Expects audio in real-time

## gRPC request

**rpc RecognizeStreaming (stream [StreamingRequest](#speechkit.stt.v3.StreamingRequest)) returns (stream [StreamingResponse](#speechkit.stt.v3.StreamingResponse))**

## StreamingRequest {#speechkit.stt.v3.StreamingRequest}

```json
{
  // Includes only one of the fields `sessionOptions`, `chunk`, `silenceChunk`, `eou`
  "sessionOptions": {
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
    "eouClassifier": {
      // Includes only one of the fields `defaultClassifier`, `externalClassifier`
      "defaultClassifier": {
        "type": "EouSensitivity",
        "maxPauseBetweenWordsHintMs": "int64"
      },
      "externalClassifier": "ExternalEouClassifier"
      // end of the list of possible fields
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
  },
  "chunk": {
    "data": "bytes"
  },
  "silenceChunk": {
    "durationMs": "int64"
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
|| sessionOptions | **[StreamingOptions](#speechkit.stt.v3.StreamingOptions)**

Session options. Should be the first message from user.

Includes only one of the fields `sessionOptions`, `chunk`, `silenceChunk`, `eou`. ||
|| chunk | **[AudioChunk](#speechkit.stt.v3.AudioChunk)**

Chunk with audio data.

Includes only one of the fields `sessionOptions`, `chunk`, `silenceChunk`, `eou`. ||
|| silenceChunk | **[SilenceChunk](#speechkit.stt.v3.SilenceChunk)**

Chunk with silence.

Includes only one of the fields `sessionOptions`, `chunk`, `silenceChunk`, `eou`. ||
|| eou | **[Eou](#speechkit.stt.v3.Eou)**

Request to end current utterance. Works only with external EOU detector.

Includes only one of the fields `sessionOptions`, `chunk`, `silenceChunk`, `eou`. ||
|#

## StreamingOptions {#speechkit.stt.v3.StreamingOptions}

#|
||Field | Description ||
|| recognitionModel | **[RecognitionModelOptions](#speechkit.stt.v3.RecognitionModelOptions)**

Configuration for speech recognition model. ||
|| eouClassifier | **[EouClassifierOptions](#speechkit.stt.v3.EouClassifierOptions)**

Configuration for end of utterance detection model. ||
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

## EouClassifierOptions {#speechkit.stt.v3.EouClassifierOptions}

#|
||Field | Description ||
|| defaultClassifier | **[DefaultEouClassifier](#speechkit.stt.v3.DefaultEouClassifier)**

EOU classifier provided by SpeechKit. Default.

Includes only one of the fields `defaultClassifier`, `externalClassifier`.

Type of EOU classifier. ||
|| externalClassifier | **[ExternalEouClassifier](#speechkit.stt.v3.ExternalEouClassifier)**

EOU is enforced by external messages from user.

Includes only one of the fields `defaultClassifier`, `externalClassifier`.

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
|| maxPauseBetweenWordsHintMs | **int64**

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
|| durationMs | **int64**

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