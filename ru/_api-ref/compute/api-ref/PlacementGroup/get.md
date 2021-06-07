---
editable: false
---

# Метод get
Возвращает указанную группу размещения.
 
Чтобы получить список доступных групп размещения, используйте запрос [list](/docs/compute/api-ref/PlacementGroup/list).
 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/placementGroups/{placementGroupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
placementGroupId | Идентификатор возвращаемой группы размещения.  Чтобы получить идентификатор группы размещения выполните запрос [list](/docs/compute/api-ref/PlacementGroup/list).
 
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
  "spreadPlacementStrategy": {}
}
```

 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор группы размещения. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит группа размещения.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя группы размещения. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Описание группы размещения. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Метки групп размещения в формате ``key:value``.</p> 
spreadPlacementStrategy | **object**<br>Стратегия распределенного размещения (`spread`). Каждая из виртуальных машин в группе расположена на отдельной стойке.<br><p>Это пустая структура, которую необходимо передать для явного указания стратегии размещения.</p> 