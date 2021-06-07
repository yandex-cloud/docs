---
editable: false
---

# Метод get
Возвращает информацию об указанной группе выделенных хостов.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostGroups/{hostGroupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
hostGroupId | Обязательное поле. Идентификатор группы выделенных хостов. Чтобы получить идентификатор группы выделенных хостов, используйте запрос [list](/docs/compute/api-ref/HostGroup/list).  Максимальная длина строки в символах — 50.
 
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
```
Описывает группу выделенных хостов.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор группы выделенных хостов.</p> 
folderId | **string**<br><p>Идентификатор каталога, к которому принадлежит группа выделенных хостов.</p> 
createdAt | **string** (date-time)<br><p>Время создания группы выделенных хостов в текстовом формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя группы выделенных хостов. Имя должно быть уникальным в каталоге.</p> 
description | **string**<br><p>Описание группы выделенных хостов.</p> 
labels | **object**<br><p>Метки ресурса в формате ``ключ:значение``.</p> 
zoneId | **string**<br><p>Зона доступности, в которой размещены все выделенные хосты.</p> 
status | **string**<br><p>Статус группы выделенных хостов.</p> 
typeId | **string**<br><p>Идентификатор типа выделенного хоста. Ресурсы, предоставляемые каждым выделенным хостом группы.</p> 
maintenancePolicy | **string**<br><p>Политика обслуживания.</p> <ul> <li>RESTART: После обслуживания перезапустить ВМ на том же выделенном хосте.</li> <li>MIGRATE: Перенести ВМ на другой выделенный хост перед обслуживанием.</li> </ul> 
scalePolicy | **object**<br><p>Политика масштабирования. На данный момент поддерживается только фиксированное количество выделенных хостов.</p> 
scalePolicy.<br>fixedScale | **object**<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br>