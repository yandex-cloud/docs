# Backup
Набор методов для управления ресурсами Backup для ClickHouse.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string"
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс Backup для ClickHouse.
[list](list.md) | Получение списка ресурсов Backup для указанного каталога.