---
editable: false
---

# Метод list
Возвращает список функций в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/functions
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка функций.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize` , сервис вернет значение [nextPageToken](/docs/functions/functions/api-ref/Function/list#responses), которое можно использовать для получения следующей страницы.  Значение по умолчанию: 100.
pageToken | Токен страницы. Установите значение `pageToken` равным значению поля [nextPageToken](/docs/functions/functions/api-ref/Function/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.
filter | Выражение фильтра, для фильтрации списка функций в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](/docs/functions/functions/api-ref/Function#representation). 2. Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functions": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
functions[] | **object**<br><p>Бессерверная функция. Дополнительные сведения о концепции см. в разделе <a href="/docs/functions/concepts/function">Функция</a>.</p> 
functions[].<br>id | **string**<br><p>Идентификатор функции. Генерируется во время создания.</p> 
functions[].<br>folderId | **string**<br><p>Идентификатор каталога, к которому принадлежит функция.</p> 
functions[].<br>createdAt | **string** (date-time)<br><p>Время создания функции.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
functions[].<br>name | **string**<br><p>Имя функции. Имя уникально в рамках каталога.</p> <p>Длина строки в символах должна быть от 3 до 63.</p> 
functions[].<br>description | **string**<br><p>Описание функции.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
functions[].<br>labels | **object**<br><p>Метки функций в виде пар ``key:value`` .</p> <p>Не более 64 на ресурс.</p> 
functions[].<br>logGroupId | **string**<br><p>Идентификатор группы журналов выполнения функции.</p> 
functions[].<br>httpInvokeUrl | **string**<br><p>URL-адрес, который нужнозапросить для вызова функции.</p> 
functions[].<br>status | **string**<br><p>Состояние функции.</p> <ul> <li>CREATING: Функция создается.</li> <li>ACTIVE: Функция готова к вызову.</li> <li>DELETING: Функция удаляется.</li> <li>ERROR: Сбой функции.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/functions/functions/api-ref/Function/list#query_params">pageSize</a>, используйте ``nextPageToken`` в качестве значения параметра <a href="/docs/functions/functions/api-ref/Function/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения ``nextPageToken`` для перебора страниц результатов.</p> 