# Нормализация чисел и дат

## Пример 1 {#example-1}

### Параметры запроса {#params}

* **Инструкция**: Перепиши текст, заменяя все числа цифрами.

* **Текст запроса**: мой заказ номер один один два три четыре ой пять шесть семь восемь девять

* **Температура**: `0`

* **Ответ**: Мой заказ номер 1123456789

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
      "text": "Перепиши текст, заменяя все числа цифрами."
    },
    {
      "role": "user",
      "text": "мой заказ номер один один два три четыре ой пять шесть семь восемь девять"
    }
  ]
}
```

{% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}

{% list tabs group=programming_language %}

- cURL {#curl}

	```bash
	curl -k -v -X POST
     	-H "Authorization: Bearer <IAM-токен>"
     	-d @prompt.json
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
                    "text": "Мой заказ номер 1123456789"
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "36",
            "completionTokens": "14",
            "totalTokens": "50"
        },
        "modelVersion": ""
    }
}
```

## Пример 2 {#example-2}

### Параметры запроса {#params}

* **Инструкция**: Перепиши текст, прописав все даты цифрами в формате день-месяц-год.

* **Текст запроса**: тридцать первое декабря две тысячи пятнадцатого года

* **Температура**: `0`

* **Ответ**: 31-12-2015

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
      "text": "Перепиши текст, прописав все даты цифрами в формате день-месяц-год."
    },
    {
      "role": "user",
      "text": "тридцать первое декабря две тысячи пятнадцатого года"
    }
  ]
}
```

{% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}

{% list tabs group=programming_language %}

- cURL {#curl}

	```bash
	curl -k -v -X POST
     	-H "Authorization: Bearer <IAM-токен>"
     	-d @prompt.json
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
                    "text": "31-12-2015"
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "38",
            "completionTokens": "11",
            "totalTokens": "49"
        },
        "modelVersion": ""
    }
}
```
