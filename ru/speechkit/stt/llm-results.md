# Обработка результатов распознавания с помощью LLM

{{ speechkit-name }} API v3 позволяет не только распознавать аудио, но и обрабатывать результаты распознавания с помощью больших генеративных моделей. Таким образом можно автоматизировать обработку результатов распознавания речи, например, сразу же получить краткий пересказ распознанного аудио, на основе аудио заполнить определенные поля в CRM-системе или перевести диалог на английский язык.

Чтобы использовать возможности генеративных моделей при распознавании аудио, в конфигурации запроса заполните блок `summarization`. Вы можете указать только текстовую инструкцию (_[промт](../../foundation-models/concepts/index.md#prompt)_) для модели или задать структуру ответа в виде JSON. Подробнее про структуру ответа см. в документации [{{ foundation-models-name }}](../../foundation-models/concepts/yandexgpt/index.md#answers-formatting). Чтобы использовать возможности генеративных моделей в {{ speechkit-name }} API v3, понадобится роль `ai.languageModels.user` или [выше](../../foundation-models/security/index.md#service-roles).

{% list tabs %}

- Простой ответ

  ```json
  {
  ...
    "summarization": {
      "modelUri": "gpt://<идентификатор_каталога>/<название_модели>",
      "properties": [
        {
          "instruction": "Промт для модели"
        }
      ]
    }
    ...
  }
  ```

- Произвольный JSON

  ```json
  {
  ...
    "summarization": {
      "modelUri": "gpt://<идентификатор_каталога>/<название_модели>",
      "properties": [
        {
          "instruction": "Промт для модели, требующий структурированного ответа",
          "jsonObject": true
        }
      ]
    }
    ...
  }
  ```

- Строгая схема JSON

  ```json
  {
  ...
    "summarization": {
      "modelUri": "gpt://<идентификатор_каталога>/<название_модели>",
      "properties": [
        {
          "instruction": "Промт для модели, требующий структурированного ответа",
          "jsonSchema": {
            // Заданная схема вывода 
            "schema": "<json-схема>"
          }
        }
      ]
    }
    ...
  }
  ```

{% endlist %}

Где: 
* `modelUri` — [модель](../../foundation-models/concepts/yandexgpt/models.md), доступная для работы _в синхронном режиме_.
* `instruction` — промт модели («Выдели основные тезисы», «Переведи на английский»). Рекомендации по созданию промтов доступны в разделе [{#T}](../../foundation-models/gpt-prompting-guide/about.md), примеры эффективных промтов см. в [библиотеке промтов {{ yagpt-name }}](../../foundation-models/prompts/yandexgpt/index.md).
* `jsonObject` — при значении `true` задает вывод модели в виде JSON произвольного формата.
* `jsonSchema` — схема для строго форматированного JSON-вывода.


Результаты работы модели вернутся в объекте `summarization`:

```json

{
...
  "result": {
    "summarization": {
      "results": [
        {
          "response": "Текст от LLM-модели"
        },
        {
          "response": "JSON от LLM-модели"
        }
      ],
      "contentUsage": {
        "inputTextTokens": 150,    // Токены запроса
        "completionTokens": 80,    // Токены ответа
        "totalTokens": 230         // Суммарное потребление
      }
    }
  }
...
}
```

Поле `contentUsage` содержит детализацию расходов [токенов](../../foundation-models/concepts/yandexgpt/tokens.md). Стоимость использования зависит от выбранной модели и рассчитывается по тарифам сервиса [{{ foundation-models-name }}](../../foundation-models/pricing.md) на основе суммарного количества токенов в вопросе и ответе (поле `totalTokens`).