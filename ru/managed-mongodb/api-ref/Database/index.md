---
editable: false
---

# Database
Набор методов для управления ресурсами Database для MongoDB.
## JSON-представление {#representation}
```json 
{
  "name": "string",
  "clusterId": "string"
}
```
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера MongoDB, к которому принадлежит база данных.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает новую базу данных MongoDB в указанном кластере.
[delete](delete.md) | Удаляет указанную базу данных MongoDB.
[get](get.md) | Возвращает указанный ресурс Database для MongoDB.
[list](list.md) | Получает список ресурсов Database для указанного кластера MongoDB.