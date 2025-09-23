# Форматирование ответов моделей

По умолчанию модель возвращает ответ, отформатированный с помощью разметки [Markdown](https://ru.wikipedia.org/wiki/Markdown). Используйте текст промта, чтобы получить ответ с дополнительным форматированием (например с [эмодзи](https://ru.wikipedia.org/wiki/Эмодзи)) или в другом формате ([JSON](https://ru.wikipedia.org/wiki/JSON), [XML](https://ru.wikipedia.org/wiki/XML) и т.п.)

Пример:

```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt/latest",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000",
    "reasoningOptions": {
      "mode": "DISABLED"
    }
  },
  "messages": [
    {
      "role": "system",
      "text": "Ты — умный ассистент."
    },
    {
      "role": "user",
      "text": "Назови любые три группы товаров в продовольственном магазине. Для каждой группы приведи три любые подгруппы, входящие в группу. Представь результат в форме объекта JSON, где каждая группа товаров представлена в виде ключа в объекте JSON, а значениями являются массивы из соответствующих подгрупп. Нужны только данные без вводных фраз и объяснений. Не используй разметку Markdown!"
    }
  ]
}
```

Результат:

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "{\n    \"мясо\": [\"говядина\", \"свинина\", \"баранина\"],\n    \"молочные продукты\": [\"молоко\", \"творог\", \"сметана\"],\n    \"фрукты\": [\"яблоки\", \"бананы\", \"апельсины\"]\n}"
        },
        "status": "ALTERNATIVE_STATUS_FINAL"
      }
    ],
    "usage": {
      "inputTextTokens": "87",
      "completionTokens": "58",
      "totalTokens": "145"
    },
    "modelVersion": "07.03.2024"
  }
}
```

Модель вернула ответ в формате JSON, где перенос строки заменен на `\n`, а кавычки экранированы.

Если с помощью промта вам не удается добиться желаемого результата, попробуйте [дообучить](../tuning/index.md) модель.

### Параметры API для сохранения структуры ответа {#structured-output}

Некоторые модели генерации текста поддерживают дополнительное управление форматом ответа не только промтом, но и с помощью параметров запроса. Так вы можете использовать параметры форматирования ответа, чтобы указать, что ответ необходимо вернуть в формате JSON. На выбор доступны два варианта:

1. JSON с произвольной структурой:

   {% list tabs group=programming_language %}

   - SDK {#sdk}

     ```python
     #!/usr/bin/env python3

     from __future__ import annotations

     import json

     import pydantic

     from yandex_cloud_ml_sdk import YCloudML

     text = """
     Назови любые три группы товаров в продовольственном магазине. 
     Для каждой группы приведи три любые подгруппы, входящие в группу. 
     Представь результат в формате JSON.
     """


     def main() -> None:
         sdk = YCloudML(
             folder_id="<идентификатор_каталога>",
             auth="<API-ключ>",
         )

         model = sdk.models.completions("yandexgpt", model_version="rc")

         model = model.configure(response_format="json")
         result = model.run(
             [
                 {"role": "user", "text": text},
             ]
         )
         print("JSON result:", result[0].text)


     if __name__ == "__main__":
         main()
     ```

   - API {#api}

     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt/rc",
       "completionOptions": {
         "stream": false
       },
       "messages": [
         {
           "role": "user",
           "text": "Назови любые три группы товаров в продовольственном магазине. Для каждой группы приведи три любые подгруппы, входящие в группу. Представь результат в формате JSON."
         }
       ],
       "json_object": true
     }
     ```

   {% endlist %}

   {% note tip %}

   Если вы хотите получить ответ в виде JSON с произвольной структурой, обязательно дополнительно укажите это словами в промте. Иначе модель может добавлять дополнительные скобки, пробелы и отступы и генерировать лишние токены.

   {% endnote %}

1. JSON, строго соответствующий заданной схеме:

   {% list tabs group=programming_language %}

   - SDK {#sdk}

     ```python
     #!/usr/bin/env python3

     from __future__ import annotations

     import json

     import pydantic

     from yandex_cloud_ml_sdk import YCloudML

     text = "Назови дату первого полета Гагарина."


     def main() -> None:
         sdk = YCloudML(
             folder_id="<идентификатор_каталога>",
             auth="<API-ключ>",
         )

         model = sdk.models.completions("yandexgpt", model_version="rc")

         model = model.configure(
             response_format={
                 "json_schema": {
                     "properties": {
                         "day": {
                             "title": "Day",
                             "description": "День месяца",
                             "type": "integer",
                         },
                         "month": {
                             "title": "Month",
                             "description": "Месяц, словом",
                             "type": "string",
                         },
                         "year": {
                             "title": "Year",
                             "description": "Год",
                             "type": "integer",
                         },
                     },
                     "required": ["day", "month", "year"],
                     "type": "object",
                 }
             }
         )
         result = model.run(
             [
                 {"role": "user", "text": text},
             ]
         )
         print("JSON result:", result[0].text)


     if __name__ == "__main__":
         main()
     ```

   - API {#api}

     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt/rc",
       "completionOptions": {
         "stream": false
       },
       "messages": [
         {
           "role": "user",
           "text": "Назови дату первого полета Гагарина."
         }
       ],
       "json_schema": {
         "schema": {
           "properties": {
             "day": {
               "title": "Day",
               "description": "День месяца",
               "type": "integer"
             },
             "month": {
               "title": "Month",
               "description": "Месяц, словом",
               "type": "string"
             },
             "year": {
               "title": "Year",
               "description": "Год",
               "type": "integer"
             }
           },
           "required": [
             "day",
             "month",
             "year"
           ],
           "type": "object"
         }
       }
     }
     ```

   {% endlist %}

Строгая структура ответа необходима при работе с внешними инструментами с помощью [вызова функций](./function-call.md). 