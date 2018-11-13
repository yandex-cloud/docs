# AccessKey
Набор методов для управления ресурсами AccessKey.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string"
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает ключ доступа для указанного сервисного аккаунта.
[delete](delete.md) | Удаляет указанный ключ доступа.
[get](get.md) | Возвращает указанный ресурс AccessKey.
[list](list.md) | Возвращает список доступных ресурсов AccessKey для указанного сервисного аккаунта.