# Распознавание именованных сущностей

## Пример 1 {#example-1}

### Параметры запроса {#params}

* **Инструкция**: Найди все упомянутые даты и время в тексте. Выпиши их, каждый с новой строки. Пример результата: 22-01-2019 17:00 Завтра 18:15 Вчера Если в тексте нет дат, верни 0.

* **Текст запроса**: Здравствуйте! Я хочу записать на завтра на пятнадцать тридцать. Или уже на послезавтра на шестнадцать тридцать.

* **Температура**: `0`

* **Ответ**: 22.01.2023 15:30
  23.01.2023 16:30

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
      "text": "Найди все упомянутые даты и время в тексте. Выпиши их, каждый с новой строки. Пример результата: 22-01-2019 17:00 Завтра 18:15 Вчера Если в тексте нет дат, верни 0"
    },
    {
      "role": "user",
      "text": "Здравствуйте! Я хочу записать на завтра на пятнадцать тридцать. Или уже на послезавтра на шестнадцать тридцать."
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
                    "text": "22.01.2023 15:30\n23.01.2103 16:30"
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "90",
            "completionTokens": "44",
            "totalTokens": "134"
        },
        "modelVersion": ""
    }
}
```

## Пример 2 {#example-2}

### Параметры запроса {#params}

* **Инструкция**: Погоду в каком городе и на какую дату спрашивают? Город по умолчанию: Москва. Ответ дай в формате: Дата: Город:

* **Текст запроса**: Алиса, погода завтра в Питере

* **Температура**: `0`

* **Ответ**: Дата: завтра
  Город: Питер

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
      "text": "Погоду в каком городе и на какую дату спрашивают? Город по умолчанию: Москва. Ответ дай в формате: Дата: Город:"
    },
    {
      "role": "user",
      "text": "Алиса, погода завтра в Питере"
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
                    "text": "Дата: завтра\nГород: Питер"
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "44",
            "completionTokens": "7",
            "totalTokens": "51"
        },
        "modelVersion": ""
    }
}
```
