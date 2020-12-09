---
editable: false
---

# TargetGroup
Набор методов для управления ресурсами TargetGroup.
## JSON-представление {#representation}
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
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор целевой группы.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит целевая группа.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя целевой группы. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание целевой группы. Длина 0-256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс.</p> 
regionId | **string**<br><p>Идентификатор региона, в котором находится целевая группа.</p> 
targets[] | **object**<br><p>Ресурс Target. Подробнее см. в разделе <a href="/docs/load-balancer/target-resources">Целевые группы и ресурсы</a>.</p> 
targets[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой подключены целевые ресурсы. В пределах одной зоны доступности все ресурсы целевой группы должны быть подключены к одной подсети.</p> <p>Максимальная длина строки в символах — 50.</p> 
targets[].<br>address | **string**<br><p>IP-адрес целевого ресурса.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[addTargets](addTargets.md) | Добавляет ресурсы в целевую группу.
[create](create.md) | Создает целевую группу в указанном каталоге и добавляет в нее указанные целевые ресурсы.
[delete](delete.md) | Удаляет указанную целевую группу.
[get](get.md) | Возвращает указанный ресурс TargetGroup.
[list](list.md) | Возвращает список TargetGroup ресурсов в указанном каталоге..
[listOperations](listOperations.md) | Возвращает список операций для указанной целевой группы.
[removeTargets](removeTargets.md) | Удаляет ресурсы из целевой группы.
[update](update.md) | Обновляет указанную целевую группу.