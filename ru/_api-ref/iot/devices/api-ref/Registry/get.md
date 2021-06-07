---
editable: false
---

# Метод get
Возвращает указанный реестр.
 
Чтобы получить список доступных реестров, используйте запрос [list](/docs/iot-core/api-ref/Registry/list).
 
## HTTP-запрос {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/registries/{registryId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
registryId | Обязательное поле. Идентификатор возвращаемого реестра.  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/iot-core/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "logGroupId": "string"
}
```
Реестр. Дополнительные сведения см. в разделе [Реестр](/docs/iot-core/concepts/index#registry).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор реестра.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит реестр.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Название реестра. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Описание реестра. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки группы размещения в формате ``key:value``. Максимум 64 метки на ресурс.</p> 
status | **string**<br><p>Статус реестра.</p> <ul> <li>CREATING: Реестр создается.</li> <li>ACTIVE: Реестр готов к использованию.</li> <li>DELETING: Реестр удаляется.</li> </ul> 
logGroupId | **string**<br><p>Идентификатор группы журналов для указанного реестра.</p> 