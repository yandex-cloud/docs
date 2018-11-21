# Operation
Набор методов для управления операциями в асинхронных запросах
API.
Ссылки указаны
относительно `https://operation.api.cloud.yandex.net`.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  // включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает информацию об указанной операции.