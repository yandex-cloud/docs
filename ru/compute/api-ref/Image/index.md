# Image
Набор методов для управления ресурсами Image.
## JSON-представление
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "family": "string",
  "storageSize": "string",
  "minDiskSize": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "os": {
    "type": "string"
  }
}
```

## Методы
Метод | Описание
--- | ---
[create](create.md) | Создает образ в указанном каталоге.
[delete](delete.md) | Удаляет указанный образ.
[get](get.md) | Возвращает указанный ресурс Image.
[getLatestByFamily](getLatestByFamily.md) | Возвращает последний образ из указанного семейства образов.
[list](list.md) | Возвращает список доступных ресурсов Image в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанного образа.
[update](update.md) | Изменяет указанный образ.