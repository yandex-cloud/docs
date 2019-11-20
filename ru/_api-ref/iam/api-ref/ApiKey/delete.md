---
editable: false
---

# Метод delete
Удаляет указанный API-ключ.
 

 
## HTTP-запрос {#https-request}
```
DELETE https://iam.api.cloud.yandex.net/iam/v1/apiKeys/{apiKeyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
apiKeyId | Обязательное поле. Идентификатор ключа, который следует удалить. Чтобы получить идентификатор ключа, используйте запрос [list](/docs/iam/api-ref/ApiKey/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Пустой JSON объект `` {} ``.
 
Поле | Описание
--- | ---
 | **object**<br><p>Пустой JSON объект <code>{}</code>.</p> 