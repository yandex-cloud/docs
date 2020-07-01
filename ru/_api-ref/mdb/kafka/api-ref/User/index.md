---
editable: false
---

# User
Набор методов для управления пользователями Apache Kafka.
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
name | **string**<br><p>Имя пользователя Apache Kafka.</p> 
clusterId | **string**<br><p>Идентификатор кластера Apache Kafka, к которому принадлежит пользователь.</p> <p>Чтобы получить идентификатор кластера Apache Kafka, выполните запрос <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a>.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>topicName | **string**<br><p>Имя топика, к которому предоставляется доступ.</p> <p>Чтобы получить имя топика, выполните запрос [Topic.List].</p> 
permissions[].<br>role | **string**<br><p>Роль доступа, которую нужно предоставить пользователю.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Роль пользователя — производитель.</li> <li>ACCESS_ROLE_CONSUMER: Роль пользователя — потребитель.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя Apache Kafka в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя Apache Kafka.
[get](get.md) | Возвращает информацию об указанном пользователе Apache Kafka.
[grantPermission](grantPermission.md) | Предоставляет разрешение указанному пользователю Apache Kafka.
[list](list.md) | Получает список пользователей Apache Kafka в указанном кластере.
[revokePermission](revokePermission.md) | Отзывает разрешение у указанного пользователя Apache Kafka.
[update](update.md) | Изменяет указанного пользователя Apache Kafka.