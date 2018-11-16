# API method description

Generates speech for the text submitted.

## Request {#http_request}

```
POST https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
```

## Parameters in the request body {#body_params}

All parameters must be URL-encoded. The maximum size of the POST request body is 30 KB.

| Parameter | Description |
| ----- | ----- |
| `text` | Required parameter.<br/>UTF-8 encoded text to be converted into speech.<br/>For homographs, use `+` before the stressed vowel. For example, `contr+ol` or `def+ect`.<br/>Maximum string length: 5000 characters. |
| `quality` | Sampling frequency of the synthesized audio.<br/>Valid values:<ul><li>`ultrahigh` — Sampling rate of 48 kHz.</li><li>`high` — Sampling rate of 16 kHz.</li><li>`low` — Sampling rate of 8 kHz.</li></ul>Default value of the parameter: `ultrahigh`. |
| `lang` | Language.<br/>Valid values:<ul><li>`ru-RU` — Russian.</li><li>`en-US` — English.</li></ul>Default value of the parameter: `ru-RU`. |
| `voice` | The voice for the synthesized speech.<br/>You can choose one of the following voices:<ul><li>female voices: `jane`, `oksana`, `alyss` or `omazh`;</li><li>male voices: `zahar` or `ermil`.</li></ul>Default value of the parameter: `oksana`. |
| `speed` | The rate (tempo) of the synthesized speech.<br/>The speech rate is set as a fractional number in the range from `0.1` to `3.0`. Where: <ul><li>`3.0` — Fastest rate.</li><li>`1.0` — Average human speech rate.</li><li>`0.1` — Slowest speech rate.</li></ul>Default value of the parameter: `1.0`. |
| `emotion` | Emotional tone of the voice.<br/>Valid values:<ul><li>`good` — Cheerful and friendly.</li><li>`evil` — Irritated.</li><li>`neutral` — Without emotion.</li></ul>Default value of the parameter: `neutral`. |
| `folderId` | Required parameter.<br/>ID of your folder.<br/>For more information about how to find the folder ID, see the section [Authorization in the API](../concepts/auth.md). |

## Response {#response}

If speech synthesis is successful, the response contains the binary content of the audio file. For audio files, the OPUS audio codec and OGG container ([OggOpus](https://wiki.xiph.org/OggOpus)) are used.

## Examples {#examples}

### Request example {#request_examples}

```httpget
curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     -d "text=hello%20world&voice=zahar&emotion=good&folderId=<folder id>" \
     "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

### Response example {#response_examples}

```no-highlight
HTTP/1.1 200 OK
Content-Type: audio/ogg
Content-Disposition: inline
Content-Transfer-Encoding: binary
YaCloud-Request-Id: YYXXYYXXYY-YXXY-YXXY-YXXY-YYXXYYXXYY
YaCloud-Billing-Units: 11
        
... (binary content of an audio file)   
```

[!INCLUDE [request-id-note](../_includes/request-id-note.md)]

