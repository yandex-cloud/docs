# Распознавание речи в формате OggOpus

Пример показывает, как с помощью [API v2](transcribation-api.md) распознать речь, записанную в аудиофайле формата [OggOpus](../../formats.md#OggOpus), в режиме асинхронного распознавания.

В примерах заданы следующие параметры:

* [язык](../index.md#langs) — русский;
* остальные параметры оставлены по умолчанию.

Формирование и отправка запроса к серверу, выполняющему распознавание, происходит с помощью утилиты [cURL](https://curl.haxx.se).

Аутентификация происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

{% list tabs %}

- cURL

  1. Создайте файл, например `body.json`, и добавьте в него следующий код:

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

      Где:

      * `languageCode` — [язык](../index.md#langs), для которого будет выполнено распознавание.
      * `uri` — ссылка на аудиофайл в {{ objstorage-name }}.

  1. Выполните созданный файл:

      ```bash
      export IAM_TOKEN=<IAM-токен>
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json" \
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```
  
      Где `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.

      Результат:

      ```bash
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

  1. Подождите немного, пока закончится распознавание. Одна минута аудио распознается примерно за 10 секунд.
  1. Отправьте запрос на [получение информации об операции](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99
      ```

      Результат:

      ```bash
      {
       "done": true,
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
        "chunks": [
         {
          "alternatives": [
           {
            "text": "твой номер 212-85-06",
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

  1. Создайте файл, например `test.py`, и добавьте в него следующий код:
  
      ```python
      # -*- coding: utf-8 -*-
  
      import requests
      import time
      import json
  
      # Укажите ваш API-ключ и ссылку на аудиофайл в Object Storage.
      key = '<IAM-токен>'
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
  
      # Отправить запрос на распознавание.
      req = requests.post(POST, headers=header, json=body)
      data = req.json()
      print(data)
  
      id = data['id']
  
      # Запрашивать на сервере статус операции, пока распознавание не будет завершено.
      while True:
  
          time.sleep(1)
  
          GET = "https://operation.{{ api-host }}/operations/{id}"
          req = requests.get(GET.format(id=id), headers=header)
          req = req.json()
  
          if req['done']: break
          print("Not ready")
  
      # Показать полный ответ сервера в формате JSON.
      print("Response:")
      print(json.dumps(req, ensure_ascii=False, indent=2))
  
      # Показать только текст из результатов распознавания.
      print("Text chunks:")
      for chunk in req['response']['chunks']:
          print(chunk['alternatives'][0]['text'])
      ```

      Где:

      * `key` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.
      * `filelink` — ссылка на аудиофайл в {{ objstorage-name }}.

  1. Выполните созданный файл:

      ```bash
      python test.py
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-lpcm.md)
* [{#T}](../../concepts/auth.md)
