---
editable: false
---

# User
Набор методов для управления пользователями Elasticsearch.
## JSON-представление {#representation}
```json 
{
  "name": "string",
  "clusterId": "string"
}
```
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя Elasticsearch.</p> 
clusterId | **string**<br><p>Идентификатор кластера Elasticsearch, к которому принадлежит пользователь.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает информацию об указанном пользователе Elasticsearch.
[list](list.md) | Получает список пользователей Elasticsearch в указанном кластере.