---
editable: false
---

# Метод get
Возвращает указанный ресурс Cloud.
 
Чтобы получить список доступных ресурсов Cloud, используйте запрос [list](/docs/resource-manager/api-ref/Cloud/list).
 
## HTTP-запрос {#https-request}
```
GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/{cloudId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
cloudId | Обязательное поле. Идентификатор запрашиваемого ресурса Cloud. Чтобы получить идентификатор облака, используйте запрос [list](/docs/resource-manager/api-ref/Cloud/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "organizationId": "string"
}
```
Ресурс Cloud. Подробнее см. в разделе [Облако как ресурс Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy#cloud).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор облака.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя облака. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание облака. Длина описания должна быть от 0 до 256 символов.</p> 
organizationId | **string**<br><p>Идентификатор организации, которой принадлежит облако.</p> 