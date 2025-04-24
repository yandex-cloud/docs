---
title: Asynchronous recognition API v2 in {{ speechkit-full-name }}
description: Follow this guide to learn how to use the asynchronous recognition API v2.
---

# Asynchronous recognition API v2


To use the API v2, you will need:

* [{{ objstorage-full-name }} bucket](../../../storage/operations/buckets/create.md) to which you will upload your audio file for recognition.
* [Service account](../../../iam/operations/sa/create.md) with the `{{ roles-speechkit-stt }}` and `storage.uploader` roles for accessing {{ speechkit-name }} and {{ objstorage-name }}.
* [IAM token](../../../iam/operations/iam-token/create-for-sa.md) or [API key](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) for authentication.

For more information on getting started, see [{#T}](../transcribation.md#async-recognition).

{% note warning %}

You can recognize audio files asynchronously only as a service account. Do not use any [other {{ yandex-cloud }}](../../../iam/concepts/users/accounts.md) accounts for the purpose.

{% endnote %}

The asynchronous recognition service for the API v2 is located at `transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize`

## Sending a file for recognition {#sendfile}

### Request body parameters {#sendfile-params}

The request body structure is as follows:

```json
{
 "config": {
  "specification": {
   "languageCode": "string",
   "model": "string",
   "profanityFilter": boolean,
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
|| config | **object**<br>Field with recognition settings. ||
|| config.<br>specification | **object**<br>Recognition settings. ||
|| config.<br>specification.<br>languageCode | **string**<br>[Language](../models.md#languages) of the audio file for speech recognition.<br/>The default value is `ru-RU`, Russian. ||
|| config.<br>specification.<br>model | **string**<br>[Language model](../models.md#tags) for speech recognition.<br>The default value is `general`.<br>Different models have different [pricing](../../pricing.md#rules-stt-long). ||
|| config.<br>specification.<br>profanityFilter | **boolean**<br>Profanity filter.<br/>Acceptable values:<ul><li>`true`: Mask profanities with asterisks in recognition results.</li><li>`false` (default): Do not mask profanities.</li></ul> ||
|| config.<br>specification.<br>literature_text | **boolean**<br>Enables [normalization mode](../normalization.md). ||
|| config.<br>specification.<br>audioEncoding | **string**<br>Submitted audio [format](../../formats.md).<br/>Acceptable values:<ul><li>`LINEAR16_PCM`: [LPCM without a WAV header](../../formats.md#lpcm).</li><li>`OGG_OPUS` (default): [Ogg](../../formats.md#oggopus) with the OPUS codec.</li><li>`MP3`: [MP3](../../formats.md#MP3).</li></ul> ||
|| config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>Sampling rate of the submitted audio.<br/>This parameter is required if `format` is set to `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default): 48 kHz.</li><li>`16000`: 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> ||
|| config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>Number of channels for [LPCM](../../formats.md#lpcm) audio files. The default value is `1`.<br>Do not use this field for [OggOpus](../../formats.md#oggopus) or [MP3](../../formats.md#MP3) audio files. They already contain information about the channel count. ||
|| config.<br>specification.<br>rawResults | **boolean** <br>Flag that toggles spelling out numbers.</br>Acceptable values:<ul><li>`true`: Spell out.</li><li>`false` (default): Use figures.</li></ul> ||
|| audio.<br>uri | **string**<br>URI of the audio file for recognition. Supports only links to files stored in [{{ objstorage-full-name }}](../../../storage/). ||
|#

### Response {#sendfile-response}

If your request is written correctly, the service returns the [Operation object](../../../api-design-guide/concepts/operation.md) with the recognition operation ID (`id`):

```json
{
 "done": false,
 "id": "e03sup6d5h1q********",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato8********",
 "modifiedAt": "2019-04-21T22:49:29Z"
}
```

Use this ID at the next step.

## Getting recognition results {#get-result}

To check the operation status and get the recognition results, submit a request at `operation.{{ api-host }}`.

Monitor the recognition results using the obtained ID. The number of result monitoring requests is [limited](../../concepts/limits.md): it takes about 10 seconds to recognize 1 minute of single-channel audio.

{% note warning %}

Recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the obtained ID.

{% endnote %}

### Path parameters {#get-result-params}

Parameter | Description
----- | -----
operationId | Operation ID received when sending the recognition request

### Response {#get-result-response}

The [Operation object](../../../api-design-guide/concepts/operation.md) is returned in response to your request. Here is a response example:

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
 "id": "e03sup6d5h1q********",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato8********",
 "modifiedAt": "2019-04-21T22:49:36Z"
}
```

#|
|| **Parameter** | **Description** ||
|| done | **boolean**
Contains `true` when the recognition is complete. ||
|| response | **object**
Asynchronous speech recognition results ||
|| response.<br>@type | **string**
Response type ||
|| response.<br>chunks | **array**
Array with recognition results<br>If speech recognition in the transmitted file fails, the response may not contain an array with the results. ||
|| response.<br>chunks.<br>alternatives | **array**
Array with recognized text alternatives ||
|| response.<br>chunks.<br>alternatives.<br>words | **array**
Array with recognized words and their details ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>startTime | **string**
Word start time in the recording. An error of 1-2 seconds is possible. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>endTime | **string**
Word end time in the recording. An error of 1-2 seconds is possible. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>word | **string**
Recognized word. Recognized numbers are spelled out (e.g., `twelve` instead of `12`). ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>confidence | **integer** (int64)
This field is not supported. Do not use it. ||
|| response.<br>chunks.<br>alternatives.<br>text | **string**
Entire recognized text. By default, numbers are written in figures. To output the entire text in word form, set the `config.specification.rawResult` parameter to `true`. ||
|| response.<br>chunks.<br>alternatives.<br>confidence | **integer** (int64)
This field is not supported. Do not use it. ||
|| response.<br>chunks.<br>channelTag | **string**
Audio channel recognition was performed for. ||
|| id | **string**
Operation ID. Generated on the service side. ||
|| createdAt | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)
Operation start time. Uses [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format. ||
|| createdBy | **string**
ID of the user who started the operation. ||
|| modifiedAt | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)
Resource last update time. Uses [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format.
|#

For more information about the response format and codes, see [{#T}](../../concepts/response.md).

## Use cases {#examples}

* [{#T}](transcribation-lpcm.md).
* [{#T}](transcribation-ogg.md).
* [{#T}](batch-transcribation.md).
