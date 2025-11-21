---
title: Переход с {{ assistant-api }} на {{ responses-api }}
description: С помощью этого руководства вы сможете пересобрать в {{ responses-api }} существующих AI-ассистентов, построенных на основе {{ assistant-api }} в {{ foundation-models-full-name }}.
---

# Переход с {{ assistant-api }} на {{ responses-api }}

{{ assistant-api }} позволял создавать AI-ассистентов, которые хранили контекст взаимодействия с пользователем в тредах, могли использовать [инструменты](../assistant/tools/index.md) {{ retrieval-tool-name }} и WebSearch, а также получать промежуточные ответы модели.

Для новых и текущих проектов мы рекомендуем использовать {{ responses-api }} — простой и гибкий интерфейс, который позволяет сохранять контекст диалога. {{ responses-api }} предоставляет [встроенные инструменты](./index.md#tools) поиска по файлам и поиска в интернете, позволяет использовать собственные функции, вызывать внешние инструменты через MCP-серверы и обеспечивает высокую производительность.

{% note warning %}

С 10 декабря 2025 года функциональность [{{ assistant-api }}](../assistant/index.md) в {{ ai-studio-full-name }} перестанет поддерживаться и будет полностью отключена 26 января 2026 года. Переведите все свои актуальные проекты на {{ responses-api }} до 26 января 2026 года.

{% endnote %}

С помощью этого руководства вы сможете преобразовать существующих AI-ассистентов, построенных на основе {{ assistant-api }}, в AI-агентов на базе {{ responses-api }}.

[_AI-агент_](./index.md) в {{ responses-api }} — это экземпляр модели с заданной конфигурацией: инструкцией, настроенными инструментами и контекстом взаимодействия. AI-агент определяет поведение модели и способ ее взаимодействия с пользователем и другими системами.

## Различия между {{ assistant-api }} и {{ responses-api }} {#differences}

Понятия и инструменты, использующиеся в {{ assistant-api }} и {{ responses-api }}, различаются:

| **{{ assistant-api }}** | **{{ responses-api }}** |
| --- | --- |
| **Assistant** — AI-ассистент как ресурс сервиса. | При работе через API отдельный ресурс не создается, все настройки передаются непосредственно в методе `responses.create()`. В [консоли управления]({{ link-console-main }}) конфигурацию AI-агента можно сохранить с уникальным идентификатором и затем использовать в {{ responses-api }}. |
| **Thread** — тред диалога. | Не существует тредов, содержащих контекст всех сообщений. Историю переписки можно передавать как контекст нового вызова `response` в поле `previous_response_id`. |
| **Run** — запуск AI-ассистента для треда. | Объект `response` — результат выполнения метода `responses.create()`. Каждый объект `response` — это аналог запуска (`Run`) {{ assistant-api }}, в котором содержится готовый ответ. |
| **Retrieval** — инструмент поиска по поисковым индексам. | [Встроенный инструмент](tools/filesearch.md) `file_search` для поиска по файлам. Для поиска необходимо указать массив индексов {{ vector-store-name }}. |
| **WebSearch** — инструмент поиска в интернете. | [Встроенный инструмент](tools/websearch.md) `web_search` для поиска в интернете. Можно указать домен и регион поиска. |
| **Streaming** — получение промежуточных ответов модели. | Метод `client.responses.stream()`. |

### Концептуальные различия {#basic-differences}

Основные концептуальные отличия {{ responses-api }} и {{ assistant-api }}:

1. В {{ responses-api }} не существует ассистентов как отдельных ресурсов сервиса {{ ai-studio-name }}.

    #|
    || **{{ assistant-api }}** | **{{ responses-api }}** ||
    ||
    В {{ assistant-api }} необходимо создать AI-ассистента один раз. После этого его можно запускать в разных тредах.
    |
    В Responses API для каждого запроса необходимо указывать:
    * модель `model`;
    * инструкции `instructions`;
    * используемые инструменты `tools`;
    * параметры модели (`temperature`, `max_output_tokens` и т.д.)
    ||
    |#

    Для адаптации вашего кода на {{ responses-api }} воспользуйтесь одним из двух вариантов сохранения настроек модели:
    * Вынесите конфигурацию AI-ассистента из {{ assistant-api }} в код вашего приложения.
    * В [консоли управления]({{ link-console-main }}/link/ml/ai-studio/agents) в разделе **{{ ui-key.yacloud.yagpt.YaGPT.navigation-group_agents_eDBFf }}** задайте и сохраните конфигурацию модели. После этого вы сможете использовать ее в коде вашего приложения, указывая идентификатор сохраненного агента в запросе.

1. Контекст передается не в тредах, а в сообщениях в поле `previous_response_id`.

    #|
    || **{{ assistant-api }}** | **{{ responses-api }}** ||
    ||
    В {{ assistant-api }} контекст хранится в тредах (`thread`), и каждый запуск (`run`) перечитывает его.
    |
    В {{ responses-api }} реализован механизм, который позволяет передать идентификатор предыдущего сообщения в поле `previous_response_id`, чтобы учитывать историю сообщений.
    ||
    |#

    {% note info %}

    Срок хранения сообщений ограничен и составляет 30 дней с момента их создания методом `responses.create()`.

    {% endnote %}

1. Инструменты встроены в {{ responses-api }} и не требуют подключения дополнительных библиотек.

    #|
    || **{{ assistant-api }}** | **{{ responses-api }}** ||
    ||
    {{ retrieval-tool-name }} и WebSearch в {{ assistant-api }} настраиваются глобально как инструменты ассистента и используют внешние источники и отдельные поисковые индексы.
    |
    В {{ responses-api }} сценарии поиска по файлам и поиска в интернете реализованы через поле `tools`, которое позволяет задавать разный набор инструментов для каждого запроса. Доступные следующие значения поля:

    * `{"type": "file_search"}`
    * `{"type": "web_search"}`
    ||
    |#

## Как перенести простого текстового ассистента на {{ responses-api }} {#migrate-simple-assistant}

### Схема работы AI-ассистента через {{ assistant-api }} {#simple-assistant-api}

{% include [assistant-api-chart](../../../_mermaid/other/ai-studio/assistant-api-chart.md) %}

Работа с ассистентом в {{ assistant-api }} состоит из следующих этапов:

* Создание AI-ассистента, в котором хранятся настройки модели, инструменты и базовые инструкции.
* Создание треда (контейнера для диалога).
* Создание сообщения в треде (сообщение пользователя).
* Запуск ассистента для обработки треда.
* Опрос состояния запуска, чтобы дождаться завершения его выполнения.
* Получение сообщения из треда (ответ модели).

### Схема работы с AI-агентом через {{ responses-api }} {#simple-responses-api}

В {{ responses-api }} AI-агент — это набор параметров в коде, а контекст предыдущего диалога передается через поле `previous_response_id`.

Логика вашего приложения должна сохранять идентификатор `response.id` как аналог треда в {{ assistant-api }}. Чтобы получить ответ с учетом истории переписки, передавайте идентификатор последнего сообщения `response.id` в поле `previous_response_id` с каждым последующим сообщением пользователя.

Пример работы простого текстового AI-агента на {{ responses-api }}:

{% list tabs %}

- Python SDK

  ```python
  from openai import OpenAI

  YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
  YANDEX_CLOUD_MODEL = "<URI_модели>"
  YANDEX_CLOUD_API_KEY = "<API-ключ_сервисного_аккаунта>"
  # или YANDEX_CLOUD_IAM_TOKEN = "<IAM-токен>"

  previous_id = None  # храним ID последнего ответа ассистента

  client = OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      project=YANDEX_CLOUD_FOLDER,
      base_url="https://rest-assistant.{{ api-host }}/v1",
  )

  print("Чат с агентом (для выхода введите 'выход')\n")

  while True:
      user_input = input("Вы: ")
      if user_input.lower() in ("exit", "quit", "выход"):
          print("Чат завершен.")
          break

      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          input=[{"role": "user", "content": user_input}],
          instructions="Ты — текстовый агент, который ведет диалог и дает информативные ответы на вопросы пользователя.",
          previous_response_id=previous_id,  # передаем контекст, если он есть
      )

      # сохраняем ID для следующего шага
      previous_id = response.id

      # выводим ответ агента
      print("Агент:", response.output_text)
  ```

{% endlist %}

## Как перенести на {{ responses-api }} ассистента с инструментами {#migrate-tooled-assistant}

Процесс переноса AI-ассистента на {{ responses-api }} зависит от подключенных инструментов и режима получения результатов генерации.

### Сценарии RAG с {{ retrieval-tool-name }} {#rag-tools}

В сценариях поиска по файлам и внутренним базам знаний используются поисковые индексы {{ assistant-api }} и инструмент {{ retrieval-tool-name }}: AI-ассистент генерирует ответы на основе загруженных в индексы документов и возвращает метаданные использованных файлов.

В {{ assistant-api }} инструмент {{ retrieval-tool-name }} был привязан к ассистенту:
  
{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  # Сначала создается инструмент для работы с существующим поисковым индексом.
  tool = sdk.tools.search_index(
      search_index,
      call_strategy={
          "type": "function",
          "function": {"name": "guide", "instruction": instruction},
      },
  )

  # Затем создается ассистент, использующий этот инструмент.
  assistant = sdk.assistants.create(
      "yandexgpt",
      instruction="Ты — помощник по внутренней документации компании. Отвечай вежливо. Если информация не содержится в документах ниже, не придумывай ответ.",
      tools=[tool],
  )
  thread = sdk.threads.create()
  ```

{% endlist %}

Чтобы перенести AI-ассистента с подключенным инструментом {{ retrieval-tool-name }}, выполните следующие действия:

1. Все документы подключенного поискового индекса загрузите в [векторное хранилище](../search/vectorstore.md), с которым работает {{ responses-api }}.
1. При формировании запроса в вашем приложении добавляйте настройки инструмента `file_search`:

  {% list tabs group=programming_language %}

  - Python SDK {#sdk}

    ```python
    import openai
    import json

    YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
    YANDEX_CLOUD_MODEL = "<URI_модели>"
    VECTOR_STORE_ID = "<идентификатор_хранилища_Vector_Store>"
    YANDEX_CLOUD_API_KEY = "<API-ключ_сервисного_аккаунта>"
    # или YANDEX_CLOUD_IAM_TOKEN = "<IAM-токен>"


    client = openai.OpenAI(
        api_key=YANDEX_CLOUD_API_KEY,
        base_url="https://rest-assistant.{{ api-host }}/v1",
        project=YANDEX_CLOUD_FOLDER,
    )

    response = client.responses.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
        instructions="Ты — умный ассистент. Если спрашивают про ... - ищи в подключенном индексе",
        tools=[
            {
                "type": "file_search", 
                "vector_store_ids": [VECTOR_STORE_ID],
            }
        ],
        input="что такое ...",
    )

    print("Текст ответа:")
    print(response.output_text)
    print("\n" + "=" * 50 + "\n")

    # Полный ответ
    print("Полный ответ (JSON):")
    print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
    ```

  {% endlist %}

### Сценарии с поиском в интернете {#websearch-tool}

В {{ assistant-api }} настройки инструмента `WebSearch` задавались при создании AI-ассистента:

{% list tabs group=programming_language %}

- cURL {#curl}

  ```json
  {
    "folderId": "<идентификатор_каталога>",
    "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest",
    "instruction": "Ты — умный помощник финансовой компании. Отвечай вежливо. Для ответов на вопросы воспользуйся инструментом поиска. Не придумывай ответ.",
    "tools": [
      {
        "genSearch": {
          "options": {
            "site": {
              "site": [
                "https://cbr.ru/",
                "https://yandex.ru/finance/currencies"
              ]
            },
            "enableNrfmDocs": true
          },
          "description": "Инструмент для получения информации об официальных курсах валют."
        }
      }
    ]
  }
  ```

{% endlist %}

В {{ responses-api }} параметры инструмента `web_search` передаются непосредственно в запросе.

Чтобы перенести AI-ассистента с инструментом `WebSearch`, в запросе передавайте настройки инструмента `file_search`:

{% list tabs group=programming_language %}

- Python SDK {#sdk}

  ```python
  import openai
  import json

  YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
  YANDEX_CLOUD_MODEL = "<URI_модели>"
  YANDEX_CLOUD_API_KEY = "<API-ключ_сервисного_аккаунта>"
  # или YANDEX_CLOUD_IAM_TOKEN = "<IAM-токен>"


  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://rest-assistant.{{ api-host }}/v1",
      project=YANDEX_CLOUD_FOLDER,
  )

  response = client.responses.create(
      model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
      input="Сделай краткий обзор последних новостей об LLM в 2025 году — только факты, без домыслов.",
      # Передаем настройки инструментов
      tools=[
          {
              "type": "web_search",
              "filters": {
                  "allowed_domains": [
                      "habr.ru",
                  ],
                  "user_location": {
                      "region": "213",
                  }
              }
          }
        ],
      temperature=0.3,
      max_output_tokens=1000,
  )
  ```

{% endlist %}


### Получение промежуточных результатов генерации ответа {#streaming}

{{ assistant-api }} позволял получать промежуточные результаты генерации ответа. Например, в ({{ ml-sdk-name }}) использовался метод `run_stream()`:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  run = assistant.run_stream(thread)

  # Промежуточные результаты по мере генерации моделью ответа
  for event in run:
      print(event._message.parts)

  # Все поля окончательного результата
  print(f"run {event=}")
  ```

{% endlist %}

{{ responses-api }} также позволяет получать промежуточные результаты генерации, например, с помощью метода `responses.stream()`:

{% list tabs group=programming_language %}

- Python SDK {#sdk}

  ```python
  import openai

  YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
  YANDEX_CLOUD_MODEL = "<URI_модели>"
  YANDEX_CLOUD_API_KEY = "<API-ключ_сервисного_аккаунта>"
  # или YANDEX_CLOUD_IAM_TOKEN = "<IAM-токен>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://rest-assistant.{{ api-host }}/v1",
      project=YANDEX_CLOUD_FOLDER,
  )

  # Создаем стриминговый запрос
  with client.responses.stream(
      model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
      input="Напиши короткий тост на день рождения, дружелюбный и смешной.",
  ) as stream:
      for event in stream:
          # Дельты текстового ответа
          if event.type == "response.output_text.delta":
              print(event.delta, end="", flush=True)
          # Событие, показывающее, что ответ завершен
          # elif event.type == "response.completed":
          #     print("\n---\nОтвет завершен")

      # Если необходимо, можно забрать текст ответа целиком
      # final_response = stream.get_final_response()
      # print("\nПолный текст ответа:\n", final_response.output_text)
  ```

{% endlist %}