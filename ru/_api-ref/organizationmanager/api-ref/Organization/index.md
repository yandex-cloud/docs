---
editable: false
---

# Organization
Набор методов для управления организациями.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "title": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор организации.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя организации. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание организации. Длина описания должна быть от 0 до 256 символов.</p> 
title | **string**<br><p>Название организации. Длина описания должна быть от 0 до 256 символов.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанную организацию.
[list](list.md) | Возвращает список доступных организаций.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанной организации.
[listOperations](listOperations.md) | Возвращает список операций для указанной организации.
[setAccessBindings](setAccessBindings.md) | Задает список привязок прав доступа для указанной организации.
[update](update.md) | Обновляет указанную органищацию.
[updateAccessBindings](updateAccessBindings.md) | Обновляет список привязок прав доступа для указанной организации.