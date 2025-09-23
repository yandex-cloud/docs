```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
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
      "text": "Ты умный ассистент"
    },
    {
      "role": "user", 
      "text": "Привет! Какими науками занимался Альберт Эйнштейн?"
    }
  ]
}
```

Где:

{% include [api-parameters](./api-parameters.md) %}