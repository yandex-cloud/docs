---
editable: false
---

# Метод getShard
Возвращает указанный шард.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Redis, к которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-redis/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
shardName | Обязательное поле. Имя запрашиваемого шарда Redis. Чтобы получить имя шаода, используйте запрос [listShards](/docs/managed-redis/api-ref/Cluster/listShards).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```

 
Поле | Описание
--- | ---
name | **string**<br><p>Имя шарда Redis. Имя шарда назначается пользователем при создании и не может быть изменено. Длина 1-63 символов.</p> 
clusterId | **string**<br><p>Идентификатор кластера Redis, к которому принадлежит шард. Этот идентификатор генерирует MDB при создании.</p> 