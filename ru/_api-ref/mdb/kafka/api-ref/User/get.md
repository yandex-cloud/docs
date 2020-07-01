---
editable: false
---

# Метод get
Возвращает информацию об указанном пользователе Apache Kafka.
 
Чтобы получить список доступных пользователей Apache Kafka, выполните запрос [list](/docs/managed-kafka/api-ref/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Apache Kafka, к которому принадлежит пользователь.  Чтобы получить идентификатор кластера, выполните запрос [list](/docs/managed-kafka/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя запрашиваемого пользователя Apache Kafka.  Чтобы получить имя пользователя, выполните запрос [list](/docs/managed-kafka/api-ref/User/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Пользователь Apache Kafka. Подробнее читайте в разделе [Учетные записи](/docs/managed-kafka/concepts/users) документации.
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя Apache Kafka.</p> 
clusterId | **string**<br><p>Идентификатор кластера Apache Kafka, к которому принадлежит пользователь.</p> <p>Чтобы получить идентификатор кластера Apache Kafka, выполните запрос <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a>.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>topicName | **string**<br><p>Имя топика, к которому предоставляется доступ.</p> <p>Чтобы получить имя топика, выполните запрос [Topic.List].</p> 
permissions[].<br>role | **string**<br><p>Роль доступа, которую нужно предоставить пользователю.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Роль пользователя — производитель.</li> <li>ACCESS_ROLE_CONSUMER: Роль пользователя — потребитель.</li> </ul> 