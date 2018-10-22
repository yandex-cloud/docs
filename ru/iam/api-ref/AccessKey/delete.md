# Метод delete
Удаляет указанный ключ доступа.
 

 
## HTTP-запрос
`DELETE /iam/aws-compatibility/v1/accessKeys/{accessKeyId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
accessKeyId | Обязательное поле. Идентификатор удаляемого ключа доступа. Чтобы получить идентификатор ключа доступа, используйте запрос [list](/docs/iam/api-ref/AccessKey/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Пустой JSON объект `` {} ``.
 
Поле | Описание
--- | ---
 | **object**<br><p>Пустой JSON объект <code>{}</code>.</p> 