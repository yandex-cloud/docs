# User
Набор методов для управления ресурсами User для PostgreSQL.
## JSON-представление
```json 
 {
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string"
    }
  ],
  "connLimit": "string"
}
```

## Методы
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя PostgreSQL в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя PostgreSQL.
[get](get.md) | Возвращает указанный ресурс User для PostgreSQL.
[grantPermission](grantPermission.md) | Выдает разрешение указанному пользователю PostgreSQL.
[list](list.md) | Получает список ресурсов User для указанного кластера PostgreSQL.
[revokePermission](revokePermission.md) | Отзывает разрешение у указанного пользователя PostgreSQL.
[update](update.md) | Изменяет указанного пользователя PostgreSQL.