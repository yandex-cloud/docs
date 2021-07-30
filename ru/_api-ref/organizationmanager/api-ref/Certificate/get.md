---
editable: false
---

# Метод get
Возвращает указанный сертификат.
 
Чтобы получить список доступных сертификатов, используйте запрос [list](/docs/organization-manager/api-ref/Certificate/list).
 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/certificates/{certificateId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
certificateId | Идентификатор возвращаемого сертификата. Чтобы получить идентификатор сертификата, используйте запрос [list](/docs/organization-manager/api-ref/Certificate/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "federationId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "data": "string"
}
```
Сертификат.
 
Поле | Описание
--- | ---
id | **string**<br><p>Обязательное поле. Идентификатор сертификата.</p> <p>Максимальная длина строки в символах — 50.</p> 
federationId | **string**<br><p>Обязательное поле. Идентификатор федерации, которой принадлежит сертификат.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Имя сертификата.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Описание сертификата. Длина описания должна быть от 0 до 256 символов.</p> <p>Максимальная длина строки в символах — 256.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
data | **string**<br><p>Обязательное поле. Данные сертификата в формате PEM.</p> <p>Максимальная длина строки в символах — 32000.</p> 