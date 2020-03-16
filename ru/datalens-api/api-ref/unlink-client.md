---
editable: false
---

# Удаление связи с клиентом

Удаляет связь указанного подключения с клиентом. 

{% note warning %}

Вы не сможете записывать данные в таблицы после удаления связи. Все загруженные данные сохранятся.
Вы сможете продолжить запись данных после повторного создания связи клиента с подключением.

{% endnote %}

## HTTP-запрос {#https-request}
```
DELETE https://upload.datalens.yandex.net/provider/v1/connection/{connection_id}/client-id
```

## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения. 

## Ответ {#responses}
**HTTP Code: 204 - No content**

Связь успешно удалена.

**HTTP Code: 400 - Bad Request**

Связь подключения с клиентом была удалена ранее.