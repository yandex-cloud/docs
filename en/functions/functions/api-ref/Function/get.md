---
editable: false
---

# Метод get
Возвращает указанную функцию.
 
Чтобы получить список доступных функций, используйте запрос [list](/docs/functions/functions/api-ref/Function/list) .
 
## HTTP-запрос {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/functions/{functionId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
functionId | Обязательное поле. Идентификатор возвращаемой функции.  Чтобы получить идентификатор функции, используйте запрос [list](/docs/functions/functions/api-ref/Function/list) .
 
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
  "logGroupId": "string",
  "httpInvokeUrl": "string",
  "status": "string"
}
```
Бессерверная функция. Дополнительные сведения о концепции см. в разделе
[Функция](/docs/functions/concepts/function).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор функции. Генерируется во время создания.</p> 
folderId | **string**<br><p>Идентификатор каталога, к которому принадлежит функция.</p> 
createdAt | **string** (date-time)<br><p>Время создания функции.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя функции. Имя уникально в рамках каталога.</p> <p>Длина строки в символах должна быть от 3 до 63.</p> 
description | **string**<br><p>Описание функции.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
labels | **object**<br><p>Метки функций в виде пар `key:value` .</p> <p>Не более 64 на ресурс.</p> 
logGroupId | **string**<br><p>Идентификатор группы журналов выполнения функции.</p> 
httpInvokeUrl | **string**<br><p>URL-адрес, который нужнозапросить для вызова функции.</p> 
status | **string**<br><p>Состояние функции.</p> <ul> <li>CREATING: Функция создается.</li> <li>ACTIVE: Функция готова к вызову.</li> <li>DELETING: Функция удаляется.</li> <li>ERROR: Сбой функции.</li> </ul> 