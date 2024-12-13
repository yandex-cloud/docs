```json
{
  "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000"
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