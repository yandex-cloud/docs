---
editable: false
---

# Database
Набор методов для управления базами данных MySQL.
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
clusterId | **string**<br><p>Идентификатор кластера MySQL, которому принадлежит база данных.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает новую базу данных MySQL в указанном кластере.
[delete](delete.md) | Удаляет указанную базу данных MySQL.
[get](get.md) | Возвращает указанную базу данных MySQL.
[list](list.md) | Получает список баз данных MySQL в указанном кластере.