# Распознавание речи в формате OggOpus

Чтобы распознать речь в формате [OggOpus](../../formats.md#oggopus), достаточно указать в конфигурации язык распознавания в поле `languageCode`. По умолчанию будет использована языковая модель `general`.

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

{% list tabs %}

- cURL
   1. Сформируйте тело запроса и сохраните его в файл, например `body.json`. Ссылку на аудиофайл в {{ objstorage-name }} укажите в поле `uri`:

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
   1. Отправьте запрос на распознавание, в параметре `IAM_TOKEN` укажите [IAM-токен](../../../iam/concepts/authorization/iam-token/):

       ```bash
       export IAM_TOKEN=<IAM-токен>
       curl -X POST \
           -H "Authorization: Bearer ${IAM_TOKEN}" \
           -d '@body.json' \
           https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
 
       {
           "done": false,
           "id": "e03sup6d5h1qr574ht99",
           "createdAt": "2019-04-21T22:49:29Z",
           "createdBy": "ajes08feato88ehbbhqq",
           "modifiedAt": "2019-04-21T22:49:29Z"
       }
       ```

      Сохраните идентификатор операции распознавания, полученный в ответе.
   1. Подождите немного, пока закончится распознавание. 1 минута одноканального аудио распознается примерно за 10 секунд.
   1. Отправьте запрос на [получение информации об операции](../../../api-design-guide/concepts/operation.md#monitoring):

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

   1. [Создайте API-ключ](../../../iam/operations/api-key/create.md), используемый для аутентификации в этом примере. Чтобы использовать IAM-токен для аутентификации, исправьте заголовок в переменной `header`: замените `Api-Key` на `Bearer` и добавьте код для [получения IAM-токена](../../../iam/operations/iam-token/create-for-sa.md) вместо API-ключа.
   1. Создайте Python-файл, например `test.py`, и добавьте в него следующий код:

       ```python
       # -*- coding: utf-8 -*-
 
       import requests
       import time
       import json
 
       # Укажите ваш API-ключ и ссылку на аудиофайл в Object Storage.
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
 
       # Если вы хотите использовать IAM-токен для аутентификации, замените Api-Key на Bearer.
       header = {'Authorization': 'Api-Key {}'.format(key)}
 
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
   1. Выполните созданный файл:

       ```bash
       python test.py
       ```
{% endlist %}
   