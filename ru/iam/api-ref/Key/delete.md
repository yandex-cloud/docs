# Метод delete
Удаляет указанную пару ключей.
 

 
## HTTP-запрос {#https-request}
```
DELETE https://iam.api.cloud.yandex.net/iam/v1/keys/{keyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
keyId | Обязательное поле. Идентификатор удаляемого ключа. Чтобы получить идентификатор ключа, используйте запрос [list](/docs/iam/api-ref/Key/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Пустой JSON объект `` {} ``.
 
Поле | Описание
--- | ---
 | **object**<br><p>Пустой JSON объект <code>{}</code>.</p> 