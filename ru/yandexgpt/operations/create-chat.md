---
title: "Как отправить запрос в режиме чата в {{ yagpt-full-name }}"
description: "Следуя данной инструкции, вы научитесь использовать {{ yagpt-full-name }} в режиме чата."
---

# Отправить запрос в режиме чата

Чтобы сгенерировать текст в [режиме чата](../concepts/index.md#working-mode), передайте список сообщений, представляющих контекст для модели, с помощью метода [completion](../api-ref/v1/TextGeneration/completion.md).

## Перед началом работы {#before-begin}

{% include notitle [ai-before-beginning](../../_includes/yandexgpt/ai-before-beginning.md) %}

## Отправьте запрос к модели {#request}

1. Создайте файл с телом запроса (например, `body.json`):

   ```json
   {
     "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
     "completionOptions": {
       "stream": false,
       "temperature": 0.6,
       "maxTokens": "2000"
     },
     "messages": [
       {
         "role": "system",
         "text": "Ты умный ассистент"
       },
       {
         "role": "user", 
         "text": "Привет! Как мне подготовиться к экзаменам?"
       },
       {
         "role": "assistant", 
         "text": "Привет! По каким предметам?"
       },
       {
         "role": "user", 
         "text": "Математике и физике"
       }
     ]
   }
   ```

   Где:

   {% include [api-parameters](../../_includes/yandexgpt/api-parameters.md) %}

1. Отправьте запрос к модели:

   {% list tabs group=programming_language %}

   - cURL {#curl}

     Выполните команду:

     ```bash
     export FOLDER_ID=<идентификатор_каталога>
     export IAM_TOKEN=<IAM-токен>
     curl --request POST \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -H "x-folder-id: ${FOLDER_ID}" \
       -d "@<путь_до_файла_json>" \
       "https://llm.{{ api-host }}/foundationModels/v1/completion"
     ```

     Где:

     * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
     * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

   - Python 3 {#python}

     1. Создайте файл `index.py` и добавьте в него код:

        ```python
        import requests
        import json
        import os

        def gpt(auth_headers):

            url = 'https://llm.api.cloud.yandex.net/foundationModels/v1/completion'

            with open('body.json', 'r', encoding='utf-8') as f:
                data = json.dumps(json.load(f))
            resp = requests.post(url, headers=auth_headers, data=data)

            if resp.status_code != 200:
                raise RuntimeError(
                    'Invalid response received: code: {}, message: {}'.format(
                        {resp.status_code}, {resp.text}
                    )
                )

            return resp.text

        if __name__ == "__main__":
            if os.getenv('IAM_TOKEN') is not None:
                iam_token = os.environ['IAM_TOKEN']
                headers = {
                    'Authorization': f'Bearer {iam_token}',
                }
            elif os.getenv('API_KEY') is not None:
                api_key = os.environ['API_KEY']
                headers = {
                    'Authorization': f'Api-Key {api_key}',
                }
            else:
                print ('Please save either an IAM token or an API key into a corresponding `IAM_TOKEN` or `API_KEY` environment variable.')
                exit()

            print(gpt(headers))
        ```

     1. Сохраните данные для аутентификации в переменную окружения:

        **Для аутентификации с помощью IAM-токена:**

        ```bash
        export IAM_TOKEN=<IAM-токен>
        ```

        **Для аутентификации с помощью API-ключа:**

        ```bash
        export API_KEY=<API-ключ>
        ```

     1. Выполните созданный файл:

        ```bash
        python index.py
        ```

   {% endlist %}

   В ответе сервис вернет сгенерированный текст:

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "1. Составь план подготовки. Определи, сколько времени ты сможешь уделять учебе каждый день, и распредели его на математику и физику.\n\n
             2. Изучай материал последовательно. Начинай с математики, затем переходи к физике и повторяй их в том же порядке. Так ты не забудешь то, что уже изучал.\n\n
             3. Используй учебники и учебные пособия. Они помогут тебе разобраться в сложных темах и понять основные принципы.\n\n
             4. Решай задачи и примеры. Это поможет закрепить знания и научиться применять их на практике.\n\n
             5. Не забывай о перерывах. Постоянная учеба может утомлять, поэтому делай перерывы каждые 30-40 минут и занимайся физкультурой или йогой.\n\n
             6. Не бойся ошибаться. Ошибки - это нормально. Они показывают, где у тебя есть пробелы в знаниях, и помогают их заполнить.\n\n
             7. Делай регулярные проверки знаний. Это поможет оценить свой прогресс и определить, какие темы требуют дополнительного внимания.\n\n
             8. Не перегружай себя. Если ты устал или не хочешь заниматься, не заставляй себя. Отдохни и вернись к учебе с новыми силами.\n\n
             9. Не забывай про здоровый образ жизни. Правильное питание, сон и физическая активность помогут тебе лучше усваивать информацию и быть более внимательным на экзаменах.\n\n
             10. И, наконец, главное - не волнуйся. Волнение может помешать тебе сосредоточиться и усвоить материал. Помни, что экзамены - это всего лишь проверка твоих знаний и навыков, а не конец света. Удачи тебе на экзаменах!"
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "44",
         "completionTokens": "323",
         "totalTokens": "367"
       },
       "modelVersion": "06.12.2023"
     }
   }
   ```
