---
title: Synchronous recognition API in {{ speechkit-full-name }}
description: Follow this guide to use the synchronous recognition API.
---

# Synchronous recognition API


With the [synchronous recognition API](../request.md), you can transcribe prepared audio files with the following characteristics:

* Maximum file size: {{ stt-short-fileSize }}
* Maximum duration: {{ stt-short-audioLength }}
* Maximum number of audio channels: {{ stt-short-channelsCount }}

The synchronous recognition service is located at `stt.{{ api-host }}/speech/v1/stt:recognize`

## Query parameters {#query_params}

Parameter | Description
----- | -----
lang | **string**<br>Recognition language.<br/>See the [model description](../../stt/models.md) for acceptable values. The default value is `ru-RU`, Russian.
topic | **string**<br>Language model to use for recognition.<br/>The more accurate your choice of the model, the better the recognition result. You can specify only one model per request.<br/>The [acceptable values](../../stt/models.md) depend on the language you select. The default value is `general`.
profanityFilter | **boolean**<br>This parameter controls the profanity filter in recognized speech.<br>Acceptable values:<ul><li>`false` (default): Profanities will not be excluded from the recognition results.</li><li>`true`: Profanities will be excluded from the recognition results.</li></ul>
rawResults |  **boolean** <br>Flag for how to write numbers: `true` for words, `false` (default) for figures.
format | **string**<br>Submitted audio [format](../../formats.md).<br/>Acceptable values:<ul><li>`lpcm`: [LPCM without a WAV header](../../formats.md#lpcm).</li><li>`oggopus` (default): [OggOpus](../../formats.md#oggopus).</li></ul>
sampleRateHertz | **string**<br>Submitted audio sampling frequency.<br/>Applies if `format` equals `lpcm`. Acceptable values:<ul><li>`48000` (default): 48 kHz.</li><li>`16000`: 16 kHz.</li><li>`8000`: 8 kHz.</li></ul>
folderId | **string**<br><p>[ID of the folder](../../../resource-manager/operations/folder/get-id.md) you have access to. Required for authorization with a user account (see [{#T}](../../concepts/auth.md) resource). Do not use this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p>

## Parameters in the request body {#body_params}

The request body has to contain the binary content of an audio file.

## Response {#response}

The recognized text is returned in the `result` field of the response.

```json
{
  "result": <recognized_text>
}
```

For more information about the response format and codes, see [{#T}](../../concepts/response.md).

## Use cases {#examples}

* [{#T}](request-examples.md).
