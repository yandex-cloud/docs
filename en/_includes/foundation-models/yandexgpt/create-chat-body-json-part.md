```json
{
  "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000"
  },
  "messages": [
    {
      "role": "system",
      "text": "You are a smart assistant"
    },
    {
      "role": "user", 
      "text": "Hi! What fields of science did Albert Einstein study?"
    }
  ]
}
```

Where:

{% include [api-parameters](./api-parameters.md) %}