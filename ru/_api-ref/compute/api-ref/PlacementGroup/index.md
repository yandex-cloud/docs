---
editable: false
---

# PlacementGroup
Набор методов для управления группами размещения.
## JSON-представление {#representation}
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
spreadPlacementStrategy | **object**<br><p>Это пустая структура, которую необходимо передать для явного указания стратегии размещения.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает группу размещения в указанном каталоге.
[delete](delete.md) | Удаляет указанную группу размещения.
[get](get.md) | Возвращает указанную группу размещения.
[list](list.md) | Возвращает список групп размещения в указанном каталоге.
[listInstances](listInstances.md) | Возвращает список виртуальных машин в указанной группе размещения.
[listOperations](listOperations.md) | Возвращает список операций указанной группы размещения.
[update](update.md) | Обновляет указанную группу размещения.