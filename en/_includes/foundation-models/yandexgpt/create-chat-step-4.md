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
    },
    {
      "role": "assistant", 
      "text": "Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\nHis general relativity works found wide recognition and had a profound influence on the development of modern physics."
    },
    {
      "role": "user", 
      "text": "What important discoveries did he make?"
    }
  ]
}
```