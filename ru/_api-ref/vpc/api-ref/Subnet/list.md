---
editable: false
---

# Метод list
Возвращает список доступных подсетей в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/subnets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка подсетей.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов  больше чем [pageSize](/docs/vpc/api-ref/Subnet/list#query_params), сервис вернет значение [nextPageToken](/docs/vpc/api-ref/Subnet/list#responses),  которое можно использовать для получения следующей страницы.  Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/vpc/api-ref/Subnet/list#query_params) равным значению поля [nextPageToken](/docs/vpc/api-ref/Subnet/list#responses)  прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Subnet.name](/docs/vpc/api-ref/Subnet#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "subnets": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "networkId": "string",
      "zoneId": "string",
      "v4CidrBlocks": [
        "string"
      ],
      "v6CidrBlocks": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
subnets[] | **object**<br><p>Ресурс Subnet. Подробнее см. <a href="/vpc/concepts/subnets">Подсети</a>.</p> 
subnets[].<br>id | **string**<br><p>Идентификатор подсети.</p> 
subnets[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит подсеть.</p> 
subnets[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
subnets[].<br>name | **string**<br><p>Имя подсети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
subnets[].<br>description | **string**<br><p>Описание подсети. Длина описания должна быть от 0 до 256 символов.</p> 
subnets[].<br>labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``. Максимум 64 метки на ресурс.</p> 
subnets[].<br>networkId | **string**<br><p>Идентификатор облачной сети, к которой принадлежит подсеть.</p> 
subnets[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, где находится подсеть.</p> 
subnets[].<br>v4CidrBlocks[] | **string**<br><p>CIDR. Диапазон внутренних адресов, определенных для этой подсети. Это поле может быть задано только во время создания ресурса Subnet и не может быть изменено. Например, 10.0.0.0/22 или 192.168.0.0/24. Минимальный размер подсети /28, максимальный размер подсети /16.</p> 
subnets[].<br>v6CidrBlocks[] | **string**<br><p>IPv6 еще не доступен.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/vpc/api-ref/Subnet/list#query_params">pageSize</a>, используйте <a href="/docs/vpc/api-ref/Subnet/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/vpc/api-ref/Subnet/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/vpc/api-ref/Subnet/list#responses">nextPageToken</a>, для перебора страниц результатов.</p> 