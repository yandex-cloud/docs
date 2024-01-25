# API v1 method description

Generates (synthesizes) speech from received text.

{% note info %}

API v1 does not support all {{ speechkit-name }} synthesis options. For a comparison of API versions, see [Synthesis options](index.md#features).

{% endnote %}

The synthesis service is located at: `tts.{{ api-host }}/speech/v1/tts:synthesize`

## Parameters in the request body {#body_params}

All parameters must be [URL-encoded](https://datatracker.ietf.org/doc/html/rfc3986#section-2). The maximum size of the POST request body is 15 KB.

| Parameter | Description |
----- | -----
| text | **string**<br>UTF-8 encoded text to be converted into speech.<br>You can only use one `text` and `ssml` field.<br>To control pronunciation (pause, emphasis, and stress), use [TTS markup](markup/tts-markup.md).<br>Maximum string length: 5,000 characters. |
| ssml | **string**<br>Text in [SSML](markup/ssml.md) format to be converted into speech.<br>You can only use one `text` and `ssml` fields. |
| lang | **string**<br>Language.<br/>Acceptable values: `ru-RU` (default): Russian. |
| voice | **string**<br>Preferred speech synthesis voice from the [list](voices.md). |
| emotion | **string**<br>Voice mode or emotional tone. Supported only for Russian (`ru-RU`). See [{#T}](voices.md) for acceptable voice/emotional tone combinations. |
| speed | **string**<br>The rate (speed) of synthesized speech.<br/>The rate of speech is set as a decimal number in the range from `0.1` to `3.0`. Where:<ul><li>`3.0`: Fastest rate.</li><li>`1.0` (default): Average human speech rate.</li><li>`0.1`: Slowest speech rate.</li></ul> |
| format | **string**<br>The format of the synthesized audio.<br/>Acceptable values:<ul><li>`lpcm`</li><li>`oggopus` (default)</li> <li>`mp3`</li></ul> |
| sampleRateHertz | **string**<br>The sampling frequency of the synthesized audio.<br/>Used if `format` is set to `lpcm`. Acceptable values include:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| folderId | **string**<br><p>[ID of the folder](../../resource-manager/operations/folder/get-id.md) that you have access to. It is required for authorization with a user account (see [{#T}](../concepts/auth.md)). Do not use this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p> |

## Response {#response}

If the synthesis was successful, the response will contain the audio file binary content. The output data format depends on the value of the `format` parameter.

For more information about the response format and codes, see [{#T}](../concepts/response.md).

## Use cases {#examples}

* [{#T}](api/tts-wav.md)
* [{#T}](api/tts-ogg.md)
* [{#T}](api/tts-ssml.md)
