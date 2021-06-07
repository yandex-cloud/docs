---
editable: false
---

# Метод list
Получает список пользователей Elasticsearch в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Elasticsearch, для которого нужно получить список пользователей.  Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-elasticsearch/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-elasticsearch/api-ref/User/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-elasticsearch/api-ref/User/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
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
users[] | **object**<br><p>Пользователь Elasticsearch.</p> 
users[].<br>name | **string**<br><p>Имя пользователя Elasticsearch.</p> 
users[].<br>clusterId | **string**<br><p>Идентификатор кластера Elasticsearch, к которому принадлежит пользователь.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-elasticsearch/api-ref/User/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/managed-elasticsearch/api-ref/User/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 