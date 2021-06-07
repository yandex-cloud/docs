---
editable: false
---

# Метод get
Возвращает указанный секрет.
 
Чтобы получить список доступных секретов, выполните запрос [list](/docs/lockbox/api-ref/Secret/list). Чтобы получить содержимое версии, используйте запрос [get](/docs/lockbox/api-ref/Payload/get).
 
## HTTP-запрос {#https-request}
```
GET https://lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secretId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
secretId | Обязательное поле. Идентификатор возвращаемого секрета.  Чтобы получить идентификатор секрета, выполните запрос [List].  Максимальная длина строки в символах — 50.
 
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
  "kmsKeyId": "string",
  "status": "string",
  "currentVersion": {
    "id": "string",
    "secretId": "string",
    "createdAt": "string",
    "destroyAt": "string",
    "description": "string",
    "status": "string",
    "payloadEntryKeys": [
      "string"
    ]
  },
  "deletionProtection": true
}
```
Секрет, который состоит из нескольких версий.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор секрета.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит секрет.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя секрета.</p> 
description | **string**<br><p>(опционально) Описание секрета.</p> 
labels | **object**<br><p>Пользовательские метки для секрета в виде пар ``key:value``. Максимум 64 на ключ.</p> 
kmsKeyId | **string**<br><p>(опционально) Идентификатор пользовательского ключа KMS. Если пользовательский ключ не указан, для шифрования и расшифровки используется системный ключ.</p> 
status | **string**<br><p>Статус секрета.</p> <ul> <li>CREATING: Секрет создается.</li> <li>ACTIVE: Секрет активен и к нему можно получить доступ.</li> </ul> <p>Можно установить в INACTIVE с помощью метода <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a>.</p> <ul> <li>INACTIVE: Секрет неактивен и не может быть использован.</li> </ul> <p>Можно установить в ACTIVE с помощью метода <a href="/docs/lockbox/api-ref/Secret/activate">activate</a>.</p> 
currentVersion | **object**<br><p>Текущая версия секрета.</p> 
currentVersion.<br>id | **string**<br><p>Идентификатор версии.</p> 
currentVersion.<br>secretId | **string**<br><p>Идентификатор секрета, которому принадлежит версия.</p> 
currentVersion.<br>createdAt | **string** (date-time)<br><p>Время создания версии ключа.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
currentVersion.<br>destroyAt | **string** (date-time)<br><p>Время, когда версия ключа будет уничтожена. Пустой, если статус ``ACTIVE``.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
currentVersion.<br>description | **string**<br><p>(опционально) Описание версии.</p> 
currentVersion.<br>status | **string**<br><p>Статус секрета.</p> <ul> <li>ACTIVE: Секрет активен и к нему можно получить доступ.</li> <li>SCHEDULED_FOR_DESTRUCTION: Версия запланирована к уничтожению. Время, когда она будет уничтожена, указано в поле ``destroyAt``.</li> <li>DESTROYED: Версия уничтожена и не может быть восстановлена.</li> </ul> 
currentVersion.<br>payloadEntryKeys[] | **string**<br><p>Ключи содержимого версии.</p> 
deletionProtection | **boolean** (boolean)<br><p>Флаг, запрещающий удаление секрета.</p> 