---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Метод list
Получает список ресурсов Repository в указанном реестре.
 

 
## HTTP-запрос {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/repositories
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
registryId | Идентификатор реестра для получения списка репозиториев.  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/container-registry/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
folderId | Идентификатор каталога, для которого запрашивается список реестров. [folderId](/docs/container-registry/api-ref/Repository/list#query_params) игнорируется, если в запросе указан [registryId](/docs/container-registry/api-ref/Image/list#query_params).  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/container-registry/api-ref/Repository/list#query_params), сервис вернет значение [nextPageToken](/docs/container-registry/api-ref/Repository/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/container-registry/api-ref/Repository/list#query_params) равным значению поля [nextPageToken](/docs/container-registry/api-ref/Repository/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Repository.name](/docs/container-registry/api-ref/Repository#representation). 2. Оператор. Может быть `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение или список значений для сравнения со значениями фильтра.  Максимальная длина строки в символах — 1000.
orderBy | Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "repositories": [
    {
      "name": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
repositories[] | **object**<br><p>Ресурс Repository. Подробнее смотрите в разделе <a href="/docs/container-registry/concepts/repository">Репозиторий</a>.</p> 
repositories[].<br>name | **string**<br><p>Имя репозитория. Уникально в рамках реестра.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageSize</a>, используйте <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 