---
editable: false
---

# Метод get
Возвращает указанный ресурс User для MongoDB.
 
Чтобы получить список доступных ресурсов User для MongoDB, отправьте запрос [list](/docs/managed-mongodb/api-ref/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MongoDB, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя запрашиваемого ресурса User для MongoDB. Чтобы получить имя пользователя, используйте запрос [list](/docs/managed-mongodb/api-ref/User/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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
Ресурс User для MongoDB. Подробнее см. в разделе [Developer's Guide](/docs/managed-mongodb/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя базы данных MongoDB.</p> 
clusterId | **string**<br><p>Идентификатор кластера MongoDB, к которому принадлежит пользователь.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
permissions[].<br>roles[] | **string**<br><p>Роли MongoDB базы данных ``databaseName``, которые предоставляет разрешение.</p> 