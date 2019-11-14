---
editable: false
---

# Создание связи с клиентом

Создает связь подключения {{ datalens-short-name }} с партнерским клиентом.

## HTTP-запрос {#https-request}
```
POST https://upload.datalens.yandex.net/provider/v1/connection/{connection_id}/client-id
```

## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения.

## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "client_id": "string"
}
```
 
Поле | Описание
--- | ---
client_id | **string**<br><p>Идентификатор клиента.</p><p>Используется для работы с таблицами и данными подключения.</p>

**HTTP Code: 400 - Bad Request**

К подключению уже создана связь с другим клиентом.