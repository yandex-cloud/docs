---
editable: false
---

# Cloud
Набор методов для управления ресурсом Cloud.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "organizationId": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор облака.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя облака. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание облака. Длина описания должна быть от 0 до 256 символов.</p> 
organizationId | **string**<br><p>Идентификатор организации, которой принадлежит облако.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс Cloud.
[list](list.md) | Возвращает список доступных ресурсов Cloud.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанного облака.
[listOperations](listOperations.md) | Возвращает список операций для указанного облака.
[setAccessBindings](setAccessBindings.md) | Задает список привязок прав доступа для указанного облака.
[update](update.md) | Обновляет указанное облако.
[updateAccessBindings](updateAccessBindings.md) | Обновляет список привязок прав доступа для указанного облака.