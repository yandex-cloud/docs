---
editable: false
---

# Метод getVersionByTag
Возвращает все версии с указанным тегом.
 
Чтобы получить список доступных версий, используйте запрос [listVersions](/docs/functions/functions/api-ref/Function/listVersions) .
 
## HTTP-запрос {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/versions:byTag
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
functionId | Обязательное поле. Идентификатор функции, для которой нужно вернуть список версий.  Чтобы получить идентификатор функции, используйте запрос [list](/docs/functions/functions/api-ref/Function/list) .
tag | Тег версии.  Чтобы получить историю тегов версий, используйте запрос [listTagHistory](/docs/functions/functions/api-ref/Function/listTagHistory) .  Значение должно соответствовать регулярному выражению `` [a-z][-_0-9a-z]*|[$]latest ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "functionId": "string",
  "description": "string",
  "createdAt": "string",
  "runtime": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "imageSize": "string",
  "status": "string",
  "tags": [
    "string"
  ],
  "logGroupId": "string",
  "environment": "object"
}
```
Версия функции. Дополнительные сведения о концепции см. в разделе
[Версия функции](/docs/functions/concepts/function#version).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор версии.</p> 
functionId | **string**<br><p>Идентификатор функции, которой принадлежит версия.</p> 
description | **string**<br><p>Описание версии.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
createdAt | **string** (date-time)<br><p>Время создания версии.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
runtime | **string**<br><p>Идентификатор среды выполнения для функции.</p> <p>Поддерживаемые среды и их идентификаторы перечислены в списке <a href="/docs/functions/concepts/runtime">Среда выполнения</a>.</p> 
entrypoint | **string**<br><p>Точка входа для функции: имя функции, вызываемой в качестве обработчика.</p> <p>Указывается в формате `<function file name>.<handler name>`, например, `index.myFunction`.</p> 
resources | **object**<br><p>Ресурсы, выделенные для версии.</p> <p>Ресурсы, выделенные для версии.</p> 
resources.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный для версии.</p> <p>Допустимые значения — от 33554432 до 1073741824 включительно.</p> 
executionTimeout | **string**<br><p>Таймаут для выполнения версии.</p> <p>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, который связан с версией.</p> 
imageSize | **string** (int64)<br><p>Окончательный размер пакета развертывания после распаковки.</p> 
status | **string**<br><p>Состояние версии.</p> <ul> <li>CREATING: Версия создается.</li> <li>ACTIVE: Версия готова к использованию.</li> </ul> 
tags[] | **string**<br><p>Теги версий. Подробнее см. в <a href="/docs/functions/concepts/function#tag">Тег версии</a>.</p> 
logGroupId | **string**<br><p>Идентификатор группы журналов выполнения для версии.</p> 
environment | **object**<br><p>Параметры среды выполнения для версии.</p> 