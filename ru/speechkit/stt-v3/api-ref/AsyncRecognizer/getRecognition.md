---
editable: false
sourcePath: en/_api-ref/ai/stt/v3/stt-v3/api-ref/AsyncRecognizer/getRecognition.md
---

# SpeechKit Recognition API v3, REST: AsyncRecognizer.getRecognition

 

 
## HTTP request {#https-request}
```
GET https://stt.{{ api-host }}/stt/v3/getRecognition
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
operationId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
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
  "channelTag": "string",

  //  includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`
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
        "confidence": "number",
        "languages": [
          {
            "languageCode": "string",
            "probability": "number"
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
        "confidence": "number",
        "languages": [
          {
            "languageCode": "string",
            "probability": "number"
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
          "confidence": "number",
          "languages": [
            {
              "languageCode": "string",
              "probability": "number"
            }
          ]
        }
      ],
      "channelTag": "string"
    }
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
          "confidence": "number"
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
    "speechRatio": "number",
    "totalSilenceMs": "string",
    "silenceRatio": "number",
    "wordsCount": "string",
    "lettersCount": "string",
    "wordsPerSecond": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
        }
      ]
    },
    "lettersPerSecond": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
        }
      ]
    },
    "wordsPerUtterance": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
        }
      ]
    },
    "lettersPerUtterance": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
        }
      ]
    },
    "utteranceCount": "string",
    "utteranceDurationEstimation": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
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
    "totalSimultaneousSilenceRatio": "number",
    "simultaneousSilenceDurationEstimation": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
        }
      ]
    },
    "totalSimultaneousSpeechDurationMs": "string",
    "totalSimultaneousSpeechRatio": "number",
    "simultaneousSpeechDurationEstimation": {
      "min": "number",
      "max": "number",
      "mean": "number",
      "std": "number",
      "quantiles": [
        {
          "level": "number",
          "value": "number"
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
    "totalSpeechRatio": "number"
  },
  // end of the list of possible fields

}
```
Responses from server.
Each response contains session uuid
AudioCursors
plus specific event
 
Field | Description
--- | ---
sessionUuid | **object**<br>Session identifier
sessionUuid.<br>uuid | **string**<br><p>Internal session identifier.</p> 
sessionUuid.<br>userRequestId | **string**<br><p>User session identifier.</p> 
audioCursors | **object**<br>Progress bar for stream session recognition: how many data we obtained; final and partial times; etc.
audioCursors.<br>receivedDataMs | **string** (int64)<br><p>Amount of audio chunks server received. This cursor is moved after each audio chunk was received by server.</p> 
audioCursors.<br>resetTimeMs | **string** (int64)<br><p>Input stream reset data.</p> 
audioCursors.<br>partialTimeMs | **string** (int64)<br><p>How much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data to update recognition results (includes silence as well).</p> 
audioCursors.<br>finalTimeMs | **string** (int64)<br><p>Time of last final. This cursor is moved when server decides that recognition from start of audio until final_time_ms will not change anymore usually this even is followed by EOU detection (but this could change in future).</p> 
audioCursors.<br>finalIndex | **string** (int64)<br><p>This is index of last final server send. Incremented after each new final.</p> 
audioCursors.<br>eouTimeMs | **string** (int64)<br><p>Estimated time of EOU. Cursor is updated after each new EOU is sent. For external classifier this equals to received_data_ms at the moment EOU event arrives. For internal classifier this is estimation of time. The time is not exact and has the same guarantees as word timings.</p> 
responseWallTimeMs | **string** (int64)<br><p>Wall clock on server side. This is time when server wrote results to stream</p> 
channelTag | **string**<br><p>Tag for distinguish audio channels.</p> 
partial | **object**<br>Partial results, server will send them regularly after enough audio data was received from user. This are current text estimation from final_time_ms to partial_time_ms. Could change after new data will arrive. <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
partial.<br>alternatives[] | **object**<br><p>List of hypothesis for timeframes.</p> 
partial.<br>alternatives[].<br>words[] | **object**<br><p>Words in time frame.</p> 
partial.<br>alternatives[].<br>words[].<br>text | **string**<br><p>Word text.</p> 
partial.<br>alternatives[].<br>words[].<br>startTimeMs | **string** (int64)<br><p>Estimation of word start time in ms.</p> 
partial.<br>alternatives[].<br>words[].<br>endTimeMs | **string** (int64)<br><p>Estimation of word end time in ms.</p> 
partial.<br>alternatives[].<br>text | **string**<br><p>Text in time frame.</p> 
partial.<br>alternatives[].<br>startTimeMs | **string** (int64)<br><p>Start of time frame.</p> 
partial.<br>alternatives[].<br>endTimeMs | **string** (int64)<br><p>End of time frame.</p> 
partial.<br>alternatives[].<br>confidence | **number** (double)<br><p>The hypothesis confidence. Currently is not used.</p> 
partial.<br>alternatives[].<br>languages[] | **object**<br><p>Distribution over possible languages.</p> 
partial.<br>alternatives[].<br>languages[].<br>languageCode | **string**<br><p>Language code in ISO 639-1 format.</p> 
partial.<br>alternatives[].<br>languages[].<br>probability | **number** (double)<br><p>Estimation of language probability.</p> 
partial.<br>channelTag | **string**
final | **object**<br>Final results, the recognition is now fixed until final_time_ms. For now, final is sent only if the EOU event was triggered. This could be change in future releases. <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
final.<br>alternatives[] | **object**<br><p>List of hypothesis for timeframes.</p> 
final.<br>alternatives[].<br>words[] | **object**<br><p>Words in time frame.</p> 
final.<br>alternatives[].<br>words[].<br>text | **string**<br><p>Word text.</p> 
final.<br>alternatives[].<br>words[].<br>startTimeMs | **string** (int64)<br><p>Estimation of word start time in ms.</p> 
final.<br>alternatives[].<br>words[].<br>endTimeMs | **string** (int64)<br><p>Estimation of word end time in ms.</p> 
final.<br>alternatives[].<br>text | **string**<br><p>Text in time frame.</p> 
final.<br>alternatives[].<br>startTimeMs | **string** (int64)<br><p>Start of time frame.</p> 
final.<br>alternatives[].<br>endTimeMs | **string** (int64)<br><p>End of time frame.</p> 
final.<br>alternatives[].<br>confidence | **number** (double)<br><p>The hypothesis confidence. Currently is not used.</p> 
final.<br>alternatives[].<br>languages[] | **object**<br><p>Distribution over possible languages.</p> 
final.<br>alternatives[].<br>languages[].<br>languageCode | **string**<br><p>Language code in ISO 639-1 format.</p> 
final.<br>alternatives[].<br>languages[].<br>probability | **number** (double)<br><p>Estimation of language probability.</p> 
final.<br>channelTag | **string**
eouUpdate | **object**<br>After EOU classifier, send the message with final, send the EouUpdate with time of EOU before eou_update we send final with the same time. there could be several finals before eou update. <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
eouUpdate.<br>timeMs | **string** (int64)<br><p>EOU estimated time.</p> 
finalRefinement | **object**<br>For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing). Final normalization will introduce additional latency. <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
finalRefinement.<br>finalIndex | **string** (int64)<br><p>Index of final for which server sends additional information.</p> 
finalRefinement.<br>normalizedText | **object**<br>Normalized text instead of raw one.
finalRefinement.<br>normalizedText.<br>alternatives[] | **object**<br><p>List of hypothesis for timeframes.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>words[] | **object**<br><p>Words in time frame.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>words[].<br>text | **string**<br><p>Word text.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>words[].<br>startTimeMs | **string** (int64)<br><p>Estimation of word start time in ms.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>words[].<br>endTimeMs | **string** (int64)<br><p>Estimation of word end time in ms.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>text | **string**<br><p>Text in time frame.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>startTimeMs | **string** (int64)<br><p>Start of time frame.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>endTimeMs | **string** (int64)<br><p>End of time frame.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>confidence | **number** (double)<br><p>The hypothesis confidence. Currently is not used.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>languages[] | **object**<br><p>Distribution over possible languages.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>languages[].<br>languageCode | **string**<br><p>Language code in ISO 639-1 format.</p> 
finalRefinement.<br>normalizedText.<br>alternatives[].<br>languages[].<br>probability | **number** (double)<br><p>Estimation of language probability.</p> 
finalRefinement.<br>normalizedText.<br>channelTag | **string**
statusCode | **object**<br>Status messages, send by server with fixed interval (keep-alive). <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
statusCode.<br>codeType | **string**<br><p>Code type.</p> <ul> <li>WORKING: All good.</li> <li>WARNING: For example, if speech is sent not in real time or context is unknown and we've made fallback.</li> <li>CLOSED: After session was closed.</li> </ul> 
statusCode.<br>message | **string**<br><p>Human readable message.</p> 
classifierUpdate | **object**<br>Result of the triggered classifier <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
classifierUpdate.<br>windowType | **string**<br><p>Response window type</p> <ul> <li>LAST_UTTERANCE: The result of applying the classifier to the last utterance response</li> <li>LAST_FINAL: The result of applying the classifier to the last final response</li> <li>LAST_PARTIAL: The result of applying the classifier to the last partial response</li> </ul> 
classifierUpdate.<br>startTimeMs | **string** (int64)<br><p>Start time of the audio segment used for classification</p> 
classifierUpdate.<br>endTimeMs | **string** (int64)<br><p>End time of the audio segment used for classification</p> 
classifierUpdate.<br>classifierResult | **object**<br><p>Result for dictionary-based classifier</p> 
classifierUpdate.<br>classifierResult.<br>classifier | **string**<br><p>Name of the triggered classifier</p> 
classifierUpdate.<br>classifierResult.<br>highlights[] | **object**<br><p>List of highlights, i.e. parts of phrase that determine the result of the classification</p> 
classifierUpdate.<br>classifierResult.<br>highlights[].<br>text | **string**<br><p>Text transcription of the highlighted audio segment</p> 
classifierUpdate.<br>classifierResult.<br>highlights[].<br>startTimeMs | **string** (int64)<br><p>Start time of the highlighted audio segment</p> 
classifierUpdate.<br>classifierResult.<br>highlights[].<br>endTimeMs | **string** (int64)<br><p>End time of the highlighted audio segment</p> 
classifierUpdate.<br>classifierResult.<br>labels[] | **object**<br><p>Classifier predictions</p> 
classifierUpdate.<br>classifierResult.<br>labels[].<br>label | **string**<br><p>The label of the class predicted by the classifier</p> 
classifierUpdate.<br>classifierResult.<br>labels[].<br>confidence | **number** (double)<br><p>The prediction confidence</p> 
speakerAnalysis | **object**<br>Speech statistics for every speaker <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
speakerAnalysis.<br>speakerTag | **string**<br><p>Speaker tag</p> 
speakerAnalysis.<br>windowType | **string**<br><p>Response window type</p> <ul> <li>TOTAL: Stats for all received audio.</li> <li>LAST_UTTERANCE: Stats for last utterance.</li> </ul> 
speakerAnalysis.<br>speechBoundaries | **object**<br><p>Audio segment boundaries</p> 
speakerAnalysis.<br>speechBoundaries.<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
speakerAnalysis.<br>speechBoundaries.<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
speakerAnalysis.<br>totalSpeechMs | **string** (int64)<br><p>Total speech duration</p> 
speakerAnalysis.<br>speechRatio | **number** (double)<br><p>Speech ratio within audio segment</p> 
speakerAnalysis.<br>totalSilenceMs | **string** (int64)<br><p>Total silence duration</p> 
speakerAnalysis.<br>silenceRatio | **number** (double)<br><p>Silence ratio within audio segment</p> 
speakerAnalysis.<br>wordsCount | **string** (int64)<br><p>Number of words in recognized speech</p> 
speakerAnalysis.<br>lettersCount | **string** (int64)<br><p>Number of letters in recognized speech</p> 
speakerAnalysis.<br>wordsPerSecond | **object**<br><p>Descriptive statistics for words per second distribution</p> 
speakerAnalysis.<br>wordsPerSecond.<br>min | **number** (double)<br><p>Minimum observed value</p> 
speakerAnalysis.<br>wordsPerSecond.<br>max | **number** (double)<br><p>Maximum observed value</p> 
speakerAnalysis.<br>wordsPerSecond.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
speakerAnalysis.<br>wordsPerSecond.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
speakerAnalysis.<br>wordsPerSecond.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
speakerAnalysis.<br>wordsPerSecond.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
speakerAnalysis.<br>wordsPerSecond.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
speakerAnalysis.<br>lettersPerSecond | **object**<br><p>Descriptive statistics for letters per second distribution</p> 
speakerAnalysis.<br>lettersPerSecond.<br>min | **number** (double)<br><p>Minimum observed value</p> 
speakerAnalysis.<br>lettersPerSecond.<br>max | **number** (double)<br><p>Maximum observed value</p> 
speakerAnalysis.<br>lettersPerSecond.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
speakerAnalysis.<br>lettersPerSecond.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
speakerAnalysis.<br>lettersPerSecond.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
speakerAnalysis.<br>lettersPerSecond.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
speakerAnalysis.<br>lettersPerSecond.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
speakerAnalysis.<br>wordsPerUtterance | **object**<br><p>Descriptive statistics for words per utterance distribution</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>min | **number** (double)<br><p>Minimum observed value</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>max | **number** (double)<br><p>Maximum observed value</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
speakerAnalysis.<br>wordsPerUtterance.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
speakerAnalysis.<br>lettersPerUtterance | **object**<br><p>Descriptive statistics for letters per utterance distribution</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>min | **number** (double)<br><p>Minimum observed value</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>max | **number** (double)<br><p>Maximum observed value</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
speakerAnalysis.<br>lettersPerUtterance.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
speakerAnalysis.<br>utteranceCount | **string** (int64)<br><p>Number of utterances</p> 
speakerAnalysis.<br>utteranceDurationEstimation | **object**<br><p>Descriptive statistics for utterance duration distribution</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>min | **number** (double)<br><p>Minimum observed value</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>max | **number** (double)<br><p>Maximum observed value</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
speakerAnalysis.<br>utteranceDurationEstimation.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
conversationAnalysis | **object**<br>Conversation statistics <br> includes only one of the fields `partial`, `final`, `eouUpdate`, `finalRefinement`, `statusCode`, `classifierUpdate`, `speakerAnalysis`, `conversationAnalysis`<br>
conversationAnalysis.<br>conversationBoundaries | **object**<br><p>Audio segment boundaries</p> 
conversationAnalysis.<br>conversationBoundaries.<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
conversationAnalysis.<br>conversationBoundaries.<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
conversationAnalysis.<br>totalSimultaneousSilenceDurationMs | **string** (int64)<br><p>Total simultaneous silence duration</p> 
conversationAnalysis.<br>totalSimultaneousSilenceRatio | **number** (double)<br><p>Simultaneous silence ratio within audio segment</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation | **object**<br><p>Descriptive statistics for simultaneous silence duration distribution</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>min | **number** (double)<br><p>Minimum observed value</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>max | **number** (double)<br><p>Maximum observed value</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
conversationAnalysis.<br>simultaneousSilenceDurationEstimation.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
conversationAnalysis.<br>totalSimultaneousSpeechDurationMs | **string** (int64)<br><p>Total simultaneous speech duration</p> 
conversationAnalysis.<br>totalSimultaneousSpeechRatio | **number** (double)<br><p>Simultaneous speech ratio within audio segment</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation | **object**<br><p>Descriptive statistics for simultaneous speech duration distribution</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>min | **number** (double)<br><p>Minimum observed value</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>max | **number** (double)<br><p>Maximum observed value</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
conversationAnalysis.<br>simultaneousSpeechDurationEstimation.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
conversationAnalysis.<br>speakerInterrupts[] | **object**<br><p>Interrupts description for every speaker</p> 
conversationAnalysis.<br>speakerInterrupts[].<br>speakerTag | **string**<br><p>Speaker tag</p> 
conversationAnalysis.<br>speakerInterrupts[].<br>interruptsCount | **string** (int64)<br><p>Number of interrupts made by the speaker</p> 
conversationAnalysis.<br>speakerInterrupts[].<br>interruptsDurationMs | **string** (int64)<br><p>Total duration of all interrupts</p> 
conversationAnalysis.<br>speakerInterrupts[].<br>interrupts[] | **object**<br><p>Boundaries for every interrupt</p> 
conversationAnalysis.<br>speakerInterrupts[].<br>interrupts[].<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
conversationAnalysis.<br>speakerInterrupts[].<br>interrupts[].<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
conversationAnalysis.<br>totalSpeechDurationMs | **string** (int64)<br><p>Total speech duration, including both simultaneous and separate speech</p> 
conversationAnalysis.<br>totalSpeechRatio | **number** (double)<br><p>Total speech ratio within audio segment</p> 