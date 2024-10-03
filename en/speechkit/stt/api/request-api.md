---
title: Synchronous recognition API in {{ speechkit-full-name }}
description: Follow this guide to use the synchronous recognition API.
---

# Synchronous Recognition API

With [Synchronous Recognition API](../request.md), you can transcribe prepared audio files with the following characteristics:

* Maximum file size: {{ stt-short-fileSize }}
* Maximum duration: {{ stt-short-audioLength }}
* Maximum number of audio channels: {{ stt-short-channelsCount }}

The synchronous recognition service is located at: `stt.{{ api-host }}/speech/v1/stt:recognize`

## Query parameters {#query_params}

| Parameter | Description |
----- | -----
| lang | **string**<br>Language that recognition will be performed for.<br/>See a list of available languages in the [model description](../../stt/models.md). The default value is `ru-RU` (Russian). |
| topic | **string**<br>Language model to use for recognition.<br/>The closer the model is matched, the better is the recognition result. You can only specify one model per request.<br/>[Acceptable values](../../stt/models.md) depend on the selected language. The default value is `general`. |
| profanityFilter | **boolean**<br>This parameter manages the profanity filter in recognized speech.<br>Acceptable values include:<ul><li>`false` (default): Profanity is not excluded from recognition results.</li><li>`true`: Profanity is excluded from recognition results.</li></ul> |
| rawResults | **boolean** <br>Flag that toggles spelling out numbers. `true`: Spell out. `false` (default): Write as numbers. |
| format | **string**<br>[Format](../../formats.md) of the audio being provided.<br/>Acceptable values include:<ul><li>`lpcm`: [LPCM with no WAV header](../../formats.md#lpcm).</li><li>`oggopus` (default): [OggOpus](../../formats.md#oggopus).</li></ul> |
| sampleRateHertz | **string**<br>Sampling frequency of the audio being provided.<br/> Used if `format` is set to `lpcm`. Acceptable values include:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| folderId | **string**<br><p>[ID of the folder](../../../resource-manager/operations/folder/get-id.md) that you have access to. It is required for authorization with a user account (see [{#T}](../../concepts/auth.md)). Do not use this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p> |

## Parameters in the request body {#body_params}

The request body has to contain the binary content of an audio file.

## Response {#response}

The recognized text is returned in the response in the `result` field.

```json
{
  "result": <recognized_text>
}
```

For more information about the response format and codes, see [{#T}](../../concepts/response.md).

## Use cases {#examples}

* [{#T}](request-examples.md)
