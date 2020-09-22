---
editable: false
---

# Метод getShardGroup
Возвращает группу шардов по имени.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups/{shardGroupName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера.  Максимальная длина строки в символах — 50.
shardGroupName | Обязательное поле. Имя группы шардов. Чтобы получить имя группы шардов, используйте запрос [listShardGroups](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "description": "string",
  "shardNames": [
    "string"
  ]
}
```

 
Поле | Описание
--- | ---
name | **string**<br><p>Имя группы шардов</p> 
clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит группа шардов.</p> 
description | **string**<br><p>Описание группы шардов. Длина описания должна быть от 0 до 256 символов.</p> 
shardNames[] | **string**<br><p>Список имен шардов, которые взоядят в группу.</p> 