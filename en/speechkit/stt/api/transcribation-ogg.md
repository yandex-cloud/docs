# Recognizing speech in OggOpus format

To recognize speech in [OggOpus](../../formats.md#oggopus) format, just specify the recognition language in the `languageCode` field of the configuration. The language model used by default is `general`.

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

{% list tabs %}

- cURL
   1. Create a request body and save it to a file (such as `body.json`). Enter the link to the audio file in {{ objstorage-name }} in the `uri` field:

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

   1. Send a recognition request, specifying the [IAM token](../../../iam/concepts/authorization/iam-token/) in the `IAM_TOKEN` parameter:

      ```bash
      export IAM_TOKEN=<IAM token>
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json" \
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Save the recognition operation ID that you receive in the response.
   1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize 1 minute of a single-channel audio file.
   1. Send a request to [get information about the operation](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99
      
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

   1. [Create an API key](../../../iam/operations/api-key/create.md) for authentication in this example. To use an IAM token for authentication, correct the header in the `header` variable: replace `Api-Key` with `Bearer` and add the code used [to get an IAM token](../../../iam/operations/iam-token/create-for-sa.md).
   1. Create a Python file (such as `test.py`) and add the following code to it:

      ```python
      # -*- coding: utf-8 -*-
      
      import requests
      import time
      import json
      
      # Specify your API key and link to the audio file in Object Storage.
      key = '<API key>'
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
      
      # If you wish to use an IAM token for authentification, replace Api-Key with Bearer.
      header = {'Authorization': 'Api-Key {}'.format(key)}
      
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
   1. Run the created file:

      ```bash
      python test.py
      ```
{% endlist %}

