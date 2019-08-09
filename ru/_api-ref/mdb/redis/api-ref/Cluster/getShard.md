---
editable: false
---

# Метод getShard
Возвращает указанный шард.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/redis/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Максимальная длина строки в символах — 50.
shardName | Обязательное поле. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
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
name | **string**<br><p>Имя шарда Redis. Имя хоста назначается пользователем при создании и не может быть изменено. Длина 1-63 символов.</p> 
clusterId | **string**<br><p>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании.</p> 