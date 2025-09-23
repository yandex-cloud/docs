{% cut "Result:" %}

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\nHis general relativity works found wide recognition and had a profound influence on the development of modern physics."
        },
        "status": "ALTERNATIVE_STATUS_FINAL"
      }
    ],
    "usage": {
      "inputTextTokens": "28",
      "completionTokens": "110",
      "totalTokens": "138"
    },
    "modelVersion": "18.01.2024"
  }
}
```

{% endcut %}

Save the `message` record value for use in subsequent requests.