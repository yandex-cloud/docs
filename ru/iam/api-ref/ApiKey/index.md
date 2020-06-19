---
editable: false
---

# ApiKey
Набор методов управления API-ключами.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор API-ключа.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит API-ключ.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание API-ключа. Длина описания должна быть от 0 до 256 символов.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает API-ключ для указанного сервисного аккаунта.
[delete](delete.md) | Удаляет указанный API-ключ.
[get](get.md) | Возвращает указанный API-ключ.
[list](list.md) | Возвращает список API-ключей для указанного сервисного аккаунта.
[listOperations](listOperations.md) | Возвращает список операций для указанного API ключа.
[update](update.md) | Обновляет указанный API-ключ.