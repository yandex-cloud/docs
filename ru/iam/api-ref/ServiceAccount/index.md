# ServiceAccount
Набор методов для управления ресурсами ServiceAccount.
## JSON-представление
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```

## Методы
Метод | Описание
--- | ---
[create](create.md) | Создает сервисный аккаунт в указанном каталоге.
[delete](delete.md) | Удаляет указанный сервисный аккаунт.
[get](get.md) | Возвращает указанный ресурс ServiceAccount.
[list](list.md) | Возвращает список доступных ресурсов ServiceAccount в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа к указанному сервисному аккаунту.
[listOperations](listOperations.md) | Возвращает список операций для указанного сервисного аккаунта.
[setAccessBindings](setAccessBindings.md) | Задает привязки прав доступа для указанного сервисного аккаунта.
[update](update.md) | Обновляет указанный сервисный аккаунт.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного сервисного аккаунта.