---
editable: false
---

# Database
Набор методов для управления базами данных SQL Server.
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
clusterId | **string**<br><p>Идентификатор кластера SQL Server, которому принадлежит база данных.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[delete](delete.md) | Удаляет указанную базу данных SQL Server.
[get](get.md) | Возвращает указанную базу данных SQL Server.
[list](list.md) | Возвращает список баз данных SQL Server в указанном кластере.
[restore](restore.md) | Создает новую базу данные в указанном кластере из резервной копии