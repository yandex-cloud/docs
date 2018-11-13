# User
Набор методов для управления ресурсами User для MongoDB.
## JSON-представление {#representation}
```json 
 {
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ]
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя MongoDB в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя MongoDB.
[get](get.md) | Возвращает указанный ресурс User для MongoDB.
[grantPermission](grantPermission.md) | Предоставляет разрешение указанному пользователю MongoDB.
[list](list.md) | Получает список ресурсов User для указанного кластера MongoDB.
[revokePermission](revokePermission.md) | Отзывает разрешение у указанного пользователя MongoDB.
[update](update.md) | Изменяет указанного пользователя MongoDB.