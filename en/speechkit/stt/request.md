# API method description

Converts speech from an audio file into text.

## Request {#http_request}

```
POST https://stt.api.cloud.yandex.net/speech/v1/stt:recognize
```

## Query parameters {#query_params}

| Parameter | Description |
| ----- | ----- |
| `topic` | [The language model](../stt/index.md#model) to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>Default value of the parameter: `general`. |
| `lang` | The language for speech recognition.<br/>Valid values:<ul><li>`ru-RU` — Russian,</li><li>`en-US` — English.</li></ul>Default value of the parameter: `ru-RU`.<br/>For the valid values of the `topic` parameter for different `lang` values, see the section [[!TITLE]](../stt/index.md#model). |
| `profanityFilter` | This parameter controls the profanity filter in recognized speech.<br>Valid values:<ul><li>`false` — profanity is not excluded from recognition results;</li><li>`true` — profanity is excluded from recognition results.</li></ul>Default value of the parameter: `false`. |
| `folderId` | Required parameter.<br/>ID of your folder.<br/>For this API method, `folderId` is passed in the Query parameters rather than the request body.<br/>For more information about how to find the folder ID, see the section [Authorization in the API](../concepts/auth.md). |

## Parameters in the request body {#body_params}

The request body must contain the binary content of an audio file that meets the following requirements:

1. Size is no more than 1 MB.
1. Duration is no more than 1 minute. 
1. Number of audio channels is exactly one.

For audio files, use the OPUS audio codec and OGG container ([OggOpus](https://wiki.xiph.org/OggOpus)).

## Response {#response}

The response contains a recognition hypothesis.

The recognition hypothesis is what the recognition system assumes has been said.

The recognized text is processed before it is sent back: numbers are converted to digits, certain punctuation marks (such as hyphens) are added, and so on. The converted text is the final recognition result that is sent in the response body.

The response is returned in JSON format.

```json
{
  "result": <recognition hypothesis>
}  
```

## Examples {#examples}

### Request example {#request_examples}

---

**[!TAB POST request]**

```httpget
POST /speech/v1/stt:recognize/?topic=general&lang=ru-RU&folderId=<folder id> HTTP/1.1
Host: stt.api.cloud.yandex.net
Authorization: Bearer <IAM-token>
  
... (binary content of an audio file)
```

**[!TAB cURL]**

```httpget
curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderId=<folder id>"
```

**[!Tab Python]**

```python
import urllib.request
import json
with open("speech.ogg", "rb") as f:
    data = f.read()
url = urllib.request.Request("https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderId=<folder id>", data=data)
url.add_header("Authorization", "Bearer <IAM-token>")
responseData = urllib.request.urlopen(url).read().decode('UTF-8')
decodedData = json.loads(responseData)
if decodedData.get("error_code") is None:
    print(decodedData.get("result"))
```

---

### Response example {#response_examples}

```
HTTP/1.1 200 OK
YaCloud-Request-Id: YYXXYYXXYY-YXXY-YXXY-YXXY-YYXXYYXXYY
YaCloud-Billing-Units: 15
{
  "result": "твой номер 212-85-06"
}        
```

[!INCLUDE [request-id-note](../_includes/request-id-note.md)]

