---
editable: false
---

# Backup
Набор методов для управления резервными копиями для ClickHouse.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "sourceShardNames": [
    "string"
  ],
  "startedAt": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор резервной копии.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
sourceClusterId | **string**<br><p>Идентификатор кластера ClickHouse, для которого была создана резервная копия.</p> 
sourceShardNames[] | **string**<br><p>Имена шардов, включенных в резервную копию.</p> 
startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанную резервную копию для ClickHouse.
[list](list.md) | Получение списка резервных копий для указанного каталога.