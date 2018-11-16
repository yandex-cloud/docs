# Cloud
Набор методов для управления ресурсом Cloud.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс Cloud.
[list](list.md) | Возвращает список доступных ресурсов Cloud.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа к указанному облаку.
[listOperations](listOperations.md) | Возвращает список операций для указанного облака.
[setAccessBindings](setAccessBindings.md) | Задает привязки прав доступа для указанного облака.
[updateAccessBindings](updateAccessBindings.md) | Обновляет привязки прав доступа для указанного облака.