# Disk
Набор методов для управления ресурсами Disk.
## JSON-представление
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "instanceIds": [
    "string"
  ],

  // включает только одно из полей `sourceImageId`, `sourceSnapshotId`
  "sourceImageId": "string",
  "sourceSnapshotId": "string",
  // конец списка возможных полей

}
```

## Методы
Метод | Описание
--- | ---
[create](create.md) | Создает диск в указанном каталоге.
[delete](delete.md) | Удаляет указанный диск.
[get](get.md) | Возвращает указанный ресурс Disk.
[list](list.md) | Возвращает список доступных ресурсов Disk в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанного диска.
[update](update.md) | Изменяет указанный диск.