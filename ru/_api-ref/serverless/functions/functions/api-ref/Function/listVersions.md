---
editable: false
---

# Метод listVersions
Извлекает список версий для указанной функции или всех версий функции в указанном
каталоге
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/versions
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Идентификатор каталога, для которого нужно вернуть список версий функции. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).
functionId | Идентификатор функции, для которой нужно вернуть список версий. Чтобы получить идентификатор функции, используйте запрос [list](/docs/functions/functions/api-ref/Function/list) .
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize` , сервис вернет значение [nextPageToken](/docs/functions/functions/api-ref/Function/listVersions#responses), которое можно использовать для получения следующей страницы.  Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `pageToken` равным значению поля [nextPageToken](/docs/functions/functions/api-ref/Function/listVersions#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Function.name](/docs/functions/functions/api-ref/Function#representation). 2. Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-function`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
versions[] | **object**<br><p>Версия функции. Дополнительные сведения о концепции см. в разделе <a href="/docs/functions/concepts/function#version">Версия функции</a>.</p> 
versions[].<br>id | **string**<br><p>Идентификатор версии.</p> 
versions[].<br>functionId | **string**<br><p>Идентификатор функции, которой принадлежит версия.</p> 
versions[].<br>description | **string**<br><p>Описание версии.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
versions[].<br>createdAt | **string** (date-time)<br><p>Время создания версии.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
versions[].<br>runtime | **string**<br><p>Идентификатор среды выполнения для функции.</p> <p>Поддерживаемые среды и их идентификаторы перечислены в списке <a href="/docs/functions/concepts/runtime">Среда выполнения</a>.</p> 
versions[].<br>entrypoint | **string**<br><p>Точка входа для функции: имя функции, вызываемой в качестве обработчика.</p> <p>Указывается в формате ``&lt;function file name&gt;.&lt;handler name&gt;``, например, ``index.myFunction``.</p> 
versions[].<br>resources | **object**<br><p>Ресурсы, выделенные для версии.</p> <p>Ресурсы, выделенные для версии.</p> 
versions[].<br>resources.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный для версии.</p> <p>Допустимые значения — от 33554432 до 1073741824 включительно.</p> 
versions[].<br>executionTimeout | **string**<br><p>Таймаут для выполнения версии.</p> <p>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код.</p> 
versions[].<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, который связан с версией.</p> 
versions[].<br>imageSize | **string** (int64)<br><p>Окончательный размер пакета развертывания после распаковки.</p> 
versions[].<br>status | **string**<br><p>Состояние версии.</p> <ul> <li>CREATING: Версия создается.</li> <li>ACTIVE: Версия готова к использованию.</li> </ul> 
versions[].<br>tags[] | **string**<br><p>Теги версий. Подробнее см. в <a href="/docs/functions/concepts/function#tag">Тег версии</a>.</p> 
versions[].<br>logGroupId | **string**<br><p>Идентификатор группы журналов выполнения для версии.</p> 
versions[].<br>environment | **object**<br><p>Параметры среды выполнения для версии.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/functions/functions/api-ref/Function/listVersions#query_params">pageSize</a>, используйте ``nextPageToken`` в качестве значения параметра <a href="/docs/functions/functions/api-ref/Function/listVersions#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения ``nextPageToken`` для перебора страниц результатов.</p> 