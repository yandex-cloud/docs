---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Метод list
Получает список ресурсов Image в указанном реестре или
репозитории.
 

 
## HTTP-запрос {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/images
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
registryId | Идентификатор реестра для получения списка Docker-образов. [registryId](/docs/container-registry/api-ref/Image/list#query_params) игнорируется, если в запросе указан [repositoryName](/docs/container-registry/api-ref/Image/list#query_params).  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/container-registry/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
repositoryName | Имя репозитория для получения списка Docker-образов.  Чтобы получить имя репозитория, используйте [list](/docs/container-registry/api-ref/Repository/list) запрос.  Значение должно соответствовать регулярному выражению `` |[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ``.
folderId | Идентификатор каталога, для которого запрашивается список Docker-образов. [folderId](/docs/container-registry/api-ref/Image/list#query_params) игнорируется, если в запросе есть [repositoryName](/docs/container-registry/api-ref/Image/list#query_params) или [registryId](/docs/container-registry/api-ref/Image/list#query_params).  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/container-registry/api-ref/Image/list#query_params), сервис вернет значение [nextPageToken](/docs/container-registry/api-ref/Image/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/container-registry/api-ref/Image/list#query_params) равным значению поля [nextPageToken](/docs/container-registry/api-ref/Image/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Image.name](/docs/container-registry/api-ref/Image#representation). 2. Оператор. Может быть `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Должно быть не более 256 символов и соответствовать регулярному выражению `[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))`.  Максимальная длина строки в символах — 1000.
orderBy | Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "images": [
    {
      "id": "string",
      "name": "string",
      "digest": "string",
      "compressedSize": "string",
      "config": {
        "id": "string",
        "digest": "string",
        "size": "string"
      },
      "layers": [
        {
          "id": "string",
          "digest": "string",
          "size": "string"
        }
      ],
      "tags": [
        "string"
      ],
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
images[] | **object**<br><p>Ресурс Image. Подробнее смотрите в разделе <a href="docs/container-registry/concepts/docker-image">Docker-образ</a>.</p> 
images[].<br>id | **string**<br><p>Только для вывода. Идентификатор Docker-образа.</p> 
images[].<br>name | **string**<br><p>Имя Docker-образа. Уникально в рамках реестра.</p> 
images[].<br>digest | **string**<br><p>Контентный адрес Docker-образа.</p> 
images[].<br>compressedSize | **string** (int64)<br><p>Размер сжатого Docker-образа, в байтах.</p> 
images[].<br>config | **object**<br><p>Конфигурация Docker-образа.</p> <p>Ресурс Blob.</p> 
images[].<br>config.<br>id | **string**<br><p>Только для вывода. Идентификатор блоба.</p> 
images[].<br>config.<br>digest | **string**<br><p>Контентный адрес блоба.</p> 
images[].<br>config.<br>size | **string** (int64)<br><p>Размер блоба, указанный в байтах.</p> 
images[].<br>layers[] | **object**<br><p>Ресурс Blob.</p> 
images[].<br>layers[].<br>id | **string**<br><p>Только для вывода. Идентификатор блоба.</p> 
images[].<br>layers[].<br>digest | **string**<br><p>Контентный адрес блоба.</p> 
images[].<br>layers[].<br>size | **string** (int64)<br><p>Размер блоба, указанный в байтах.</p> 
images[].<br>tags[] | **string**<br><p>Теги Docker-образа.</p> <p>Каждый тег уникален в пределах репозитория.</p> 
images[].<br>createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/container-registry/api-ref/Image/list#query_params">pageSize</a>, используйте <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/container-registry/api-ref/Image/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 