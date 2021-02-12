---
editable: false
---

# Метод list
Возвращает список TargetGroup ресурсов в указанном каталоге..
 

 
## HTTP-запрос {#https-request}
```
GET https://load-balancer.api.cloud.yandex.net/network-load-balancer/v1/targetGroups
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для вывода списка целевых групп.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/network-load-balancer/api-ref/TargetGroup/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/network-load-balancer/api-ref/TargetGroup/list#query_params), сервис вернет значение [nextPageToken](/docs/network-load-balancer/api-ref/TargetGroup/list#responses),  которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/network-load-balancer/api-ref/TargetGroup/list#query_params) равным значению поля [nextPageToken](/docs/network-load-balancer/api-ref/TargetGroup/list#responses), прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [TargetGroup.name](/docs/network-load-balancer/api-ref/TargetGroup#representation). 2. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "targetGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "regionId": "string",
      "targets": [
        {
          "subnetId": "string",
          "address": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
targetGroups[] | **object**<br><p>Ресурс TargetGroup. Подробнее см. в разделе <a href="/docs/network-load-balancer/concepts/target-resources">Целевые группы и ресурсы</a>.</p> 
targetGroups[].<br>id | **string**<br><p>Только для вывода. Идентификатор целевой группы.</p> 
targetGroups[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит целевая группа.</p> 
targetGroups[].<br>createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
targetGroups[].<br>name | **string**<br><p>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
targetGroups[].<br>description | **string**<br><p>Описание целевой группы. Длина 0-256 символов.</p> 
targetGroups[].<br>labels | **object**<br><p>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс.</p> 
targetGroups[].<br>regionId | **string**<br><p>Идентификатор региона, в котором находится целевая группа.</p> 
targetGroups[].<br>targets[] | **object**<br><p>Ресурс Target. Подробнее см. в разделе <a href="/docs/network-load-balancer/target-resources">Целевые группы и ресурсы</a>.</p> 
targetGroups[].<br>targets[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети.</p> <p>Максимальная длина строки в символах — 50.</p> 
targetGroups[].<br>targets[].<br>address | **string**<br><p>IP-адрес целевого ресурса.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#query_params">pageSize</a>, используйте <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a>, для перебора страниц результатов.</p> 