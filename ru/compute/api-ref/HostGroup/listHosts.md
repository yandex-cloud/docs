---
editable: false
---

# Метод listHosts
Список выделенных хостов, привязанных к указанной группе хостов.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostGroups/{hostGroupId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
hostGroupId | Обязательное поле. Идентификатор группы выделенных хостов, для которой запрашивается список хостов. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [list](/docs/compute/api-ref/HostGroup/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/HostGroup/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/HostGroup/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/HostGroup/listHosts#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/HostGroup/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "id": "string",
      "status": "string",
      "serverId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Описывает выделенный хост.</p> 
hosts[].<br>id | **string**<br><p>Идентификатор выделенного хоста.</p> 
hosts[].<br>status | **string**<br><p>Текущий статус выделенного хоста. Новые ВМ не могут запускаться на выделенном хосте в статусе DOWN.</p> 
hosts[].<br>serverId | **string**<br><p>Идентификатор физического сервера, которому принадлежит выделенный хост.</p> 
nextPageToken | **string**<br><p>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> для продолжения перебора страниц результатов.</p> 