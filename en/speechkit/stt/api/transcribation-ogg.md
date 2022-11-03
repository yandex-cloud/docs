# Recognizing speech in OggOpus format

The example shows how the [API v2](transcribation-api.md) helps asynchronously recognize speech in the [OggOpus](../../formats.md#OggOpus) audio file format.

The examples use the following parameters:

* [Language](../index.md#langs): Russian.
* Other parameters were left with their default values.

Use the [cURL](https://curl.haxx.se) utility to generate and send a request to the server for recognition.

An [IAM token](../../../iam/concepts/authorization/iam-token.md) is used to authenticate the service account. Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

{% list tabs %}

- cURL

   1. Create a file (for example, `body.json`), and add the following code to it:

      ```json
      {
          "config": {
              "specification": {
                  "languageCode": "ru-RU"
              }
          },
          "audio": {
              "uri": "https://storage.yandexcloud.net/speechkit/speech.ogg"
          }
      }
      ```

      Where:

      * `languageCode`: [Language](../index.md#langs) that recognition is performed for.
      * `uri`: Link to audio file in {{ objstorage-name }}.

   1. Run the created file:

      ```bash
      export IAM_TOKEN=<IAM token>
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json" \
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```

      Where the `IAM_TOKEN` is an [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account.

      Result:

      ```bash
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Save the recognition operation `id` that you receive in the response.

   1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize one minute of an audio file.
   1. Send a request to [get information about the operation](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99
      ```

      Result:

      ```bash
      {
       "done": true,
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
        "chunks": [
         {
          "alternatives": [
           {
            "text": "your number is 212-85-06",
            "confidence": 1
           }
          ],
          "channelTag": "1"
         }
        ]
       },
       "id": "e03sup6d5h1qr574ht99",
       "createdAt": "2019-04-21T22:49:29Z",
       "createdBy": "ajes08feato88ehbbhqq",
       "modifiedAt": "2019-04-21T22:49:36Z"
      }
      ```

- Python 3

   1. Create a file (for example, `test.py`), and add the following code to it:

      ```python
      # -*- coding: utf-8 -*-

      import requests
      import time
      import json

      # Specify your API key and link to the audio file in Object Storage.
      key = '<IAM token>'
      filelink = 'https://storage.yandexcloud.net/speechkit/speech.ogg'

      POST = "https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize"

      body ={
          "config": {
              "specification": {
                  "languageCode": "ru-RU"
              }
          },
          "audio": {
              "uri": filelink
          }
      }

      header = {'Authorization': 'Bearer {}'.format(key)}

      # Send a recognition request.
      req = requests.post(POST, headers=header, json=body)
      data = req.json()
      print(data)

      id = data['id']

      # Request the operation status on the server until recognition is complete.
      while True:

          time.sleep(1)

          GET = "https://operation.{{ api-host }}/operations/{id}"
          req = requests.get(GET.format(id=id), headers=header)
          req = req.json()

          if req['done']: break
          print("Not ready")

      # Show the full server response in JSON format.
      print("Response:")
      print(json.dumps(req, ensure_ascii=False, indent=2))

      # Show only text from recognition results.
      print("Text chunks:")
      for chunk in req['response']['chunks']:
          print(chunk['alternatives'][0]['text'])
      ```

      Where:

      * `key`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account.
      * `filelink`: Link to audio file in {{ objstorage-name }}.

   1. Run the created file:

      ```bash
      python test.py
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-lpcm.md)
* [{#T}](../../concepts/auth.md)
