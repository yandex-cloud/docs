---
title: "Асинхронное распознавание аудиофайлов в формате OggOpus в {{ speechkit-full-name }}"
description: "Следуя данной инструкции, вы сможете использовать асинхронное распознавание аудиофайлов в формате OggOpus." 
---

# Асинхронное распознавание аудиофайлов в формате OggOpus

Ниже рассмотрены примеры [асинхронного распознавания речи](../transcribation.md) из аудиофайла с помощью [API v2](transcribation-api.md) {{ speechkit-name }}. В примерах заданы параметры:

* [язык](../models.md#languages) — русский;
* формат аудиопотока — [OggOpus](../../formats.md#OggOpus) с расширением файла OPUS;
* остальные параметры оставлены по умолчанию.

Вы можете сформировать и отправить запрос на распознавание речи с помощью утилиты [cURL](https://curl.haxx.se) или Python-скрипта.

Аутентификация происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

## Перед началом работы {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

Если у вас нет аудиофайла формата OggOpus, вы можете скачать [пример файла](https://{{ s3-storage-host }}/doc-files/speech.ogg).

## Выполните распознавание с помощью API {#recognize-using-api}

{% note warning %}

Для двухканальной OggOpus-записи не нужно указывать количество каналов с помощью параметра `audioChannelCount`.

{% endnote %}

{% list tabs %}

- cURL

  1. [Получите ссылку на аудиофайл](../../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
  1. Создайте файл, например `body.json`, и добавьте в него код:

      ```json
      {
          "config": {
              "specification": {
                  "languageCode": "ru-RU"
              }
          },
          "audio": {
              "uri": "<ссылка_на_аудиофайл>"
          }
      }
      ```

      Где:

      * `languageCode` — [язык](../models.md#languages), для которого будет выполнено распознавание.
      * `uri` — ссылка на аудиофайл в {{ objstorage-name }}. Пример ссылки: `https://{{ s3-storage-host }}/speechkit/speech.opus`.

         Для бакета с ограниченным доступом в ссылке присутствуют дополнительные query-параметры (после знака `?`). Эти параметры не нужно передавать в {{ speechkit-name }} — они игнорируются.

      Формат аудиопотока указывать не нужно, так как OggOpus — формат по умолчанию.

      {% note info %}

      Не передавайте параметр [audioChannelCount](transcribation-api.md#sendfile-params), чтобы указать количество аудиоканалов. Файлы формата OggOpus уже содержат информацию о количестве каналов.

      {% endnote %}

  1. Выполните созданный файл:

      ```bash
      export IAM_TOKEN=<IAM-токен_сервисного_аккаунта> && \
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json" \
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```

      Где `IAM_TOKEN` — IAM-токен сервисного аккаунта.

      Пример результата:

      ```text
      {
          "done": false,
          "id": "e03sup6d5h1q********",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato8********",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

  1. Подождите, пока закончится распознавание. Одна минута аудио распознается примерно за 10 секунд.
  1. Отправьте запрос на [получение информации об операции](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/<идентификатор_операции_распознавания>
      ```

      Пример результата:

      ```text
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
       "id": "e03sup6d5h1q********",
       "createdAt": "2019-04-21T22:49:29Z",
       "createdBy": "ajes08feato8********",
       "modifiedAt": "2019-04-21T22:49:36Z"
      }
      ```

- Python 3

  1. Установите пакет `requests` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

     ```bash
     pip install requests
     ```

  1. Создайте файл, например `test.py`, и добавьте в него код:

      ```python
      # -*- coding: utf-8 -*-

      import requests
      import time
      import json

      # Укажите ваш IAM-токен и ссылку на аудиофайл в {{ objstorage-name }}.
      key = '<IAM-токен_сервисного_аккаунта>'
      filelink = '<ссылка_на_аудиофайл>'
     
      POST ='https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize'

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

      # Отправьте запрос на распознавание.
      req = requests.post(POST, headers=header, json=body)
      data = req.json()
      print(data)

      id = data['id']

      # Запрашивайте на сервере статус операции, пока распознавание не будет завершено.
      while True:

          time.sleep(1)

          GET = "https://operation.{{ api-host }}/operations/{id}"
          req = requests.get(GET.format(id=id), headers=header)
          req = req.json()

          if req['done']: break
          print("Not ready")

      # Покажите полный ответ сервера в формате JSON.
      print("Response:")
      print(json.dumps(req, ensure_ascii=False, indent=2))

      # Покажите только текст из результатов распознавания.
      print("Text chunks:")
      for chunk in req['response']['chunks']:
          print(chunk['alternatives'][0]['text'])
      ```

      Где:

      * `key` — IAM-токен сервисного аккаунта;
      * `filelink` — ссылка на аудиофайл в {{ objstorage-name }}.

  1. Выполните созданный файл:

      ```bash
      python3 test.py
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-lpcm.md)
* [{#T}](batch-transcribation.md)
* [{#T}](../../concepts/auth.md)
