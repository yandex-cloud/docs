---
editable: false
---

# Метод get
Возвращает указанный ресурс Network.
 
Чтобы получить список доступных ресурсов Network, используйте
запрос [list](/docs/vpc/api-ref/Network/list).
 
## HTTP-запрос {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/networks/{networkId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
networkId | Обязательное поле. Идентификатор возвращаемого ресурса Network. Чтобы получить идентификатор облачной сети, используйте запрос [list](/docs/vpc/api-ref/Network/list).  Максимальная длина строки в символах — 50.
 
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
  "defaultSecurityGroupId": "string"
}
```
Ресурс Network. Подробнее см. [Сети](/docs/vpc/concepts/network).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор облачной сети.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит сеть.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя облачной сети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание облачной сети. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``. Максимум 64 метки на ресурс.</p> 
defaultSecurityGroupId | **string**<br><p>Идентификатор группы безопасности по умолчанию.</p> 