---
editable: false
---

# HostGroup
Набор методов для управления группами выделенных хостов.
## JSON-представление {#representation}
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

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает группу выделенных хостов в указанном каталоге.
[delete](delete.md) | Удаляет указанную группу выделенных хостов.
[get](get.md) | Возвращает информацию об указанной группе выделенных хостов.
[list](list.md) | Возвращает список доступных групп выделенных хостов в указанном каталоге.
[listHosts](listHosts.md) | Список выделенных хостов, привязанных к указанной группе хостов.
[listInstances](listInstances.md) | Список ВМ, привязанных к указанной группе выделенных хостов.
[listOperations](listOperations.md) | Возвращает список операций указанной группы выделенных хостов.
[update](update.md) | Обновляет параметры указанной группы выделенных хостов.