---
editable: false
sourcePath: en/_api-ref/ai/stt/v3/stt-v3/api-ref/AsyncRecognizer/recognizeFile.md
---

# SpeechKit Recognition API v3, REST: AsyncRecognizer.recognizeFile

 

 
## HTTP request {#https-request}
```
POST https://stt.{{ api-host }}/stt/v3/recognizeFileAsync
```
 
## Body parameters {#body_params}
 
```json 
{
  "recognitionModel": {
    "model": "string",
    "audioFormat": {

      // `recognitionModel.audioFormat` includes only one of the fields `rawAudio`, `containerAudio`
      "rawAudio": {
        "audioEncoding": "string",
        "sampleRateHertz": "string",
        "audioChannelCount": "string"
      },
      "containerAudio": {
        "containerAudioType": "string"
      },
      // end of the list of possible fields`recognitionModel.audioFormat`

    },
    "textNormalization": {
      "textNormalization": "string",
      "profanityFilter": true,
      "literatureText": true,
      "phoneFormattingMode": "string"
    },
    "languageRestriction": {
      "restrictionType": "string",
      "languageCode": [
        "string"
      ]
    },
    "audioProcessingType": "string"
  },
  "recognitionClassifier": {
    "classifiers": [
      {
        "classifier": "string",
        "triggers": [
          "string"
        ]
      }
    ]
  },
  "speechAnalysis": {
    "enableSpeakerAnalysis": true,
    "enableConversationAnalysis": true,
    "descriptiveStatisticsQuantiles": [
      "number"
    ]
  },
  "speakerLabeling": {
    "speakerLabeling": "string"
  },

  //  includes only one of the fields `content`, `uri`
  "content": "string",
  "uri": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
recognitionModel | **object**<br>Configuration for speech recognition model.
recognitionModel.<br>model | **string**<br><p>Sets the recognition model for the cloud version of SpeechKit. Possible values: 'general', 'general:rc', 'general:deprecated'. The model is ignored for SpeechKit Hybrid.</p> 
recognitionModel.<br>audioFormat | **object**<br><p>Specified input audio.</p> <p>Audio format options.</p> 
recognitionModel.<br>audioFormat.<br>rawAudio | **object**<br>Audio without container. <br>`recognitionModel.audioFormat` includes only one of the fields `rawAudio`, `containerAudio`<br>
recognitionModel.<br>audioFormat.<br>rawAudio.<br>audioEncoding | **string**<br><p>Type of audio encoding</p> <ul> <li>LINEAR16_PCM: Audio bit depth 16-bit signed little-endian (Linear PCM).</li> </ul> 
recognitionModel.<br>audioFormat.<br>rawAudio.<br>sampleRateHertz | **string** (int64)<br><p>PCM sample rate</p> 
recognitionModel.<br>audioFormat.<br>rawAudio.<br>audioChannelCount | **string** (int64)<br><p>PCM channel count. Currently only single channel audio is supported in real-time recognition.</p> 
recognitionModel.<br>audioFormat.<br>containerAudio | **object**<br>Audio is wrapped in container. <br>`recognitionModel.audioFormat` includes only one of the fields `rawAudio`, `containerAudio`<br>
recognitionModel.<br>audioFormat.<br>containerAudio.<br>containerAudioType | **string**<br><p>Type of audio container.</p> <ul> <li>WAV: Audio bit depth 16-bit signed little-endian (Linear PCM).</li> <li>OGG_OPUS: Data is encoded using the OPUS audio codec and compressed using the OGG container format.</li> <li>MP3: Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format.</li> </ul> 
recognitionModel.<br>textNormalization | **object**<br><p>Text normalization options.</p> <p>Options</p> 
recognitionModel.<br>textNormalization.<br>textNormalization | **string**<br><p>Normalization</p> <ul> <li>TEXT_NORMALIZATION_ENABLED: Enable normalization</li> <li>TEXT_NORMALIZATION_DISABLED: Disable normalization</li> </ul> 
recognitionModel.<br>textNormalization.<br>profanityFilter | **boolean** (boolean)<br><p>Profanity filter (default: false).</p> 
recognitionModel.<br>textNormalization.<br>literatureText | **boolean** (boolean)<br><p>Rewrite text in literature style (default: false).</p> 
recognitionModel.<br>textNormalization.<br>phoneFormattingMode | **string**<br><p>Define phone formatting mode</p> <ul> <li>PHONE_FORMATTING_MODE_DISABLED: Disable phone formatting</li> </ul> 
recognitionModel.<br>languageRestriction | **object**<br><p>Possible languages in audio.</p> <p>Type of restriction for the list of languages expected in the incoming speech stream.</p> 
recognitionModel.<br>languageRestriction.<br>restrictionType | **string**<br><p>Language restriction type</p> <ul> <li>WHITELIST: The allowing list. The incoming audio can contain only the listed languages.</li> <li>BLACKLIST: The forbidding list. The incoming audio cannot contain the listed languages.</li> </ul> 
recognitionModel.<br>languageRestriction.<br>languageCode[] | **string**<br><p>The list of language codes to restrict recognition in the case of an auto model</p> 
recognitionModel.<br>audioProcessingType | **string**<br><p>How to deal with audio data (in real time, after all data is received, etc). Default is REAL_TIME.</p> <ul> <li>REAL_TIME: Process audio in mode optimized for real-time recognition, i.e. send partials and final responses as soon as possible</li> <li>FULL_DATA: Process audio after all data was received</li> </ul> 
recognitionClassifier | **object**<br>Configuration for classifiers over speech recognition.
recognitionClassifier.<br>classifiers[] | **object**<br><p>List of classifiers to use</p> 
recognitionClassifier.<br>classifiers[].<br>classifier | **string**<br><p>Classifier name</p> 
recognitionClassifier.<br>classifiers[].<br>triggers[] | **string**<br><p>Describes the types of responses to which the classification results will come</p> <ul> <li>ON_UTTERANCE: Apply classifier to utterance responses</li> <li>ON_FINAL: Apply classifier to final responses</li> <li>ON_PARTIAL: Apply classifier to partial responses</li> </ul> 
speechAnalysis | **object**<br>Configuration for speech analysis over speech recognition.
speechAnalysis.<br>enableSpeakerAnalysis | **boolean** (boolean)<br><p>Analyse speech for every speaker</p> 
speechAnalysis.<br>enableConversationAnalysis | **boolean** (boolean)<br><p>Analyse conversation of two speakers</p> 
speechAnalysis.<br>descriptiveStatisticsQuantiles[] | **number** (double)<br><p>Quantile levels in range (0, 1) for descriptive statistics</p> 
speakerLabeling | **object**<br>Configuration for speaker labeling
speakerLabeling.<br>speakerLabeling | **string**<br><p>Specifies the execution of speaker labeling. Default is SPEAKER_LABELING_DISABLED.</p> <ul> <li>SPEAKER_LABELING_ENABLED: Enable speaker labeling</li> <li>SPEAKER_LABELING_DISABLED: Disable speaker labeling</li> </ul> 
content | **string** (byte) <br> includes only one of the fields `content`, `uri`<br><br><p>Bytes with data</p> 
uri | **string** <br> includes only one of the fields `content`, `uri`<br><br><p>S3 data url</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 