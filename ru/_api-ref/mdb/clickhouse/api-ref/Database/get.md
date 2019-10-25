---
editable: false
---

# Метод get
Возвращает указанный ресурс Database для ClickHouse.
 
Чтобы получить список доступных ресурсов Database для ClickHouse, отправьте запрос [list](/docs/managed-clickhouse/api-ref/Database/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-clickhouse/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
databaseName | Обязательное поле. Имя возвращаемого ресурса Database для базы данных ClickHouse. Чтобы получить имя базы данных, используйте запрос [list](/docs/managed-clickhouse/api-ref/Database/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
Ресурс Database для ClickHouse. Подробнее см. в разделе [Developer's Guide](/docs/managed-clickhouse/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит база данных.</p> 