# Локализация текста с учетом отраслевой специфики

## Пример 1 {#example-1}

### Параметры запроса {#params}

* **Инструкция**: Переведи текст на русский язык.

* **Текст запроса**: Dr. James wants to run some additional test.

* **Температура**: `0`

* **Ответ**: Доктор Джеймс хочет провести несколько дополнительных тестов.

### Структура запроса {#structure}

```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
  "completionOptions": {
    "stream": false,
    "temperature": 0,
    "maxTokens": "8000"
  },
  "messages": [
    {
      "role": "system",
      "text": "Переведи текст на русский язык."
    },
    {
      "role": "user",
      "text": "Dr. James wants to run some additional test."
    }
  ]
}
```

Где `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

{% list tabs %}

- cURL

	```bash
	curl -k -v -X POST
     	-H "Authorization: Bearer <значение_IAM-токена>"
     	-d @prompt.json
     	https://llm.{{ api-host }}/foundationModels/v1/completion
	```
	
	Где:

	* `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
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
                    "text": "Доктор Джеймс хочет провести несколько дополнительных тестов."
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "28",
            "completionTokens": "8",
            "totalTokens": "36"
        },
        "modelVersion": ""
    }
}
```

## Пример 2 {#example-2}

### Параметры запроса {#params}

* **Инструкция**: Переведи текст на немецкий язык.

* **Текст запроса**: Дорогой Ганс! С Днем рождения! Ура!

* **Температура**: `0`

* **Ответ**: Lieber Hans, herzlichen Glückwunsch zum Geburtstag! Alles Gute!

### Структура запроса {#structure}

```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
  "completionOptions": {
    "stream": false,
    "temperature": 0,
    "maxTokens": "8000"
  },
  "messages": [
    {
      "role": "system",
      "text": "Переведи текст на немецкий язык."
    },
    {
      "role": "user",
      "text": "Дорогой Ганс! С Днем рождения! Ура!"
    }
  ]
}
```

Где `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

{% list tabs %}

- cURL

	```bash
	curl -k -v -X POST
     	-H "Authorization: Bearer <значение_IAM-токена>"
     	-d @prompt.json
     	https://llm.{{ api-host }}/foundationModels/v1/completion
	```
	
	Где:

	* `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
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
                    "text": "Lieber Hans, herzlichen Glückwunsch zum Geburtstag! Alles Gute!"
                },
                "status": "ALTERNATIVE_STATUS_FINAL"
            }
        ],
        "usage": {
            "inputTextTokens": "29",
            "completionTokens": "24",
            "totalTokens": "53"
        },
        "modelVersion": ""
    }
}
```
