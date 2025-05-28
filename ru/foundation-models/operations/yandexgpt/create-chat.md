---
title: Как отправить серию запросов в режиме чата в {{ gpt-lite }} или {{ gpt-pro }}
description: Следуя данной инструкции, вы научитесь использовать {{ gpt-lite }} и {{ gpt-pro }} в режиме чата.
---

# Как реализовать чат с {{ gpt-lite }} или {{ gpt-pro }}

Модели {{ gpt-lite }} и {{ gpt-pro }} не хранят контекст предшествующих сообщений, поэтому для реализации диалога с выбранной моделью историю сообщений нужно сохранять на стороне клиента и передавать в каждом обращении к модели. [Чат](../../concepts/yandexgpt/index.md), доступный в консоли управления, представляет собой серию промт-запросов, в которой в контекст каждого нового запроса добавляются ответы модели на предыдущие запросы. Модели генерации текста имеют [ограничения](../../concepts/limits.md) на длину контекста.

{% note tip %}

Используйте {{ assistant-api }}, чтобы создать чат с моделью. Пример реализации чата с помощью ассистентов и тредов доступен в инструкции [{#T}](../assistant/create.md).

{% endnote %}

Чтобы реализовать в своем приложении чат с моделью и избежать задержек с ответами, отправляйте промт-запросы в [синхронном](../../concepts/index.md#working-mode) режиме с помощью метода [completion](../../text-generation/api-ref/TextGeneration/completion.md) или [{{ ml-sdk-full-name }}](../../sdk/index.md).

## Перед началом работы {#before-begin}

{% list tabs group=programming_language %}

- SDK {#sdk}

  Чтобы воспользоваться примерами запросов с использованием SDK:

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

- Python {#python}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Реализуйте чат {#develop-chat}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `create-chat.py` и добавьте в него следующий код:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations
      from yandex_cloud_ml_sdk import YCloudML

      messages = [
          {
              "role": "system",
              "text": "Ты умный ассистент",
          },
          {
              "role": "user",
              "text": "Привет! Какими науками занимался Альберт Эйнштейн?",
          },
      ]

      def main():
          sdk = YCloudML(
              folder_id="<идентификатор_каталога>",
              auth="<API-ключ>",
          )

          result = (
              sdk.models.completions("yandexgpt").configure(temperature=0.6).run(messages)
          )

          for alternative in result:
              print(alternative)

      if __name__ == "__main__":
          main()
      ```

      Где:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% endnote %}

      {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      {% include [yandexgpt-model-version-sdk-info](../../../_includes/foundation-models/yandexgpt/yandexgpt-model-version-sdk-info.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 create-chat.py
      ```

      Результат:

      ```text
      Alternative(role='assistant', text='Альберт Эйнштейн занимался **физикой** и **математикой**. Его работы оказали огромное влияние на обе эти науки, а также на развитие теоретической физики в целом.', status=<AlternativeStatus.FINAL: 3>)
      ```

  1. В конец массива `messages` в файле `create-chat.py` добавьте ответ, полученный в результате выполнения предыдущего запроса к модели, а также новый вопрос пользователя:

      ```python
      ...
      messages = [
          {
              "role": "system",
              "text": "Ты умный ассистент",
          },
          {
              "role": "user",
              "text": "Привет! Какими науками занимался Альберт Эйнштейн?",
          },
          {
              "role": "assistant",
              "text": """Альберт Эйнштейн занимался **физикой** и **математикой**. 
      Его работы оказали огромное влияние на обе эти науки, 
      а также на развитие теоретической физики в целом.""",
          },
          {
              "role": "user",
              "text": "Какие важные открытия он совершил?",
          },
      ]
      ...
      ```

  1. Вновь выполните файл:

      ```bash
      python3 create-chat.py
      ```

      Результат:

      ```text
      Alternative(role='assistant', text='Альберт Эйнштейн — один из самых выдающихся учёных XX века. Вот несколько его важных открытий:\n* **Специальная теория относительности.** Эйнштейн разработал специальную теорию относительности, которая описывает движение, законы механики и пространственно-временные отношения при произвольных скоростях движения, меньших скорости света в вакууме.\n* **Общая теория относительности.** Эта теория описывает гравитацию как искривление пространства-времени и позволяет понять многие астрономические явления, включая гравитационные волны и чёрную дыру.\n* **Фотоэлектрический эффект.** За это открытие Эйнштейну была присуждена Нобелевская премия по физике. Его работа объясняет, как свет может выбивать электроны из вещества, что стало основой для квантовой теории.\n* **Эквивалентность массы и энергии.** Формула $E=mc^2$ стала одной из самых известных в науке. Она объясняет, как масса может быть преобразована в энергию и наоборот.', status=<AlternativeStatus.FINAL: 3>)
      ```

  1. Продолжайте дополнять контекст запроса полученными ответами и вопросами пользователя:

      ```python
      ...
      messages = [
          {
              "role": "system",
              "text": "Ты умный ассистент",
          },
          {
              "role": "user",
              "text": "Привет! Какими науками занимался Альберт Эйнштейн?",
          },
          {
              "role": "assistant",
              "text": """Альберт Эйнштейн занимался **физикой** и **математикой**. 
      Его работы оказали огромное влияние на обе эти науки, 
      а также на развитие теоретической физики в целом.""",
          },
          {
              "role": "user",
              "text": "Какие важные открытия он совершил?",
          },
          {
              "role": "assistant",
              "text": """Альберт Эйнштейн — один из самых выдающихся учёных XX века. 
      Вот несколько его важных открытий:\n* **Специальная теория относительности.** 
      Эйнштейн разработал специальную теорию относительности, которая описывает движение, 
      законы механики и пространственно-временные отношения при произвольных скоростях 
      движения, меньших скорости света в вакууме.\n* **Общая теория относительности.** 
      Эта теория описывает гравитацию как искривление пространства-времени и позволяет 
      понять многие астрономические явления, включая гравитационные волны и чёрную дыру.\n* 
      **Фотоэлектрический эффект.** За это открытие Эйнштейну была присуждена 
      Нобелевская премия по физике. Его работа объясняет, как свет может выбивать электроны 
      из вещества, что стало основой для квантовой теории.\n* **Эквивалентность массы 
      и энергии.** Формула $E=mc^2$ стала одной из самых известных в науке. 
      Она объясняет, как масса может быть преобразована в энергию и наоборот.""",
          },
          {
              "role": "user",
              "text": "Сделай короче",
          },
      ]
      ...
      ```

      Результат:

      ```text
      Alternative(role='assistant', text='Альберт Эйнштейн — один из самых выдающихся учёных XX века. Вот несколько его важных открытий:\n* **Специальная теория относительности** описывает движение, законы механики и пространственно-временные отношения при скоростях меньше скорости света.\n* **Общая теория относительности** объясняет гравитацию как искривление пространства-времени.\n* За открытие **фотоэлектрического эффекта** Эйнштейну присудили Нобелевскую премию по физике. Его работа объясняет выбивание электронов из вещества под действием света.\n* Формула $E=mc^2$ демонстрирует **эквивалентность массы и энергии**.', status=<AlternativeStatus.FINAL: 3>)
      ```

- cURL {#curl}

  1. Подготовьте файл запроса к модели, например `body.json`:
  
      {% include notitle [create-chat-body-json-part](../../../_includes/foundation-models/yandexgpt/create-chat-body-json-part.md) %}

  1. Отправьте запрос к модели:

      ```bash
      export FOLDER_ID=<идентификатор_каталога>
      export IAM_TOKEN=<IAM-токен>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "x-folder-id: ${FOLDER_ID}" \
        --data "@<путь_до_файла_json>" \
        "https://llm.{{ api-host }}/foundationModels/v1/completion"
      ```

      Где:

      * `FOLDER_ID` — идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
      * `IAM_TOKEN` — IAM-токен вашего аккаунта.

  1. В ответ на запрос модель вернет сгенерированный текст:

      {% include notitle [create-chat-step-3](../../../_includes/foundation-models/yandexgpt/create-chat-step-3.md) %}

  1. В конец массива `messages` в файл запроса добавьте значение записи `message`, полученное в результате выполнения предыдущего запроса к модели, а также новый вопрос пользователя:

      {% include notitle [create-chat-step-4](../../../_includes/foundation-models/yandexgpt/create-chat-step-4.md) %}

  1. Отправьте новый запрос к модели, повторив второй шаг инструкции. В ответ на запрос модель снова вернет сгенерированный текст:

      {% include notitle [create-chat-step-5](../../../_includes/foundation-models/yandexgpt/create-chat-step-5.md) %}

  1. Продолжайте дополнять контекст запроса полученными ответами и вопросами пользователя:

      {% include notitle [create-chat-step-6](../../../_includes/foundation-models/yandexgpt/create-chat-step-6.md) %}

- Python {#python}

  1. Подготовьте файл запроса к модели, например `body.json`:
  
      {% include notitle [create-chat-body-json-part](../../../_includes/foundation-models/yandexgpt/create-chat-body-json-part.md) %}

  1. Отправьте запрос к модели:

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

         **Для аутентификации с помощью API-ключа (только для сервисного аккаунта):**

         ```bash
         export API_KEY=<API-ключ>
         ```

      1. Выполните созданный файл:

         ```bash
         python index.py
         ```

  1. В ответ на запрос модель вернет сгенерированный текст:

      {% include notitle [create-chat-step-3](../../../_includes/foundation-models/yandexgpt/create-chat-step-3.md) %}

  1. В конец массива `messages` в файл запроса добавьте значение записи `message`, полученное в результате выполнения предыдущего запроса к модели, а также новый вопрос пользователя:

      {% include notitle [create-chat-step-4](../../../_includes/foundation-models/yandexgpt/create-chat-step-4.md) %}

  1. Отправьте новый запрос к модели, повторив шаг `2.3` инструкции. В ответ на запрос модель снова вернет сгенерированный текст:

      {% include notitle [create-chat-step-5](../../../_includes/foundation-models/yandexgpt/create-chat-step-5.md) %}

  1. Продолжайте дополнять контекст запроса полученными ответами и вопросами пользователя:

      {% include notitle [create-chat-step-6](../../../_includes/foundation-models/yandexgpt/create-chat-step-6.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/yandexgpt/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)