---
editable: false
---

# Key
Набор методов для управления ресурсами Key.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "description": "string",
  "keyAlgorithm": "string",
  "publicKey": "string",

  //  включает только одно из полей `userAccountId`, `serviceAccountId`
  "userAccountId": "string",
  "serviceAccountId": "string",
  // конец списка возможных полей

}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса Key</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание ресурса Key. Длина 0-256 символов.</p> 
keyAlgorithm | **string**<br>Алгоритм, используемый для создания пары ключей ресурса Key.<br><ul> <li>RSA_2048: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li> <li>RSA_4096: RSA с длиной ключа 4096 бит.</li> </ul> 
publicKey | **string**<br><p>Закрытый ключ из ресурса Key.</p> 
userAccountId | **string** <br> включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key.</p> 
serviceAccountId | **string** <br> включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пару ключей для указанного сервисного аккаунта.
[delete](delete.md) | Удаляет указанный ресурс Key.
[get](get.md) | Возвращает указанный ресурс Key.
[list](list.md) | Возвращает список доступных ресурсов Key для указанного сервисного аккаунта.
[listOperations](listOperations.md) | Возвращает список операций для указанного ресурса Key.
[update](update.md) | Обновляет указанный ключ.