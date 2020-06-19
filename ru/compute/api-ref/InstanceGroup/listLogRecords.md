---
editable: false
---

# Метод listLogRecords
Возвращает список логов для указанной группы виртуальных машин.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups/{instanceGroupId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
instanceGroupId | Обязательное поле. Идентификатор ресурса InstanceGroup для получения списка логов. Чтобы получить идентификатор группы виртуальных машин, используйте запрос [list](/docs/compute/api-ref/InstanceGroup/list).
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/InstanceGroup/listLogRecords#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/InstanceGroup/listLogRecords#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [InstanceGroup.name](/docs/compute/api-ref/InstanceGroup#representation).  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logRecords": [
    {
      "timestamp": "string",
      "message": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
logRecords[] | **object**<br><p>Возвращает список логов для указанной группы виртуальных машин.</p> 
logRecords[].<br>timestamp | **string** (date-time)<br><p>Время записи лога в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logRecords[].<br>message | **string**<br><p>Сообщение.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/InstanceGroup/listLogRecords#responses">nextPageToken</a> для перебора страниц результатов.</p> 