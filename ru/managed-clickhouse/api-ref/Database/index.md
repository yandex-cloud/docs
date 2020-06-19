---
editable: false
---

# Database
Набор методов для управления ресурсами Database для ClickHouse.
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
clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит база данных.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает новую базу данных ClickHouse в указанном кластере.
[delete](delete.md) | Удаляет указанную базу данных ClickHouse.
[get](get.md) | Возвращает указанный ресурс Database для ClickHouse.
[list](list.md) | Получает список ресурсов Database для указанного кластера ClickHouse.