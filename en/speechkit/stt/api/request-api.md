# Synchronous Recognition API

With [Synchronous Recognition API](../request.md), you can transcribe prepared audio files with the following characteristics:

* Maximum file size: {{ stt-short-fileSize }}
* Maximum duration: {{ stt-short-audioLength }}
* Maximum number of audio channels: {{ stt-short-channelsCount }}

## HTTP request {#http_request}

```
POST https://stt.{{ api-host }}/speech/v1/stt:recognize
```

### Query parameters {#query_params}

| Parameter | Description |
----- | -----
| lang | **string**<br>Language that recognition will be performed for.<br/>See a list of available languages in the [model description](../../stt/models.md). The default value is `ru-RU` (Russian). |
| topic | **string**<br>The language model to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>[Acceptable values](../../stt/models.md) depend on the selected language. Default value: `general`. |
| profanityFilter | **boolean**<br>This parameter controls the profanity filter in recognized speech.<br>Acceptable values:<ul><li>`false` (default): Profanity is not excluded from recognition results.</li><li>`true`: Profanity is excluded from recognition results.</li></ul> |
| rawResults | **boolean** <br>Flag that indicates how to write numbers. `true`: In words. `false` (by default): In numbers. |
| format | **string**<br>Synthesized audio [format](../../formats.md).<br/>Acceptable values include:<ul><li>`lpcm`: [LPCM with no WAV header](../../formats.md#lpcm).</li><li>`oggopus` (default): [OggOpus](../../formats.md#oggopus).</li></ul> |
| sampleRateHertz | **string**<br>Sampling frequency of the synthesized audio.<br/>It is used if `format` is set to `lpcm`. Acceptable values include:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| folderId | **string**<br><p>[ID of the folder](../../../resource-manager/operations/folder/get-id.md) that you have access to. It is required for authorization with a user account (see the [{#T}](../../concepts/auth.md) resource). Do not specify this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p> |

### Parameters in the request body {#body_params}

The request body has to contain the binary content of an audio file.

## Response {#response}

The recognized text is returned in the response in the `result` field.

```json
{
  "result": <recognized text>
}
```
