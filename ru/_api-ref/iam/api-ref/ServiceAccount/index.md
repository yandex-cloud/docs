---
editable: false
---

# ServiceAccount
Набор методов для управления ресурсами ServiceAccount.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор сервисного аккаунта.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит сервисный аккаунт.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя сервисного аккаунта. Имя должно быть уникальным в облаке. Длина 3-63 символов.</p> 
description | **string**<br><p>Описание сервисного аккаунта. Длина описания должна быть от 0 до 256 символов.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает сервисный аккаунт в указанном каталоге.
[delete](delete.md) | Удаляет указанный сервисный аккаунт.
[get](get.md) | Возвращает указанный ресурс ServiceAccount.
[list](list.md) | Возвращает список доступных ресурсов ServiceAccount в указанном каталоге.
[listAccessBindings](listAccessBindings.md) | Возвращает список привязок прав доступа для указанного сервисного аккаунта.
[listOperations](listOperations.md) | Возвращает список операций для указанного сервисного аккаунта.
[setAccessBindings](setAccessBindings.md) | Задает список привязок прав доступа для указанного сервисного аккаунта.
[update](update.md) | Обновляет указанный сервисный аккаунт.
[updateAccessBindings](updateAccessBindings.md) | Обновляет список привязок прав доступа для указанного сервисного аккаунта.