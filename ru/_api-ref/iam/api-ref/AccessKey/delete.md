---
editable: false
---

# Метод delete
Удаляет указанный ключ доступа.
 

 
## HTTP-запрос {#https-request}
```
DELETE https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys/{accessKeyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
accessKeyId | Обязательное поле. Идентификатор удаляемого ключа доступа. Чтобы получить идентификатор ключа доступа, используйте запрос [list](/docs/iam/api-ref/AccessKey/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Пустой JSON объект `` {} ``.
 
Поле | Описание
--- | ---
 | **object**<br><p>Пустой JSON объект <code>{}</code>.</p> 