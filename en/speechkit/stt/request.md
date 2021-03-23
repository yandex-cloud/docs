# Short audio recognition

Short audio recognition ensures fast response time and is suitable for single-channel audio of small length.

If you want to recognize speech over the same connection, use [streaming mode](streaming.md). In streaming mode, you can get intermediate recognition results.

## Audio requirements {#Audio-requirements}

The audio you send must meet the following requirements:

1. Maximum file size: {{ stt-short-fileSize }}.
1. Maximum length: {{ stt-short-audioLength }}.
1. Maximum number of audio channels: {{ stt-short-channelsCount }}.

If your file is larger, longer, or has more audio channels, use [long audio recognition](transcribation.md).

## HTTP request {#http_request}

```
POST https://stt.api.cloud.yandex.net/speech/v1/stt:recognize
```

Use the `"Transfer-Encoding: chunked"` header for data streaming.

### Query parameters {#query_params}

| Parameter | Description |
| ----- | ----- |
| lang | **string**<br>The language to use for recognition.<br/>Acceptable values:<ul><li>`ru-RU` (by default) — Russian.</li><li>`en-US` — English.</li><li>`tr-TR` — Turkish.</li></ul> |
| topic | **string**<br>The language model to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>[Acceptable values](../stt/models.md) depend on the selected language. Default value: `general`. |
| profanityFilter | **boolean**<br>This parameter controls the profanity filter in recognized speech.<br>Acceptable values:<ul><li>`false` (default) — Profanities aren't excluded from recognition results.</li><li>`true` — Profanities are excluded from recognition results.</li></ul> |
| format | **string**<br>[The format](formats.md) of the submitted audio.<br/>Acceptable values:<ul><li>`lpcm` — [LPCM with no WAV header](formats.md#lpcm).</li><li>`oggopus` (default) — [OggOpus](formats.md#oggopus).</li></ul> |
| sampleRateHertz | **string**<br>The sampling frequency of the submitted audio.<br/>Used if `format` is set to `lpcm`. Acceptable values:<ul><li>`48000` (default) — Sampling rate of 48 kHz.</li><li>`16000` — Sampling rate of 16 kHz.</li><li>`8000` — Sampling rate of 8 kHz.</li></ul> |
| folderId | **string**<br><p>ID of the folder that you have access to. Required for authorization with a user account (see the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make a request on behalf of a service account.</p> <p>Maximum string length: 50 characters.</p> |

### Parameters in the request body {#body_params}

The request body has to contain the binary content of an audio file.

## Response {#response}

The recognized text is returned in the response in the `result` field.

```json
{
  "result": <recognized text>
}
```

## Examples {#examples}

To recognize speech in Russian, send an audio fragment (for example, [speech.ogg](https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg)) to the service.

### Sample request {#request_examples}

{% list tabs %}

- POST request

  ```httpget
  POST /speech/v1/stt:recognize?topic=general&lang=ru-RU&folderId={folder ID} HTTP/1.1
  Host: stt.api.cloud.yandex.net
  Authorization: Bearer <IAM-TOKEN>

  ... (binary content of an audio file)
  ```

- cURL

  ```httpget
  $ export FOLDER_ID=b1gvmob95yysaplct532
  $ export IAM_TOKEN=CggaATEVAgA...
  $ curl -X POST \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -H "Transfer-Encoding: chunked" \
       --data-binary "@speech.ogg" \
       "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?topic=general&folderId=${FOLDER_ID}"
  ```

- Python 3

  ```python
  import urllib.request
  import json

  FOLDER_ID = "b1gvmob95yysaplct532" # ID of the folder
  IAM_TOKEN = "CggaATEVAgA..." # IAM token

  with open("speech.ogg", "rb") as f:
      data = f.read()

  params = "&".join([
      "topic=general",
      "folderId=%s" % FOLDER_ID,
      "lang=ru-RU"
  ])

  url = urllib.request.Request("https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?%s" % params, data=data)
  url.add_header("Authorization", "Bearer %s" % IAM_TOKEN)

  responseData = urllib.request.urlopen(url).read().decode('UTF-8')
  decodedData = json.loads(responseData)

  if decodedData.get("error_code") is None:
      print(decodedData.get("result"))
  ```

- PHP

  ```php
  <?php

  $token = 'CggaATEVAgA...'; # IAM token
  $folderId = "b1gvmob95yysaplct532"; # ID of the folder
  $audioFileName = "speech.ogg";

  $file = fopen($audioFileName, 'rb');

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?lang=ru-RU&folderId=${folderId}&format=oggopus");
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $token, 'Transfer-Encoding: chunked'));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
  curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);

  curl_setopt($ch, CURLOPT_INFILE, $file);
  curl_setopt($ch, CURLOPT_INFILESIZE, filesize($audioFileName));
  $res = curl_exec($ch);
  curl_close($ch);
  $decodedResponse = json_decode($res, true);
  if (isset($decodedResponse["result"])) {
      echo $decodedResponse["result"];
  } else {
      echo "Error code: " . $decodedResponse["error_code"] . "\r\n";
      echo "Error message: " . $decodedResponse["error_message"] . "\r\n";
  }

  fclose($file);
  ```

{% endlist %}

### Response example {#response_examples}

```
HTTP/1.1 200 OK
YaCloud-Billing-Units: 15
{
  "result": "your number is 212-85-06"
}
```

