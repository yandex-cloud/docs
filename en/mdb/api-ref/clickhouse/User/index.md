# User
Набор методов для управления ресурсами User для ClickHouse.
## JSON-представление
```json 
 {
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string"
    }
  ]
}
```

## Методы
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя ClickHouse в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя ClickHouse.
[get](get.md) | Возвращает указанный ресурс User для ClickHouse.
[grantPermission](grantPermission.md) | Предоставляет разрешение указанному пользователю ClickHouse.
[list](list.md) | Получает список ресурсов User для указанного кластера ClickHouse.
[revokePermission](revokePermission.md) | Отзывает разрешения у указанного пользователя ClickHouse.
[update](update.md) | Изменяет указанного пользователя ClickHouse.