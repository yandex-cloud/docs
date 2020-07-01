---
editable: false
---

# Метод list
Получает список пользователей Apache Kafka в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, для которого нужно получить список пользователей.  Чтобы получить идентификатор кластера, выполните запрос [list](/docs/managed-kafka/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-kafka/api-ref/User/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-kafka/api-ref/User/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "topicName": "string",
          "role": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
users[] | **object**<br><p>Пользователь Apache Kafka. Подробнее читайте в разделе <a href="/docs/managed-kafka/concepts/users">Учетные записи</a> документации.</p> 
users[].<br>name | **string**<br><p>Имя пользователя Apache Kafka.</p> 
users[].<br>clusterId | **string**<br><p>Идентификатор кластера Apache Kafka, к которому принадлежит пользователь.</p> <p>Чтобы получить идентификатор кластера Apache Kafka, выполните запрос <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a>.</p> 
users[].<br>permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
users[].<br>permissions[].<br>topicName | **string**<br><p>Имя топика, к которому предоставляется доступ.</p> <p>Чтобы получить имя топика, выполните запрос [Topic.List].</p> 
users[].<br>permissions[].<br>role | **string**<br><p>Роль доступа, которую нужно предоставить пользователю.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Роль пользователя — производитель.</li> <li>ACCESS_ROLE_CONSUMER: Роль пользователя — потребитель.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageSize</a>, используйте <code>next_page_token</code> в качестве значения параметра <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения <code>next_page_token</code> для перебора страниц результатов.</p> 