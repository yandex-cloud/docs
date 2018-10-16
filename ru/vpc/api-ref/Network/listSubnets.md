# Метод listSubnets
Возвращает список доступных подсетей в указанной облачной
сети.
 

 
## HTTP-запрос
`GET /vpc/v1/networks/{networkId}/subnets`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
networkId | Обязательное поле. Идентификатор ресурса Network для получения списка подсетей.  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/vpc/api-ref/Network/listSubnets#query_params), сервис вернет значение [nextPageToken](/docs/vpc/api-ref/Network/listSubnets#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/vpc/api-ref/Network/listSubnets#query_params) равным значению поля [nextPageToken](/docs/vpc/api-ref/Network/listSubnets#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
subnets | **object**<br><p>Ресурс Subnet. Дополнительные сведения см. в разделе <a href="/docs/vpc/concepts/network#subnet">Подсети</a>.</p> 
subnets.<br>id | **string**<br><p>Идентификатор подсети.</p> 
subnets.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит подсеть.</p> 
subnets.<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
subnets.<br>name | **string**<br><p>Имя подсети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
subnets.<br>description | **string**<br><p>Описание подсети. Длина описания должна быть от 0 до 256 символов.</p> 
subnets.<br>labels | **object**<br><p>Метки ресурса в формате ключ-значение. Максимум 64 метки на ресурс.</p> 
subnets.<br>networkId | **string**<br><p>Идентификатор облачной сети, к которой принадлежит подсеть.</p> 
subnets.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, где находится подсеть.</p> 
subnets.<br>v4CidrBlocks | **string**<br><p>CIDR. Диапазон внутренних адресов, определенных для этой подсети. Это поле может быть задано только во время создания ресурса Subnet и не может быть изменено. Например, 10.0.0.0/22 или 192.168.0.0/24. Минимальный размер подсети /28, максимальный размер подсети /16.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/vpc/api-ref/Network/listSubnets#query_params">pageSize</a>, используйте <a href="/docs/vpc/api-ref/Network/listSubnets#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/vpc/api-ref/Network/listSubnets#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/vpc/api-ref/Network/listSubnets#responses">nextPageToken</a>, для перебора страниц результатов.</p> 