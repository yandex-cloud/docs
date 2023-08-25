# Example use for synchronous recognition API

The example shows how the [API v2](request-api.md) helps synchronously recognize speech in the [OggOpus](../../formats.md#OggOpus) audio file format.

The example uses the following parameters:

* [Language](../index.md#langs): Russian.
* Other parameters were left with their default values.

Use the [cURL](https://curl.haxx.se) utility to generate and send a request to the server for recognition.

The Yandex account or federated account are authenticated using an [IAM token](../../../iam/concepts/authorization/iam-token.md). If you use your service account, you do not need to include the folder ID in the request. Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

## Sample request {#request_examples}

{% list tabs %}

- POST request

   Send a [request](../request.md) to convert speech to text:

   ```httpget
   POST /speech/v1/stt:recognize?topic=general&lang=ru-RU&folderId={<folder ID>} HTTP/1.1
   Host: stt.{{ api-host }}
   Authorization: Bearer <IAM token>

   ... (binary content of an audio file)
   ```

   Where:

   * `topic`: [Language model](../models.md).
   * `lang`: [Recognition language](../index.md#langs).
   * `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `<IAM token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md).

- cURL

   Send a [request](../request.md) to convert speech to text:

   ```bash
   export FOLDER_ID=<folder ID>
   export IAM_TOKEN=<IAM token>
   curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -H "Transfer-Encoding: chunked" \
        --data-binary "@speech.ogg" \
        "https://stt.{{ api-host }}/speech/v1/stt:recognize?topic=general&folderId=${FOLDER_ID}"
   ```

   Where:

   * `FOLDER_ID`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `--data-binary`: Name of the audio file for recognition.
   * `topic`: [Language model](../models.md).

- Python 3

   Send a [request](../request.md) to convert speech to text:

   ```python
   import urllib.request
   import json

   FOLDER_ID = "<folder ID>" # Folder ID
   IAM_TOKEN = "<IAM token>" # IAM token

   with open("speech.ogg", "rb") as f:
       data = f.read()

   params = "&".join([
       "topic=general",
       "folderId=%s" % FOLDER_ID,
       "lang=ru-RU"
   ])

   url = urllib.request.Request("https://stt.{{ api-host }}/speech/v1/stt:recognize?%s" % params, data=data)
   url.add_header("Authorization", "Bearer %s" % IAM_TOKEN)

   responseData = urllib.request.urlopen(url).read().decode('UTF-8')
   decodedData = json.loads(responseData)

   if decodedData.get("error_code") is None:
       print(decodedData.get("result"))
   ```

   Where:

   * `FOLDER_ID`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `speech.ogg`: Name of the audio file for recognition.
   * `topic`: [Language model](../models.md).
   * `lang`: [Recognition language](../index.md#langs).

- PHP

   Send a [request](../request.md) to convert speech to text:

   ```php
   <?php

   $token = '<IAM token>'; # IAM token
   $folderId = "<folder ID>"; # Folder ID
   $audioFileName = "speech.ogg";

   $file = fopen($audioFileName, 'rb');

   $ch = curl_init();
   curl_setopt($ch, CURLOPT_URL, "https://stt.{{ api-host }}/speech/v1/stt:recognize?lang=ru-RU&folderId=${folderId}&format=oggopus");
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

   Where:

   * `token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `audioFileName`: Name of the audio file for recognition.
   * `lang`: [Recognition language](../index.md#langs).
   * `format`: [Format](../../formats.md) of submitted audio.

{% endlist %}

## Response example {#response_examples}

```text
HTTP/1.1 200 OK
YaCloud-Billing-Units: 15
{
  "result": "your number is 212-85-06"
}
```

#### See also {#see-also}

* [{#T}](request-api.md)
* [{#T}](../../concepts/auth.md)
* [{#T}](../../sdk/python/request.md)
