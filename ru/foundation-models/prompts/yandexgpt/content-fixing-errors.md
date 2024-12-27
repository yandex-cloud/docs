---
title: Исправление грамматических ошибок в тексте
description: В статье вы ознакомитесь с промтом для исправления грамматических ошибок в тексте.
---

# Исправление грамматических ошибок в тексте

## Пример 1 {#example-1}

### Параметры запроса {#params}

* **Инструкция**: Исправь грамматические, орфографические и пунктуационные ошибки в тексте. Сохраняй исходный порядок слов.

* **Текст запроса**: Нейросети помогают человеку работать быстрее и эффективнее но опосения что искуственный интелек заменит человека - пока преждевремены

* **Температура**: `0`

* **Ответ**: Нейросети могут помочь человеку работать более быстро и эффективно, но опасения о том, что искусственный интеллект заменит человека, пока преждевременны.

### Структура запроса {#structure}

```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt/latest",
  "completionOptions": {
    "stream": false,
    "temperature": 0,
    "maxTokens": "200"
  },
  "messages": [
    {
      "role": "system",
      "text": "Исправь грамматические, орфографические и пунктуационные ошибки в тексте. Сохраняй исходный порядок слов."
    },
    {
      "role": "user",
      "text": "Нейросети помогают человеку работать быстрее и эффективнее но опосения что искуственный интелек заменит человека - пока преждевремены"
    }
  ]
}
```

{% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}

{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
      --insecure \
      --verbose \
      --request POST \
      --header "Authorization: Bearer <IAM-токен>" \
      --data @prompt.json \
      https://llm.{{ api-host }}/foundationModels/v1/completion
  ```

	Где:

	* `<IAM-токен>` — значение IAM-токена, полученного для вашего аккаунта.
	* `prompt.json` — файл в формате JSON, содержащий параметры запроса.

{% endlist %}

### Ответ {#answer}

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "Нейросети помогают человеку работать быстрее и эффективнее, но опасения, что искусственный интеллект заменит человека, пока преждевременны."
        },
        "status": "ALTERNATIVE_STATUS_FINAL"
      }
    ],
    "usage": {
      "inputTextTokens": "56",
      "completionTokens": "23",
      "totalTokens": "79"
    },
    "modelVersion": "07.03.2024"
  }
}
```

## Пример 2 {#example-2}

### Параметры запроса {#params}

* **Инструкция**: Исправь грамматические, орфографические и пунктуационные ошибки в тексте. Сохраняй исходный порядок слов.

* **Текст запроса**: Здраствуйте, дарагие каллеги? Паздравляем вас с настпщим новым годом! Здаровия и процвитания!

* **Температура**: `0`

* **Ответ**: Здравствуйте, дорогие коллеги! Поздравляем вас с наступающим Новым годом! Здоровья и процветания!

### Структура запроса {#structure}

```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
  "completionOptions": {
    "stream": false,
    "temperature": 0,
    "maxTokens": "2000"
  },
  "messages": [
    {
      "role": "system",
      "text": "Исправь грамматические, орфографические и пунктуационные ошибки в тексте. Сохраняй исходный порядок слов."
    },
    {
      "role": "user",
      "text": "Здравствуйте, дорогие коллеги! Поздравляем вас с наступающим Новым годом! Здоровья и процветания!"
    }
  ]
}
```

{% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}

{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
      --insecure \
      --verbose \
      --request POST \
      --header "Authorization: Bearer <IAM-токен>" \
      --data @prompt.json \
      https://llm.{{ api-host }}/foundationModels/v1/completion
  ```

	Где:

	* `<IAM-токен>` — значение IAM-токена, полученного для вашего аккаунта.
	* `prompt.json` — файл в формате JSON, содержащий параметры запроса.

{% endlist %}

### Ответ {#answer}

```json
{
    "result": {
        "alternatives": [
            {
                "message": {
                    "role": "assistant",
                    "text": "Здравствуйте, дорогие коллеги! Поздравляем вас с наступающим Новым годом! Здоровья и процветания!"
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "63",
            "completionTokens": "16",
            "totalTokens": "79"
        },
        "modelVersion": ""
    }
}
```
