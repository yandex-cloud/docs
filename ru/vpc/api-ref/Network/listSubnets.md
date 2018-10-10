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
subnets | **object**<br>Ресурс Subnet. Дополнительные сведения см. в разделе [Подсети](/docs/vpc/concepts/network#subnet).
subnets.<br>id | **string**<br>Только для вывода. Идентификатор подсети.
subnets.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит подсеть.
subnets.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
subnets.<br>name | **string**<br>Имя подсети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.
subnets.<br>description | **string**<br>Описание подсети. Длина описания должна быть от 0 до 256 символов.
subnets.<br>labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 метки на ресурс.
subnets.<br>networkId | **string**<br>Идентификатор облачной сети, к которой принадлежит подсеть.
subnets.<br>zoneId | **string**<br>Идентификатор зоны доступности, где находится подсеть.
subnets.<br>v4CidrBlocks | **string**<br>CIDR. Диапазон внутренних адресов, определенных для этой подсети. Это поле может быть задано только во время создания ресурса Subnet и не может быть изменено. Например, 10.0.0.0/22 или 192.168.0.0/24. Минимальный размер подсети /28, максимальный размер подсети /16.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/vpc/api-ref/Network/listSubnets#query_params), используйте [nextPageToken](/docs/vpc/api-ref/Network/listSubnets#responses) в качестве значения параметра [pageToken](/docs/vpc/api-ref/Network/listSubnets#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/vpc/api-ref/Network/listSubnets#responses), для перебора страниц результатов.