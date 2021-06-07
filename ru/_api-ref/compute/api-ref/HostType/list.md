---
editable: false
---

# Метод list
Список доступных типов выделенных хостов.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostTypes
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/HostType/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/HostType/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/HostType/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/HostType/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hostTypes": [
    {
      "id": "string",
      "cores": "string",
      "memory": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hostTypes[] | **object**<br><p>Описывает ресурсы выделенного хоста. Примечание. Платформа может использовать выделенные хосты с разным количеством памяти и ядер.</p> 
hostTypes[].<br>id | **string**<br><p>Уникальный идентификатор типа выделенного хоста.</p> 
hostTypes[].<br>cores | **string** (int64)<br><p>Общее количество ядер, доступных для ВМ выделенного хоста.</p> 
hostTypes[].<br>memory | **string** (int64)<br><p>Объем памяти, доступный для ВМ выделенного хоста.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/HostType/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/compute/api-ref/HostType/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Каждая следующая страница будет иметь свой ``next_page_token`` для продолжения перебора страниц результатов.</p> 