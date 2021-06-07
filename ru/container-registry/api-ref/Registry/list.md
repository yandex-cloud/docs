---
editable: false
---

# Метод list
Возвращает список доступных ресурсов Registry в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/registries
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка реестров.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/container-registry/api-ref/Registry/list#query_params), сервис вернет значение [nextPageToken](/docs/container-registry/api-ref/Registry/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/container-registry/api-ref/Registry/list#query_params) равным значению поля [nextPageToken](/docs/container-registry/api-ref/Registry/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Registry.name](/docs/container-registry/api-ref/Registry#representation). 2. Оператор. Может быть `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение или список значений для сравнения со значениями фильтра.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "status": "string",
      "createdAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
registries[] | **object**<br><p>Ресурс Registry. Подробнее смотрите в разделе <a href="/docs/container-registry/concepts/registry">Реестр</a>.</p> 
registries[].<br>id | **string**<br><p>Только для вывода. Идентификатор реестра.</p> 
registries[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит реестр.</p> 
registries[].<br>name | **string**<br><p>Название реестра.</p> 
registries[].<br>status | **string**<br><p>Только для вывода. Статус реестра.</p> <ul> <li>CREATING: Реестр создается.</li> <li>ACTIVE: Реестр готов к использованию.</li> <li>DELETING: Реестр удаляется.</li> </ul> 
registries[].<br>createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
registries[].<br>labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 метки на ресурс.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/container-registry/api-ref/Registry/list#query_params">pageSize</a>, используйте <a href="/docs/container-registry/api-ref/Registry/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/container-registry/api-ref/Registry/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/container-registry/api-ref/Registry/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 