# Folder
Набор методов для управления ресурсом Folder.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string"
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает каталог в указанном облаке.
[delete](delete.md) | Удаляет указанный каталог.
[get](get.md) | Возвращает указанный ресурс Folder.
[list](list.md) | Возвращает список доступных ресурсов Folder в указанном облаке.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа к указанному каталогу.
[listOperations](listOperations.md) | Возвращает список операций для указанного каталога.
[setAccessBindings](setAccessBindings.md) | Задает привязки прав доступа для указанного каталога.
[update](update.md) | Обновляет указанный каталог.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного каталога.