---
editable: false
sourcePath: en/_api-ref/speechsense/v1/api-ref/Talk/get.md
---

# Talk Analytics API, REST: Talk.get
rpc for bulk get
 

 
## HTTP request {#https-request}
```
POST https://speechsense.{{ api-host }}/speechsense/v1/talks/bulkGet
```
 
## Body parameters {#body_params}
 
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

 
Field | Description
--- | ---
organizationId | **string**<br><p>id of organization</p> 
spaceId | **string**<br><p>id of space</p> 
connectionId | **string**<br><p>id of connection to search data</p> 
projectId | **string**<br><p>id of project to search data</p> 
talkIds[] | **string**<br><p>ids of talks to return. Requesting too many talks may result in "message exceeds maximum size" error. Up to 100 of talks per request is recommended.</p> 
resultsMask | **string**<br><p>All types of analysis will be returned if not set.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
 
## Response {#responses}
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
                    "confidence": "number"
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
        }
      },
      "silenceStatistics": {
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
              }
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
                "channelNumber": "integer",
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
      }
    }
  ]
}
```

 
Field | Description
--- | ---
talk[] | **object**
talk[].<br>id | **string**<br><p>talk id</p> 
talk[].<br>organizationId | **string**
talk[].<br>spaceId | **string**
talk[].<br>connectionId | **string**
talk[].<br>projectIds[] | **string**
talk[].<br>createdBy | **string**<br><p>audition info</p> 
talk[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
talk[].<br>modifiedBy | **string**
talk[].<br>modifiedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
talk[].<br>talkFields[] | **object**<br><p>key-value representation of talk fields with values</p> 
talk[].<br>talkFields[].<br>name | **string**<br><p>name of the field</p> 
talk[].<br>talkFields[].<br>value | **string**<br><p>field value</p> 
talk[].<br>talkFields[].<br>type | **string**<br><p>field type</p> <p>connection field type</p> 
talk[].<br>transcription | **object**<br><p>various ml analysis results</p> 
talk[].<br>transcription.<br>phrases[] | **object**
talk[].<br>transcription.<br>phrases[].<br>channelNumber | **string** (int64)
talk[].<br>transcription.<br>phrases[].<br>startTimeMs | **string** (int64)
talk[].<br>transcription.<br>phrases[].<br>endTimeMs | **string** (int64)
talk[].<br>transcription.<br>phrases[].<br>phrase | **object**
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>text | **string**
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>language | **string**
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>normalizedText | **string**
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>words[] | **object**
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>words[].<br>word | **string**
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>words[].<br>startTimeMs | **string** (int64)
talk[].<br>transcription.<br>phrases[].<br>phrase.<br>words[].<br>endTimeMs | **string** (int64)
talk[].<br>transcription.<br>phrases[].<br>statistics | **object**
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics | **object**
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>speakerTag | **string**
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>speechBoundaries | **object**<br><p>Audio segment boundaries</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>speechBoundaries.<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>speechBoundaries.<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>speechBoundaries.<br>durationSeconds | **string** (int64)<br><p>Duration in seconds</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>totalSpeechMs | **string** (int64)<br><p>Total speech duration</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>speechRatio | **number** (double)<br><p>Speech ratio within audio segment</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>totalSilenceMs | **string** (int64)<br><p>Total silence duration</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>silenceRatio | **number** (double)<br><p>Silence ratio within audio segment</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsCount | **string** (int64)<br><p>Number of words in recognized speech</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersCount | **string** (int64)<br><p>Number of letters in recognized speech</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond | **object**<br><p>Descriptive statistics for words per second distribution</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>wordsPerSecond.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond | **object**<br><p>Descriptive statistics for letters per second distribution</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>transcription.<br>phrases[].<br>statistics.<br>statistics.<br>lettersPerSecond.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[] | **object**
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>startTimeMs | **string** (int64)<br><p>Start time of the audio segment used for classification</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>endTimeMs | **string** (int64)<br><p>End time of the audio segment used for classification</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>classifier | **string**<br><p>Name of the triggered classifier</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>highlights[] | **object**<br><p>List of highlights, i.e. parts of phrase that determine the result of the classification</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>highlights[].<br>text | **string**<br><p>Text transcription of the highlighted audio segment</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>highlights[].<br>offset | **string** (int64)<br><p>offset in symbols from the beginning of whole phrase where highlight begins</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>highlights[].<br>count | **string** (int64)<br><p>count of symbols in highlighted text</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>labels[] | **object**<br><p>Classifier predictions</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>labels[].<br>label | **string**<br><p>The label of the class predicted by the classifier</p> 
talk[].<br>transcription.<br>phrases[].<br>classifiers[].<br>labels[].<br>confidence | **number** (double)<br><p>The prediction confidence</p> 
talk[].<br>transcription.<br>algorithmsMetadata[] | **object**<br><p>Their might be several algorithms that work on talk transcription. For example: speechkit and translator So there might be other fields here for tracing</p> 
talk[].<br>transcription.<br>algorithmsMetadata[].<br>createdTaskDate | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
talk[].<br>transcription.<br>algorithmsMetadata[].<br>completedTaskDate | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
talk[].<br>transcription.<br>algorithmsMetadata[].<br>error | **object**
talk[].<br>transcription.<br>algorithmsMetadata[].<br>error.<br>code | **string**
talk[].<br>transcription.<br>algorithmsMetadata[].<br>error.<br>message | **string**
talk[].<br>transcription.<br>algorithmsMetadata[].<br>traceId | **string**
talk[].<br>transcription.<br>algorithmsMetadata[].<br>name | **string**
talk[].<br>speechStatistics | **object**
talk[].<br>speechStatistics.<br>totalSimultaneousSpeechDurationSeconds | **string** (int64)<br><p>Total simultaneous speech duration in seconds</p> 
talk[].<br>speechStatistics.<br>totalSimultaneousSpeechDurationMs | **string** (int64)<br><p>Total simultaneous speech duration in ms</p> 
talk[].<br>speechStatistics.<br>totalSimultaneousSpeechRatio | **number** (double)<br><p>Simultaneous speech ratio within audio segment</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation | **object**<br><p>Descriptive statistics for simultaneous speech duration distribution</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>speechStatistics.<br>simultaneousSpeechDurationEstimation.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>silenceStatistics | **object**
talk[].<br>silenceStatistics.<br>totalSimultaneousSilenceDurationMs | **string** (int64)
talk[].<br>silenceStatistics.<br>totalSimultaneousSilenceRatio | **number** (double)<br><p>Simultaneous silence ratio within audio segment</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation | **object**<br><p>Descriptive statistics for simultaneous silence duration distribution</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>silenceStatistics.<br>simultaneousSilenceDurationEstimation.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>silenceStatistics.<br>totalSimultaneousSilenceDurationSeconds | **string** (int64)
talk[].<br>interruptsStatistics | **object**
talk[].<br>interruptsStatistics.<br>speakerInterrupts[] | **object**<br><p>Interrupts description for every speaker</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>speakerTag | **string**<br><p>Speaker tag</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interruptsCount | **string** (int64)<br><p>Number of interrupts made by the speaker</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interruptsDurationMs | **string** (int64)<br><p>Total duration of all interrupts</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interrupts[] | **object**<br><p>Boundaries for every interrupt</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interrupts[].<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interrupts[].<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interrupts[].<br>durationSeconds | **string** (int64)<br><p>Duration in seconds</p> 
talk[].<br>interruptsStatistics.<br>speakerInterrupts[].<br>interruptsDurationSeconds | **string** (int64)<br><p>Total duration of all interrupts in seconds</p> 
talk[].<br>conversationStatistics | **object**
talk[].<br>conversationStatistics.<br>conversationBoundaries | **object**<br><p>Audio segment boundaries</p> 
talk[].<br>conversationStatistics.<br>conversationBoundaries.<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
talk[].<br>conversationStatistics.<br>conversationBoundaries.<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
talk[].<br>conversationStatistics.<br>conversationBoundaries.<br>durationSeconds | **string** (int64)<br><p>Duration in seconds</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[] | **object**<br><p>Average statistics for each speaker</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>speakerTag | **string**<br><p>Speaker tag</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics | **object**<br><p>analysis of all phrases in format of single utterance</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>speakerTag | **string**
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>speechBoundaries | **object**<br><p>Audio segment boundaries</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>speechBoundaries.<br>startTimeMs | **string** (int64)<br><p>Audio segment start time</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>speechBoundaries.<br>endTimeMs | **string** (int64)<br><p>Audio segment end time</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>speechBoundaries.<br>durationSeconds | **string** (int64)<br><p>Duration in seconds</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>totalSpeechMs | **string** (int64)<br><p>Total speech duration</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>speechRatio | **number** (double)<br><p>Speech ratio within audio segment</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>totalSilenceMs | **string** (int64)<br><p>Total silence duration</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>silenceRatio | **number** (double)<br><p>Silence ratio within audio segment</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsCount | **string** (int64)<br><p>Number of words in recognized speech</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersCount | **string** (int64)<br><p>Number of letters in recognized speech</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond | **object**<br><p>Descriptive statistics for words per second distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>wordsPerSecond.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond | **object**<br><p>Descriptive statistics for letters per second distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>completeStatistics.<br>lettersPerSecond.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance | **object**<br><p>Descriptive statistics for words per utterance distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>wordsPerUtterance.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance | **object**<br><p>Descriptive statistics for letters per utterance distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>lettersPerUtterance.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceCount | **string** (int64)<br><p>Number of utterances</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation | **object**<br><p>Descriptive statistics for utterance duration distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>min | **number** (double)<br><p>Minimum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>max | **number** (double)<br><p>Maximum observed value</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>mean | **number** (double)<br><p>Estimated mean of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>std | **number** (double)<br><p>Estimated standard deviation of distribution</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>quantiles[] | **object**<br><p>List of evaluated quantiles</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>quantiles[].<br>level | **number** (double)<br><p>Quantile level in range (0, 1)</p> 
talk[].<br>conversationStatistics.<br>speakerStatistics[].<br>utteranceDurationEstimation.<br>quantiles[].<br>value | **number** (double)<br><p>Quantile value</p> 
talk[].<br>points | **object**
talk[].<br>points.<br>quiz[] | **object**
talk[].<br>points.<br>quiz[].<br>request | **string**
talk[].<br>points.<br>quiz[].<br>response | **string**
talk[].<br>points.<br>quiz[].<br>id | **string**
talk[].<br>textClassifiers | **object**
talk[].<br>textClassifiers.<br>classificationResult[] | **object**
talk[].<br>textClassifiers.<br>classificationResult[].<br>classifier | **string**<br><p>Classifier name</p> 
talk[].<br>textClassifiers.<br>classificationResult[].<br>classifierStatistics[] | **object**<br><p>Classifier statistics</p> 
talk[].<br>textClassifiers.<br>classificationResult[].<br>classifierStatistics[].<br>channelNumber | **integer** (int64)<br><p>Channel number, null for whole talk</p> 
talk[].<br>textClassifiers.<br>classificationResult[].<br>classifierStatistics[].<br>totalCount | **string** (int64)<br><p>classifier total count</p> 
talk[].<br>textClassifiers.<br>classificationResult[].<br>classifierStatistics[].<br>histograms[] | **object**<br><p>Represents various histograms build on top of classifiers</p> 
talk[].<br>textClassifiers.<br>classificationResult[].<br>classifierStatistics[].<br>histograms[].<br>countValues[] | **string** (int64)<br><p>histogram count values. For example: if len(count_values) = 2, it means that histogram is 50/50, if len(count_values) = 3 - [0] value represents first third, [1] - second third, [2] - last third, etc.</p> 