---
editable: false
---

# Role
Набор методов для управления ресурсами Role.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "description": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор роли.</p> 
description | **string**<br><p>Описание роли. Длина описания должна быть от 0 до 256 символов.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс Role.
[list](list.md) | Возвращает список доступных ресурсов Role.