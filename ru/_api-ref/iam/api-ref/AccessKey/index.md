---
editable: false
---

# AccessKey
Набор методов управления ключами доступа.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.</p> 
keyId | **string**<br><p>Идентификатор ключа доступа. Ключ совместим с сервисами AWS.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает ключ доступа для указанного сервисного аккаунта.
[delete](delete.md) | Удаляет указанный ключ доступа.
[get](get.md) | Возвращает указанный ключ доступа.
[list](list.md) | Возвращает список ключей доступа для указанного сервисного аккаунта.
[listOperations](listOperations.md) | Возвращает список операций для указанного ключа доступа.
[update](update.md) | Обновляет указанный ключ доступа.