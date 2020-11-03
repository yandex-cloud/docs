---
editable: false
---

# User
Набор методов для управления пользователями Kafka.
## JSON-представление {#representation}
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
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя Kafka.</p> 
clusterId | **string**<br><p>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь.</p> <p>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a>.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>topicName | **string**<br><p>Имя топика, к которому предоставляется доступ.</p> <p>Чтобы получить имя топика, выполните запрос <a href="/docs/managed-kafka/api-ref/Topic/list">list</a>.</p> 
permissions[].<br>role | **string**<br><p>Роль доступа, которую нужно предоставить пользователю.</p> <ul> <li>ACCESS_ROLE_PRODUCER: роль пользователя — производитель.</li> <li>ACCESS_ROLE_CONSUMER: роль пользователя — потребитель.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя Kafka в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя Kafka.
[get](get.md) | Возвращает информацию об указанном пользователе Kafka.
[grantPermission](grantPermission.md) | Предоставляет разрешение указанному пользователю Kafka.
[list](list.md) | Получает список пользователей Kafka в указанном кластере.
[revokePermission](revokePermission.md) | Отзывает разрешение у указанного пользователя Kafka.
[update](update.md) | Изменяет указанного пользователя Kafka.