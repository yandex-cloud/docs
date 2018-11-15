# Snapshot
Набор методов для управления ресурсами Snapshot.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "storageSize": "string",
  "diskSize": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "sourceDiskId": "string"
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает снимок указанного диска.
[delete](delete.md) | Удаляет указанный снимок.
[get](get.md) | Возвращает указанный ресурс Snapshot.
[list](list.md) | Возвращает список доступных ресурсов Snapshot в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанного снимка.
[update](update.md) | Изменяет указанный снимок.