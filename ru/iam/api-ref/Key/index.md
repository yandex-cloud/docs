# Key
Набор методов для управления ресурсами Key.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "createdAt": "string",
  "description": "string",
  "keyAlgorithm": "string",
  "publicKey": "string",

  // включает только одно из полей `userAccountId`, `serviceAccountId`
  "userAccountId": "string",
  "serviceAccountId": "string",
  // конец списка возможных полей

}
```

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пару ключей для указанного сервисного аккаунта.
[delete](delete.md) | Удаляет указанную пару ключей.
[get](get.md) | Возвращает указанный ресурс Key.
[list](list.md) | Возвращает список доступных ресурсов Key для указанного сервисного аккаунта.