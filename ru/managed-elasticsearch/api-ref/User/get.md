---
editable: false
---

# Метод get
Возвращает информацию об указанном пользователе Elasticsearch.
 
Чтобы получить список доступных пользователей Elasticsearch, выполните запрос [list](/docs/managed-elasticsearch/api-ref/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Elasticsearch, к которому принадлежит пользователь.  Чтобы получить идентификатор кластера, выполните запрос [list](/docs/managed-elasticsearch/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя запрашиваемого пользователя Elasticsearch.  Чтобы получить имя пользователя, выполните запрос [list](/docs/managed-elasticsearch/api-ref/User/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
Пользователь Elasticsearch.
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя Elasticsearch.</p> 
clusterId | **string**<br><p>Идентификатор кластера Elasticsearch, к которому принадлежит пользователь.</p> 