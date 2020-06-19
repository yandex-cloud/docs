---
editable: false
---

# Метод get
Возвращает указанный ресурс Database для MongoDB.
 
Чтобы получить список доступных ресурсов Database для MongoDB, отправьте запрос [list](/docs/managed-mongodb/api-ref/Database/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MongoDB, к которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
databaseName | Обязательное поле. Имя запрашиваемой базы данных MongoDB. Чтобы получить имя базы данных, используйте запрос [List].  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
Ресурс Database для MongoDB. Подробнее см. в разделе [Developer's Guide](/docs/managed-mongodb/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера MongoDB, к которому принадлежит база данных.</p> 