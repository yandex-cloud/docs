---
editable: false
---

# Метод get
Возвращает указанную организацию.
 
Чтобы получить список доступных организацией, используйте запрос [list](/docs/organization-manager/api-ref/Organization/list).
 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/{organizationId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
organizationId | Обязательное поле. Идентификатор организации. Чтобы получить идентификатор организации, используйте запрос [list](/docs/organization-manager/api-ref/Organization/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "title": "string"
}
```
Ресурс "Организация". Подробнее см. в разделе [Управление организациями](/docs/organization/enable-org).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор организации.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя организации. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание организации. Длина описания должна быть от 0 до 256 символов.</p> 
title | **string**<br><p>Название организации. Длина описания должна быть от 0 до 256 символов.</p> 