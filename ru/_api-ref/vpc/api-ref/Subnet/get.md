---
editable: false
---

# Метод get
Возвращает указанный ресурс Subnet.
 
Чтобы получить список доступных подсетей, используйте запрос [list](/docs/vpc/api-ref/Subnet/list).
 
## HTTP-запрос {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/subnets/{subnetId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
subnetId | Обязательное поле. Идентификатор возвращаемого ресурса Subnet.   Чтобы получить идентификатор подсети, используйте запрос [list](/docs/vpc/api-ref/Subnet/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Ресурс Subnet. Подробнее см. [Подсети](/vpc/concepts/subnets).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор подсети.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит подсеть.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя подсети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание подсети. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``. Максимум 64 метки на ресурс.</p> 
networkId | **string**<br><p>Идентификатор облачной сети, к которой принадлежит подсеть.</p> 
zoneId | **string**<br><p>Идентификатор зоны доступности, где находится подсеть.</p> 
v4CidrBlocks[] | **string**<br><p>CIDR. Диапазон внутренних адресов, определенных для этой подсети. Это поле может быть задано только во время создания ресурса Subnet и не может быть изменено. Например, 10.0.0.0/22 или 192.168.0.0/24. Минимальный размер подсети /28, максимальный размер подсети /16.</p> 
v6CidrBlocks[] | **string**<br><p>IPv6 еще не доступен.</p> 