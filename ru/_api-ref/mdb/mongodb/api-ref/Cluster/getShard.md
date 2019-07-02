---
editable: false
---

# Метод getShard
Возвращает указанный шард.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор MongoDB-кластера, которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [List].  Максимальная длина строки в символах — 50.
shardName | Обязательное поле. Имя запрашиваемого шарда MongoDB. Чтобы получить имя шарда, используйте запрос [ListShards].  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
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
name | **string**<br><p>Имя шарда.</p> 
clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит шард.</p> 