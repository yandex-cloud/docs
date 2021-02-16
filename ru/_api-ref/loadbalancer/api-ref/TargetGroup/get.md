---
editable: false
---

# Метод get
Возвращает указанный ресурс TargetGroup.
 

 
## HTTP-запрос {#https-request}
```
GET https://load-balancer.api.cloud.yandex.net/network-load-balancer/v1/targetGroups/{targetGroupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
targetGroupId | Обязательное поле. Идентификатор возвращаемого ресурса TargetGroup.  Чтобы узнать идентификатор целевой группы, используйте запрос [list](/docs/network-load-balancer/api-ref/TargetGroup/list).  Максимальная длина строки в символах — 50.
 
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
  "regionId": "string",
  "targets": [
    {
      "subnetId": "string",
      "address": "string"
    }
  ]
}
```
Ресурс TargetGroup. Подробнее см. в разделе [Целевые группы и ресурсы](/docs/network-load-balancer/concepts/target-resources).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор целевой группы.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит целевая группа.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание целевой группы. Длина 0-256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс.</p> 
regionId | **string**<br><p>Идентификатор региона, в котором находится целевая группа.</p> 
targets[] | **object**<br><p>Ресурс Target. Подробнее см. в разделе <a href="/docs/network-load-balancer/target-resources">Целевые группы и ресурсы</a>.</p> 
targets[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети.</p> <p>Максимальная длина строки в символах — 50.</p> 
targets[].<br>address | **string**<br><p>IP-адрес целевого ресурса.</p> 