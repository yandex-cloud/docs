---
editable: false
---

# Метод listShards
Получает список шардов.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/redis/v1/clusters/{clusterId}/shards
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное значение — 1000.
pageToken | Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "shards": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
shards[] | **object**<br>
shards[].<br>name | **string**<br><p>Имя шарда Redis. Имя хоста назначается пользователем при создании и не может быть изменено. Длина 1-63 символов.</p> 
shards[].<br>clusterId | **string**<br><p>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании.</p> 
nextPageToken | **string**<br>