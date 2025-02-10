# API v1 method description

Generates (synthesizes) speech from received text.


{% note info %}

API v1 does not support all {{ speechkit-name }} synthesis options. For a comparison of API versions, see [Synthesis options](index.md#features).

{% endnote %}

The synthesis suite is available at: `tts.{{ api-host }}/speech/v1/tts:synthesize`

## Parameters in the request body {#body_params}

All parameters must be [URL-encoded](https://datatracker.ietf.org/doc/html/rfc3986#section-2). The maximum size of the POST request body is 15 KB.

Parameter | Description
----- | -----
text | **string**<br>UTF-8 encoded text to convert to speech.<br>You can use only one of the fields: `text` or `ssml`.<br>To control pronunciation (pause, emphasis, and stress), use [TTS markup](markup/tts-markup.md).<br>Maximum string length: 5,000 characters.
ssml | **string**<br>[SSML](markup/ssml.md) text to convert to speech.<br>You can use only one of the fields: `text` or `ssml`.
lang | **string**<br>Language.<br/>Acceptable values: `ru-RU` (default), Russian.
voice | **string**<br>Preferred speech synthesis voice from the [list](voices.md).
emotion | **string**<br>Role or emotional tone of the voice. Supported only for Russian (`ru-RU`). See [{#T}](voices.md) for acceptable voice/emotional tone combinations.
speed | **string**<br>Synthesized speech rate.<br/>The rate of speech is set as a decimal number in the range from `0.1` to `3.0`. Where:<ul><li>`3.0`: Fastest rate.</li><li>`1.0` (default): Average human speech rate.</li><li>`0.1`: Slowest speech rate.</li></ul>
format | **string**<br>Synthesized audio format.<br/>Acceptable values:<ul><li>`lpcm`</li><li>`oggopus` (default)</li> <li>`mp3`</li></ul>
sampleRateHertz | **string**<br>Synthesized audio sampling frequency.<br/>Applies if `format` equals `lpcm`. Acceptable values:<ul><li>`48000` (default): 48 kHz.</li><li>`16000`: 16 kHz.</li><li>`8000`: 8 kHz.</li></ul>
folderId | **string**<br><p>[ID of the folder](../../resource-manager/operations/folder/get-id.md) you have access to. Required for authorization with a user account (see [{#T}](../concepts/auth.md) resource). Do not use this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p>

## Response {#response}

If the synthesis was successful, the response will contain the audio file binary content. The output data format depends on the value of the `format` parameter.

For more information about the response format and codes, see [{#T}](../concepts/response.md).

## Use cases {#examples}

* [{#T}](api/tts-wav.md).
* [{#T}](api/tts-ogg.md).
* [{#T}](api/tts-ssml.md).
