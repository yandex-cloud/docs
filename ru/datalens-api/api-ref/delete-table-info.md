---
editable: false
---

# Удаление таблицы

Удаляет указанную таблицу.
 
## HTTP-запрос {#https-request}
```
DELETE https://upload.datalens.yandex.net/provider/v1/connection/{conn_id}/table/{table_name}/definition
```
 
## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения.
table_name | Имя таблицы.

## Ответ {#responses}
**HTTP Code: 204 - No Content**

```text
Table was successfully removed
```