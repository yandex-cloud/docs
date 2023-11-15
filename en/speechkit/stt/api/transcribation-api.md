# Asynchronous Recognition API

## How to use the asynchronous recognition API {#how-to-use}

1. [Create a service account](../../../iam/operations/sa/create.md).
1. [Assign it the following roles](../../../iam/operations/sa/assign-role-for-sa.md):

   * `{{ roles-speechkit-stt }}` for speech recognition.
   * `storage.uploader` for uploading audio files to a [{{ objstorage-full-name }} bucket](../../../storage/concepts/bucket.md).
   * (Optional) `storage.configurer`, `kms.keys.encrypter`, and `kms.keys.decrypter` for bucket object encryption and decryption. These roles are only required if you use [encryption in {{ objstorage-name }}](../../../storage/concepts/encryption.md).

1. Get an [IAM token](../../../iam/operations/iam-token/create-for-sa.md) or [API key](../../../iam/operations/api-key/create.md) for your service account. You will need them for authorization in the API. Provide them in every request as HTTP headers:

   * `Authorization: Bearer <IAM token>` to authorize using an IAM token.
   * `Authorization: Api-Key <API key>` to authorize using an API key.

1. [Create a {{ objstorage-full-name }} bucket](../../../storage/operations/buckets/create.md).
1. [Upload an audio file to the bucket](../../../storage/operations/objects/upload.md).
1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded file. Use this link in the [body of your speech recognition request](#sendfile-params).

   The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

## Sending a file for recognition {#sendfile}

### Parameters in the request body {#sendfile-params}

The request body structure is as follows:

```json
{
 "config": {
  "specification": {
   "languageCode": "string",
   "model": "string",
   "profanityFilter": "string",
   "literature_text": boolean,
   "audioEncoding": "string",
   "sampleRateHertz": integer,
   "audioChannelCount": integer,
   "rawResults": boolean
  }
 },
 "audio": {
  "uri": "string"
 }
}
```

#|
|| **Parameter** | **Description** ||
|| config | **object**<br>Field with recognition settings ||
|| config.<br>specification | **object**<br>Recognition settings ||
|| config.<br>specification.<br>languageCode | **string**<br>[Language](../models.md#languages) of the speech in the audio recording to recognize.<br/>The default value is `ru-RU` (Russian). ||
|| config.<br>specification.<br>model | **string**<br>[Language model](../models.md#tags) used for speech recognition.<br>The default parameter value is `general`.<br>The model you select affects the service [usage cost](../../pricing.md#rules-stt-long). ||
|| config.<br>specification.<br>profanityFilter | **boolean**<br>Profanity filter.<br/>Acceptable values include:<ul><li>`true`: Mask profanities with asterisks in recognition results.</li><li>`false` (default): Do not mask profanities.</li></ul> ||
|| config.<br>specification.<br>literature_text | **boolean**<br>Enables [normalization mode](../normalization.md). ||
|| config.<br>specification.<br>audioEncoding | **string**<br>[Synthesized audio](../../formats.md) format.<br/>Acceptable values include:<ul><li>`LINEAR16_PCM`: [LPCM without WAV header](../../formats.md#lpcm).</li><li>`OGG_OPUS` (default): [OggOpus](../../formats.md#oggopus) format.</li><li>`MP3`: [MP3](../../formats.md#MP3) format.</li></ul> ||
|| config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>Sampling frequency of the synthesized audio.<br/>This parameter is required if `format` is set to `LINEAR16_PCM`. Acceptable values include:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> ||
|| config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>Number of channels for [LPCM](../../formats.md#lpcm) audio files. The default value is `1`.<br>Do not use this field for [OggOpus](../../formats.md#oggopus) and [MP3](../../formats.md#MP3) audio files. They already contain information about the channel count. ||
|| config.<br>specification.<br>rawResults | **boolean** <br>Flag indicating how to write numbers.</br>Acceptable values include:<ul><li>`true`: In words.</li><li>`false` (default): In numbers.</li></ul> ||
|| audio.<br>uri | **string**<br>URI of the audio file for recognition. Supports only links to files stored in [{{ objstorage-full-name }}](../../../storage/). ||
|#

### Response {#sendfile-response}

If your request is written correctly, the service returns the [Operation object](../../../api-design-guide/concepts/operation.md) with the recognition operation ID (`id`):

```json
{
 "done": false,
 "id": "e03sup**********ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08**********bhqq",
 "modifiedAt": "2019-04-21T22:49:29Z"
}
```

Use this ID at the next step.

## Getting recognition results {#get-result}

Monitor the recognition results using the obtained ID. The number of result monitoring requests is [limited](../../concepts/limits.md): it takes about 10 seconds to recognize 1 minute of a single-channel audio file.

{% note warning %}

Recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the obtained ID.

{% endnote %}

### Path parameters {#get-result-params}

| Parameter | Description |
----- | -----
| operationId | Operation ID received when sending the recognition request |

### Response {#get-result-response}

The [Operation object](../../../api-design-guide/concepts/operation.md) is returned in response to your request. Sample response:

```json
{
 "done": true,
 "response": {
  "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
  "chunks": [
   {
    "alternatives": [
     {
      "words": [
       {
        "startTime": "0.879999999s",
        "endTime": "1.159999992s",
        "word": "when",
        "confidence": 1
       },
       {
        "startTime": "1.219999995s",
        "endTime": "1.539999988s",
        "word": "writing",
        "confidence": 1
       },
       ...
      ],
      "text": "when writing The Hobbit, Tolkien referred to the Norse mythology of the Old English poem Beowulf",
      "confidence": 1
     }
    ],
    "channelTag": "1"
   },
   ...
  ]
 },
 "id": "e03sup**********ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08**********bhqq",
 "modifiedAt": "2019-04-21T22:49:36Z"
}
```

#|
|| **Parameter** | **Description** ||
|| done | **boolean**
Set to `true` when the recognition is complete. ||
|| response | **object**
Asynchronous speech recognition results ||
|| response.<br>@type | **string**
Request response type ||
|| response.<br>chunks | **array**
Array with recognition results ||
|| response.<br>chunks.<br>alternatives | **array**
Array with recognized text alternatives ||
|| response.<br>chunks.<br>alternatives.<br>words | **array**
Array with recognized words and their details ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>startTime | **string**
Word start time in the audio recording. An error of 1-2 seconds is possible. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>endTime | **string**
Word end time in the audio recording. An error of 1-2 seconds is possible. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>word | **string**
Recognized word. Recognized numbers are written in words (e.g., `twelve` instead of `12`). ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>confidence | **integer** (int64)
The field is not supported. Do not use it. ||
|| response.<br>chunks.<br>alternatives.<br>text | **string**
Entire recognized text. By default, numbers are written in figures. To output the entire text in words, set the `config.specification.rawResult` parameter to `true`. ||
|| response.<br>chunks.<br>alternatives.<br>confidence | **integer** (int64)
The field is not supported. Do not use it. ||
|| response.<br>chunks.<br>channelTag | **string**
Audio channel for which the recognition was performed. ||
|| id | **string**
Operation ID. It is generated on the service side. ||
|| createdAt | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)
Operation start time. It is specified in [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format. ||
|| createdBy | **string**
ID of the user who run the operation. ||
|| modifiedAt | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)
Time when the resource was last updated. It is specified in [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format.
|#
