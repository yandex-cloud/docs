---
editable: false
---

# Метод list
Возвращает список доступных групп выделенных хостов в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostGroups
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, в котором созданы группы выделенных хостов. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/HostGroup/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/HostGroup/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/HostGroup/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/HostGroup/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурса в ответе. В настоящее время фильтрация осуществляется только по полю [HostGroup.name](/docs/compute/api-ref/HostGroup#representation).  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hostGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "status": "string",
      "typeId": "string",
      "maintenancePolicy": "string",
      "scalePolicy": {
        "fixedScale": {
          "size": "string"
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hostGroups[] | **object**<br><p>Описывает группу выделенных хостов.</p> 
hostGroups[].<br>id | **string**<br><p>Идентификатор группы выделенных хостов.</p> 
hostGroups[].<br>folderId | **string**<br><p>Идентификатор каталога, к которому принадлежит группа выделенных хостов.</p> 
hostGroups[].<br>createdAt | **string** (date-time)<br><p>Время создания группы выделенных хостов в текстовом формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
hostGroups[].<br>name | **string**<br><p>Имя группы выделенных хостов. Имя должно быть уникальным в каталоге.</p> 
hostGroups[].<br>description | **string**<br><p>Описание группы выделенных хостов.</p> 
hostGroups[].<br>labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``.</p> 
hostGroups[].<br>zoneId | **string**<br><p>Зона доступности, в которой размещены все выделенные хосты.</p> 
hostGroups[].<br>status | **string**<br><p>Статус группы выделенных хостов.</p> 
hostGroups[].<br>typeId | **string**<br><p>Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы.</p> 
hostGroups[].<br>maintenancePolicy | **string**<br><p>Политика обслуживания.</p> <ul> <li>RESTART: После обслуживания перезапустить ВМ на том же выделенном хосте.</li> <li>MIGRATE: Перенести ВМ на другой выделенный хост перед обслуживанием.</li> </ul> 
hostGroups[].<br>scalePolicy | **object**<br><p>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов.</p> 
hostGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>
hostGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br>
nextPageToken | **string**<br><p>Этот токен позволяет получить следующую страницу результатов для списка запросов. Если количество результатов больше чем <a href="/docs/compute/api-ref/HostGroup/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/HostGroup/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/HostGroup/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Каждая следующая страница будет иметь свой <a href="/docs/compute/api-ref/HostGroup/list#responses">nextPageToken</a> для продолжения перебора страниц результатов.</p> 