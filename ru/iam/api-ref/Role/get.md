# Метод get
Возвращает указанный ресурс Role.
 
Чтобы получить список доступных ресурсов Role, используйте
запрос [list](/docs/iam/api-ref/Role/list).
 
## HTTP-запрос
`GET /iam/v1/roles/{roleId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
roleId | Обязательное поле. Идентификатор возвращаемого ресурса Role. Чтобы получить идентификатор роли, используйте запрос [list](/docs/iam/api-ref/Role/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Role. Дополнительные сведения см. в разделе
[Роли](/docs/iam/concepts/access-control/roles).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор роли.</p> 
description | **string**<br><p>Описание роли. Длина описания должна быть от 0 до 256 символов.</p> 