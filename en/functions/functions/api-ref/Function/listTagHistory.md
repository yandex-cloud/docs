---
editable: false
---

# Метод listTagHistory
Возвращает журнал тегов, назначенных версиям указанной функции.
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/functions/{functionId}:tagHistory
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
functionId | Обязательное поле. Идентификатор функции для получения истории тегов.  Чтобы получить идентификатор функции, используйте запрос [list](/docs/functions/functions/api-ref/Function/list) .
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
tag | Конкретный тег, которым должна быть ограничена история.  Значение должно соответствовать регулярному выражению `` [a-z][-_0-9a-z]*|[$]latest ``.
pageSize | Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `pageSize` , сервис вернет значение [nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `pageToken` равным значению поля [nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](/docs/functions/functions/api-ref/Function#representation). 2. Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Например, `name=my-function`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functionTagHistoryRecord": [
    {
      "functionId": "string",
      "functionVersionId": "string",
      "tag": "string",
      "effectiveFrom": "string",
      "effectiveTo": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
functionTagHistoryRecord[] | **object**<br><p>Запись в истории тегов.</p> 
functionTagHistoryRecord[].<br>functionId | **string**<br><p>Идентификатор функции, для которой идет запись.</p> 
functionTagHistoryRecord[].<br>functionVersionId | **string**<br><p>Идентификатор версии функции, для которой идет запись.</p> 
functionTagHistoryRecord[].<br>tag | **string**<br><p>Тег, который был установлен для версии в какой-то момент.</p> 
functionTagHistoryRecord[].<br>effectiveFrom | **string** (date-time)<br><p>Отметка времени, когда тег начал быть активным для функции.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
functionTagHistoryRecord[].<br>effectiveTo | **string** (date-time)<br><p>Отметка времени, когда тег перестал быть активным для функции.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/functions/functions/api-ref/Function/listTagHistory#query_params">pageSize</a>, используйте `nextPageToken` в качестве значения параметра <a href="/docs/functions/functions/api-ref/Function/listTagHistory#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения `nextPageToken` для перебора страниц результатов.</p> 