# Создать текстового агента с поиском в интернете

В {{ foundation-models-full-name }} вы можете создать текстового [агента](../../concepts/agents/index.md), который для формирования ответа будет использовать информацию, [найденную в интернете](../../concepts/agents/tools/filesearch.md).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  {% include [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Создайте агента {#create-agent}

{% list tabs group=programming_language %}

- Python {#python}

  1. [Создайте поисковый индекс](./manage-searchindex.md#create-index).
  1. Создайте файл `index.py` и добавьте в него код:

     ```python
     import openai
     import json
 
     YANDEX_CLOUD_FOLDER = "..."
     YANDEX_CLOUD_API_KEY = "..."
     YANDEX_CLOUD_MODEL = "yandexgpt"
 
     client = openai.OpenAI(
         api_key=YANDEX_CLOUD_API_KEY,
         base_url="https://rest-assistant.api.cloud.yandex.net/v1",
         project=YANDEX_CLOUD_FOLDER
     )
 
     response = client.responses.create(
         model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
         input="Сделай краткий обзор новостей про LLM за сентябрь 2025 года.",
         tools=[
             {
                "type": "web_search",
                "filters": {
                    "allowed_domains": [
                        "habr.ru"
                    ]
                },
                "user_location": {
                        "region": "213",
                    }
             }
         ],
         temperature=0.3,
         max_output_tokens=1000
     )
 
     # Текст ответа
     print("Текст ответа:")
     print(response.output_text)
     print("\n" + "=" * 50 + "\n")
 
     # Полный ответ
     print("Полный ответ (JSON):")
     print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))xs
     ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YANDEX_CLOUD_FOLDER=<идентификатор_каталога>
      export YANDEX_CLOUD_API_KEY=<API-ключ>
      export VECTOR_STORE_ID=<идентификатор_поискового_индекса>
      ```

  1. Выполните созданный файл:

      ```bash
      python index.py
      ```

{% endlist %}
