---
editable: false
---

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
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя базы данных MongoDB.</p> 
clusterId | **string**<br><p>Идентификатор кластера MongoDB, к которому принадлежит пользователь.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
permissions[].<br>roles[] | **string**<br><p>Роли MongoDB базы данных ``databaseName``, которые предоставляет разрешение.</p> 

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