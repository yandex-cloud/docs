# Метод get
Возвращает указанный ресурс Cloud.
 
Чтобы получить список доступных ресурсов Cloud, используйте
запрос [list](/docs/resource-manager/api-ref/Cloud/list).
 
## HTTP-запрос
`GET /resource-manager/v1/clouds/{cloudId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
cloudId | Обязательное поле. Идентификатор запрашиваемого ресурса Cloud. Чтобы получить идентификатор облака, используйте запрос [list](/docs/resource-manager/api-ref/Cloud/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Cloud. Дополнительные сведения см. в разделе
[Облако как ресурс Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy#cloud).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор облака.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
name | **string**<br>Имя облака. Длина имени должна быть от 3 до 63 символов.
description | **string**<br>Описание облака. Длина описания должна быть от 0 до 256 символов.